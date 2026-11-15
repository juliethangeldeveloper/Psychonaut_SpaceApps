// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get navHome => 'Главная';

  @override
  String get navCheckIn => 'Отметка';

  @override
  String get navTrends => 'Динамика';

  @override
  String get navCrew => 'Экипаж';

  @override
  String get profileAndSettings => 'Профиль и настройки';

  @override
  String get back => 'Назад';

  @override
  String get sampleData => 'Демо-данные';

  @override
  String get disclaimer =>
      'Psychonaut не ставит диагнозов и не заменяет врача.';

  @override
  String get statusOnCourse => 'На курсе';

  @override
  String get statusDrifting => 'Дрейф';

  @override
  String get statusOffCourse => 'Вне курса';

  @override
  String get statusAlert => 'Тревога';

  @override
  String traitSemantics(String label, int valueNum) {
    return '$label: $valueNum из 100';
  }

  @override
  String get indicatorMood => 'Настроение';

  @override
  String get indicatorStress => 'Стресс';

  @override
  String get indicatorSleep => 'Сон';

  @override
  String get indicatorFocus => 'Концентрация';

  @override
  String get indicatorMotivation => 'Мотивация';

  @override
  String get indicatorConnection => 'Связь';

  @override
  String get indicatorWorkload => 'Нагрузка';

  @override
  String get indicatorReaction => 'Время реакции';

  @override
  String get trendImproving => 'улучшается';

  @override
  String get trendSteady => 'стабильно';

  @override
  String get trendSlipping => 'ухудшается';

  @override
  String get homeTitle => 'Ваш курс';

  @override
  String missionLine(int dayNum, String phase) {
    return 'День миссии $dayNum · $phase';
  }

  @override
  String headingSemantics(int degreesNum, String status) {
    return 'Отклонение от курса: $degreesNum°. Общий статус: $status.';
  }

  @override
  String get headingOffCourse => 'отклонение от курса';

  @override
  String get headingMeasured => 'Относительно вашего личного базового уровня.';

  @override
  String get mismatchTitle => 'Ваши ощущения и данные тела расходятся';

  @override
  String mismatchBody(String mood, String details) {
    return 'Вы оценили настроение на $mood, на уровне базового или выше, но $details. Верно может быть и то и другое. Стоит присмотреться.';
  }

  @override
  String mismatchDetailSleep(int daysNum) {
    return 'сон ниже вашего базового уровня уже $daysNum дн.';
  }

  @override
  String mismatchDetailReaction(int daysNum) {
    return 'время реакции медленнее вашего базового уровня уже $daysNum дн.';
  }

  @override
  String mismatchJoin(String first, String second) {
    return '$first, а также $second';
  }

  @override
  String get lifeEventTitle => 'Что-то случилось дома';

  @override
  String get lifeEventCardBody =>
      'Нести это так далеко от дома непросто. Вам не нужно справляться в одиночку. Следующие 14 дней за настроением следят внимательнее, а «Написать домой» предлагается первым.';

  @override
  String get reactionPromptTitle => 'Пора пройти тест реакции';

  @override
  String get reactionPromptText =>
      'Три минуты. Он показывает усталость раньше, чем вы её почувствуете.';

  @override
  String get reactionPromptButton => 'Начать тест';

  @override
  String get logOpenTitle => 'Бортовой журнал открыт';

  @override
  String get logOpenText => 'Сегодня вы ещё не делали запись.';

  @override
  String get logEntry => 'Сделать запись';

  @override
  String get readingPreparing => 'Готовим ваш обзор';

  @override
  String get readingUnavailable => 'Обзор сейчас недоступен.';

  @override
  String get readingTitle => 'Обзор дня';

  @override
  String get readingFixedAlertNote =>
      'Фиксированное сообщение безопасности, не создано ИИ.';

  @override
  String get aiGenerated => 'Создано ИИ';

  @override
  String get suggestedAction => 'Предлагаемое действие';

  @override
  String readingSource(String source) {
    return 'Источник: $source';
  }

  @override
  String get sourceRuleBased => 'По правилам · на этом устройстве';

  @override
  String get sourceOnBoard => 'Бортовая модель';

  @override
  String get sourceCloud => 'Облачная модель';

  @override
  String loadError(String error) {
    return 'Не удалось загрузить данные.\n$error';
  }

  @override
  String get indicatorsTitle => 'Показатели';

  @override
  String get panelMindMap => 'Карта состояния';

  @override
  String get panelSelected => 'Выбранный показатель';

  @override
  String chartLast14(String indicator) {
    return '$indicator, последние 14 дней';
  }

  @override
  String get chartSleep14 => 'Сон, 14 ночей';

  @override
  String tileSemantics(String indicator, String status, String trend) {
    return '$indicator, $status, $trend';
  }

  @override
  String get trendNoData => 'Данных пока нет';

  @override
  String get trendAtBaseline => 'На базовом уровне';

  @override
  String trendAbove(String amount) {
    return 'на $amount выше базового уровня';
  }

  @override
  String trendBelow(String amount) {
    return 'на $amount ниже базового уровня';
  }

  @override
  String trendJoin(String where, String trend) {
    return '$where, $trend';
  }

  @override
  String detailNow(String now, String baseline, String trend) {
    return 'Сейчас $now · ваш базовый уровень $baseline · $trend';
  }

  @override
  String get flaggedSooner =>
      'С учётом вашего профиля отслеживается на день раньше.';

  @override
  String get detailHowMeasured => 'Как измеряется';

  @override
  String get detailWhy => 'Почему это важно';

  @override
  String get detailWhatToDo => 'Что делать сейчас';

  @override
  String whatToDoOptions(String text, String options) {
    return '$text Варианты: $options.';
  }

  @override
  String whatToDoRecommended(String text, String action) {
    return '$text Рекомендуем: $action.';
  }

  @override
  String whatToDoOneStep(String action, String description) {
    return 'Один шаг: $action. $description';
  }

  @override
  String get nasaRiskLabel => 'Риск NASA';

  @override
  String get nasaHazardLabel => 'Фактор опасности';

  @override
  String labelValue(String label, String value) {
    return '$label: $value';
  }

  @override
  String unitHours(String value) {
    return '$value ч';
  }

  @override
  String unitMs(String value) {
    return '$value мс';
  }

  @override
  String get refMeasuredMood =>
      'Ваша ежедневная самооценка от 1 до 10 в бортовом журнале в сравнении с вашим личным базовым уровнем.';

  @override
  String get refWhyMood =>
      'Небольшие устойчивые спады настроения легче исправить на ранней стадии. Сравнение с базовым уровнем полезнее, чем любой отдельный день.';

  @override
  String get refTodoMood =>
      'Отвечайте честно, затем выберите одно небольшое действие. Если плохие дни накапливаются, скажите об этом товарищу по экипажу.';

  @override
  String get refMeasuredStress =>
      'Ваша ежедневная оценка стресса от 1 до 10 в сравнении с вашим базовым уровнем. Чем выше, тем хуже.';

  @override
  String get refWhyStress =>
      'Долгое пребывание в замкнутом пространстве держит стресс на высоком уровне. Растущий стресс к тому же отнимает сон и концентрацию.';

  @override
  String get refTodoStress =>
      'Две минуты дышите медленно, подвигайтесь или передайте кому-нибудь одну задачу на сегодня.';

  @override
  String get refMeasuredSleep =>
      'Часы сна каждую ночь по данным трекера сна или демо-данным. Здоровый диапазон: 7–8 часов. 6 часов и меньше считается коротким сном.';

  @override
  String get refWhySleep =>
      'Недосып и нерегулярный график замедляют реакцию, ухудшают настроение и делают мелкие проблемы крупнее.';

  @override
  String get refTodoSleep =>
      'Для перезагрузки сна держите фиксированное время отбоя, за час приглушите экраны и охладите каюту.';

  @override
  String get refMeasuredFocus =>
      'Ваша оценка концентрации от 1 до 10 вместе с числом пропусков в тесте реакции.';

  @override
  String get refWhyFocus =>
      'Внимание первым страдает, когда сбиваются сон или нагрузка, а ошибки в полёте обходятся дороже всего.';

  @override
  String get refTodoFocus =>
      'Сделайте настоящий перерыв без экранов, затем выполняйте задачи по одной. Сначала проверьте свой сон.';

  @override
  String get refMeasuredMotivation =>
      'Ваша оценка вовлечённости от 1 до 10 в сравнении с вашим базовым уровнем.';

  @override
  String get refWhyMotivation =>
      'Долгие однообразные миссии располагают к скуке. Снижение вовлечённости может предшествовать спаду настроения.';

  @override
  String get refTodoMotivation =>
      'Начните небольшой новый проект или измените порядок дня для разнообразия.';

  @override
  String get refMeasuredConnection =>
      'Ваша оценка связи с экипажем от 1 до 10 в сравнении с вашим базовым уровнем.';

  @override
  String get refWhyConnection =>
      'Хорошая командная работа зависит от ощущения связи с другими. Удалённость от Земли к тому же делает общение с семьёй медленнее и реже.';

  @override
  String get refTodoConnection =>
      'Разделите трапезу с экипажем или отправьте сообщение домой. Даже небольшой контакт имеет значение.';

  @override
  String get refMeasuredWorkload =>
      'Ваша оценка нагрузки от 1 до 10 в сравнении с вашим базовым уровнем. Чем выше, тем хуже.';

  @override
  String get refWhyWorkload =>
      'Перегрузка отнимает время сна. Из-за задержек связи с Землёй экипажу приходится самому регулировать темп.';

  @override
  String get refTodoWorkload =>
      'Перенесите одну задачу на завтра или попросите экипаж её разделить. Берегите время для сна.';

  @override
  String get refMeasuredReaction =>
      'Тест реакции на 3 минуты. Когда появляется сигнал, нажимайте как можно быстрее. Мы записываем среднее время реакции, пропуски (медленнее 500 мс) и фальстарты.';

  @override
  String get refWhyReaction =>
      'Медленные ответы и пропуски относятся к самым ранним признакам усталости и рассеянного внимания, часто раньше, чем вы заметите это сами.';

  @override
  String get refTodoReaction =>
      'Повторяйте тест раз в несколько дней примерно в одно и то же время и сравнивайте со своим базовым уровнем.';

  @override
  String get actionExerciseTitle => 'Упражнения';

  @override
  String get actionExerciseDesc =>
      'Короткая тренировка на беговой дорожке или велотренажёре.';

  @override
  String get actionJournalTitle => 'Дневник';

  @override
  String get actionJournalDesc =>
      'Десять минут личных записей о прошедшем дне.';

  @override
  String get actionFamilyCallTitle => 'Написать домой';

  @override
  String get actionFamilyCallDesc =>
      'Отправьте сообщение или запланируйте звонок кому-то на Земле.';

  @override
  String get actionGardenTitle => 'Иллюминатор и оранжерея';

  @override
  String get actionGardenDesc =>
      'Проведите время у иллюминатора или с растениями.';

  @override
  String get actionWindowTimeTitle => 'Время у иллюминатора';

  @override
  String get actionWindowTimeDesc =>
      'Десять минут у иллюминатора, глядя на Землю или звёзды.';

  @override
  String get actionNewProjectTitle => 'Начать небольшой проект';

  @override
  String get actionNewProjectDesc =>
      'Выберите короткую новую задачу, чтобы нарушить рутину.';

  @override
  String get actionSleepResetTitle => 'Перезагрузка сна';

  @override
  String get actionSleepResetDesc =>
      'Фиксированный отбой, приглушённые экраны и более прохладная каюта на одну ночь.';

  @override
  String get aiRuleBasedLabel => 'По правилам';

  @override
  String get aiRuleBasedDesc =>
      'Шаблоны на этом устройстве. Без сети. По умолчанию.';

  @override
  String get aiOnBoardLabel => 'Бортовая модель';

  @override
  String get aiOnBoardDesc =>
      'Модель, работающая на этом компьютере или в сети корабля. Ничего не покидает корабль. Если она не запущена, используются правила.';

  @override
  String get aiCloudLabel => 'Облачная модель';

  @override
  String get aiCloudDesc =>
      'Большая языковая модель через интернет. Только для использования на Земле. Отправляет ваши оценки и профиль личности, но не имя и не заметки.';

  @override
  String get phaseAdjustment => 'Адаптация';

  @override
  String get phaseAdjustmentNote =>
      'Период привыкания. Распорядок ещё складывается.';

  @override
  String get phaseMid => 'Середина миссии';

  @override
  String get phaseMidNote => 'Устойчивый период. Следите за медленным дрейфом.';

  @override
  String get phaseLate => 'Поздний этап миссии';

  @override
  String get phaseLateNote =>
      'После 150-го дня наблюдение строже. В исследованиях-аналогах поведенческие симптомы усиливаются через 5–6 месяцев.';

  @override
  String get riskBehavioral => 'Поведенческие состояния';

  @override
  String get riskTeamwork => 'Недостаточная командная работа';

  @override
  String get riskSleep => 'Недостаток сна и нерегулярный график';

  @override
  String get hazardIsolation => 'Изоляция и замкнутое пространство';

  @override
  String get hazardDistance => 'Удалённость от Земли';

  @override
  String get toneDirect => 'Прямой';

  @override
  String get toneGentle => 'Мягкий';

  @override
  String get framingInternal => 'Внутренний: данные и варианты';

  @override
  String get framingMixed => 'Смешанный: данные и одна рекомендация';

  @override
  String get framingExternal => 'Внешний: один понятный шаг';

  @override
  String get copingProblem => 'Ориентированный на проблему';

  @override
  String get copingEmotion => 'Ориентированный на эмоции';

  @override
  String get copingAvoidant => 'Избегающий';

  @override
  String get sourceMiniIpip => 'Опросник Mini-IPIP';

  @override
  String get sourceIpipNeo120 => 'Опросник IPIP-NEO-120';

  @override
  String get sourceImported => 'Импортированный файл';

  @override
  String get alertMessage =>
      'Сообщите медицинскому офицеру экипажа и подготовьте сводку для Земли';

  @override
  String sourceUnavailableNote(String source) {
    return '$source недоступна, поэтому этот обзор создан по правилам.';
  }

  @override
  String insOnCourseDirect(int degreesNum) {
    return 'Вы на курсе с отклонением $degreesNum°, и все показатели близки к вашему базовому уровню.';
  }

  @override
  String insOnCourseGentle(int degreesNum) {
    return 'Вы на курсе, отклонение всего $degreesNum°, и показатели близки к вашей обычной норме.';
  }

  @override
  String insWorstGentle(
    String indicator,
    String current,
    String baseline,
    String trend,
  ) {
    return 'Показатель «$indicator» немного сместился: сейчас $current при обычном $baseline, тенденция: $trend.';
  }

  @override
  String insWorstDirect(
    String indicator,
    String status,
    String current,
    String baseline,
    String trend,
  ) {
    return 'Показатель «$indicator»: $status, $current при базовом уровне $baseline, тенденция: $trend.';
  }

  @override
  String insMismatchGentle(int daysNum) {
    return 'Вы сказали, что чувствуете себя хорошо, и это важно, но данные тела уже $daysNum дн. вне базового уровня.';
  }

  @override
  String insMismatchDirect(int daysNum) {
    return 'Вы оценили настроение на уровне базового или выше, но данные тела уже $daysNum дн. вне базового уровня.';
  }

  @override
  String get insLifeGentle =>
      'Вы отметили событие дома, поэтому пока за настроением следят чуть внимательнее.';

  @override
  String get insLifeDirect =>
      'Вы отметили событие дома, поэтому 14 дней за настроением следят внимательнее.';

  @override
  String insActionGentle(String action) {
    return 'Сегодня может помочь один небольшой шаг: $action.';
  }

  @override
  String insActionDirect(String action) {
    return 'Одно небольшое действие на сегодня: $action.';
  }

  @override
  String get insEvidenceAllOk =>
      'Все показатели в пределах одного стандартного отклонения от вашего базового уровня.';

  @override
  String insEvidence(String indicator, String current, String baseline) {
    return '$indicator: $current при базовом уровне $baseline.';
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
      other: '$count дня',
      many: '$count дней',
      few: '$count дня',
      one: '$count день',
    );
    return '$indicator: $current при базовом уровне $baseline, за пределами $sd СО уже $_temp0.';
  }

  @override
  String insNights(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count недавней ночи со сном 6 часов или меньше.',
      many: '$count недавних ночей со сном 6 часов или меньше.',
      few: '$count недавние ночи со сном 6 часов или меньше.',
      one: '$count недавняя ночь со сном 6 часов или меньше.',
    );
    return '$_temp0';
  }

  @override
  String get insLapses => 'Пропусков в тесте реакции больше, чем обычно.';

  @override
  String insOptions(String options) {
    return 'Варианты: $options';
  }

  @override
  String insRecommended(String action, String description) {
    return 'Рекомендуем: $action. $description';
  }

  @override
  String insRecommendedStep(String action, String description) {
    return 'Рекомендуемый шаг: $action. $description Сегодня достаточно только этого шага.';
  }

  @override
  String get insLatePhase =>
      'После 150-го дня миссии наблюдение строже, поэтому отмечаются и небольшие изменения.';

  @override
  String get insLifeSupport =>
      'Новости из дома могут быть тяжёлыми. Возможно, поможет разговор с тем, кому вы доверяете.';

  @override
  String get trendsTitle => 'Отклонение от курса';

  @override
  String get trendsSubtitle =>
      'Насколько вы отходите от своего базового уровня';

  @override
  String get trendsSleepTitle => 'Сон, последние 14 ночей';

  @override
  String get trendsNoTests => 'Тестов пока нет';

  @override
  String trendsLatestReaction(String ms, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count пропуска',
      many: '$count пропусков',
      few: '$count пропуска',
      one: '$count пропуск',
    );
    return 'Последний $ms · $_temp0';
  }

  @override
  String trendsNasaLine(String risk, String hazards) {
    return 'Риск NASA: $risk. Фактор опасности: $hazards.';
  }

  @override
  String get correctionsTitle => 'Корректировки курса';

  @override
  String get correctionsHint =>
      'Выберите одно небольшое действие. Предпочтительные для вас идут первыми.';

  @override
  String correctionsPlan(String title, String description) {
    return 'Ваш план: $title. $description';
  }

  @override
  String get correctionsSuggested => 'Рекомендуется';

  @override
  String actionSemantics(String title, String description) {
    return '$title. $description';
  }

  @override
  String actionSemanticsSuggested(String title, String description) {
    return '$title. $description Рекомендуется на сегодня.';
  }

  @override
  String get chartNoSleep => 'Данных о сне пока нет.';

  @override
  String chartBaselineValue(String value) {
    return 'Ваш базовый уровень $value';
  }

  @override
  String get chartBaseline => 'Ваш базовый уровень';

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
    return 'Сон за последние ночи: $count. Базовый уровень $baseline. Последняя ночь $latest, $status.';
  }

  @override
  String get chartToday => 'Сегодня';

  @override
  String get chartNeedTests =>
      'Пройдите тест реакции несколько раз, чтобы увидеть динамику.';

  @override
  String chartReactionSemantics(int count, String baseline, String latest) {
    return 'Время реакции по последним тестам: $count. Базовый уровень $baseline. Последний $latest.';
  }

  @override
  String get chartNotEnough => 'Данных пока недостаточно.';

  @override
  String chartDaysAgo(int daysNum) {
    return '-$daysNum дн.';
  }

  @override
  String get checkinTitle => 'Бортовой журнал';

  @override
  String get checkinSubtitle =>
      'Как вы сегодня? Отвечайте честно. Неправильных ответов нет.';

  @override
  String get qEngagement => 'Вовлечённость';

  @override
  String get qConnection => 'Связь с экипажем';

  @override
  String get scaleLow => 'Низко';

  @override
  String get scaleHigh => 'Высоко';

  @override
  String get scaleCalm => 'Спокойно';

  @override
  String get scaleVeryStressed => 'Сильный стресс';

  @override
  String get scaleLight => 'Легко';

  @override
  String get scaleOverloaded => 'Перегрузка';

  @override
  String get scaleBored => 'Скучно';

  @override
  String get scaleAbsorbed => 'Увлечённо';

  @override
  String get scaleScattered => 'Рассеянно';

  @override
  String get scaleSharp => 'Собранно';

  @override
  String get scaleDistant => 'Отстранённо';

  @override
  String get scaleClose => 'Близко';

  @override
  String checkinStreak(int count) {
    return 'Серия: $count дн.';
  }

  @override
  String checkinStreakSemantics(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count дня',
      many: '$count дней',
      few: '$count дня',
      one: '$count день',
    );
    return 'Серия записей: $_temp0';
  }

  @override
  String get checkinStreakNote =>
      'Считаются дни с записью, а не то, какие были оценки.';

  @override
  String get checkinOptional => 'Необязательно.';

  @override
  String get checkinNoteLabel => 'Личная заметка';

  @override
  String get checkinNoteHelper =>
      'Хранится только на этом устройстве. Никуда не отправляется.';

  @override
  String get checkinUpdate => 'Обновить сегодняшнюю запись';

  @override
  String get checkinLogged => 'Запись сохранена. Спасибо.';

  @override
  String sliderSemantics(String label, int valueNum) {
    return '$label: $valueNum из 10';
  }

  @override
  String get crewTitle => 'Боевой дух корабля';

  @override
  String get crewSubtitle => 'Состояние экипажа одним анонимным числом';

  @override
  String get moraleHigh => 'Высокий';

  @override
  String get moraleSteady => 'Стабильный';

  @override
  String get moraleStrained => 'Напряжённый';

  @override
  String get moraleLow => 'Низкий';

  @override
  String get crewOutOf100 => '/ 100';

  @override
  String crewMeterSemantics(
    String level,
    int scoreNum,
    int contributedNum,
    int crewNum,
  ) {
    return 'Боевой дух экипажа: $level, $scoreNum из 100. Сегодня отметились $contributedNum из $crewNum членов экипажа.';
  }

  @override
  String crewCheckedIn(int contributedNum, int crewNum) {
    return 'Сегодня отметились $contributedNum из $crewNum членов экипажа. Имена никогда не показываются.';
  }

  @override
  String get crewGoalLabel => 'Общая цель недели';

  @override
  String get crewGoalTitle => 'Ужинать вместе';

  @override
  String get crewGoalDesc =>
      'На этой неделе поужинайте с экипажем в 6 вечеров. Можно коротко и без спешки.';

  @override
  String crewGoalProgress(int doneNum, int segmentsNum, int peopleNum) {
    return 'Выполнено вечеров: $doneNum из $segmentsNum · участников: $peopleNum';
  }

  @override
  String crewGoalSemantics(int doneNum, int segmentsNum) {
    return 'Выполнено вечеров: $doneNum из $segmentsNum';
  }

  @override
  String get crewJoin => 'Присоединиться к цели';

  @override
  String get crewLeave => 'Вы участвуете. Нажмите, чтобы выйти';

  @override
  String get crewPrivacyTitle => 'Ваша конфиденциальность';

  @override
  String get crewPrivacyBody =>
      'Показывается только среднее по группе. Ваши оценки, заметки и профиль остаются на этом устройстве. Нет ни имён, ни рейтингов, ни сравнений между людьми.';

  @override
  String get profileTitle => 'Профиль';

  @override
  String get profileSubtitle =>
      'Всё хранится на этом устройстве, если вы не выберете облачную модель.';

  @override
  String get profileRetake => 'Пройти опросник заново';

  @override
  String get profileSamples => 'Демо-профили';

  @override
  String get profileSamplesHint =>
      'Переключитесь на встроенный пример, чтобы увидеть, как приложение подстраивается под другого человека.';

  @override
  String get scienceTitle => 'Научная основа';

  @override
  String profileLoaded(String name) {
    return 'Загружен профиль: $name.';
  }

  @override
  String get profileCurrent => 'Текущий';

  @override
  String profileCurrentSemantics(String label) {
    return '$label, текущий';
  }

  @override
  String get traitOpenness => 'Открытость опыту';

  @override
  String get traitConscientiousness => 'Добросовестность';

  @override
  String get traitExtraversion => 'Экстраверсия';

  @override
  String get traitAgreeableness => 'Доброжелательность';

  @override
  String get traitEmotionalStability => 'Эмоциональная стабильность';

  @override
  String get traitBoredom => 'Склонность к скуке';

  @override
  String get facetsTitle => 'Аспекты';

  @override
  String get facetExcitement => 'Поиск острых ощущений';

  @override
  String get facetGregariousness => 'Общительность';

  @override
  String get facetVulnerability => 'Уязвимость';

  @override
  String get facetSelfDiscipline => 'Самодисциплина';

  @override
  String get profileAdviceFraming => 'Подача советов';

  @override
  String get profileCoping => 'Стиль совладания';

  @override
  String get profileTone => 'Тон';

  @override
  String get profilePreferred => 'Предпочитаемые действия';

  @override
  String get profileBaseline => 'Базовый уровень';

  @override
  String dotJoin2(String a, String b) {
    return '$a · $b';
  }

  @override
  String dotJoin3(String a, String b, String c) {
    return '$a · $b · $c';
  }

  @override
  String get restingHeartRate => 'Пульс в покое';

  @override
  String get hrvLabel => 'ВСР';

  @override
  String unitBpm(String value) {
    return '$value уд/мин';
  }

  @override
  String get settingsMissionDay => 'День миссии';

  @override
  String get settingsPrevDay => 'Предыдущий день';

  @override
  String get settingsNextDay => 'Следующий день';

  @override
  String settingsDay(int dayNum) {
    return 'День $dayNum';
  }

  @override
  String settingsMissionDaySemantics(int dayNum, String phase) {
    return 'День миссии $dayNum, $phase';
  }

  @override
  String get settingsAiSource => 'Источник ИИ';

  @override
  String get settingsAiHint =>
      'Откуда берётся текстовый обзор на главном экране. При тревоге сообщение всегда фиксированное.';

  @override
  String get settingsLanguage => 'Язык';

  @override
  String get settingsLanguageHint =>
      'Выберите язык приложения. Текстовый обзор будет на этом же языке.';

  @override
  String get languageDevice => 'Язык устройства';

  @override
  String get importTitle => 'Импорт профиля';

  @override
  String get importHint =>
      'Загрузите другого человека из JSON-файла с теми же полями, что и во встроенных примерах. Ничего никуда не отправляется.';

  @override
  String get importButton => 'Импортировать JSON профиля';

  @override
  String importFailed(String error) {
    return 'Не удалось импортировать этот файл. $error';
  }

  @override
  String get importNotJson => 'Этот файл не является корректным JSON.';

  @override
  String get importUnreadable => 'Не удалось прочитать этот файл.';

  @override
  String importDone(String name) {
    return 'Импортирован профиль: $name.';
  }

  @override
  String get scienceSubtitle => 'Откуда взяты идеи Psychonaut.';

  @override
  String get scienceAssumptionsTitle => 'Допущения проекта';

  @override
  String get sciHrpTitle =>
      'Программа исследований человека NASA: опасности и риски';

  @override
  String get sciHrpBody =>
      'Перечень опасностей космического полёта, включая изоляцию, замкнутое пространство и удалённость от Земли, и связанные с ними риски для здоровья человека.';

  @override
  String get sciBhrTitle => 'Реестр рисков поведенческого здоровья NASA';

  @override
  String get sciBhrBody =>
      'Риски для поведенческого здоровья и работоспособности в длительных миссиях: поведенческие состояния, командная работа и сон.';

  @override
  String get sciReactionTitle => 'Исследования теста реакции';

  @override
  String get sciReactionBody =>
      'Basner, Mollicone и Dinges (2011), краткий тест психомоторной бдительности (PVT-B), и тест реакции NASA, который астронавты используют для отслеживания усталости.';

  @override
  String get sciIpipTitle => 'Международный банк личностных опросников (IPIP)';

  @override
  String get sciIpipBody =>
      'Общедоступные утверждения с сайта ipip.ori.org. Mini-IPIP из 20 утверждений разработан Donnellan, Oswald, Baird и Lucas (2006). В полной версии продукта будет использоваться IPIP-NEO-120 из 120 утверждений для 30 аспектов.';

  @override
  String get sciAssume1 =>
      'Пороги в стандартных отклонениях и число дней до отметки изменения выбраны для прототипа.';

  @override
  String get sciAssume2 =>
      'Более строгий порог после 150-го дня миссии основан на исследованиях-аналогах, где поведенческие симптомы усиливаются через 5–6 месяцев.';

  @override
  String get sciAssume3 =>
      'Черты личности влияют только на то, как быстро отмечается изменение. Они никогда не навешивают на человека ярлыков.';

  @override
  String get reactionTitle => 'Тест реакции';

  @override
  String get ipipItem1 => 'Я душа компании';

  @override
  String get ipipItem2 => 'Я сочувствую чувствам других';

  @override
  String get ipipItem3 => 'Я сразу берусь за бытовые дела';

  @override
  String get ipipItem4 => 'У меня часто меняется настроение';

  @override
  String get ipipItem5 => 'У меня богатое воображение';

  @override
  String get ipipItem6 => 'Я мало говорю';

  @override
  String get ipipItem7 => 'Меня не интересуют чужие проблемы';

  @override
  String get ipipItem8 => 'Я часто забываю класть вещи на место';

  @override
  String get ipipItem9 => 'Большую часть времени я чувствую себя спокойно';

  @override
  String get ipipItem10 => 'Меня не интересуют абстрактные идеи';

  @override
  String get ipipItem11 =>
      'На вечеринках я разговариваю с множеством разных людей';

  @override
  String get ipipItem12 => 'Я чувствую эмоции других';

  @override
  String get ipipItem13 => 'Я люблю порядок';

  @override
  String get ipipItem14 => 'Меня легко расстроить';

  @override
  String get ipipItem15 => 'Мне трудно понимать абстрактные идеи';

  @override
  String get ipipItem16 => 'Я держусь в тени';

  @override
  String get ipipItem17 => 'Другие люди меня не особо интересуют';

  @override
  String get ipipItem18 => 'Я устраиваю беспорядок во всём';

  @override
  String get ipipItem19 => 'Мне редко бывает грустно';

  @override
  String get ipipItem20 => 'У меня плохое воображение';

  @override
  String get ipipAnswer1 => 'Совершенно неверно';

  @override
  String get ipipAnswer2 => 'Скорее неверно';

  @override
  String get ipipAnswer3 => 'Ни верно, ни неверно';

  @override
  String get ipipAnswer4 => 'Скорее верно';

  @override
  String get ipipAnswer5 => 'Совершенно верно';

  @override
  String ipipAnswerSemantics(String n, String label) {
    return '$n, $label';
  }

  @override
  String onbStep(int stepNum, int totalNum) {
    return 'Шаг $stepNum из $totalNum';
  }

  @override
  String get onbNext => 'Далее';

  @override
  String get onbCreate => 'Создать профиль';

  @override
  String get onbWelcome => 'Добро пожаловать на борт';

  @override
  String get onbWelcomeSub => 'Psychonaut, ваш ежедневный спутник';

  @override
  String get onbIntro =>
      'Psychonaut сравнивает вас с вашим собственным базовым уровнем и каждый день предлагает одно небольшое действие. Короткий опросник из 20 утверждений настраивает, как быстро отмечаются изменения и как приложение с вами говорит. Ваши ответы остаются на этом устройстве.';

  @override
  String get onbName => 'Ваше имя';

  @override
  String get onbRole => 'Ваша роль, например командир';

  @override
  String get onbExploring => 'Просто знакомитесь?';

  @override
  String get onbSampleHint => 'Загрузите вместо этого демо-профиль.';

  @override
  String get onbCancel => 'Отменить и оставить текущий профиль';

  @override
  String get onbAboutYou => 'О вас';

  @override
  String onbItemsHint(int pageNum, int pagesNum) {
    return 'Описывайте себя таким, какой вы обычно сейчас, а не каким хотели бы быть. Страница $pageNum из $pagesNum.';
  }

  @override
  String get onbLocusTitle => 'Когда дела идут хорошо или плохо';

  @override
  String get onbLocusSub =>
      'Что больше похоже на вас? От этого зависит подача советов.';

  @override
  String get onbLocusInternalTitle => 'В основном мои решения и усилия';

  @override
  String get onbLocusInternalText =>
      'То, что со мной происходит, в основном зависит от моих действий.';

  @override
  String get onbLocusMixedTitle => 'И то и другое';

  @override
  String get onbLocusMixedText =>
      'Мои усилия важны, как и обстоятельства, которые я не контролирую.';

  @override
  String get onbLocusExternalTitle => 'В основном обстоятельства и другие люди';

  @override
  String get onbLocusExternalText =>
      'Многое из происходящего мне неподвластно.';

  @override
  String get onbToneTitle => 'Как Psychonaut должен с вами говорить?';

  @override
  String get onbToneSub => 'Это можно изменить позже.';

  @override
  String get onbToneDirectEx =>
      '«Сон сократился на 0,8 ч. Сегодня попробуйте перезагрузку сна.»';

  @override
  String get onbToneGentleEx =>
      '«Сон немного сместился. Может помочь спокойный вечер.»';

  @override
  String get onbActionsTitle => 'Что помогает вам восстановиться?';

  @override
  String get onbActionsSub =>
      'Выберите действия, которые вам нравятся. Они будут предлагаться в том порядке, в котором вы их выберете.';

  @override
  String get onbYourProfile => 'Ваш профиль';

  @override
  String get onbTraits => 'Черты личности';

  @override
  String get onbTraitsNote =>
      'По короткой версии из 20 утверждений. Черты влияют только на то, как быстро отмечается изменение. Они никогда не навешивают на вас ярлыков.';

  @override
  String get onbPrefs => 'Ваши предпочтения';

  @override
  String get onbActionsLabel => 'Действия';

  @override
  String get roleDefault => 'Член экипажа';

  @override
  String get importPickerTitle => 'Выберите JSON-файл профиля';

  @override
  String get reactionIntro =>
      'Этот трёхминутный тест проверяет, насколько вы бдительны. Когда на экране появится «Нажмите», нажимайте как можно быстрее. Не нажимайте раньше.';

  @override
  String get reactionKeyboardHint => 'На клавиатуре нажимайте пробел.';

  @override
  String get reactionWait => 'Ждите…';

  @override
  String get reactionTapNow => 'Нажмите';

  @override
  String get reactionTooSoon => 'Слишком рано. Дождитесь сигнала.';

  @override
  String reactionTimeLeft(String time) {
    return 'Осталось $time';
  }

  @override
  String get reactionDiscardHint =>
      'Если сейчас вернуться назад, тест будет отменён.';

  @override
  String get reactionDoneTitle => 'Тест завершён';

  @override
  String get reactionMean => 'Среднее время реакции';

  @override
  String get reactionResponses => 'Ответов';

  @override
  String get reactionLapses => 'Пропуски (медленнее 500 мс)';

  @override
  String get reactionFalseStarts => 'Фальстарты';

  @override
  String get reactionSaved =>
      'Сохранено. Результат виден в разделе «Динамика».';

  @override
  String get reactionNoResponses =>
      'Ответы не записаны, поэтому ничего не сохранено.';

  @override
  String get reactionDone => 'Готово';
}
