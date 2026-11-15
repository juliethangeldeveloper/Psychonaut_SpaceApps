import '../../models/action_id.dart';
import '../../models/personality_profile.dart';

/// The 20-item Mini-IPIP (Donnellan, Oswald, Baird and Lucas, 2006), public domain from ipip.ori.org.
///
/// NOTE: the full product would use the 120-item IPIP-NEO-120 to get 30 facets
/// (for example excitement-seeking, gregariousness, vulnerability and self-discipline)
/// instead of five broad traits. This prototype uses the short form to keep onboarding quick.
enum Trait {
  extraversion,
  agreeableness,
  conscientiousness,
  neuroticism,
  intellect,
}

class MiniIpipItem {
  const MiniIpipItem(this.text, this.trait, {this.reversed = false});

  final String text;
  final Trait trait;
  final bool reversed;
}

/// Order repeats E, A, C, N, I. Items 6 to 10 and 15 to 20 are reverse-scored.
const miniIpipItems = [
  MiniIpipItem('Am the life of the party', Trait.extraversion),
  MiniIpipItem("Sympathize with others' feelings", Trait.agreeableness),
  MiniIpipItem('Get chores done right away', Trait.conscientiousness),
  MiniIpipItem('Have frequent mood swings', Trait.neuroticism),
  MiniIpipItem('Have a vivid imagination', Trait.intellect),
  MiniIpipItem("Don't talk a lot", Trait.extraversion, reversed: true),
  MiniIpipItem(
    "Am not interested in other people's problems",
    Trait.agreeableness,
    reversed: true,
  ),
  MiniIpipItem(
    'Often forget to put things back in their proper place',
    Trait.conscientiousness,
    reversed: true,
  ),
  MiniIpipItem(
    'Am relaxed most of the time',
    Trait.neuroticism,
    reversed: true,
  ),
  MiniIpipItem(
    'Am not interested in abstract ideas',
    Trait.intellect,
    reversed: true,
  ),
  MiniIpipItem(
    'Talk to a lot of different people at parties',
    Trait.extraversion,
  ),
  MiniIpipItem("Feel others' emotions", Trait.agreeableness),
  MiniIpipItem('Like order', Trait.conscientiousness),
  MiniIpipItem('Get upset easily', Trait.neuroticism),
  MiniIpipItem(
    'Have difficulty understanding abstract ideas',
    Trait.intellect,
    reversed: true,
  ),
  MiniIpipItem('Keep in the background', Trait.extraversion, reversed: true),
  MiniIpipItem(
    'Am not really interested in others',
    Trait.agreeableness,
    reversed: true,
  ),
  MiniIpipItem(
    'Make a mess of things',
    Trait.conscientiousness,
    reversed: true,
  ),
  MiniIpipItem('Seldom feel blue', Trait.neuroticism, reversed: true),
  MiniIpipItem(
    'Do not have a good imagination',
    Trait.intellect,
    reversed: true,
  ),
];

/// [answers] holds 20 values from 1 to 5. Each trait is the mean of its 4 items
/// converted to 0 to 100 with (mean - 1) / 4 * 100. Emotional stability is 100 - neuroticism.
BigFive scoreMiniIpip(List<int> answers) {
  if (answers.length != miniIpipItems.length) {
    throw ArgumentError('Expected ${miniIpipItems.length} answers');
  }
  final sums = {for (final t in Trait.values) t: 0};
  for (var i = 0; i < answers.length; i++) {
    final a = answers[i];
    if (a < 1 || a > 5) throw ArgumentError('Answer ${i + 1} must be 1 to 5');
    final item = miniIpipItems[i];
    sums[item.trait] = sums[item.trait]! + (item.reversed ? 6 - a : a);
  }
  double score(Trait t) => (sums[t]! / 4 - 1) / 4 * 100;
  return BigFive(
    openness: score(Trait.intellect),
    conscientiousness: score(Trait.conscientiousness),
    extraversion: score(Trait.extraversion),
    agreeableness: score(Trait.agreeableness),
    emotionalStability: 100 - score(Trait.neuroticism),
  );
}

String slugify(String name) {
  final s = name
      .toLowerCase()
      .replaceAll(RegExp(r'[^a-z0-9]+'), '-')
      .replaceAll(RegExp(r'^-+|-+$'), '');
  return s.isEmpty ? 'astronaut' : s;
}

/// Builds the profile from the questionnaire. The baseline starts from population
/// defaults and is replaced by the person's own data after 30 days.
PersonalityProfile buildProfile({
  required String displayName,
  required String role,
  required String defaultRole,
  required List<int> answers,
  required LocusOfControl locus,
  required Tone tone,
  required List<ActionId> preferredActions,
}) {
  final big = scoreMiniIpip(answers);
  return PersonalityProfile(
    id: slugify(displayName),
    displayName: displayName.trim(),
    role: role.trim().isEmpty ? defaultRole : role.trim(),
    source: ProfileSource.miniIpip,
    bigFive: big,
    locusOfControl: locus,
    // Design assumption: coping style follows locus of control, because the
    // questionnaire has no coping items.
    copingStyle: switch (locus) {
      LocusOfControl.internal => CopingStyle.problemFocused,
      LocusOfControl.mixed => CopingStyle.emotionFocused,
      LocusOfControl.external => CopingStyle.avoidant,
    },
    // Design assumption: boredom proneness rises with stimulation need
    // (extraversion) and falls with conscientiousness.
    boredomProneness: ((big.extraversion + (100 - big.conscientiousness)) / 2)
        .clamp(0, 100),
    baseline: Baseline.defaults,
    preferences: Preferences(tone: tone, preferredActions: preferredActions),
  );
}
