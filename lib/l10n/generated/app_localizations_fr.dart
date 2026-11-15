// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get navHome => 'Accueil';

  @override
  String get navCheckIn => 'Bilan';

  @override
  String get navTrends => 'Tendances';

  @override
  String get navCrew => 'Équipage';

  @override
  String get profileAndSettings => 'Profil et réglages';

  @override
  String get back => 'Retour';

  @override
  String get sampleData => 'Données d\'exemple';

  @override
  String get disclaimer =>
      'Psychonaut ne pose pas de diagnostic et ne remplace pas un professionnel de santé.';

  @override
  String get statusOnCourse => 'Sur la bonne trajectoire';

  @override
  String get statusDrifting => 'En dérive';

  @override
  String get statusOffCourse => 'Hors trajectoire';

  @override
  String get statusAlert => 'Alerte';

  @override
  String traitSemantics(String label, int valueNum) {
    return '$label $valueNum sur 100';
  }

  @override
  String get indicatorMood => 'Humeur';

  @override
  String get indicatorStress => 'Stress';

  @override
  String get indicatorSleep => 'Sommeil';

  @override
  String get indicatorFocus => 'Concentration';

  @override
  String get indicatorMotivation => 'Motivation';

  @override
  String get indicatorConnection => 'Lien';

  @override
  String get indicatorWorkload => 'Charge de travail';

  @override
  String get indicatorReaction => 'Temps de réaction';

  @override
  String get trendImproving => 'en amélioration';

  @override
  String get trendSteady => 'stable';

  @override
  String get trendSlipping => 'en baisse';

  @override
  String get homeTitle => 'Votre cap';

  @override
  String missionLine(int dayNum, String phase) {
    return 'Jour $dayNum de la mission · $phase';
  }

  @override
  String headingSemantics(int degreesNum, String status) {
    return '$degreesNum degrés hors trajectoire. Globalement : $status.';
  }

  @override
  String get headingOffCourse => 'hors trajectoire';

  @override
  String get headingMeasured => 'Mesuré par rapport à votre propre référence.';

  @override
  String get mismatchTitle =>
      'Ce que vous dites et ce que montre votre corps diffèrent';

  @override
  String mismatchBody(String mood, String details) {
    return 'Vous avez noté votre humeur à $mood, au niveau de votre référence ou au-dessus, mais $details. Les deux peuvent être vrais. Cela mérite un examen plus attentif.';
  }

  @override
  String mismatchDetailSleep(int daysNum) {
    return 'votre sommeil est sous votre référence depuis $daysNum jours';
  }

  @override
  String mismatchDetailReaction(int daysNum) {
    return 'votre temps de réaction est plus lent que votre référence depuis $daysNum jours';
  }

  @override
  String mismatchJoin(String first, String second) {
    return '$first et $second';
  }

  @override
  String get lifeEventTitle => 'Il s\'est passé quelque chose à la maison';

  @override
  String get lifeEventCardBody =>
      'C\'est difficile à porter de si loin. Vous n\'avez pas à y faire face seul. Votre humeur sera suivie de plus près pendant 14 jours et « Écrire à la maison » vous sera proposé en premier.';

  @override
  String get reactionPromptTitle => 'C\'est l\'heure de votre test de réaction';

  @override
  String get reactionPromptText =>
      'Trois minutes. Il révèle la fatigue avant que vous ne la ressentiez.';

  @override
  String get reactionPromptButton => 'Commencer le test';

  @override
  String get logOpenTitle => 'Le journal de bord est ouvert';

  @override
  String get logOpenText => 'Vous n\'avez pas encore enregistré aujourd\'hui.';

  @override
  String get logEntry => 'Enregistrer';

  @override
  String get readingPreparing => 'Préparation de votre analyse';

  @override
  String get readingUnavailable =>
      'Votre analyse n\'est pas disponible pour le moment.';

  @override
  String get readingTitle => 'Analyse du jour';

  @override
  String get readingFixedAlertNote =>
      'Message de sécurité fixe, non généré par l\'IA.';

  @override
  String get aiGenerated => 'Généré par l\'IA';

  @override
  String get suggestedAction => 'Action suggérée';

  @override
  String readingSource(String source) {
    return 'Source : $source';
  }

  @override
  String get sourceRuleBased => 'Basé sur des règles · sur cet appareil';

  @override
  String get sourceOnBoard => 'Modèle embarqué';

  @override
  String get sourceCloud => 'Modèle cloud';

  @override
  String loadError(String error) {
    return 'Impossible de charger vos données.\n$error';
  }

  @override
  String get indicatorsTitle => 'Indicateurs';

  @override
  String get panelMindMap => 'Carte mentale';

  @override
  String get panelSelected => 'Indicateur sélectionné';

  @override
  String chartLast14(String indicator) {
    return '$indicator, 14 derniers jours';
  }

  @override
  String get chartSleep14 => 'Sommeil, 14 nuits';

  @override
  String tileSemantics(String indicator, String status, String trend) {
    return '$indicator, $status, $trend';
  }

  @override
  String get trendNoData => 'Pas encore de données';

  @override
  String get trendAtBaseline => 'À votre référence';

  @override
  String trendAbove(String amount) {
    return '$amount au-dessus de la référence';
  }

  @override
  String trendBelow(String amount) {
    return '$amount en dessous de la référence';
  }

  @override
  String trendJoin(String where, String trend) {
    return '$where, $trend';
  }

  @override
  String detailNow(String now, String baseline, String trend) {
    return 'Maintenant $now · votre référence $baseline · $trend';
  }

  @override
  String get flaggedSooner =>
      'Surveillé un jour plus tôt pour vous, selon votre profil.';

  @override
  String get detailHowMeasured => 'Comment c\'est mesuré';

  @override
  String get detailWhy => 'Pourquoi c\'est important';

  @override
  String get detailWhatToDo => 'Que faire maintenant';

  @override
  String whatToDoOptions(String text, String options) {
    return '$text Options : $options.';
  }

  @override
  String whatToDoRecommended(String text, String action) {
    return '$text Recommandé : $action.';
  }

  @override
  String whatToDoOneStep(String action, String description) {
    return 'Une étape : $action. $description';
  }

  @override
  String get nasaRiskLabel => 'Risque NASA';

  @override
  String get nasaHazardLabel => 'Danger';

  @override
  String labelValue(String label, String value) {
    return '$label : $value';
  }

  @override
  String unitHours(String value) {
    return '$value h';
  }

  @override
  String unitMs(String value) {
    return '$value ms';
  }

  @override
  String get refMeasuredMood =>
      'Votre auto-évaluation quotidienne de 1 à 10 dans le journal de bord, comparée à votre propre référence.';

  @override
  String get refWhyMood =>
      'Les petites baisses régulières d\'humeur se corrigent plus facilement tôt. Suivre l\'humeur par rapport à votre référence est plus utile qu\'une seule journée.';

  @override
  String get refTodoMood =>
      'Répondez honnêtement, puis choisissez une petite action. Parlez-en à un équipier si les mauvais jours s\'accumulent.';

  @override
  String get refMeasuredStress =>
      'Votre niveau de stress quotidien de 1 à 10, comparé à votre propre référence. Plus élevé est moins favorable.';

  @override
  String get refWhyStress =>
      'Un long confinement maintient le stress élevé. Un stress croissant grignote aussi le sommeil et la concentration.';

  @override
  String get refTodoStress =>
      'Ralentissez votre respiration pendant deux minutes, bougez, ou confiez une tâche à quelqu\'un pour aujourd\'hui.';

  @override
  String get refMeasuredSleep =>
      'Heures dormies chaque nuit, d\'après le suivi du sommeil ou les données d\'exemple. 7 à 8 heures est la plage saine ; 6 heures ou moins est un sommeil court.';

  @override
  String get refWhySleep =>
      'Le manque de sommeil et les horaires irréguliers ralentissent les réactions, abaissent l\'humeur et amplifient les petits problèmes.';

  @override
  String get refTodoSleep =>
      'Gardez une heure d\'extinction fixe, atténuez les écrans une heure avant et rafraîchissez la cabine pour relancer le sommeil.';

  @override
  String get refMeasuredFocus =>
      'Votre niveau de concentration de 1 à 10, avec le nombre de lapsus du test de réaction.';

  @override
  String get refWhyFocus =>
      'L\'attention est la première à flancher quand le sommeil ou la charge de travail dérapent, et les erreurs coûtent le plus cher en vol.';

  @override
  String get refTodoFocus =>
      'Faites une vraie pause loin des écrans, puis une tâche à la fois. Vérifiez d\'abord votre sommeil.';

  @override
  String get refMeasuredMotivation =>
      'Votre niveau d\'engagement de 1 à 10, comparé à votre propre référence.';

  @override
  String get refWhyMotivation =>
      'Les longues missions répétitives favorisent l\'ennui. Une baisse d\'engagement peut précéder une baisse d\'humeur.';

  @override
  String get refTodoMotivation =>
      'Lancez un petit projet ou changez l\'ordre de votre journée pour varier.';

  @override
  String get refMeasuredConnection =>
      'Votre sentiment de lien avec l\'équipage de 1 à 10, comparé à votre propre référence.';

  @override
  String get refWhyConnection =>
      'Le bon travail d\'équipe repose sur le sentiment d\'être lié aux autres. La distance de la Terre rend aussi les contacts avec la famille plus lents et plus rares.';

  @override
  String get refTodoConnection =>
      'Partagez un repas avec l\'équipage ou écrivez à la maison. Un petit contact compte.';

  @override
  String get refMeasuredWorkload =>
      'Votre charge de travail de 1 à 10, comparée à votre propre référence. Plus élevé est moins favorable.';

  @override
  String get refWhyWorkload =>
      'La surcharge de travail empiète sur le sommeil. Avec les délais de communication avec la Terre, les équipages doivent gérer leur propre rythme.';

  @override
  String get refTodoWorkload =>
      'Reportez une tâche à demain ou demandez à l\'équipage de la partager. Protégez votre créneau de sommeil.';

  @override
  String get refMeasuredReaction =>
      'Un test de réaction de 3 minutes. Vous touchez l\'écran le plus vite possible quand un stimulus apparaît. Nous enregistrons votre temps de réponse moyen, les lapsus (plus de 500 ms) et les faux départs.';

  @override
  String get refWhyReaction =>
      'Des réponses lentes ou des lapsus sont parmi les premiers signes de fatigue et de baisse d\'attention, souvent avant même que vous la ressentiez.';

  @override
  String get refTodoReaction =>
      'Refaites le test tous les quelques jours à une heure similaire et comparez avec votre propre référence.';

  @override
  String get actionExerciseTitle => 'Exercice';

  @override
  String get actionExerciseDesc =>
      'Une courte séance sur le tapis de course ou le vélo.';

  @override
  String get actionJournalTitle => 'Journal';

  @override
  String get actionJournalDesc =>
      'Dix minutes d’écriture privée sur votre journée.';

  @override
  String get actionFamilyCallTitle => 'Écrire à la maison';

  @override
  String get actionFamilyCallDesc =>
      'Envoyez un message ou planifiez un appel avec quelqu’un sur Terre.';

  @override
  String get actionGardenTitle => 'Hublot et jardin';

  @override
  String get actionGardenDesc =>
      'Passez du temps au hublot ou avec les plantes.';

  @override
  String get actionWindowTimeTitle => 'Temps au hublot';

  @override
  String get actionWindowTimeDesc =>
      'Passez dix minutes au hublot à regarder la Terre ou les étoiles.';

  @override
  String get actionNewProjectTitle => 'Lancer un petit projet';

  @override
  String get actionNewProjectDesc =>
      'Choisissez une tâche nouvelle et courte pour rompre la routine.';

  @override
  String get actionSleepResetTitle => 'Remise à zéro du sommeil';

  @override
  String get actionSleepResetDesc =>
      'Extinction à heure fixe, écrans atténués et cabine plus fraîche pendant une nuit.';

  @override
  String get aiRuleBasedLabel => 'Basé sur des règles';

  @override
  String get aiRuleBasedDesc =>
      'Modèles sur cet appareil. Sans réseau. Par défaut.';

  @override
  String get aiOnBoardLabel => 'Modèle embarqué';

  @override
  String get aiOnBoardDesc =>
      'Un modèle exécuté sur cet ordinateur ou sur le réseau du vaisseau. Rien ne quitte le véhicule. Repli sur les règles s’il ne tourne pas.';

  @override
  String get aiCloudLabel => 'Modèle cloud';

  @override
  String get aiCloudDesc =>
      'Un grand modèle de langage via Internet. À utiliser uniquement sur Terre. Envoie vos notes chiffrées et votre profil de personnalité, jamais votre nom ni vos remarques.';

  @override
  String get phaseAdjustment => 'Adaptation';

  @override
  String get phaseAdjustmentNote =>
      'Mise en place. Les routines se forment encore.';

  @override
  String get phaseMid => 'Mi-mission';

  @override
  String get phaseMidNote => 'Régime stable. Surveillez les dérives lentes.';

  @override
  String get phaseLate => 'Fin de mission';

  @override
  String get phaseLateNote =>
      'Après le jour 150, la surveillance est plus serrée. Dans les études analogues, les symptômes comportementaux augmentent après 5 à 6 mois.';

  @override
  String get riskBehavioral => 'Troubles du comportement';

  @override
  String get riskTeamwork => 'Travail d’équipe insuffisant';

  @override
  String get riskSleep => 'Sommeil insuffisant et horaires irréguliers';

  @override
  String get hazardIsolation => 'Isolement et confinement';

  @override
  String get hazardDistance => 'Éloignement de la Terre';

  @override
  String get toneDirect => 'Direct';

  @override
  String get toneGentle => 'Doux';

  @override
  String get framingInternal => 'Interne : données et options';

  @override
  String get framingMixed => 'Mixte : données et une recommandation';

  @override
  String get framingExternal => 'Externe : une étape claire';

  @override
  String get copingProblem => 'Centré sur le problème';

  @override
  String get copingEmotion => 'Centré sur les émotions';

  @override
  String get copingAvoidant => 'Évitant';

  @override
  String get sourceMiniIpip => 'Questionnaire Mini-IPIP';

  @override
  String get sourceIpipNeo120 => 'Questionnaire IPIP-NEO-120';

  @override
  String get sourceImported => 'Fichier importé';

  @override
  String get alertMessage =>
      'Informez le médecin de bord de l’équipage et préparez un résumé pour la Terre';

  @override
  String sourceUnavailableNote(String source) {
    return '$source indisponible : cette analyse provient de la source basée sur des règles.';
  }

  @override
  String insOnCourseDirect(int degreesNum) {
    return 'Vous êtes sur la bonne trajectoire à $degreesNum° d’écart, et chaque mesure reste proche de votre référence.';
  }

  @override
  String insOnCourseGentle(int degreesNum) {
    return 'Vous êtes sur la bonne trajectoire, à seulement $degreesNum° d’écart, et vos mesures restent proches de votre normale.';
  }

  @override
  String insWorstGentle(
    String indicator,
    String current,
    String baseline,
    String trend,
  ) {
    return '$indicator a un peu bougé : $current maintenant contre $baseline d’habitude, et c’est $trend.';
  }

  @override
  String insWorstDirect(
    String indicator,
    String status,
    String current,
    String baseline,
    String trend,
  ) {
    return '$indicator est $status à $current contre votre référence de $baseline, et c’est $trend.';
  }

  @override
  String insMismatchGentle(int daysNum) {
    return 'Vous avez dit aller bien, et cela compte, mais les données de votre corps s’écartent de la référence depuis $daysNum jours.';
  }

  @override
  String insMismatchDirect(int daysNum) {
    return 'Vous avez noté votre humeur au niveau ou au-dessus de la référence, mais les données de votre corps s’écartent depuis $daysNum jours.';
  }

  @override
  String get insLifeGentle =>
      'Vous avez signalé quelque chose venant de la maison : votre humeur est suivie d’un peu plus près pour l’instant.';

  @override
  String get insLifeDirect =>
      'Vous avez enregistré quelque chose venant de la maison : l’humeur est suivie de plus près pendant 14 jours.';

  @override
  String insActionGentle(String action) {
    return 'Un petit pas pourrait aider aujourd’hui : $action.';
  }

  @override
  String insActionDirect(String action) {
    return 'Une petite action aujourd’hui : $action.';
  }

  @override
  String get insEvidenceAllOk =>
      'Toutes les mesures sont à moins d’un écart-type de votre propre référence.';

  @override
  String insEvidence(String indicator, String current, String baseline) {
    return '$indicator : $current contre une référence de $baseline.';
  }

  @override
  String insEvidenceBeyond(
    String indicator,
    String current,
    String baseline,
    String sd,
    int count,
  ) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count jours',
      one: '1 jour',
    );
    return '$indicator : $current contre une référence de $baseline, au-delà de $sd é.-t. depuis $_temp0.';
  }

  @override
  String insNights(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count nuits récentes de 6 heures ou moins.',
      one: '1 nuit récente de 6 heures ou moins.',
    );
    return '$_temp0';
  }

  @override
  String get insLapses =>
      'Les lapsus au test de réaction dépassent votre habitude.';

  @override
  String insOptions(String options) {
    return 'Options : $options';
  }

  @override
  String insRecommended(String action, String description) {
    return 'Recommandé : $action. $description';
  }

  @override
  String insRecommendedStep(String action, String description) {
    return 'Étape recommandée : $action. $description Rien que cette étape aujourd’hui.';
  }

  @override
  String get insLatePhase =>
      'Après le jour 150 de la mission, la surveillance est plus serrée : des changements plus petits sont signalés.';

  @override
  String get insLifeSupport =>
      'Recevoir des nouvelles de la maison peut peser lourd. Se confier à quelqu’un de confiance peut aider.';

  @override
  String get trendsTitle => 'Écart de trajectoire';

  @override
  String get trendsSubtitle =>
      'Votre écart par rapport à votre propre référence';

  @override
  String get trendsSleepTitle => 'Sommeil, 14 dernières nuits';

  @override
  String get trendsNoTests => 'Pas encore de test';

  @override
  String trendsLatestReaction(String ms, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lapsus',
      one: '1 lapsus',
    );
    return 'Dernier $ms · $_temp0';
  }

  @override
  String trendsNasaLine(String risk, String hazards) {
    return 'Risque NASA : $risk. Danger : $hazards.';
  }

  @override
  String get correctionsTitle => 'Corrections de trajectoire';

  @override
  String get correctionsHint =>
      'Choisissez une petite action. Vos préférées viennent en premier.';

  @override
  String correctionsPlan(String title, String description) {
    return 'Votre plan : $title. $description';
  }

  @override
  String get correctionsSuggested => 'Suggérée';

  @override
  String actionSemantics(String title, String description) {
    return '$title. $description';
  }

  @override
  String actionSemanticsSuggested(String title, String description) {
    return '$title. $description Suggérée pour aujourd’hui.';
  }

  @override
  String get chartNoSleep => 'Pas encore de données de sommeil.';

  @override
  String chartBaselineValue(String value) {
    return 'Votre référence $value';
  }

  @override
  String get chartBaseline => 'Votre référence';

  @override
  String chartTooltipSleep(String value, String status) {
    return '$value\n$status';
  }

  @override
  String chartSleepSemantics(
    int count,
    String baseline,
    String latest,
    String status,
  ) {
    return 'Sommeil des $count dernières nuits. Référence $baseline. Dernière nuit $latest, $status.';
  }

  @override
  String get chartToday => 'Aujourd’hui';

  @override
  String get chartNeedTests =>
      'Faites le test de réaction plusieurs fois pour voir votre tendance.';

  @override
  String chartReactionSemantics(int count, String baseline, String latest) {
    return 'Temps de réaction des $count derniers tests. Référence $baseline. Dernier $latest.';
  }

  @override
  String get chartNotEnough => 'Pas encore assez de données.';

  @override
  String chartDaysAgo(int daysNum) {
    return '-$daysNum j';
  }

  @override
  String get checkinTitle => 'Journal de bord';

  @override
  String get checkinSubtitle =>
      'Comment allez-vous aujourd’hui ? Soyez honnête. Il n’y a pas de mauvaise réponse.';

  @override
  String get qEngagement => 'Engagement';

  @override
  String get qConnection => 'Lien avec l’équipage';

  @override
  String get scaleLow => 'Bas';

  @override
  String get scaleHigh => 'Élevé';

  @override
  String get scaleCalm => 'Calme';

  @override
  String get scaleVeryStressed => 'Très stressé';

  @override
  String get scaleLight => 'Légère';

  @override
  String get scaleOverloaded => 'Surchargé';

  @override
  String get scaleBored => 'Ennuyé';

  @override
  String get scaleAbsorbed => 'Absorbé';

  @override
  String get scaleScattered => 'Dispersé';

  @override
  String get scaleSharp => 'Vif';

  @override
  String get scaleDistant => 'Distant';

  @override
  String get scaleClose => 'Proche';

  @override
  String checkinStreak(int count) {
    return 'Série de $count jours';
  }

  @override
  String checkinStreakSemantics(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count jours',
      one: '1 jour',
    );
    return 'Série d’enregistrements : $_temp0';
  }

  @override
  String get checkinStreakNote =>
      'Compte les jours où vous avez enregistré, jamais la valeur des notes.';

  @override
  String get checkinOptional => 'Facultatif.';

  @override
  String get checkinNoteLabel => 'Note privée';

  @override
  String get checkinNoteHelper =>
      'Reste sur cet appareil. Jamais envoyée ailleurs.';

  @override
  String get checkinUpdate => 'Mettre à jour l’entrée du jour';

  @override
  String get checkinLogged => 'Entrée enregistrée. Merci.';

  @override
  String sliderSemantics(String label, int valueNum) {
    return '$label $valueNum sur 10';
  }

  @override
  String get crewTitle => 'Moral du vaisseau';

  @override
  String get crewSubtitle =>
      'Comment va l’équipage, en un seul chiffre anonyme';

  @override
  String get moraleHigh => 'Élevé';

  @override
  String get moraleSteady => 'Stable';

  @override
  String get moraleStrained => 'Tendu';

  @override
  String get moraleLow => 'Bas';

  @override
  String get crewOutOf100 => '/ 100';

  @override
  String crewMeterSemantics(
    String level,
    int scoreNum,
    int contributedNum,
    int crewNum,
  ) {
    return 'Moral de l’équipage $level, $scoreNum sur 100. $contributedNum équipiers sur $crewNum ont enregistré aujourd’hui.';
  }

  @override
  String crewCheckedIn(int contributedNum, int crewNum) {
    return '$contributedNum équipiers sur $crewNum ont enregistré aujourd’hui. Les noms ne sont jamais affichés.';
  }

  @override
  String get crewGoalLabel => 'Objectif hebdomadaire commun';

  @override
  String get crewGoalTitle => 'Partager un dîner ensemble';

  @override
  String get crewGoalDesc =>
      'Dînez avec l’équipage 6 soirs cette semaine. Court et sans hâte, c’est très bien.';

  @override
  String crewGoalProgress(int doneNum, int segmentsNum, int peopleNum) {
    return '$doneNum soirs sur $segmentsNum faits · $peopleNum équipiers participent';
  }

  @override
  String crewGoalSemantics(int doneNum, int segmentsNum) {
    return '$doneNum soirs sur $segmentsNum faits';
  }

  @override
  String get crewJoin => 'Rejoindre cet objectif';

  @override
  String get crewLeave => 'Vous participez. Touchez pour quitter';

  @override
  String get crewPrivacyTitle => 'Votre vie privée';

  @override
  String get crewPrivacyBody =>
      'Seule une moyenne du groupe est affichée. Vos notes, vos remarques et votre profil restent sur cet appareil. Il n’y a ni noms, ni classements, ni comparaisons entre personnes.';

  @override
  String get profileTitle => 'Profil';

  @override
  String get profileSubtitle =>
      'Tout reste sur cet appareil, sauf si vous choisissez le modèle cloud.';

  @override
  String get profileRetake => 'Refaire le questionnaire';

  @override
  String get profileSamples => 'Profils d’exemple';

  @override
  String get profileSamplesHint =>
      'Passez à un exemple fourni pour voir comment l’application s’adapte à une autre personne.';

  @override
  String get scienceTitle => 'À propos de la science';

  @override
  String profileLoaded(String name) {
    return '$name chargé.';
  }

  @override
  String get profileCurrent => 'Actuel';

  @override
  String profileCurrentSemantics(String label) {
    return '$label, actuel';
  }

  @override
  String get traitOpenness => 'Ouverture';

  @override
  String get traitConscientiousness => 'Conscienciosité';

  @override
  String get traitExtraversion => 'Extraversion';

  @override
  String get traitAgreeableness => 'Agréabilité';

  @override
  String get traitEmotionalStability => 'Stabilité émotionnelle';

  @override
  String get traitBoredom => 'Propension à l’ennui';

  @override
  String get facetsTitle => 'Facettes';

  @override
  String get facetExcitement => 'Recherche d’excitation';

  @override
  String get facetGregariousness => 'Sociabilité';

  @override
  String get facetVulnerability => 'Vulnérabilité';

  @override
  String get facetSelfDiscipline => 'Autodiscipline';

  @override
  String get profileAdviceFraming => 'Formulation des conseils';

  @override
  String get profileCoping => 'Style d’adaptation';

  @override
  String get profileTone => 'Ton';

  @override
  String get profilePreferred => 'Actions préférées';

  @override
  String get profileBaseline => 'Référence';

  @override
  String dotJoin2(String a, String b) {
    return '$a · $b';
  }

  @override
  String dotJoin3(String a, String b, String c) {
    return '$a · $b · $c';
  }

  @override
  String get restingHeartRate => 'Fréquence cardiaque au repos';

  @override
  String get hrvLabel => 'VRC';

  @override
  String unitBpm(String value) {
    return '$value bpm';
  }

  @override
  String get settingsMissionDay => 'Jour de la mission';

  @override
  String get settingsPrevDay => 'Jour précédent';

  @override
  String get settingsNextDay => 'Jour suivant';

  @override
  String settingsDay(int dayNum) {
    return 'Jour $dayNum';
  }

  @override
  String settingsMissionDaySemantics(int dayNum, String phase) {
    return 'Jour $dayNum de la mission, $phase';
  }

  @override
  String get settingsAiSource => 'Source de l’IA';

  @override
  String get settingsAiHint =>
      'D’où vient l’analyse écrite de l’accueil. Au niveau d’alerte, le message est toujours fixe.';

  @override
  String get settingsLanguage => 'Langue';

  @override
  String get settingsLanguageHint =>
      'Choisissez la langue de l’application. L’analyse écrite la suit.';

  @override
  String get languageDevice => 'Langue de l’appareil';

  @override
  String get importTitle => 'Importer un profil';

  @override
  String get importHint =>
      'Chargez une autre personne depuis un fichier JSON avec les mêmes champs que les exemples fournis. Rien n’est envoyé.';

  @override
  String get importButton => 'Importer un profil JSON';

  @override
  String importFailed(String error) {
    return 'Impossible d’importer ce fichier. $error';
  }

  @override
  String get importNotJson => 'Ce fichier n’est pas un JSON valide.';

  @override
  String get importUnreadable => 'Ce fichier n’a pas pu être lu.';

  @override
  String importDone(String name) {
    return '$name importé.';
  }

  @override
  String get scienceSubtitle => 'D’où viennent les idées de Psychonaut.';

  @override
  String get scienceAssumptionsTitle => 'Hypothèses de conception';

  @override
  String get sciHrpTitle =>
      'Programme de recherche humaine de la NASA : dangers et risques';

  @override
  String get sciHrpBody =>
      'La liste des dangers du vol spatial, dont l’isolement et le confinement et l’éloignement de la Terre, et les risques pour la santé humaine qui leur sont liés.';

  @override
  String get sciBhrTitle =>
      'Dossier des risques de santé comportementale de la NASA';

  @override
  String get sciBhrBody =>
      'Les risques de santé comportementale et de performance pour les longues missions : troubles du comportement, travail d’équipe et sommeil.';

  @override
  String get sciReactionTitle => 'Recherche sur l’auto-test de réaction';

  @override
  String get sciReactionBody =>
      'Basner, Mollicone et Dinges (2011), un bref test de vigilance psychomotrice (PVT-B), et l’auto-test de réaction de la NASA utilisé par les astronautes pour suivre la fatigue.';

  @override
  String get sciIpipTitle => 'International Personality Item Pool (IPIP)';

  @override
  String get sciIpipBody =>
      'Items du domaine public issus de ipip.ori.org. Le Mini-IPIP de 20 items est de Donnellan, Oswald, Baird et Lucas (2006). Le produit complet utiliserait l’IPIP-NEO-120, à 120 items, pour 30 facettes.';

  @override
  String get sciAssume1 =>
      'Les seuils en écarts-types et le nombre de jours nécessaires pour signaler un changement sont des choix de conception d’un prototype.';

  @override
  String get sciAssume2 =>
      'La limite plus serrée après le jour 150 s’appuie sur des études analogues indiquant une hausse des symptômes comportementaux après 5 à 6 mois.';

  @override
  String get sciAssume3 =>
      'Les traits de personnalité modifient seulement la rapidité avec laquelle un changement est signalé. Ils n’étiquettent jamais une personne.';

  @override
  String get reactionTitle => 'Test de réaction';

  @override
  String get ipipItem1 => 'Je suis le boute-en-train des fêtes';

  @override
  String get ipipItem2 => 'Je compatis aux sentiments des autres';

  @override
  String get ipipItem3 => 'Je fais mes corvées tout de suite';

  @override
  String get ipipItem4 => 'J’ai de fréquents changements d’humeur';

  @override
  String get ipipItem5 => 'J’ai une imagination débordante';

  @override
  String get ipipItem6 => 'Je ne parle pas beaucoup';

  @override
  String get ipipItem7 => 'Je ne m’intéresse pas aux problèmes des autres';

  @override
  String get ipipItem8 =>
      'J’oublie souvent de remettre les choses à leur place';

  @override
  String get ipipItem9 => 'Je suis détendu la plupart du temps';

  @override
  String get ipipItem10 => 'Je ne m’intéresse pas aux idées abstraites';

  @override
  String get ipipItem11 =>
      'Je parle à beaucoup de personnes différentes dans les fêtes';

  @override
  String get ipipItem12 => 'Je ressens les émotions des autres';

  @override
  String get ipipItem13 => 'J’aime l’ordre';

  @override
  String get ipipItem14 => 'Je me contrarie facilement';

  @override
  String get ipipItem15 => 'J’ai du mal à comprendre les idées abstraites';

  @override
  String get ipipItem16 => 'Je reste en retrait';

  @override
  String get ipipItem17 => 'Je ne m’intéresse pas vraiment aux autres';

  @override
  String get ipipItem18 => 'Je mets le désordre partout';

  @override
  String get ipipItem19 => 'Je me sens rarement triste';

  @override
  String get ipipItem20 => 'Je n’ai pas une bonne imagination';

  @override
  String get ipipAnswer1 => 'Très inexact';

  @override
  String get ipipAnswer2 => 'Plutôt inexact';

  @override
  String get ipipAnswer3 => 'Ni exact ni inexact';

  @override
  String get ipipAnswer4 => 'Plutôt exact';

  @override
  String get ipipAnswer5 => 'Très exact';

  @override
  String ipipAnswerSemantics(String n, String label) {
    return '$n, $label';
  }

  @override
  String onbStep(int stepNum, int totalNum) {
    return 'Étape $stepNum sur $totalNum';
  }

  @override
  String get onbNext => 'Suivant';

  @override
  String get onbCreate => 'Créer le profil';

  @override
  String get onbWelcome => 'Bienvenue à bord';

  @override
  String get onbWelcomeSub => 'Psychonaut, votre compagnon quotidien';

  @override
  String get onbIntro =>
      'Psychonaut vous compare à votre propre référence et suggère une petite action par jour. Un court questionnaire de 20 affirmations règle la rapidité avec laquelle il signale les changements et sa façon de vous parler. Vos réponses restent sur cet appareil.';

  @override
  String get onbName => 'Votre nom';

  @override
  String get onbRole => 'Votre rôle, par exemple Commandant';

  @override
  String get onbExploring => 'Vous voulez juste explorer ?';

  @override
  String get onbSampleHint => 'Chargez plutôt un profil d’exemple.';

  @override
  String get onbCancel => 'Annuler et garder mon profil actuel';

  @override
  String get onbAboutYou => 'À propos de vous';

  @override
  String onbItemsHint(int pageNum, int pagesNum) {
    return 'Décrivez-vous tel que vous êtes en général aujourd’hui, pas tel que vous voudriez être. Page $pageNum sur $pagesNum.';
  }

  @override
  String get onbLocusTitle => 'Quand les choses vont bien ou mal';

  @override
  String get onbLocusSub =>
      'Laquelle vous ressemble le plus ? Cela détermine la formulation des conseils.';

  @override
  String get onbLocusInternalTitle => 'Surtout mes choix et mes efforts';

  @override
  String get onbLocusInternalText =>
      'Ce qui m’arrive dépend surtout de ce que je fais.';

  @override
  String get onbLocusMixedTitle => 'Un mélange des deux';

  @override
  String get onbLocusMixedText =>
      'Mes efforts comptent, tout comme les circonstances que je ne contrôle pas.';

  @override
  String get onbLocusExternalTitle => 'Surtout les circonstances et les autres';

  @override
  String get onbLocusExternalText =>
      'Une grande partie de ce qui arrive échappe à mon contrôle.';

  @override
  String get onbToneTitle => 'Comment Psychonaut doit-il vous parler ?';

  @override
  String get onbToneSub => 'Vous pourrez le changer plus tard.';

  @override
  String get onbToneDirectEx =>
      '« Le sommeil a baissé de 0,8 h. Essayez une remise à zéro du sommeil ce soir. »';

  @override
  String get onbToneGentleEx =>
      '« Le sommeil a un peu bougé. Une soirée calme pourrait aider. »';

  @override
  String get onbActionsTitle => 'Qu’est-ce qui vous aide à vous ressourcer ?';

  @override
  String get onbActionsSub =>
      'Choisissez les actions que vous aimez. L’ordre de vos choix est l’ordre dans lequel elles sont proposées.';

  @override
  String get onbYourProfile => 'Votre profil';

  @override
  String get onbTraits => 'Traits de personnalité';

  @override
  String get onbTraitsNote =>
      'D’après une version courte de 20 items. Les traits modifient seulement la rapidité du signalement d’un changement. Ils ne vous étiquettent jamais.';

  @override
  String get onbPrefs => 'Vos préférences';

  @override
  String get onbActionsLabel => 'Actions';

  @override
  String get roleDefault => 'Équipier';

  @override
  String get importPickerTitle => 'Choisissez un fichier JSON de profil';

  @override
  String get reactionIntro =>
      'Ce test de 3 minutes mesure votre niveau de vigilance. Quand l’écran affiche « Touchez maintenant », touchez-le le plus vite possible. Ne touchez pas avant.';

  @override
  String get reactionKeyboardHint => 'Au clavier, appuyez sur Espace.';

  @override
  String get reactionWait => 'Attendez…';

  @override
  String get reactionTapNow => 'Touchez maintenant';

  @override
  String get reactionTooSoon => 'Trop tôt. Attendez le signal.';

  @override
  String reactionTimeLeft(String time) {
    return '$time restantes';
  }

  @override
  String get reactionDiscardHint =>
      'Revenir en arrière maintenant annule ce test.';

  @override
  String get reactionDoneTitle => 'Test terminé';

  @override
  String get reactionMean => 'Temps de réaction moyen';

  @override
  String get reactionResponses => 'Réponses';

  @override
  String get reactionLapses => 'Lapsus (plus de 500 ms)';

  @override
  String get reactionFalseStarts => 'Faux départs';

  @override
  String get reactionSaved => 'Enregistré. Vous pouvez le voir dans Tendances.';

  @override
  String get reactionNoResponses =>
      'Aucune réponse n’a été enregistrée, donc rien n’a été sauvegardé.';

  @override
  String get reactionDone => 'Terminé';
}
