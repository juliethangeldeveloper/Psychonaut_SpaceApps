import 'package:flutter/widgets.dart' show Locale;
import 'package:flutter_test/flutter_test.dart';
import 'package:psychonaut_application/l10n/l10n.dart';
import 'package:psychonaut_application/features/onboarding/mini_ipip.dart';
import 'package:psychonaut_application/models/action_id.dart';
import 'package:psychonaut_application/models/personality_profile.dart';

void main() {
  test('20 items in the E, A, C, N, I order', () {
    expect(miniIpipItems, hasLength(20));
    const order = [
      Trait.extraversion,
      Trait.agreeableness,
      Trait.conscientiousness,
      Trait.neuroticism,
      Trait.intellect,
    ];
    for (var i = 0; i < 20; i++) {
      expect(miniIpipItems[i].trait, order[i % 5], reason: 'item ${i + 1}');
    }
  });

  test('items 6-10 and 15-20 are reverse-scored, nothing else', () {
    for (var n = 1; n <= 20; n++) {
      final reversed = (n >= 6 && n <= 10) || (n >= 15 && n <= 20);
      expect(miniIpipItems[n - 1].reversed, reversed, reason: 'item $n');
    }
  });

  test('wording matches the IPIP list', () {
    expect(miniIpipItems.first.text, 'Am the life of the party');
    expect(miniIpipItems[8].text, 'Am relaxed most of the time');
    expect(miniIpipItems[19].text, 'Do not have a good imagination');
    final en = lookupAppLocalizations(const Locale('en'));
    expect(en.ipipItem(0), 'I am the life of the party');
    expect(en.ipipItem(5), "I don't talk a lot");
  });

  group('scoring', () {
    test('all 3s is 50 on every trait', () {
      final b = scoreMiniIpip(List.filled(20, 3));
      expect(b.extraversion, 50);
      expect(b.agreeableness, 50);
      expect(b.conscientiousness, 50);
      expect(b.openness, 50);
      expect(b.emotionalStability, 50);
    });

    test('all 5s: reverse items pull traits down, stability follows', () {
      final b = scoreMiniIpip(List.filled(20, 5));
      // Each trait has 2 normal items (5) and 2 reversed items (1): mean 3.
      expect(b.extraversion, 50);
      expect(b.emotionalStability, 50);
    });

    test('maximum extraversion answers give 100', () {
      final a = List.filled(20, 3);
      for (var i = 0; i < 20; i++) {
        if (miniIpipItems[i].trait == Trait.extraversion) {
          a[i] = miniIpipItems[i].reversed ? 1 : 5;
        }
      }
      final b = scoreMiniIpip(a);
      expect(b.extraversion, 100);
      expect(b.agreeableness, 50);
    });

    test('emotional stability is 100 minus neuroticism', () {
      final calm = List.filled(20, 3);
      final anxious = List.filled(20, 3);
      for (var i = 0; i < 20; i++) {
        if (miniIpipItems[i].trait == Trait.neuroticism) {
          calm[i] = miniIpipItems[i].reversed ? 5 : 1;
          anxious[i] = miniIpipItems[i].reversed ? 1 : 5;
        }
      }
      expect(scoreMiniIpip(calm).emotionalStability, 100);
      expect(scoreMiniIpip(anxious).emotionalStability, 0);
    });

    test('scores stay within 0 to 100 and validate input', () {
      final lo = scoreMiniIpip(List.filled(20, 1));
      final hi = scoreMiniIpip(List.filled(20, 5));
      for (final b in [lo, hi]) {
        for (final v in [
          b.openness,
          b.conscientiousness,
          b.extraversion,
          b.agreeableness,
          b.emotionalStability,
        ]) {
          expect(v, inInclusiveRange(0, 100));
        }
      }
      expect(() => scoreMiniIpip(List.filled(19, 3)), throwsArgumentError);
      expect(() => scoreMiniIpip(List.filled(20, 6)), throwsArgumentError);
    });
  });

  group('profile creation', () {
    final p = buildProfile(
      displayName: 'Ana María Ruiz',
      role: '',
      defaultRole: 'Crew member',
      answers: List.filled(20, 3),
      locus: LocusOfControl.external,
      tone: Tone.gentle,
      preferredActions: [ActionId.journal, ActionId.garden],
    );

    test('fills the schema and round-trips through JSON', () {
      expect(p.id, 'ana-mar-a-ruiz');
      expect(p.role, 'Crew member');
      expect(p.source, ProfileSource.miniIpip);
      expect(p.facets, isNull);
      expect(p.locusOfControl, LocusOfControl.external);
      expect(p.preferences.preferredActions, [
        ActionId.journal,
        ActionId.garden,
      ]);
      final again = PersonalityProfile.fromJson(p.toJson());
      expect(again.bigFive.extraversion, 50);
      expect(again.baseline.reactionMs, 250);
    });

    test('slugs are safe ids', () {
      expect(slugify('  Maya Reyes! '), 'maya-reyes');
      expect(slugify('???'), 'astronaut');
    });
  });
}
