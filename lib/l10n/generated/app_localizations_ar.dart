// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get navHome => 'الرئيسية';

  @override
  String get navCheckIn => 'تسجيل';

  @override
  String get navTrends => 'الاتجاهات';

  @override
  String get navCrew => 'الطاقم';

  @override
  String get profileAndSettings => 'الملف الشخصي والإعدادات';

  @override
  String get back => 'رجوع';

  @override
  String get sampleData => 'بيانات تجريبية';

  @override
  String get disclaimer =>
      'لا يقوم Psychonaut بالتشخيص ولا يحلّ محلّ الطبيب أو الأخصائي.';

  @override
  String get statusOnCourse => 'على المسار';

  @override
  String get statusDrifting => 'ينحرف';

  @override
  String get statusOffCourse => 'خارج المسار';

  @override
  String get statusAlert => 'تنبيه';

  @override
  String traitSemantics(String label, int valueNum) {
    return '$label $valueNum من 100';
  }

  @override
  String get indicatorMood => 'المزاج';

  @override
  String get indicatorStress => 'التوتر';

  @override
  String get indicatorSleep => 'النوم';

  @override
  String get indicatorFocus => 'التركيز';

  @override
  String get indicatorMotivation => 'الدافعية';

  @override
  String get indicatorConnection => 'التواصل';

  @override
  String get indicatorWorkload => 'عبء العمل';

  @override
  String get indicatorReaction => 'زمن الاستجابة';

  @override
  String get trendImproving => 'يتحسن';

  @override
  String get trendSteady => 'مستقر';

  @override
  String get trendSlipping => 'يتراجع';

  @override
  String get homeTitle => 'مسارك';

  @override
  String missionLine(int dayNum, String phase) {
    return 'يوم المهمة $dayNum · $phase';
  }

  @override
  String headingSemantics(int degreesNum, String status) {
    return '$degreesNum درجة خارج المسار. الحالة العامة: $status.';
  }

  @override
  String get headingOffCourse => 'خارج المسار';

  @override
  String get headingMeasured => 'يُقاس بالنسبة إلى خطك المرجعي الخاص.';

  @override
  String get mismatchTitle => 'ما تقوله وما يُظهره جسمك مختلفان';

  @override
  String mismatchBody(String mood, String details) {
    return 'قيّمتَ مزاجك بـ $mood، أي عند خطك المرجعي أو أعلى منه، لكن $details. قد يكون الأمران صحيحين. يستحق الأمر نظرة أدق.';
  }

  @override
  String mismatchDetailSleep(int daysNum) {
    return 'نومك أقل من خطك المرجعي منذ $daysNum أيام';
  }

  @override
  String mismatchDetailReaction(int daysNum) {
    return 'زمن استجابتك أبطأ من خطك المرجعي منذ $daysNum أيام';
  }

  @override
  String mismatchJoin(String first, String second) {
    return '$first و$second';
  }

  @override
  String get lifeEventTitle => 'حدث شيء في المنزل';

  @override
  String get lifeEventCardBody =>
      'من الصعب تحمّل ذلك من بُعد كهذا. لا يجب أن تواجهه وحدك. سنراقب مزاجك عن كثب خلال الأيام الـ14 القادمة، وسيُعرض عليك أولاً «مراسلة المنزل».';

  @override
  String get reactionPromptTitle => 'حان وقت اختبار الاستجابة';

  @override
  String get reactionPromptText => 'ثلاث دقائق. يكشف الإرهاق قبل أن تشعر به.';

  @override
  String get reactionPromptButton => 'ابدأ الاختبار';

  @override
  String get logOpenTitle => 'سجلّ القبطان مفتوح';

  @override
  String get logOpenText => 'لم تسجّل اليوم بعد.';

  @override
  String get logEntry => 'سجّل الإدخال';

  @override
  String get readingPreparing => 'جارٍ إعداد قراءتك';

  @override
  String get readingUnavailable => 'قراءتك غير متاحة حالياً.';

  @override
  String get readingTitle => 'قراءة اليوم';

  @override
  String get readingFixedAlertNote =>
      'رسالة سلامة ثابتة وليست من إنشاء الذكاء الاصطناعي.';

  @override
  String get aiGenerated => 'مُنشأ بالذكاء الاصطناعي';

  @override
  String get suggestedAction => 'الإجراء المقترح';

  @override
  String readingSource(String source) {
    return 'المصدر: $source';
  }

  @override
  String get sourceRuleBased => 'قائم على القواعد · على هذا الجهاز';

  @override
  String get sourceOnBoard => 'النموذج المدمج';

  @override
  String get sourceCloud => 'النموذج السحابي';

  @override
  String loadError(String error) {
    return 'تعذّر تحميل بياناتك.\n$error';
  }

  @override
  String get indicatorsTitle => 'المؤشرات';

  @override
  String get panelMindMap => 'خريطة ذهنية';

  @override
  String get panelSelected => 'المؤشر المحدد';

  @override
  String chartLast14(String indicator) {
    return '$indicator، آخر 14 يوماً';
  }

  @override
  String get chartSleep14 => 'النوم، 14 ليلة';

  @override
  String tileSemantics(String indicator, String status, String trend) {
    return '$indicator، $status، $trend';
  }

  @override
  String get trendNoData => 'لا توجد بيانات بعد';

  @override
  String get trendAtBaseline => 'عند خطك المرجعي';

  @override
  String trendAbove(String amount) {
    return 'أعلى من الخط المرجعي بمقدار $amount';
  }

  @override
  String trendBelow(String amount) {
    return 'أقل من الخط المرجعي بمقدار $amount';
  }

  @override
  String trendJoin(String where, String trend) {
    return '$where، $trend';
  }

  @override
  String detailNow(String now, String baseline, String trend) {
    return 'الآن $now · خطك المرجعي $baseline · $trend';
  }

  @override
  String get flaggedSooner =>
      'تتم مراقبته قبل يوم واحد من أجلك، بحسب ملفك الشخصي.';

  @override
  String get detailHowMeasured => 'كيف يُقاس';

  @override
  String get detailWhy => 'لماذا يهم';

  @override
  String get detailWhatToDo => 'ماذا تفعل الآن';

  @override
  String whatToDoOptions(String text, String options) {
    return '$text الخيارات: $options.';
  }

  @override
  String whatToDoRecommended(String text, String action) {
    return '$text الموصى به: $action.';
  }

  @override
  String whatToDoOneStep(String action, String description) {
    return 'خطوة واحدة: $action. $description';
  }

  @override
  String get nasaRiskLabel => 'مخاطر ناسا';

  @override
  String get nasaHazardLabel => 'الخطر';

  @override
  String labelValue(String label, String value) {
    return '$label: $value';
  }

  @override
  String unitHours(String value) {
    return '$value س';
  }

  @override
  String unitMs(String value) {
    return '$value م.ث';
  }

  @override
  String get refMeasuredMood =>
      'تقييمك الذاتي اليومي من 1 إلى 10 في سجلّ القبطان، مقارنةً بخطك المرجعي الخاص.';

  @override
  String get refWhyMood =>
      'من الأسهل معالجة الانخفاضات الصغيرة المستمرة في المزاج مبكراً. ومتابعة المزاج مقارنةً بخطك المرجعي أنفع من النظر إلى يوم واحد.';

  @override
  String get refTodoMood =>
      'سجّل بصدق ثم اختر إجراءً صغيراً واحداً. أخبر أحد زملائك إذا تراكمت الأيام السيئة.';

  @override
  String get refMeasuredStress =>
      'تقييمك اليومي للتوتر من 1 إلى 10، مقارنةً بخطك المرجعي. كلما ارتفع كان أقل ملاءمة.';

  @override
  String get refWhyStress =>
      'يُبقي الحبس الطويل مستويات التوتر مرتفعة. كما أن ازدياد التوتر يقتطع من النوم والتركيز.';

  @override
  String get refTodoStress =>
      'أبطئ تنفسك لدقيقتين، أو حرّك جسمك، أو سلّم مهمة واحدة لغيرك اليوم.';

  @override
  String get refMeasuredSleep =>
      'عدد ساعات النوم كل ليلة من جهاز تتبّع النوم أو البيانات التجريبية. المدى الصحي من 7 إلى 8 ساعات، و6 ساعات أو أقل تُعدّ نوماً قصيراً.';

  @override
  String get refWhySleep =>
      'يبطئ قلة النوم والجداول غير المنتظمة ردود الفعل، ويخفضان المزاج، ويجعلان المشكلات الصغيرة تبدو أكبر.';

  @override
  String get refTodoSleep =>
      'حافظ على موعد ثابت لإطفاء الأضواء، وخفّف إضاءة الشاشات قبل ساعة، وبرّد المقصورة لإعادة ضبط النوم.';

  @override
  String get refMeasuredFocus =>
      'تقييم تركيزك من 1 إلى 10 مع عدد حالات الغفلة في اختبار الاستجابة.';

  @override
  String get refWhyFocus =>
      'الانتباه أول ما يتراجع عندما يسوء النوم أو يزداد عبء العمل، والأخطاء في الرحلة هي الأكثر كلفة.';

  @override
  String get refTodoFocus =>
      'خذ استراحة حقيقية بعيداً عن الشاشات، ثم أنجز مهمة واحدة في كل مرة. تحقّق من نومك أولاً.';

  @override
  String get refMeasuredMotivation =>
      'تقييم انخراطك من 1 إلى 10، مقارنةً بخطك المرجعي الخاص.';

  @override
  String get refWhyMotivation =>
      'المهام الطويلة المتكررة تجلب الملل. وقد يسبق تراجع الانخراط انخفاضَ المزاج.';

  @override
  String get refTodoMotivation =>
      'ابدأ مشروعاً صغيراً جديداً أو غيّر ترتيب يومك لتنويعه.';

  @override
  String get refMeasuredConnection =>
      'تقييم تواصلك مع الطاقم من 1 إلى 10، مقارنةً بخطك المرجعي الخاص.';

  @override
  String get refWhyConnection =>
      'يعتمد التعاون الجيد على الشعور بالترابط. كما أن البعد عن الأرض يجعل التواصل مع الأسرة أبطأ وأندر.';

  @override
  String get refTodoConnection =>
      'شارك الطاقم وجبة أو أرسل رسالة إلى المنزل. حتى التواصل البسيط له قيمة.';

  @override
  String get refMeasuredWorkload =>
      'تقييم عبء عملك من 1 إلى 10، مقارنةً بخطك المرجعي. كلما ارتفع كان أقل ملاءمة.';

  @override
  String get refWhyWorkload =>
      'يقتطع الإفراط في العمل من النوم. ومع تأخر الاتصال بالأرض، على الطاقم أن يدير إيقاعه بنفسه.';

  @override
  String get refTodoWorkload =>
      'انقل مهمة واحدة إلى الغد أو اطلب من الطاقم مشاركتها. احمِ وقت نومك.';

  @override
  String get refMeasuredReaction =>
      'اختبار استجابة مدته 3 دقائق. تنقر بأسرع ما يمكن عند ظهور المحفّز. نسجّل متوسط زمن استجابتك وحالات الغفلة (أبطأ من 500 م.ث) والنقرات المبكرة.';

  @override
  String get refWhyReaction =>
      'الاستجابات البطيئة أو حالات الغفلة من أبكر علامات الإرهاق وتشتت الانتباه، وغالباً قبل أن تشعر به بنفسك.';

  @override
  String get refTodoReaction =>
      'كرّر الاختبار كل بضعة أيام في وقت مشابه من اليوم وقارن بخطك المرجعي.';

  @override
  String get actionExerciseTitle => 'تمرين';

  @override
  String get actionExerciseDesc => 'تمرين قصير على جهاز المشي أو الدراجة.';

  @override
  String get actionJournalTitle => 'كتابة اليوميات';

  @override
  String get actionJournalDesc => 'عشر دقائق من الكتابة الخاصة عن يومك.';

  @override
  String get actionFamilyCallTitle => 'مراسلة المنزل';

  @override
  String get actionFamilyCallDesc =>
      'أرسل رسالة أو رتّب مكالمة مع شخص على الأرض.';

  @override
  String get actionGardenTitle => 'وقت النافذة والحديقة';

  @override
  String get actionGardenDesc => 'اقضِ وقتاً عند النافذة أو مع النباتات.';

  @override
  String get actionWindowTimeTitle => 'وقت النافذة';

  @override
  String get actionWindowTimeDesc =>
      'اقضِ عشر دقائق عند النافذة تتأمل الأرض أو النجوم.';

  @override
  String get actionNewProjectTitle => 'ابدأ مشروعاً صغيراً';

  @override
  String get actionNewProjectDesc => 'اختر مهمة جديدة قصيرة لكسر الروتين.';

  @override
  String get actionSleepResetTitle => 'إعادة ضبط النوم';

  @override
  String get actionSleepResetDesc =>
      'موعد ثابت لإطفاء الأضواء وشاشات خافتة ومقصورة أبرد لليلة واحدة.';

  @override
  String get aiRuleBasedLabel => 'قائم على القواعد';

  @override
  String get aiRuleBasedDesc => 'قوالب على هذا الجهاز. دون شبكة. الافتراضي.';

  @override
  String get aiOnBoardLabel => 'النموذج المدمج';

  @override
  String get aiOnBoardDesc =>
      'نموذج يعمل على هذا الحاسوب أو على شبكة السفينة. لا شيء يغادر المركبة. يعود إلى القائم على القواعد إذا لم يكن يعمل.';

  @override
  String get aiCloudLabel => 'النموذج السحابي';

  @override
  String get aiCloudDesc =>
      'نموذج لغوي كبير عبر الإنترنت. للاستخدام على الأرض فقط. يرسل درجاتك وملف شخصيتك، ولا يرسل اسمك أو ملاحظاتك أبداً.';

  @override
  String get phaseAdjustment => 'التكيّف';

  @override
  String get phaseAdjustmentNote =>
      'مرحلة الاستقرار. ما زالت الروتينات تتشكّل.';

  @override
  String get phaseMid => 'منتصف المهمة';

  @override
  String get phaseMidNote => 'مرحلة مستقرة. راقب الانحراف البطيء.';

  @override
  String get phaseLate => 'أواخر المهمة';

  @override
  String get phaseLateNote =>
      'بعد اليوم 150 تصبح المراقبة أشد. في دراسات المحاكاة ترتفع الأعراض السلوكية بعد 5 إلى 6 أشهر.';

  @override
  String get riskBehavioral => 'الحالات السلوكية';

  @override
  String get riskTeamwork => 'ضعف العمل الجماعي';

  @override
  String get riskSleep => 'قلة النوم والجداول غير المنتظمة';

  @override
  String get hazardIsolation => 'العزلة والحبس';

  @override
  String get hazardDistance => 'البعد عن الأرض';

  @override
  String get toneDirect => 'مباشر';

  @override
  String get toneGentle => 'لطيف';

  @override
  String get framingInternal => 'داخلي: بيانات وخيارات';

  @override
  String get framingMixed => 'مختلط: بيانات وتوصية واحدة';

  @override
  String get framingExternal => 'خارجي: خطوة واحدة واضحة';

  @override
  String get copingProblem => 'موجَّه نحو المشكلة';

  @override
  String get copingEmotion => 'موجَّه نحو المشاعر';

  @override
  String get copingAvoidant => 'تجنّبي';

  @override
  String get sourceMiniIpip => 'استبيان Mini-IPIP';

  @override
  String get sourceIpipNeo120 => 'استبيان IPIP-NEO-120';

  @override
  String get sourceImported => 'ملف مستورد';

  @override
  String get alertMessage => 'أبلغ الضابط الطبي في طاقمك وجهّز ملخصاً للأرض';

  @override
  String sourceUnavailableNote(String source) {
    return '$source غير متاح، لذا جاءت هذه القراءة من المصدر القائم على القواعد.';
  }

  @override
  String insOnCourseDirect(int degreesNum) {
    return 'أنت على المسار بانحراف $degreesNum°، وكل القراءات قريبة من خطك المرجعي.';
  }

  @override
  String insOnCourseGentle(int degreesNum) {
    return 'أنت على المسار، بانحراف $degreesNum° فقط، وقراءاتك قريبة من معتادك.';
  }

  @override
  String insWorstGentle(
    String indicator,
    String current,
    String baseline,
    String trend,
  ) {
    return 'تحرّك $indicator قليلاً: $current الآن مقابل $baseline المعتاد، وهو $trend.';
  }

  @override
  String insWorstDirect(
    String indicator,
    String status,
    String current,
    String baseline,
    String trend,
  ) {
    return '$indicator في حالة «$status» عند $current مقابل خطك المرجعي $baseline، وهو $trend.';
  }

  @override
  String insMismatchGentle(int daysNum) {
    return 'قلتَ إنك بخير، وهذا مهم، لكن بيانات جسمك خارج الخط المرجعي منذ $daysNum أيام.';
  }

  @override
  String insMismatchDirect(int daysNum) {
    return 'قيّمتَ مزاجك عند الخط المرجعي أو أعلى، لكن بيانات جسمك خارجه منذ $daysNum أيام.';
  }

  @override
  String get insLifeGentle =>
      'سجّلتَ أمراً من المنزل، لذا نراقب مزاجك عن كثب أكثر قليلاً حالياً.';

  @override
  String get insLifeDirect =>
      'سجّلتَ أمراً من المنزل، لذا يُراقب المزاج عن كثب لمدة 14 يوماً.';

  @override
  String insActionGentle(String action) {
    return 'قد تساعد خطوة صغيرة اليوم: $action.';
  }

  @override
  String insActionDirect(String action) {
    return 'إجراء صغير اليوم: $action.';
  }

  @override
  String get insEvidenceAllOk =>
      'جميع القراءات ضمن انحراف معياري واحد من خطك المرجعي.';

  @override
  String insEvidence(String indicator, String current, String baseline) {
    return '$indicator: $current مقابل خط مرجعي $baseline.';
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
      other: '$count أيام',
      one: 'يوم واحد',
    );
    return '$indicator: $current مقابل خط مرجعي $baseline، وتجاوز $sd انحراف معياري لمدة $_temp0.';
  }

  @override
  String insNights(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ليالٍ أخيرة بـ6 ساعات أو أقل.',
      one: 'ليلة أخيرة واحدة بـ6 ساعات أو أقل.',
    );
    return '$_temp0';
  }

  @override
  String get insLapses => 'حالات الغفلة في اختبار الاستجابة أعلى من معتادك.';

  @override
  String insOptions(String options) {
    return 'الخيارات: $options';
  }

  @override
  String insRecommended(String action, String description) {
    return 'الموصى به: $action. $description';
  }

  @override
  String insRecommendedStep(String action, String description) {
    return 'الخطوة الموصى بها: $action. $description هذه الخطوة وحدها تكفي اليوم.';
  }

  @override
  String get insLatePhase =>
      'بعد اليوم 150 من المهمة تصبح المراقبة أشد، فتُرصد التغيّرات الأصغر.';

  @override
  String get insLifeSupport =>
      'قد تكون أخبار المنزل ثقيلة. وقد يفيدك التواصل مع شخص تثق به.';

  @override
  String get trendsTitle => 'الانحراف عن المسار';

  @override
  String get trendsSubtitle => 'مدى ابتعادك عن خطك المرجعي الخاص';

  @override
  String get trendsSleepTitle => 'النوم، آخر 14 ليلة';

  @override
  String get trendsNoTests => 'لا توجد اختبارات بعد';

  @override
  String trendsLatestReaction(String ms, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count حالات غفلة',
      one: 'حالة غفلة واحدة',
    );
    return 'الأحدث $ms · $_temp0';
  }

  @override
  String trendsNasaLine(String risk, String hazards) {
    return 'مخاطر ناسا: $risk. الخطر: $hazards.';
  }

  @override
  String get correctionsTitle => 'تصحيحات المسار';

  @override
  String get correctionsHint =>
      'اختر إجراءً صغيراً واحداً. إجراءاتك المفضلة تأتي أولاً.';

  @override
  String correctionsPlan(String title, String description) {
    return 'خطتك: $title. $description';
  }

  @override
  String get correctionsSuggested => 'مقترحة';

  @override
  String actionSemantics(String title, String description) {
    return '$title. $description';
  }

  @override
  String actionSemanticsSuggested(String title, String description) {
    return '$title. $description مقترحة لهذا اليوم.';
  }

  @override
  String get chartNoSleep => 'لا توجد بيانات نوم بعد.';

  @override
  String chartBaselineValue(String value) {
    return 'خطك المرجعي $value';
  }

  @override
  String get chartBaseline => 'خطك المرجعي';

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
    return 'النوم خلال آخر $count ليالٍ. الخط المرجعي $baseline. آخر ليلة $latest، $status.';
  }

  @override
  String get chartToday => 'اليوم';

  @override
  String get chartNeedTests => 'أجرِ اختبار الاستجابة عدة مرات لترى اتجاهك.';

  @override
  String chartReactionSemantics(int count, String baseline, String latest) {
    return 'زمن الاستجابة في آخر $count اختبارات. الخط المرجعي $baseline. الأحدث $latest.';
  }

  @override
  String get chartNotEnough => 'لا توجد بيانات كافية بعد.';

  @override
  String chartDaysAgo(int daysNum) {
    return '-$daysNum ي';
  }

  @override
  String get checkinTitle => 'سجلّ القبطان';

  @override
  String get checkinSubtitle =>
      'كيف حالك اليوم؟ كن صريحاً. لا توجد إجابات خاطئة.';

  @override
  String get qEngagement => 'الانخراط';

  @override
  String get qConnection => 'التواصل مع الطاقم';

  @override
  String get scaleLow => 'منخفض';

  @override
  String get scaleHigh => 'مرتفع';

  @override
  String get scaleCalm => 'هادئ';

  @override
  String get scaleVeryStressed => 'متوتر جداً';

  @override
  String get scaleLight => 'خفيف';

  @override
  String get scaleOverloaded => 'مثقل';

  @override
  String get scaleBored => 'ممل';

  @override
  String get scaleAbsorbed => 'مستغرق';

  @override
  String get scaleScattered => 'مشتّت';

  @override
  String get scaleSharp => 'حادّ';

  @override
  String get scaleDistant => 'بعيد';

  @override
  String get scaleClose => 'قريب';

  @override
  String checkinStreak(int count) {
    return 'سلسلة $count يوم';
  }

  @override
  String checkinStreakSemantics(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count أيام',
      one: 'يوم واحد',
    );
    return 'سلسلة التسجيل: $_temp0';
  }

  @override
  String get checkinStreakNote =>
      'يحسب الأيام التي سجّلت فيها، وليس شكل الدرجات أبداً.';

  @override
  String get checkinOptional => 'اختياري.';

  @override
  String get checkinNoteLabel => 'ملاحظة خاصة';

  @override
  String get checkinNoteHelper => 'تبقى على هذا الجهاز ولا تُرسل إلى أي مكان.';

  @override
  String get checkinUpdate => 'تحديث إدخال اليوم';

  @override
  String get checkinLogged => 'تم تسجيل الإدخال. شكراً لك.';

  @override
  String sliderSemantics(String label, int valueNum) {
    return '$label $valueNum من 10';
  }

  @override
  String get crewTitle => 'معنويات السفينة';

  @override
  String get crewSubtitle => 'حال الطاقم في رقم واحد مجهول';

  @override
  String get moraleHigh => 'مرتفع';

  @override
  String get moraleSteady => 'مستقر';

  @override
  String get moraleStrained => 'متوتر';

  @override
  String get moraleLow => 'منخفض';

  @override
  String get crewOutOf100 => '/ 100';

  @override
  String crewMeterSemantics(
    String level,
    int scoreNum,
    int contributedNum,
    int crewNum,
  ) {
    return 'معنويات الطاقم $level، $scoreNum من 100. سجّل اليوم $contributedNum من $crewNum من أفراد الطاقم.';
  }

  @override
  String crewCheckedIn(int contributedNum, int crewNum) {
    return 'سجّل اليوم $contributedNum من $crewNum من الطاقم. لا تُعرض الأسماء أبداً.';
  }

  @override
  String get crewGoalLabel => 'الهدف الأسبوعي المشترك';

  @override
  String get crewGoalTitle => 'تناول وجبة عشاء معاً';

  @override
  String get crewGoalDesc =>
      'تناولوا العشاء مع الطاقم في 6 أمسيات هذا الأسبوع. يكفي أن يكون قصيراً وبلا استعجال.';

  @override
  String crewGoalProgress(int doneNum, int segmentsNum, int peopleNum) {
    return 'أُنجزت $doneNum من $segmentsNum أمسيات · انضمّ $peopleNum من الطاقم';
  }

  @override
  String crewGoalSemantics(int doneNum, int segmentsNum) {
    return 'أُنجزت $doneNum من $segmentsNum أمسيات';
  }

  @override
  String get crewJoin => 'انضم إلى هذا الهدف';

  @override
  String get crewLeave => 'انضممت. اضغط للمغادرة';

  @override
  String get crewPrivacyTitle => 'خصوصيتك';

  @override
  String get crewPrivacyBody =>
      'يُعرض متوسط المجموعة فقط. تبقى درجاتك وملاحظاتك وملفك الشخصي على هذا الجهاز. لا توجد أسماء ولا ترتيب ولا مقارنات بين الأشخاص.';

  @override
  String get profileTitle => 'الملف الشخصي';

  @override
  String get profileSubtitle =>
      'كل شيء يبقى على هذا الجهاز ما لم تختر النموذج السحابي.';

  @override
  String get profileRetake => 'إعادة الاستبيان';

  @override
  String get profileSamples => 'ملفات شخصية تجريبية';

  @override
  String get profileSamplesHint =>
      'انتقل إلى نموذج مرفق لترى كيف يتكيّف التطبيق مع شخص آخر.';

  @override
  String get scienceTitle => 'حول الأساس العلمي';

  @override
  String profileLoaded(String name) {
    return 'تم تحميل $name.';
  }

  @override
  String get profileCurrent => 'الحالي';

  @override
  String profileCurrentSemantics(String label) {
    return '$label، الحالي';
  }

  @override
  String get traitOpenness => 'الانفتاح';

  @override
  String get traitConscientiousness => 'الضمير الحي';

  @override
  String get traitExtraversion => 'الانبساط';

  @override
  String get traitAgreeableness => 'المقبولية';

  @override
  String get traitEmotionalStability => 'الاستقرار العاطفي';

  @override
  String get traitBoredom => 'الميل إلى الملل';

  @override
  String get facetsTitle => 'الجوانب الفرعية';

  @override
  String get facetExcitement => 'البحث عن الإثارة';

  @override
  String get facetGregariousness => 'الميل إلى الاجتماع';

  @override
  String get facetVulnerability => 'الهشاشة';

  @override
  String get facetSelfDiscipline => 'الانضباط الذاتي';

  @override
  String get profileAdviceFraming => 'صياغة النصائح';

  @override
  String get profileCoping => 'أسلوب التكيّف';

  @override
  String get profileTone => 'النبرة';

  @override
  String get profilePreferred => 'الإجراءات المفضلة';

  @override
  String get profileBaseline => 'الخط المرجعي';

  @override
  String dotJoin2(String a, String b) {
    return '$a · $b';
  }

  @override
  String dotJoin3(String a, String b, String c) {
    return '$a · $b · $c';
  }

  @override
  String get restingHeartRate => 'معدل نبض القلب أثناء الراحة';

  @override
  String get hrvLabel => 'تقلب معدل ضربات القلب';

  @override
  String unitBpm(String value) {
    return '$value نبضة/د';
  }

  @override
  String get settingsMissionDay => 'يوم المهمة';

  @override
  String get settingsPrevDay => 'اليوم السابق';

  @override
  String get settingsNextDay => 'اليوم التالي';

  @override
  String settingsDay(int dayNum) {
    return 'اليوم $dayNum';
  }

  @override
  String settingsMissionDaySemantics(int dayNum, String phase) {
    return 'يوم المهمة $dayNum، $phase';
  }

  @override
  String get settingsAiSource => 'مصدر الذكاء الاصطناعي';

  @override
  String get settingsAiHint =>
      'مصدر القراءة المكتوبة في الرئيسية. عند مستوى التنبيه تكون الرسالة ثابتة دائماً.';

  @override
  String get settingsLanguage => 'اللغة';

  @override
  String get settingsLanguageHint =>
      'اختر لغة التطبيق. تتبعها القراءة المكتوبة.';

  @override
  String get languageDevice => 'لغة الجهاز';

  @override
  String get importTitle => 'استيراد ملف شخصي';

  @override
  String get importHint =>
      'حمّل شخصاً آخر من ملف JSON بنفس حقول النماذج المرفقة. لا يُرفع أي شيء.';

  @override
  String get importButton => 'استيراد ملف JSON';

  @override
  String importFailed(String error) {
    return 'تعذّر استيراد هذا الملف. $error';
  }

  @override
  String get importNotJson => 'هذا الملف ليس JSON صالحاً.';

  @override
  String get importUnreadable => 'تعذّرت قراءة هذا الملف.';

  @override
  String importDone(String name) {
    return 'تم استيراد $name.';
  }

  @override
  String get scienceSubtitle => 'من أين جاءت أفكار Psychonaut.';

  @override
  String get scienceAssumptionsTitle => 'افتراضات التصميم';

  @override
  String get sciHrpTitle => 'برنامج ناسا للبحوث البشرية: المخاطر والأخطار';

  @override
  String get sciHrpBody =>
      'قائمة أخطار الرحلات الفضائية، ومنها العزلة والحبس والبعد عن الأرض، ومخاطر الصحة البشرية المرتبطة بها.';

  @override
  String get sciBhrTitle => 'سجل مخاطر الصحة السلوكية في ناسا';

  @override
  String get sciBhrBody =>
      'مخاطر الصحة السلوكية والأداء في المهام الطويلة: الحالات السلوكية والعمل الجماعي والنوم.';

  @override
  String get sciReactionTitle => 'أبحاث اختبار الاستجابة الذاتي';

  @override
  String get sciReactionBody =>
      'Basner وMollicone وDinges (2011)، اختبار قصير لليقظة النفسية الحركية (PVT-B)، واختبار الاستجابة الذاتي من ناسا الذي يستخدمه رواد الفضاء لتتبّع الإرهاق.';

  @override
  String get sciIpipTitle => 'مجمع بنود الشخصية الدولي (IPIP)';

  @override
  String get sciIpipBody =>
      'بنود من الملك العام من ipip.ori.org. اختبار Mini-IPIP من 20 بنداً من وضع Donnellan وOswald وBaird وLucas (2006). سيستخدم المنتج الكامل IPIP-NEO-120 من 120 بنداً للحصول على 30 جانباً فرعياً.';

  @override
  String get sciAssume1 =>
      'الحدود بالانحراف المعياري وعدد الأيام اللازمة لرصد تغيّر هي خيارات تصميم لنموذج أولي.';

  @override
  String get sciAssume2 =>
      'الحد الأشد بعد اليوم 150 يستند إلى دراسات محاكاة تفيد بارتفاع الأعراض السلوكية بعد 5 إلى 6 أشهر.';

  @override
  String get sciAssume3 =>
      'سمات الشخصية تغيّر فقط مدى سرعة رصد التغيّر. ولا تصنّف الشخص أبداً.';

  @override
  String get reactionTitle => 'اختبار الاستجابة';

  @override
  String get ipipItem1 => 'أنا روح الحفلة';

  @override
  String get ipipItem2 => 'أتعاطف مع مشاعر الآخرين';

  @override
  String get ipipItem3 => 'أنجز المهام اليومية فوراً';

  @override
  String get ipipItem4 => 'تتقلب حالتي المزاجية كثيراً';

  @override
  String get ipipItem5 => 'لدي خيال واسع';

  @override
  String get ipipItem6 => 'لا أتكلم كثيراً';

  @override
  String get ipipItem7 => 'لا أهتم بمشكلات الآخرين';

  @override
  String get ipipItem8 => 'كثيراً ما أنسى إعادة الأشياء إلى مكانها';

  @override
  String get ipipItem9 => 'أكون مرتاحاً معظم الوقت';

  @override
  String get ipipItem10 => 'لا تهمني الأفكار المجردة';

  @override
  String get ipipItem11 => 'أتحدث مع كثير من الناس المختلفين في الحفلات';

  @override
  String get ipipItem12 => 'أشعر بمشاعر الآخرين';

  @override
  String get ipipItem13 => 'أحب النظام';

  @override
  String get ipipItem14 => 'أنزعج بسهولة';

  @override
  String get ipipItem15 => 'أجد صعوبة في فهم الأفكار المجردة';

  @override
  String get ipipItem16 => 'أبقى في الخلفية';

  @override
  String get ipipItem17 => 'لا أهتم حقاً بالآخرين';

  @override
  String get ipipItem18 => 'أُفسد الأمور وأُحدث فوضى';

  @override
  String get ipipItem19 => 'نادراً ما أشعر بالحزن';

  @override
  String get ipipItem20 => 'ليس لدي خيال جيد';

  @override
  String get ipipAnswer1 => 'غير دقيق إطلاقاً';

  @override
  String get ipipAnswer2 => 'غير دقيق نوعاً ما';

  @override
  String get ipipAnswer3 => 'لا دقيق ولا غير دقيق';

  @override
  String get ipipAnswer4 => 'دقيق نوعاً ما';

  @override
  String get ipipAnswer5 => 'دقيق جداً';

  @override
  String ipipAnswerSemantics(String n, String label) {
    return '$n، $label';
  }

  @override
  String onbStep(int stepNum, int totalNum) {
    return 'الخطوة $stepNum من $totalNum';
  }

  @override
  String get onbNext => 'التالي';

  @override
  String get onbCreate => 'إنشاء الملف الشخصي';

  @override
  String get onbWelcome => 'مرحباً على متن السفينة';

  @override
  String get onbWelcomeSub => 'Psychonaut، رفيقك اليومي';

  @override
  String get onbIntro =>
      'يقارنك Psychonaut بخطك المرجعي الخاص ويقترح إجراءً صغيراً واحداً كل يوم. استبيان قصير من 20 عبارة يضبط سرعة رصد التغيّرات وطريقة حديثه إليك. تبقى إجاباتك على هذا الجهاز.';

  @override
  String get onbName => 'اسمك';

  @override
  String get onbRole => 'دورك، مثلاً القائد';

  @override
  String get onbExploring => 'هل تستكشف فقط؟';

  @override
  String get onbSampleHint => 'حمّل ملفاً شخصياً تجريبياً بدلاً من ذلك.';

  @override
  String get onbCancel => 'إلغاء والاحتفاظ بملفي الحالي';

  @override
  String get onbAboutYou => 'عنك';

  @override
  String onbItemsHint(int pageNum, int pagesNum) {
    return 'صف نفسك كما أنت عادةً الآن، لا كما تتمنى أن تكون. الصفحة $pageNum من $pagesNum.';
  }

  @override
  String get onbLocusTitle => 'عندما تسير الأمور جيداً أو سيئاً';

  @override
  String get onbLocusSub => 'أيّها أقرب إليك؟ هذا يحدد كيف تُصاغ النصائح.';

  @override
  String get onbLocusInternalTitle => 'غالباً خياراتي وجهدي';

  @override
  String get onbLocusInternalText => 'ما يحدث لي يعتمد في الغالب على ما أفعله.';

  @override
  String get onbLocusMixedTitle => 'مزيج من الاثنين';

  @override
  String get onbLocusMixedText => 'جهدي مهم، وكذلك الظروف التي لا أتحكم بها.';

  @override
  String get onbLocusExternalTitle => 'غالباً الظروف والآخرون';

  @override
  String get onbLocusExternalText => 'كثير مما يحدث خارج عن سيطرتي.';

  @override
  String get onbToneTitle => 'كيف تريد أن يخاطبك Psychonaut؟';

  @override
  String get onbToneSub => 'يمكنك تغيير ذلك لاحقاً.';

  @override
  String get onbToneDirectEx =>
      '«نومك انخفض 0.8 ساعة. جرّب إعادة ضبط النوم الليلة.»';

  @override
  String get onbToneGentleEx => '«تحرّك نومك قليلاً. قد تساعد أمسية هادئة.»';

  @override
  String get onbActionsTitle => 'ما الذي يساعدك على استعادة توازنك؟';

  @override
  String get onbActionsSub =>
      'اختر الإجراءات التي تحبها. ترتيب اختيارك هو ترتيب عرضها.';

  @override
  String get onbYourProfile => 'ملفك الشخصي';

  @override
  String get onbTraits => 'سمات الشخصية';

  @override
  String get onbTraitsNote =>
      'من نسخة مختصرة من 20 بنداً. تغيّر السمات فقط سرعة رصد التغيّر. ولا تصنّفك أبداً.';

  @override
  String get onbPrefs => 'تفضيلاتك';

  @override
  String get onbActionsLabel => 'الإجراءات';

  @override
  String get roleDefault => 'فرد من الطاقم';

  @override
  String get importPickerTitle => 'اختر ملف JSON للملف الشخصي';

  @override
  String get reactionIntro =>
      'يقيس هذا الاختبار، ومدته 3 دقائق، مدى يقظتك. عندما تظهر على الشاشة عبارة «انقر الآن» انقر بأسرع ما يمكن. لا تنقر قبل ظهورها.';

  @override
  String get reactionKeyboardHint => 'على لوحة المفاتيح، اضغط مفتاح المسافة.';

  @override
  String get reactionWait => 'انتظر…';

  @override
  String get reactionTapNow => 'انقر الآن';

  @override
  String get reactionTooSoon => 'مبكر جداً. انتظر الإشارة.';

  @override
  String reactionTimeLeft(String time) {
    return 'بقي $time';
  }

  @override
  String get reactionDiscardHint => 'الرجوع الآن يلغي هذا الاختبار.';

  @override
  String get reactionDoneTitle => 'اكتمل الاختبار';

  @override
  String get reactionMean => 'متوسط زمن الاستجابة';

  @override
  String get reactionResponses => 'الاستجابات';

  @override
  String get reactionLapses => 'حالات الغفلة (أبطأ من 500 م.ث)';

  @override
  String get reactionFalseStarts => 'النقرات المبكرة';

  @override
  String get reactionSaved => 'تم الحفظ. يمكنك رؤيته في الاتجاهات.';

  @override
  String get reactionNoResponses => 'لم تُسجَّل أي استجابة، لذلك لم يُحفظ شيء.';

  @override
  String get reactionDone => 'تم';
}
