import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_ja.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('ja'),
  ];

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navCheckIn.
  ///
  /// In en, this message translates to:
  /// **'Check in'**
  String get navCheckIn;

  /// No description provided for @navTrends.
  ///
  /// In en, this message translates to:
  /// **'Trends'**
  String get navTrends;

  /// No description provided for @navCrew.
  ///
  /// In en, this message translates to:
  /// **'Crew'**
  String get navCrew;

  /// No description provided for @profileAndSettings.
  ///
  /// In en, this message translates to:
  /// **'Profile and settings'**
  String get profileAndSettings;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @sampleData.
  ///
  /// In en, this message translates to:
  /// **'Sample data'**
  String get sampleData;

  /// No description provided for @disclaimer.
  ///
  /// In en, this message translates to:
  /// **'Psychonaut does not diagnose or replace a clinician.'**
  String get disclaimer;

  /// No description provided for @statusOnCourse.
  ///
  /// In en, this message translates to:
  /// **'On course'**
  String get statusOnCourse;

  /// No description provided for @statusDrifting.
  ///
  /// In en, this message translates to:
  /// **'Drifting'**
  String get statusDrifting;

  /// No description provided for @statusOffCourse.
  ///
  /// In en, this message translates to:
  /// **'Off course'**
  String get statusOffCourse;

  /// No description provided for @statusAlert.
  ///
  /// In en, this message translates to:
  /// **'Alert'**
  String get statusAlert;

  /// No description provided for @traitSemantics.
  ///
  /// In en, this message translates to:
  /// **'{label} {valueNum} out of 100'**
  String traitSemantics(String label, int valueNum);

  /// No description provided for @indicatorMood.
  ///
  /// In en, this message translates to:
  /// **'Mood'**
  String get indicatorMood;

  /// No description provided for @indicatorStress.
  ///
  /// In en, this message translates to:
  /// **'Stress'**
  String get indicatorStress;

  /// No description provided for @indicatorSleep.
  ///
  /// In en, this message translates to:
  /// **'Sleep'**
  String get indicatorSleep;

  /// No description provided for @indicatorFocus.
  ///
  /// In en, this message translates to:
  /// **'Focus'**
  String get indicatorFocus;

  /// No description provided for @indicatorMotivation.
  ///
  /// In en, this message translates to:
  /// **'Motivation'**
  String get indicatorMotivation;

  /// No description provided for @indicatorConnection.
  ///
  /// In en, this message translates to:
  /// **'Connection'**
  String get indicatorConnection;

  /// No description provided for @indicatorWorkload.
  ///
  /// In en, this message translates to:
  /// **'Workload'**
  String get indicatorWorkload;

  /// No description provided for @indicatorReaction.
  ///
  /// In en, this message translates to:
  /// **'Reaction time'**
  String get indicatorReaction;

  /// No description provided for @trendImproving.
  ///
  /// In en, this message translates to:
  /// **'improving'**
  String get trendImproving;

  /// No description provided for @trendSteady.
  ///
  /// In en, this message translates to:
  /// **'steady'**
  String get trendSteady;

  /// No description provided for @trendSlipping.
  ///
  /// In en, this message translates to:
  /// **'slipping'**
  String get trendSlipping;

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'Your heading'**
  String get homeTitle;

  /// No description provided for @missionLine.
  ///
  /// In en, this message translates to:
  /// **'Mission day {dayNum} · {phase}'**
  String missionLine(int dayNum, String phase);

  /// No description provided for @headingSemantics.
  ///
  /// In en, this message translates to:
  /// **'{degreesNum} degrees off course. Overall {status}.'**
  String headingSemantics(int degreesNum, String status);

  /// No description provided for @headingOffCourse.
  ///
  /// In en, this message translates to:
  /// **'off course'**
  String get headingOffCourse;

  /// No description provided for @headingMeasured.
  ///
  /// In en, this message translates to:
  /// **'Measured against your own baseline.'**
  String get headingMeasured;

  /// No description provided for @mismatchTitle.
  ///
  /// In en, this message translates to:
  /// **'What you say and what your body shows differ'**
  String get mismatchTitle;

  /// No description provided for @mismatchBody.
  ///
  /// In en, this message translates to:
  /// **'You rated mood {mood}, at or above your baseline, but {details}. Both can be true. It is worth a closer look.'**
  String mismatchBody(String mood, String details);

  /// No description provided for @mismatchDetailSleep.
  ///
  /// In en, this message translates to:
  /// **'sleep has been below your baseline for {daysNum} days'**
  String mismatchDetailSleep(int daysNum);

  /// No description provided for @mismatchDetailReaction.
  ///
  /// In en, this message translates to:
  /// **'reaction time has been slower than your baseline for {daysNum} days'**
  String mismatchDetailReaction(int daysNum);

  /// No description provided for @mismatchJoin.
  ///
  /// In en, this message translates to:
  /// **'{first} and {second}'**
  String mismatchJoin(String first, String second);

  /// No description provided for @lifeEventTitle.
  ///
  /// In en, this message translates to:
  /// **'Something happened at home'**
  String get lifeEventTitle;

  /// No description provided for @lifeEventCardBody.
  ///
  /// In en, this message translates to:
  /// **'That is hard to carry from so far away. You don\'t have to handle it alone. Mood is watched more closely for the next 14 days, and Message home is offered first.'**
  String get lifeEventCardBody;

  /// No description provided for @reactionPromptTitle.
  ///
  /// In en, this message translates to:
  /// **'Time for your reaction test'**
  String get reactionPromptTitle;

  /// No description provided for @reactionPromptText.
  ///
  /// In en, this message translates to:
  /// **'Three minutes. It shows fatigue before you feel it.'**
  String get reactionPromptText;

  /// No description provided for @reactionPromptButton.
  ///
  /// In en, this message translates to:
  /// **'Start test'**
  String get reactionPromptButton;

  /// No description provided for @logOpenTitle.
  ///
  /// In en, this message translates to:
  /// **'Captain\'s log is open'**
  String get logOpenTitle;

  /// No description provided for @logOpenText.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t logged today.'**
  String get logOpenText;

  /// No description provided for @logEntry.
  ///
  /// In en, this message translates to:
  /// **'Log entry'**
  String get logEntry;

  /// No description provided for @readingPreparing.
  ///
  /// In en, this message translates to:
  /// **'Preparing your reading'**
  String get readingPreparing;

  /// No description provided for @readingUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Your reading is not available right now.'**
  String get readingUnavailable;

  /// No description provided for @readingTitle.
  ///
  /// In en, this message translates to:
  /// **'Today\'s reading'**
  String get readingTitle;

  /// No description provided for @readingFixedAlertNote.
  ///
  /// In en, this message translates to:
  /// **'Fixed safety message, not AI-generated.'**
  String get readingFixedAlertNote;

  /// No description provided for @aiGenerated.
  ///
  /// In en, this message translates to:
  /// **'AI-generated'**
  String get aiGenerated;

  /// No description provided for @suggestedAction.
  ///
  /// In en, this message translates to:
  /// **'Suggested action'**
  String get suggestedAction;

  /// No description provided for @readingSource.
  ///
  /// In en, this message translates to:
  /// **'Source: {source}'**
  String readingSource(String source);

  /// No description provided for @sourceRuleBased.
  ///
  /// In en, this message translates to:
  /// **'Rule-based · on this device'**
  String get sourceRuleBased;

  /// No description provided for @sourceOnBoard.
  ///
  /// In en, this message translates to:
  /// **'On-board model'**
  String get sourceOnBoard;

  /// No description provided for @sourceCloud.
  ///
  /// In en, this message translates to:
  /// **'Cloud model'**
  String get sourceCloud;

  /// No description provided for @loadError.
  ///
  /// In en, this message translates to:
  /// **'Could not load your data.\n{error}'**
  String loadError(String error);

  /// No description provided for @indicatorsTitle.
  ///
  /// In en, this message translates to:
  /// **'Indicators'**
  String get indicatorsTitle;

  /// No description provided for @panelMindMap.
  ///
  /// In en, this message translates to:
  /// **'Mind map'**
  String get panelMindMap;

  /// No description provided for @panelSelected.
  ///
  /// In en, this message translates to:
  /// **'Selected indicator'**
  String get panelSelected;

  /// No description provided for @chartLast14.
  ///
  /// In en, this message translates to:
  /// **'{indicator}, last 14 days'**
  String chartLast14(String indicator);

  /// No description provided for @chartSleep14.
  ///
  /// In en, this message translates to:
  /// **'Sleep, 14 nights'**
  String get chartSleep14;

  /// No description provided for @tileSemantics.
  ///
  /// In en, this message translates to:
  /// **'{indicator}, {status}, {trend}'**
  String tileSemantics(String indicator, String status, String trend);

  /// No description provided for @trendNoData.
  ///
  /// In en, this message translates to:
  /// **'No data yet'**
  String get trendNoData;

  /// No description provided for @trendAtBaseline.
  ///
  /// In en, this message translates to:
  /// **'At your baseline'**
  String get trendAtBaseline;

  /// No description provided for @trendAbove.
  ///
  /// In en, this message translates to:
  /// **'{amount} above baseline'**
  String trendAbove(String amount);

  /// No description provided for @trendBelow.
  ///
  /// In en, this message translates to:
  /// **'{amount} below baseline'**
  String trendBelow(String amount);

  /// No description provided for @trendJoin.
  ///
  /// In en, this message translates to:
  /// **'{where}, {trend}'**
  String trendJoin(String where, String trend);

  /// No description provided for @detailNow.
  ///
  /// In en, this message translates to:
  /// **'Now {now} · your baseline {baseline} · {trend}'**
  String detailNow(String now, String baseline, String trend);

  /// No description provided for @flaggedSooner.
  ///
  /// In en, this message translates to:
  /// **'Watched a day sooner for you, based on your profile.'**
  String get flaggedSooner;

  /// No description provided for @detailHowMeasured.
  ///
  /// In en, this message translates to:
  /// **'How it\'s measured'**
  String get detailHowMeasured;

  /// No description provided for @detailWhy.
  ///
  /// In en, this message translates to:
  /// **'Why it matters'**
  String get detailWhy;

  /// No description provided for @detailWhatToDo.
  ///
  /// In en, this message translates to:
  /// **'What to do now'**
  String get detailWhatToDo;

  /// No description provided for @whatToDoOptions.
  ///
  /// In en, this message translates to:
  /// **'{text} Options: {options}.'**
  String whatToDoOptions(String text, String options);

  /// No description provided for @whatToDoRecommended.
  ///
  /// In en, this message translates to:
  /// **'{text} Recommended: {action}.'**
  String whatToDoRecommended(String text, String action);

  /// No description provided for @whatToDoOneStep.
  ///
  /// In en, this message translates to:
  /// **'One step: {action}. {description}'**
  String whatToDoOneStep(String action, String description);

  /// No description provided for @nasaRiskLabel.
  ///
  /// In en, this message translates to:
  /// **'NASA risk'**
  String get nasaRiskLabel;

  /// No description provided for @nasaHazardLabel.
  ///
  /// In en, this message translates to:
  /// **'Hazard'**
  String get nasaHazardLabel;

  /// No description provided for @labelValue.
  ///
  /// In en, this message translates to:
  /// **'{label}: {value}'**
  String labelValue(String label, String value);

  /// No description provided for @unitHours.
  ///
  /// In en, this message translates to:
  /// **'{value} h'**
  String unitHours(String value);

  /// No description provided for @unitMs.
  ///
  /// In en, this message translates to:
  /// **'{value} ms'**
  String unitMs(String value);

  /// No description provided for @refMeasuredMood.
  ///
  /// In en, this message translates to:
  /// **'Your daily self-rating from 1 to 10 in the Captain\'s log, compared with your own baseline.'**
  String get refMeasuredMood;

  /// No description provided for @refWhyMood.
  ///
  /// In en, this message translates to:
  /// **'Small, steady dips in mood are easier to fix early. Watching mood against your baseline is more useful than any single day.'**
  String get refWhyMood;

  /// No description provided for @refTodoMood.
  ///
  /// In en, this message translates to:
  /// **'Log honestly, then pick one small action. Tell a crewmate if low days keep adding up.'**
  String get refTodoMood;

  /// No description provided for @refMeasuredStress.
  ///
  /// In en, this message translates to:
  /// **'Your daily stress rating from 1 to 10, compared with your own baseline. Higher is less favourable.'**
  String get refMeasuredStress;

  /// No description provided for @refWhyStress.
  ///
  /// In en, this message translates to:
  /// **'Long confinement keeps stress levels raised. Rising stress also tends to cut into sleep and focus.'**
  String get refWhyStress;

  /// No description provided for @refTodoStress.
  ///
  /// In en, this message translates to:
  /// **'Slow your breathing for two minutes, move your body, or hand off one task for today.'**
  String get refTodoStress;

  /// No description provided for @refMeasuredSleep.
  ///
  /// In en, this message translates to:
  /// **'Hours slept each night, from the sleep tracker or sample data. 7 to 8 hours is the healthy range; 6 hours or less is short sleep.'**
  String get refMeasuredSleep;

  /// No description provided for @refWhySleep.
  ///
  /// In en, this message translates to:
  /// **'Sleep loss and irregular schedules slow reactions, lower mood and make small problems feel bigger.'**
  String get refWhySleep;

  /// No description provided for @refTodoSleep.
  ///
  /// In en, this message translates to:
  /// **'Keep a fixed lights-out time, dim screens an hour before and cool the cabin for a sleep reset.'**
  String get refTodoSleep;

  /// No description provided for @refMeasuredFocus.
  ///
  /// In en, this message translates to:
  /// **'Your focus rating from 1 to 10, together with the lapse count from the reaction test.'**
  String get refMeasuredFocus;

  /// No description provided for @refWhyFocus.
  ///
  /// In en, this message translates to:
  /// **'Attention is the first thing to slip when sleep or workload goes wrong, and errors cost the most in flight.'**
  String get refWhyFocus;

  /// No description provided for @refTodoFocus.
  ///
  /// In en, this message translates to:
  /// **'Take a real break away from screens, then do one task at a time. Check your sleep first.'**
  String get refTodoFocus;

  /// No description provided for @refMeasuredMotivation.
  ///
  /// In en, this message translates to:
  /// **'Your engagement rating from 1 to 10, compared with your own baseline.'**
  String get refMeasuredMotivation;

  /// No description provided for @refWhyMotivation.
  ///
  /// In en, this message translates to:
  /// **'Long, repetitive missions invite boredom. Falling engagement can come before low mood.'**
  String get refWhyMotivation;

  /// No description provided for @refTodoMotivation.
  ///
  /// In en, this message translates to:
  /// **'Start a small new project or change the order of your day for variety.'**
  String get refTodoMotivation;

  /// No description provided for @refMeasuredConnection.
  ///
  /// In en, this message translates to:
  /// **'Your crew connection rating from 1 to 10, compared with your own baseline.'**
  String get refMeasuredConnection;

  /// No description provided for @refWhyConnection.
  ///
  /// In en, this message translates to:
  /// **'Good teamwork depends on feeling connected. Distance from Earth also makes contact with family slower and rarer.'**
  String get refWhyConnection;

  /// No description provided for @refTodoConnection.
  ///
  /// In en, this message translates to:
  /// **'Share a meal with the crew or send a message home. Small contact counts.'**
  String get refTodoConnection;

  /// No description provided for @refMeasuredWorkload.
  ///
  /// In en, this message translates to:
  /// **'Your workload rating from 1 to 10, compared with your own baseline. Higher is less favourable.'**
  String get refMeasuredWorkload;

  /// No description provided for @refWhyWorkload.
  ///
  /// In en, this message translates to:
  /// **'Work overload eats into sleep. With delays to Earth, crews must manage their own pace.'**
  String get refWhyWorkload;

  /// No description provided for @refTodoWorkload.
  ///
  /// In en, this message translates to:
  /// **'Move one task to tomorrow, or ask the crew to share it. Protect your sleep window.'**
  String get refTodoWorkload;

  /// No description provided for @refMeasuredReaction.
  ///
  /// In en, this message translates to:
  /// **'A 3-minute reaction test. You tap as fast as you can when a stimulus appears. We record your mean response time, lapses (slower than 500 ms) and false starts.'**
  String get refMeasuredReaction;

  /// No description provided for @refWhyReaction.
  ///
  /// In en, this message translates to:
  /// **'Slow or lapsing responses are one of the earliest signs of fatigue and drifting attention, often before you feel it yourself.'**
  String get refWhyReaction;

  /// No description provided for @refTodoReaction.
  ///
  /// In en, this message translates to:
  /// **'Repeat the test every few days at a similar time of day, and compare with your own baseline.'**
  String get refTodoReaction;

  /// No description provided for @actionExerciseTitle.
  ///
  /// In en, this message translates to:
  /// **'Exercise'**
  String get actionExerciseTitle;

  /// No description provided for @actionExerciseDesc.
  ///
  /// In en, this message translates to:
  /// **'A short workout on the treadmill or bike.'**
  String get actionExerciseDesc;

  /// No description provided for @actionJournalTitle.
  ///
  /// In en, this message translates to:
  /// **'Journal'**
  String get actionJournalTitle;

  /// No description provided for @actionJournalDesc.
  ///
  /// In en, this message translates to:
  /// **'Ten minutes of private writing about your day.'**
  String get actionJournalDesc;

  /// No description provided for @actionFamilyCallTitle.
  ///
  /// In en, this message translates to:
  /// **'Message home'**
  String get actionFamilyCallTitle;

  /// No description provided for @actionFamilyCallDesc.
  ///
  /// In en, this message translates to:
  /// **'Send a message or schedule a call with someone on Earth.'**
  String get actionFamilyCallDesc;

  /// No description provided for @actionGardenTitle.
  ///
  /// In en, this message translates to:
  /// **'Window and garden time'**
  String get actionGardenTitle;

  /// No description provided for @actionGardenDesc.
  ///
  /// In en, this message translates to:
  /// **'Spend time at the window or with the plants.'**
  String get actionGardenDesc;

  /// No description provided for @actionWindowTimeTitle.
  ///
  /// In en, this message translates to:
  /// **'Window time'**
  String get actionWindowTimeTitle;

  /// No description provided for @actionWindowTimeDesc.
  ///
  /// In en, this message translates to:
  /// **'Spend ten minutes at the window looking at Earth or the stars.'**
  String get actionWindowTimeDesc;

  /// No description provided for @actionNewProjectTitle.
  ///
  /// In en, this message translates to:
  /// **'Start a small project'**
  String get actionNewProjectTitle;

  /// No description provided for @actionNewProjectDesc.
  ///
  /// In en, this message translates to:
  /// **'Pick a short, new task to break the routine.'**
  String get actionNewProjectDesc;

  /// No description provided for @actionSleepResetTitle.
  ///
  /// In en, this message translates to:
  /// **'Sleep reset'**
  String get actionSleepResetTitle;

  /// No description provided for @actionSleepResetDesc.
  ///
  /// In en, this message translates to:
  /// **'Fixed lights-out, dim screens and a cooler cabin for one night.'**
  String get actionSleepResetDesc;

  /// No description provided for @aiRuleBasedLabel.
  ///
  /// In en, this message translates to:
  /// **'Rule-based'**
  String get aiRuleBasedLabel;

  /// No description provided for @aiRuleBasedDesc.
  ///
  /// In en, this message translates to:
  /// **'Templates on this device. No network. Default.'**
  String get aiRuleBasedDesc;

  /// No description provided for @aiOnBoardLabel.
  ///
  /// In en, this message translates to:
  /// **'On-board model'**
  String get aiOnBoardLabel;

  /// No description provided for @aiOnBoardDesc.
  ///
  /// In en, this message translates to:
  /// **'A model running on this computer or the ship\'s network. Nothing leaves the vehicle. Falls back to rule-based if it is not running.'**
  String get aiOnBoardDesc;

  /// No description provided for @aiCloudLabel.
  ///
  /// In en, this message translates to:
  /// **'Cloud model'**
  String get aiCloudLabel;

  /// No description provided for @aiCloudDesc.
  ///
  /// In en, this message translates to:
  /// **'A large language model over the internet. For use on Earth only. Sends your scores and personality profile, never your name or notes.'**
  String get aiCloudDesc;

  /// No description provided for @phaseAdjustment.
  ///
  /// In en, this message translates to:
  /// **'Adjustment'**
  String get phaseAdjustment;

  /// No description provided for @phaseAdjustmentNote.
  ///
  /// In en, this message translates to:
  /// **'Settling in. Routines are still forming.'**
  String get phaseAdjustmentNote;

  /// No description provided for @phaseMid.
  ///
  /// In en, this message translates to:
  /// **'Mid-mission'**
  String get phaseMid;

  /// No description provided for @phaseMidNote.
  ///
  /// In en, this message translates to:
  /// **'Steady state. Watch for slow drift.'**
  String get phaseMidNote;

  /// No description provided for @phaseLate.
  ///
  /// In en, this message translates to:
  /// **'Late mission'**
  String get phaseLate;

  /// No description provided for @phaseLateNote.
  ///
  /// In en, this message translates to:
  /// **'Past day 150 the watch is tighter. Behavioural symptoms rise after 5 to 6 months in analog studies.'**
  String get phaseLateNote;

  /// No description provided for @riskBehavioral.
  ///
  /// In en, this message translates to:
  /// **'Behavioral conditions'**
  String get riskBehavioral;

  /// No description provided for @riskTeamwork.
  ///
  /// In en, this message translates to:
  /// **'Inadequate teamwork'**
  String get riskTeamwork;

  /// No description provided for @riskSleep.
  ///
  /// In en, this message translates to:
  /// **'Inadequate sleep and irregular schedules'**
  String get riskSleep;

  /// No description provided for @hazardIsolation.
  ///
  /// In en, this message translates to:
  /// **'Isolation and confinement'**
  String get hazardIsolation;

  /// No description provided for @hazardDistance.
  ///
  /// In en, this message translates to:
  /// **'Distance from Earth'**
  String get hazardDistance;

  /// No description provided for @toneDirect.
  ///
  /// In en, this message translates to:
  /// **'Direct'**
  String get toneDirect;

  /// No description provided for @toneGentle.
  ///
  /// In en, this message translates to:
  /// **'Gentle'**
  String get toneGentle;

  /// No description provided for @framingInternal.
  ///
  /// In en, this message translates to:
  /// **'Internal: data and options'**
  String get framingInternal;

  /// No description provided for @framingMixed.
  ///
  /// In en, this message translates to:
  /// **'Mixed: data and one recommendation'**
  String get framingMixed;

  /// No description provided for @framingExternal.
  ///
  /// In en, this message translates to:
  /// **'External: one clear step'**
  String get framingExternal;

  /// No description provided for @copingProblem.
  ///
  /// In en, this message translates to:
  /// **'Problem-focused'**
  String get copingProblem;

  /// No description provided for @copingEmotion.
  ///
  /// In en, this message translates to:
  /// **'Emotion-focused'**
  String get copingEmotion;

  /// No description provided for @copingAvoidant.
  ///
  /// In en, this message translates to:
  /// **'Avoidant'**
  String get copingAvoidant;

  /// No description provided for @sourceMiniIpip.
  ///
  /// In en, this message translates to:
  /// **'Mini-IPIP questionnaire'**
  String get sourceMiniIpip;

  /// No description provided for @sourceIpipNeo120.
  ///
  /// In en, this message translates to:
  /// **'IPIP-NEO-120 questionnaire'**
  String get sourceIpipNeo120;

  /// No description provided for @sourceImported.
  ///
  /// In en, this message translates to:
  /// **'Imported file'**
  String get sourceImported;

  /// No description provided for @alertMessage.
  ///
  /// In en, this message translates to:
  /// **'Tell your crew medical officer and prepare a summary for Earth'**
  String get alertMessage;

  /// No description provided for @sourceUnavailableNote.
  ///
  /// In en, this message translates to:
  /// **'{source} unavailable, so this reading came from the rule-based source.'**
  String sourceUnavailableNote(String source);

  /// No description provided for @insOnCourseDirect.
  ///
  /// In en, this message translates to:
  /// **'You are on course at {degreesNum}° off, and every reading sits close to your own baseline.'**
  String insOnCourseDirect(int degreesNum);

  /// No description provided for @insOnCourseGentle.
  ///
  /// In en, this message translates to:
  /// **'You\'re on course, just {degreesNum}° off, and your readings sit close to your own normal.'**
  String insOnCourseGentle(int degreesNum);

  /// No description provided for @insWorstGentle.
  ///
  /// In en, this message translates to:
  /// **'{indicator} has moved a little: {current} now against your usual {baseline}, and it is {trend}.'**
  String insWorstGentle(
    String indicator,
    String current,
    String baseline,
    String trend,
  );

  /// No description provided for @insWorstDirect.
  ///
  /// In en, this message translates to:
  /// **'{indicator} is {status} at {current} against your baseline of {baseline}, and it is {trend}.'**
  String insWorstDirect(
    String indicator,
    String status,
    String current,
    String baseline,
    String trend,
  );

  /// No description provided for @insMismatchGentle.
  ///
  /// In en, this message translates to:
  /// **'You said you feel fine, and that counts, but your body data has been off baseline for {daysNum} days.'**
  String insMismatchGentle(int daysNum);

  /// No description provided for @insMismatchDirect.
  ///
  /// In en, this message translates to:
  /// **'You rated mood at or above baseline, but your body data has been off baseline for {daysNum} days.'**
  String insMismatchDirect(int daysNum);

  /// No description provided for @insLifeGentle.
  ///
  /// In en, this message translates to:
  /// **'You noted something from home, so mood is being watched a little more closely for now.'**
  String get insLifeGentle;

  /// No description provided for @insLifeDirect.
  ///
  /// In en, this message translates to:
  /// **'You logged something from home, so mood is watched more closely for 14 days.'**
  String get insLifeDirect;

  /// No description provided for @insActionGentle.
  ///
  /// In en, this message translates to:
  /// **'One small step could help today: {action}.'**
  String insActionGentle(String action);

  /// No description provided for @insActionDirect.
  ///
  /// In en, this message translates to:
  /// **'One small action today: {action}.'**
  String insActionDirect(String action);

  /// No description provided for @insEvidenceAllOk.
  ///
  /// In en, this message translates to:
  /// **'All readings are within one standard deviation of your own baseline.'**
  String get insEvidenceAllOk;

  /// No description provided for @insEvidence.
  ///
  /// In en, this message translates to:
  /// **'{indicator}: {current} against a baseline of {baseline}.'**
  String insEvidence(String indicator, String current, String baseline);

  /// No description provided for @insEvidenceBeyond.
  ///
  /// In en, this message translates to:
  /// **'{indicator}: {current} against a baseline of {baseline}, beyond {sd} SD for {count, plural, =1{1 day} other{{count} days}}.'**
  String insEvidenceBeyond(
    String indicator,
    String current,
    String baseline,
    String sd,
    int count,
  );

  /// No description provided for @insNights.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 recent night of 6 hours or less.} other{{count} recent nights of 6 hours or less.}}'**
  String insNights(int count);

  /// No description provided for @insLapses.
  ///
  /// In en, this message translates to:
  /// **'Lapses in the reaction test are above your usual.'**
  String get insLapses;

  /// No description provided for @insOptions.
  ///
  /// In en, this message translates to:
  /// **'Options: {options}'**
  String insOptions(String options);

  /// No description provided for @insRecommended.
  ///
  /// In en, this message translates to:
  /// **'Recommended: {action}. {description}'**
  String insRecommended(String action, String description);

  /// No description provided for @insRecommendedStep.
  ///
  /// In en, this message translates to:
  /// **'Recommended step: {action}. {description} Just this one step today.'**
  String insRecommendedStep(String action, String description);

  /// No description provided for @insLatePhase.
  ///
  /// In en, this message translates to:
  /// **'After mission day 150 the watch is tighter, so smaller changes are flagged.'**
  String get insLatePhase;

  /// No description provided for @insLifeSupport.
  ///
  /// In en, this message translates to:
  /// **'Hearing from home can be heavy. Reaching out to someone you trust may help.'**
  String get insLifeSupport;

  /// No description provided for @trendsTitle.
  ///
  /// In en, this message translates to:
  /// **'Course deviation'**
  String get trendsTitle;

  /// No description provided for @trendsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'How you are drifting from your own baseline'**
  String get trendsSubtitle;

  /// No description provided for @trendsSleepTitle.
  ///
  /// In en, this message translates to:
  /// **'Sleep, last 14 nights'**
  String get trendsSleepTitle;

  /// No description provided for @trendsNoTests.
  ///
  /// In en, this message translates to:
  /// **'No tests yet'**
  String get trendsNoTests;

  /// No description provided for @trendsLatestReaction.
  ///
  /// In en, this message translates to:
  /// **'Latest {ms} · {count, plural, =1{1 lapse} other{{count} lapses}}'**
  String trendsLatestReaction(String ms, int count);

  /// No description provided for @trendsNasaLine.
  ///
  /// In en, this message translates to:
  /// **'NASA risk: {risk}. Hazard: {hazards}.'**
  String trendsNasaLine(String risk, String hazards);

  /// No description provided for @correctionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Course corrections'**
  String get correctionsTitle;

  /// No description provided for @correctionsHint.
  ///
  /// In en, this message translates to:
  /// **'Pick one small action. Your preferred ones come first.'**
  String get correctionsHint;

  /// No description provided for @correctionsPlan.
  ///
  /// In en, this message translates to:
  /// **'Your plan: {title}. {description}'**
  String correctionsPlan(String title, String description);

  /// No description provided for @correctionsSuggested.
  ///
  /// In en, this message translates to:
  /// **'Suggested'**
  String get correctionsSuggested;

  /// No description provided for @actionSemantics.
  ///
  /// In en, this message translates to:
  /// **'{title}. {description}'**
  String actionSemantics(String title, String description);

  /// No description provided for @actionSemanticsSuggested.
  ///
  /// In en, this message translates to:
  /// **'{title}. {description} Suggested for today.'**
  String actionSemanticsSuggested(String title, String description);

  /// No description provided for @chartNoSleep.
  ///
  /// In en, this message translates to:
  /// **'No sleep data yet.'**
  String get chartNoSleep;

  /// No description provided for @chartBaselineValue.
  ///
  /// In en, this message translates to:
  /// **'Your baseline {value}'**
  String chartBaselineValue(String value);

  /// No description provided for @chartBaseline.
  ///
  /// In en, this message translates to:
  /// **'Your baseline'**
  String get chartBaseline;

  /// No description provided for @chartTooltipSleep.
  ///
  /// In en, this message translates to:
  /// **'{value}\n{status}'**
  String chartTooltipSleep(String value, String status);

  /// No description provided for @chartSleepSemantics.
  ///
  /// In en, this message translates to:
  /// **'Sleep over the last {count} nights. Baseline {baseline}. Latest night {latest}, {status}.'**
  String chartSleepSemantics(
    int count,
    String baseline,
    String latest,
    String status,
  );

  /// No description provided for @chartToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get chartToday;

  /// No description provided for @chartNeedTests.
  ///
  /// In en, this message translates to:
  /// **'Take the reaction test a few times to see your trend.'**
  String get chartNeedTests;

  /// No description provided for @chartReactionSemantics.
  ///
  /// In en, this message translates to:
  /// **'Reaction time over the last {count} tests. Baseline {baseline}. Latest {latest}.'**
  String chartReactionSemantics(int count, String baseline, String latest);

  /// No description provided for @chartNotEnough.
  ///
  /// In en, this message translates to:
  /// **'Not enough data yet.'**
  String get chartNotEnough;

  /// No description provided for @chartDaysAgo.
  ///
  /// In en, this message translates to:
  /// **'-{daysNum}d'**
  String chartDaysAgo(int daysNum);

  /// No description provided for @checkinTitle.
  ///
  /// In en, this message translates to:
  /// **'Captain\'s log'**
  String get checkinTitle;

  /// No description provided for @checkinSubtitle.
  ///
  /// In en, this message translates to:
  /// **'How are you today? Be honest. There are no wrong answers.'**
  String get checkinSubtitle;

  /// No description provided for @qEngagement.
  ///
  /// In en, this message translates to:
  /// **'Engagement'**
  String get qEngagement;

  /// No description provided for @qConnection.
  ///
  /// In en, this message translates to:
  /// **'Crew connection'**
  String get qConnection;

  /// No description provided for @scaleLow.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get scaleLow;

  /// No description provided for @scaleHigh.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get scaleHigh;

  /// No description provided for @scaleCalm.
  ///
  /// In en, this message translates to:
  /// **'Calm'**
  String get scaleCalm;

  /// No description provided for @scaleVeryStressed.
  ///
  /// In en, this message translates to:
  /// **'Very stressed'**
  String get scaleVeryStressed;

  /// No description provided for @scaleLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get scaleLight;

  /// No description provided for @scaleOverloaded.
  ///
  /// In en, this message translates to:
  /// **'Overloaded'**
  String get scaleOverloaded;

  /// No description provided for @scaleBored.
  ///
  /// In en, this message translates to:
  /// **'Bored'**
  String get scaleBored;

  /// No description provided for @scaleAbsorbed.
  ///
  /// In en, this message translates to:
  /// **'Absorbed'**
  String get scaleAbsorbed;

  /// No description provided for @scaleScattered.
  ///
  /// In en, this message translates to:
  /// **'Scattered'**
  String get scaleScattered;

  /// No description provided for @scaleSharp.
  ///
  /// In en, this message translates to:
  /// **'Sharp'**
  String get scaleSharp;

  /// No description provided for @scaleDistant.
  ///
  /// In en, this message translates to:
  /// **'Distant'**
  String get scaleDistant;

  /// No description provided for @scaleClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get scaleClose;

  /// No description provided for @checkinStreak.
  ///
  /// In en, this message translates to:
  /// **'{count}-day streak'**
  String checkinStreak(int count);

  /// No description provided for @checkinStreakSemantics.
  ///
  /// In en, this message translates to:
  /// **'Logging streak: {count, plural, =1{1 day} other{{count} days}}'**
  String checkinStreakSemantics(int count);

  /// No description provided for @checkinStreakNote.
  ///
  /// In en, this message translates to:
  /// **'Counts days you logged, never how the scores look.'**
  String get checkinStreakNote;

  /// No description provided for @checkinOptional.
  ///
  /// In en, this message translates to:
  /// **'Optional.'**
  String get checkinOptional;

  /// No description provided for @checkinNoteLabel.
  ///
  /// In en, this message translates to:
  /// **'Private note'**
  String get checkinNoteLabel;

  /// No description provided for @checkinNoteHelper.
  ///
  /// In en, this message translates to:
  /// **'Stays on this device. Never sent anywhere.'**
  String get checkinNoteHelper;

  /// No description provided for @checkinUpdate.
  ///
  /// In en, this message translates to:
  /// **'Update today\'s entry'**
  String get checkinUpdate;

  /// No description provided for @checkinLogged.
  ///
  /// In en, this message translates to:
  /// **'Entry logged. Thank you.'**
  String get checkinLogged;

  /// No description provided for @sliderSemantics.
  ///
  /// In en, this message translates to:
  /// **'{label} {valueNum} out of 10'**
  String sliderSemantics(String label, int valueNum);

  /// No description provided for @crewTitle.
  ///
  /// In en, this message translates to:
  /// **'Ship morale'**
  String get crewTitle;

  /// No description provided for @crewSubtitle.
  ///
  /// In en, this message translates to:
  /// **'How the crew is doing, as one anonymous number'**
  String get crewSubtitle;

  /// No description provided for @moraleHigh.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get moraleHigh;

  /// No description provided for @moraleSteady.
  ///
  /// In en, this message translates to:
  /// **'Steady'**
  String get moraleSteady;

  /// No description provided for @moraleStrained.
  ///
  /// In en, this message translates to:
  /// **'Strained'**
  String get moraleStrained;

  /// No description provided for @moraleLow.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get moraleLow;

  /// No description provided for @crewOutOf100.
  ///
  /// In en, this message translates to:
  /// **'/ 100'**
  String get crewOutOf100;

  /// No description provided for @crewMeterSemantics.
  ///
  /// In en, this message translates to:
  /// **'Crew morale {level}, {scoreNum} out of 100. {contributedNum} of {crewNum} crew checked in today.'**
  String crewMeterSemantics(
    String level,
    int scoreNum,
    int contributedNum,
    int crewNum,
  );

  /// No description provided for @crewCheckedIn.
  ///
  /// In en, this message translates to:
  /// **'{contributedNum} of {crewNum} crew checked in today. Names are never shown.'**
  String crewCheckedIn(int contributedNum, int crewNum);

  /// No description provided for @crewGoalLabel.
  ///
  /// In en, this message translates to:
  /// **'Shared weekly goal'**
  String get crewGoalLabel;

  /// No description provided for @crewGoalTitle.
  ///
  /// In en, this message translates to:
  /// **'Share an evening meal together'**
  String get crewGoalTitle;

  /// No description provided for @crewGoalDesc.
  ///
  /// In en, this message translates to:
  /// **'Eat one evening meal with the crew on 6 evenings this week. Short and unhurried is fine.'**
  String get crewGoalDesc;

  /// No description provided for @crewGoalProgress.
  ///
  /// In en, this message translates to:
  /// **'{doneNum} of {segmentsNum} evenings done · {peopleNum} crew joined'**
  String crewGoalProgress(int doneNum, int segmentsNum, int peopleNum);

  /// No description provided for @crewGoalSemantics.
  ///
  /// In en, this message translates to:
  /// **'{doneNum} of {segmentsNum} evenings done'**
  String crewGoalSemantics(int doneNum, int segmentsNum);

  /// No description provided for @crewJoin.
  ///
  /// In en, this message translates to:
  /// **'Join this goal'**
  String get crewJoin;

  /// No description provided for @crewLeave.
  ///
  /// In en, this message translates to:
  /// **'You\'ve joined. Tap to leave'**
  String get crewLeave;

  /// No description provided for @crewPrivacyTitle.
  ///
  /// In en, this message translates to:
  /// **'Your privacy'**
  String get crewPrivacyTitle;

  /// No description provided for @crewPrivacyBody.
  ///
  /// In en, this message translates to:
  /// **'Only a group average is shown. Your own scores, notes and profile stay on this device. There are no names, no rankings and no comparisons between people.'**
  String get crewPrivacyBody;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @profileSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Everything stays on this device unless you choose the cloud model.'**
  String get profileSubtitle;

  /// No description provided for @profileRetake.
  ///
  /// In en, this message translates to:
  /// **'Retake the questionnaire'**
  String get profileRetake;

  /// No description provided for @profileSamples.
  ///
  /// In en, this message translates to:
  /// **'Sample profiles'**
  String get profileSamples;

  /// No description provided for @profileSamplesHint.
  ///
  /// In en, this message translates to:
  /// **'Switch to a bundled sample to see how the app adapts to a different person.'**
  String get profileSamplesHint;

  /// No description provided for @scienceTitle.
  ///
  /// In en, this message translates to:
  /// **'About the science'**
  String get scienceTitle;

  /// No description provided for @profileLoaded.
  ///
  /// In en, this message translates to:
  /// **'Loaded {name}.'**
  String profileLoaded(String name);

  /// No description provided for @profileCurrent.
  ///
  /// In en, this message translates to:
  /// **'Current'**
  String get profileCurrent;

  /// No description provided for @profileCurrentSemantics.
  ///
  /// In en, this message translates to:
  /// **'{label}, current'**
  String profileCurrentSemantics(String label);

  /// No description provided for @traitOpenness.
  ///
  /// In en, this message translates to:
  /// **'Openness'**
  String get traitOpenness;

  /// No description provided for @traitConscientiousness.
  ///
  /// In en, this message translates to:
  /// **'Conscientiousness'**
  String get traitConscientiousness;

  /// No description provided for @traitExtraversion.
  ///
  /// In en, this message translates to:
  /// **'Extraversion'**
  String get traitExtraversion;

  /// No description provided for @traitAgreeableness.
  ///
  /// In en, this message translates to:
  /// **'Agreeableness'**
  String get traitAgreeableness;

  /// No description provided for @traitEmotionalStability.
  ///
  /// In en, this message translates to:
  /// **'Emotional stability'**
  String get traitEmotionalStability;

  /// No description provided for @traitBoredom.
  ///
  /// In en, this message translates to:
  /// **'Boredom proneness'**
  String get traitBoredom;

  /// No description provided for @facetsTitle.
  ///
  /// In en, this message translates to:
  /// **'Facets'**
  String get facetsTitle;

  /// No description provided for @facetExcitement.
  ///
  /// In en, this message translates to:
  /// **'Excitement-seeking'**
  String get facetExcitement;

  /// No description provided for @facetGregariousness.
  ///
  /// In en, this message translates to:
  /// **'Gregariousness'**
  String get facetGregariousness;

  /// No description provided for @facetVulnerability.
  ///
  /// In en, this message translates to:
  /// **'Vulnerability'**
  String get facetVulnerability;

  /// No description provided for @facetSelfDiscipline.
  ///
  /// In en, this message translates to:
  /// **'Self-discipline'**
  String get facetSelfDiscipline;

  /// No description provided for @profileAdviceFraming.
  ///
  /// In en, this message translates to:
  /// **'Advice framing'**
  String get profileAdviceFraming;

  /// No description provided for @profileCoping.
  ///
  /// In en, this message translates to:
  /// **'Coping style'**
  String get profileCoping;

  /// No description provided for @profileTone.
  ///
  /// In en, this message translates to:
  /// **'Tone'**
  String get profileTone;

  /// No description provided for @profilePreferred.
  ///
  /// In en, this message translates to:
  /// **'Preferred actions'**
  String get profilePreferred;

  /// No description provided for @profileBaseline.
  ///
  /// In en, this message translates to:
  /// **'Baseline'**
  String get profileBaseline;

  /// No description provided for @dotJoin2.
  ///
  /// In en, this message translates to:
  /// **'{a} · {b}'**
  String dotJoin2(String a, String b);

  /// No description provided for @dotJoin3.
  ///
  /// In en, this message translates to:
  /// **'{a} · {b} · {c}'**
  String dotJoin3(String a, String b, String c);

  /// No description provided for @restingHeartRate.
  ///
  /// In en, this message translates to:
  /// **'Resting heart rate'**
  String get restingHeartRate;

  /// No description provided for @hrvLabel.
  ///
  /// In en, this message translates to:
  /// **'HRV'**
  String get hrvLabel;

  /// No description provided for @unitBpm.
  ///
  /// In en, this message translates to:
  /// **'{value} bpm'**
  String unitBpm(String value);

  /// No description provided for @settingsMissionDay.
  ///
  /// In en, this message translates to:
  /// **'Mission day'**
  String get settingsMissionDay;

  /// No description provided for @settingsPrevDay.
  ///
  /// In en, this message translates to:
  /// **'Previous day'**
  String get settingsPrevDay;

  /// No description provided for @settingsNextDay.
  ///
  /// In en, this message translates to:
  /// **'Next day'**
  String get settingsNextDay;

  /// No description provided for @settingsDay.
  ///
  /// In en, this message translates to:
  /// **'Day {dayNum}'**
  String settingsDay(int dayNum);

  /// No description provided for @settingsMissionDaySemantics.
  ///
  /// In en, this message translates to:
  /// **'Mission day {dayNum}, {phase}'**
  String settingsMissionDaySemantics(int dayNum, String phase);

  /// No description provided for @settingsAiSource.
  ///
  /// In en, this message translates to:
  /// **'AI source'**
  String get settingsAiSource;

  /// No description provided for @settingsAiHint.
  ///
  /// In en, this message translates to:
  /// **'Where the written reading on Home comes from. At alert level the message is always fixed.'**
  String get settingsAiHint;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @settingsLanguageHint.
  ///
  /// In en, this message translates to:
  /// **'Choose the language of the app. The written reading follows it.'**
  String get settingsLanguageHint;

  /// No description provided for @languageDevice.
  ///
  /// In en, this message translates to:
  /// **'Device language'**
  String get languageDevice;

  /// No description provided for @importTitle.
  ///
  /// In en, this message translates to:
  /// **'Import a profile'**
  String get importTitle;

  /// No description provided for @importHint.
  ///
  /// In en, this message translates to:
  /// **'Load another person from a JSON file with the same fields as the bundled samples. Nothing is uploaded.'**
  String get importHint;

  /// No description provided for @importButton.
  ///
  /// In en, this message translates to:
  /// **'Import profile JSON'**
  String get importButton;

  /// No description provided for @importFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t import this file. {error}'**
  String importFailed(String error);

  /// No description provided for @importNotJson.
  ///
  /// In en, this message translates to:
  /// **'That file is not valid JSON.'**
  String get importNotJson;

  /// No description provided for @importUnreadable.
  ///
  /// In en, this message translates to:
  /// **'That file could not be read.'**
  String get importUnreadable;

  /// No description provided for @importDone.
  ///
  /// In en, this message translates to:
  /// **'Imported {name}.'**
  String importDone(String name);

  /// No description provided for @scienceSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Where the ideas in Psychonaut come from.'**
  String get scienceSubtitle;

  /// No description provided for @scienceAssumptionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Design assumptions'**
  String get scienceAssumptionsTitle;

  /// No description provided for @sciHrpTitle.
  ///
  /// In en, this message translates to:
  /// **'NASA Human Research Program: Hazards and Risks'**
  String get sciHrpTitle;

  /// No description provided for @sciHrpBody.
  ///
  /// In en, this message translates to:
  /// **'The list of spaceflight hazards, including isolation and confinement and distance from Earth, and the human health risks linked to them.'**
  String get sciHrpBody;

  /// No description provided for @sciBhrTitle.
  ///
  /// In en, this message translates to:
  /// **'NASA Behavioral Health Risk Record'**
  String get sciBhrTitle;

  /// No description provided for @sciBhrBody.
  ///
  /// In en, this message translates to:
  /// **'The behavioural health and performance risks for long missions: behavioural conditions, teamwork and sleep.'**
  String get sciBhrBody;

  /// No description provided for @sciReactionTitle.
  ///
  /// In en, this message translates to:
  /// **'Reaction Self-Test research'**
  String get sciReactionTitle;

  /// No description provided for @sciReactionBody.
  ///
  /// In en, this message translates to:
  /// **'Basner, Mollicone and Dinges (2011), a brief psychomotor vigilance test (PVT-B), and the NASA Reaction Self-Test used by astronauts to track fatigue.'**
  String get sciReactionBody;

  /// No description provided for @sciIpipTitle.
  ///
  /// In en, this message translates to:
  /// **'International Personality Item Pool (IPIP)'**
  String get sciIpipTitle;

  /// No description provided for @sciIpipBody.
  ///
  /// In en, this message translates to:
  /// **'Public domain items from ipip.ori.org. The 20-item Mini-IPIP is by Donnellan, Oswald, Baird and Lucas (2006). The full product would use the 120-item IPIP-NEO-120 for 30 facets.'**
  String get sciIpipBody;

  /// No description provided for @sciAssume1.
  ///
  /// In en, this message translates to:
  /// **'Thresholds in standard deviations, and the days needed to flag a change, are design choices for a prototype.'**
  String get sciAssume1;

  /// No description provided for @sciAssume2.
  ///
  /// In en, this message translates to:
  /// **'The tighter limit after mission day 150 follows analog studies that report behavioural symptoms rising after 5 to 6 months.'**
  String get sciAssume2;

  /// No description provided for @sciAssume3.
  ///
  /// In en, this message translates to:
  /// **'Personality traits only shift how soon a change is flagged. They never label a person.'**
  String get sciAssume3;

  /// No description provided for @reactionTitle.
  ///
  /// In en, this message translates to:
  /// **'Reaction test'**
  String get reactionTitle;

  /// No description provided for @ipipItem1.
  ///
  /// In en, this message translates to:
  /// **'I am the life of the party'**
  String get ipipItem1;

  /// No description provided for @ipipItem2.
  ///
  /// In en, this message translates to:
  /// **'I sympathize with others\' feelings'**
  String get ipipItem2;

  /// No description provided for @ipipItem3.
  ///
  /// In en, this message translates to:
  /// **'I get chores done right away'**
  String get ipipItem3;

  /// No description provided for @ipipItem4.
  ///
  /// In en, this message translates to:
  /// **'I have frequent mood swings'**
  String get ipipItem4;

  /// No description provided for @ipipItem5.
  ///
  /// In en, this message translates to:
  /// **'I have a vivid imagination'**
  String get ipipItem5;

  /// No description provided for @ipipItem6.
  ///
  /// In en, this message translates to:
  /// **'I don\'t talk a lot'**
  String get ipipItem6;

  /// No description provided for @ipipItem7.
  ///
  /// In en, this message translates to:
  /// **'I am not interested in other people\'s problems'**
  String get ipipItem7;

  /// No description provided for @ipipItem8.
  ///
  /// In en, this message translates to:
  /// **'I often forget to put things back in their proper place'**
  String get ipipItem8;

  /// No description provided for @ipipItem9.
  ///
  /// In en, this message translates to:
  /// **'I am relaxed most of the time'**
  String get ipipItem9;

  /// No description provided for @ipipItem10.
  ///
  /// In en, this message translates to:
  /// **'I am not interested in abstract ideas'**
  String get ipipItem10;

  /// No description provided for @ipipItem11.
  ///
  /// In en, this message translates to:
  /// **'I talk to a lot of different people at parties'**
  String get ipipItem11;

  /// No description provided for @ipipItem12.
  ///
  /// In en, this message translates to:
  /// **'I feel others\' emotions'**
  String get ipipItem12;

  /// No description provided for @ipipItem13.
  ///
  /// In en, this message translates to:
  /// **'I like order'**
  String get ipipItem13;

  /// No description provided for @ipipItem14.
  ///
  /// In en, this message translates to:
  /// **'I get upset easily'**
  String get ipipItem14;

  /// No description provided for @ipipItem15.
  ///
  /// In en, this message translates to:
  /// **'I have difficulty understanding abstract ideas'**
  String get ipipItem15;

  /// No description provided for @ipipItem16.
  ///
  /// In en, this message translates to:
  /// **'I keep in the background'**
  String get ipipItem16;

  /// No description provided for @ipipItem17.
  ///
  /// In en, this message translates to:
  /// **'I am not really interested in others'**
  String get ipipItem17;

  /// No description provided for @ipipItem18.
  ///
  /// In en, this message translates to:
  /// **'I make a mess of things'**
  String get ipipItem18;

  /// No description provided for @ipipItem19.
  ///
  /// In en, this message translates to:
  /// **'I seldom feel blue'**
  String get ipipItem19;

  /// No description provided for @ipipItem20.
  ///
  /// In en, this message translates to:
  /// **'I do not have a good imagination'**
  String get ipipItem20;

  /// No description provided for @ipipAnswer1.
  ///
  /// In en, this message translates to:
  /// **'Very inaccurate'**
  String get ipipAnswer1;

  /// No description provided for @ipipAnswer2.
  ///
  /// In en, this message translates to:
  /// **'Moderately inaccurate'**
  String get ipipAnswer2;

  /// No description provided for @ipipAnswer3.
  ///
  /// In en, this message translates to:
  /// **'Neither inaccurate nor accurate'**
  String get ipipAnswer3;

  /// No description provided for @ipipAnswer4.
  ///
  /// In en, this message translates to:
  /// **'Moderately accurate'**
  String get ipipAnswer4;

  /// No description provided for @ipipAnswer5.
  ///
  /// In en, this message translates to:
  /// **'Very accurate'**
  String get ipipAnswer5;

  /// No description provided for @ipipAnswerSemantics.
  ///
  /// In en, this message translates to:
  /// **'{n}, {label}'**
  String ipipAnswerSemantics(String n, String label);

  /// No description provided for @onbStep.
  ///
  /// In en, this message translates to:
  /// **'Step {stepNum} of {totalNum}'**
  String onbStep(int stepNum, int totalNum);

  /// No description provided for @onbNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get onbNext;

  /// No description provided for @onbCreate.
  ///
  /// In en, this message translates to:
  /// **'Create profile'**
  String get onbCreate;

  /// No description provided for @onbWelcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome aboard'**
  String get onbWelcome;

  /// No description provided for @onbWelcomeSub.
  ///
  /// In en, this message translates to:
  /// **'Psychonaut, your daily companion'**
  String get onbWelcomeSub;

  /// No description provided for @onbIntro.
  ///
  /// In en, this message translates to:
  /// **'Psychonaut compares you with your own baseline and suggests one small action a day. A short questionnaire of 20 statements tunes how soon it flags changes and how it speaks to you. Your answers stay on this device.'**
  String get onbIntro;

  /// No description provided for @onbName.
  ///
  /// In en, this message translates to:
  /// **'Your name'**
  String get onbName;

  /// No description provided for @onbRole.
  ///
  /// In en, this message translates to:
  /// **'Your role, for example Commander'**
  String get onbRole;

  /// No description provided for @onbExploring.
  ///
  /// In en, this message translates to:
  /// **'Just exploring?'**
  String get onbExploring;

  /// No description provided for @onbSampleHint.
  ///
  /// In en, this message translates to:
  /// **'Load a sample profile instead.'**
  String get onbSampleHint;

  /// No description provided for @onbCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel and keep my current profile'**
  String get onbCancel;

  /// No description provided for @onbAboutYou.
  ///
  /// In en, this message translates to:
  /// **'About you'**
  String get onbAboutYou;

  /// No description provided for @onbItemsHint.
  ///
  /// In en, this message translates to:
  /// **'Describe yourself as you generally are now, not as you wish to be. Page {pageNum} of {pagesNum}.'**
  String onbItemsHint(int pageNum, int pagesNum);

  /// No description provided for @onbLocusTitle.
  ///
  /// In en, this message translates to:
  /// **'When things go well or badly'**
  String get onbLocusTitle;

  /// No description provided for @onbLocusSub.
  ///
  /// In en, this message translates to:
  /// **'Which sounds most like you? This shapes how advice is framed.'**
  String get onbLocusSub;

  /// No description provided for @onbLocusInternalTitle.
  ///
  /// In en, this message translates to:
  /// **'Mostly my own choices and effort'**
  String get onbLocusInternalTitle;

  /// No description provided for @onbLocusInternalText.
  ///
  /// In en, this message translates to:
  /// **'What happens to me is mostly down to what I do.'**
  String get onbLocusInternalText;

  /// No description provided for @onbLocusMixedTitle.
  ///
  /// In en, this message translates to:
  /// **'A mix of both'**
  String get onbLocusMixedTitle;

  /// No description provided for @onbLocusMixedText.
  ///
  /// In en, this message translates to:
  /// **'My effort matters, and so do circumstances I can\'t control.'**
  String get onbLocusMixedText;

  /// No description provided for @onbLocusExternalTitle.
  ///
  /// In en, this message translates to:
  /// **'Mostly circumstances and other people'**
  String get onbLocusExternalTitle;

  /// No description provided for @onbLocusExternalText.
  ///
  /// In en, this message translates to:
  /// **'Much of what happens is outside my control.'**
  String get onbLocusExternalText;

  /// No description provided for @onbToneTitle.
  ///
  /// In en, this message translates to:
  /// **'How should Psychonaut talk to you?'**
  String get onbToneTitle;

  /// No description provided for @onbToneSub.
  ///
  /// In en, this message translates to:
  /// **'You can change this later.'**
  String get onbToneSub;

  /// No description provided for @onbToneDirectEx.
  ///
  /// In en, this message translates to:
  /// **'\"Sleep is down 0.8 h. Try a sleep reset tonight.\"'**
  String get onbToneDirectEx;

  /// No description provided for @onbToneGentleEx.
  ///
  /// In en, this message translates to:
  /// **'\"Sleep has moved a little. A calm evening might help.\"'**
  String get onbToneGentleEx;

  /// No description provided for @onbActionsTitle.
  ///
  /// In en, this message translates to:
  /// **'What helps you reset?'**
  String get onbActionsTitle;

  /// No description provided for @onbActionsSub.
  ///
  /// In en, this message translates to:
  /// **'Pick the actions you like. The order you tap is the order they are offered.'**
  String get onbActionsSub;

  /// No description provided for @onbYourProfile.
  ///
  /// In en, this message translates to:
  /// **'Your profile'**
  String get onbYourProfile;

  /// No description provided for @onbTraits.
  ///
  /// In en, this message translates to:
  /// **'Personality traits'**
  String get onbTraits;

  /// No description provided for @onbTraitsNote.
  ///
  /// In en, this message translates to:
  /// **'From a 20-item short form. Traits only change how soon a shift is flagged. They never label you.'**
  String get onbTraitsNote;

  /// No description provided for @onbPrefs.
  ///
  /// In en, this message translates to:
  /// **'Your preferences'**
  String get onbPrefs;

  /// No description provided for @onbActionsLabel.
  ///
  /// In en, this message translates to:
  /// **'Actions'**
  String get onbActionsLabel;

  /// No description provided for @roleDefault.
  ///
  /// In en, this message translates to:
  /// **'Crew member'**
  String get roleDefault;

  /// No description provided for @importPickerTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose a profile JSON file'**
  String get importPickerTitle;

  /// No description provided for @reactionIntro.
  ///
  /// In en, this message translates to:
  /// **'This 3-minute test checks how alert you are. When the screen says \"Tap now\", tap as fast as you can. Do not tap before it appears.'**
  String get reactionIntro;

  /// No description provided for @reactionKeyboardHint.
  ///
  /// In en, this message translates to:
  /// **'On a keyboard, press Space.'**
  String get reactionKeyboardHint;

  /// No description provided for @reactionWait.
  ///
  /// In en, this message translates to:
  /// **'Wait…'**
  String get reactionWait;

  /// No description provided for @reactionTapNow.
  ///
  /// In en, this message translates to:
  /// **'Tap now'**
  String get reactionTapNow;

  /// No description provided for @reactionTooSoon.
  ///
  /// In en, this message translates to:
  /// **'Too soon. Wait for the signal.'**
  String get reactionTooSoon;

  /// No description provided for @reactionTimeLeft.
  ///
  /// In en, this message translates to:
  /// **'{time} left'**
  String reactionTimeLeft(String time);

  /// No description provided for @reactionDiscardHint.
  ///
  /// In en, this message translates to:
  /// **'Going back now discards this test.'**
  String get reactionDiscardHint;

  /// No description provided for @reactionDoneTitle.
  ///
  /// In en, this message translates to:
  /// **'Test complete'**
  String get reactionDoneTitle;

  /// No description provided for @reactionMean.
  ///
  /// In en, this message translates to:
  /// **'Mean reaction time'**
  String get reactionMean;

  /// No description provided for @reactionResponses.
  ///
  /// In en, this message translates to:
  /// **'Responses'**
  String get reactionResponses;

  /// No description provided for @reactionLapses.
  ///
  /// In en, this message translates to:
  /// **'Lapses (slower than 500 ms)'**
  String get reactionLapses;

  /// No description provided for @reactionFalseStarts.
  ///
  /// In en, this message translates to:
  /// **'False starts'**
  String get reactionFalseStarts;

  /// No description provided for @reactionSaved.
  ///
  /// In en, this message translates to:
  /// **'Saved. You can see it in Trends.'**
  String get reactionSaved;

  /// No description provided for @reactionNoResponses.
  ///
  /// In en, this message translates to:
  /// **'No responses were recorded, so nothing was saved.'**
  String get reactionNoResponses;

  /// No description provided for @reactionDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get reactionDone;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en', 'es', 'fr', 'ja'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'ja':
      return AppLocalizationsJa();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
