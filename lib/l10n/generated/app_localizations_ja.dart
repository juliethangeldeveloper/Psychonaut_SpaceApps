// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get navHome => 'ホーム';

  @override
  String get navCheckIn => '記録';

  @override
  String get navTrends => '推移';

  @override
  String get navCrew => 'クルー';

  @override
  String get profileAndSettings => 'プロフィールと設定';

  @override
  String get back => '戻る';

  @override
  String get sampleData => 'サンプルデータ';

  @override
  String get disclaimer => 'Psychonautは診断を行わず、医療従事者の代わりにはなりません。';

  @override
  String get statusOnCourse => '順調';

  @override
  String get statusDrifting => 'ずれ始め';

  @override
  String get statusOffCourse => '軌道を外れている';

  @override
  String get statusAlert => '警告';

  @override
  String traitSemantics(String label, int valueNum) {
    return '$label $valueNum/100';
  }

  @override
  String get indicatorMood => '気分';

  @override
  String get indicatorStress => 'ストレス';

  @override
  String get indicatorSleep => '睡眠';

  @override
  String get indicatorFocus => '集中力';

  @override
  String get indicatorMotivation => 'モチベーション';

  @override
  String get indicatorConnection => 'つながり';

  @override
  String get indicatorWorkload => '作業負荷';

  @override
  String get indicatorReaction => '反応時間';

  @override
  String get trendImproving => '改善中';

  @override
  String get trendSteady => '安定';

  @override
  String get trendSlipping => '悪化中';

  @override
  String get homeTitle => 'あなたの針路';

  @override
  String missionLine(int dayNum, String phase) {
    return 'ミッション$dayNum日目 · $phase';
  }

  @override
  String headingSemantics(int degreesNum, String status) {
    return '軌道から$degreesNum度ずれています。全体：$status。';
  }

  @override
  String get headingOffCourse => '軌道からのずれ';

  @override
  String get headingMeasured => 'あなた自身の基準値との比較です。';

  @override
  String get mismatchTitle => '自己申告と身体データに差があります';

  @override
  String mismatchBody(String mood, String details) {
    return '気分は$moodと、基準値と同じかそれ以上でしたが、$details。どちらも本当かもしれません。よく確認してみましょう。';
  }

  @override
  String mismatchDetailSleep(int daysNum) {
    return '睡眠が$daysNum日間、基準値を下回っています';
  }

  @override
  String mismatchDetailReaction(int daysNum) {
    return '反応時間が$daysNum日間、基準値より遅くなっています';
  }

  @override
  String mismatchJoin(String first, String second) {
    return '$first、また$second';
  }

  @override
  String get lifeEventTitle => '家で何かがありました';

  @override
  String get lifeEventCardBody =>
      'そんなに遠くで受け止めるのはつらいことです。一人で抱え込まなくて大丈夫です。今後14日間は気分をより注意深く見守り、「家族にメッセージ」を最初にご提案します。';

  @override
  String get reactionPromptTitle => '反応テストの時間です';

  @override
  String get reactionPromptText => '3分間。疲れを自覚する前に、その兆候がわかります。';

  @override
  String get reactionPromptButton => 'テストを開始';

  @override
  String get logOpenTitle => '船長日誌が開いています';

  @override
  String get logOpenText => '今日はまだ記録していません。';

  @override
  String get logEntry => '記録する';

  @override
  String get readingPreparing => '今日の読み取りを準備中';

  @override
  String get readingUnavailable => '現在、読み取りを表示できません。';

  @override
  String get readingTitle => '今日の読み取り';

  @override
  String get readingFixedAlertNote => '固定の安全メッセージです。AIによる生成ではありません。';

  @override
  String get aiGenerated => 'AI生成';

  @override
  String get suggestedAction => 'おすすめの行動';

  @override
  String readingSource(String source) {
    return '提供元：$source';
  }

  @override
  String get sourceRuleBased => 'ルールベース・この端末内';

  @override
  String get sourceOnBoard => 'オンボードモデル';

  @override
  String get sourceCloud => 'クラウドモデル';

  @override
  String loadError(String error) {
    return 'データを読み込めませんでした。\n$error';
  }

  @override
  String get indicatorsTitle => '指標';

  @override
  String get panelMindMap => 'マインドマップ';

  @override
  String get panelSelected => '選択した指標';

  @override
  String chartLast14(String indicator) {
    return '$indicator、過去14日間';
  }

  @override
  String get chartSleep14 => '睡眠、14夜';

  @override
  String tileSemantics(String indicator, String status, String trend) {
    return '$indicator、$status、$trend';
  }

  @override
  String get trendNoData => 'データはまだありません';

  @override
  String get trendAtBaseline => '基準値どおり';

  @override
  String trendAbove(String amount) {
    return '基準値より$amount高い';
  }

  @override
  String trendBelow(String amount) {
    return '基準値より$amount低い';
  }

  @override
  String trendJoin(String where, String trend) {
    return '$where、$trend';
  }

  @override
  String detailNow(String now, String baseline, String trend) {
    return '現在 $now · 基準値 $baseline · $trend';
  }

  @override
  String get flaggedSooner => 'プロフィールに基づき、あなたの場合は1日早く注意して見守ります。';

  @override
  String get detailHowMeasured => '測定方法';

  @override
  String get detailWhy => 'なぜ重要か';

  @override
  String get detailWhatToDo => '今できること';

  @override
  String whatToDoOptions(String text, String options) {
    return '$text 選択肢：$options。';
  }

  @override
  String whatToDoRecommended(String text, String action) {
    return '$text おすすめ：$action。';
  }

  @override
  String whatToDoOneStep(String action, String description) {
    return '次の一歩：$action。$description';
  }

  @override
  String get nasaRiskLabel => 'NASAのリスク';

  @override
  String get nasaHazardLabel => 'ハザード';

  @override
  String labelValue(String label, String value) {
    return '$label：$value';
  }

  @override
  String unitHours(String value) {
    return '$value時間';
  }

  @override
  String unitMs(String value) {
    return '$valueミリ秒';
  }

  @override
  String get refMeasuredMood => '船長日誌での1〜10の自己評価を、あなた自身の基準値と比較します。';

  @override
  String get refWhyMood =>
      '気分の小さな落ち込みが続く場合は、早めに対処するほうが簡単です。1日だけを見るより、基準値と比べて見守るほうが役に立ちます。';

  @override
  String get refTodoMood =>
      '正直に記録し、小さな行動を一つ選びましょう。気分の低い日が続くときは、クルーの仲間に伝えてください。';

  @override
  String get refMeasuredStress => '1〜10のストレス評価を、あなた自身の基準値と比較します。高いほど好ましくありません。';

  @override
  String get refWhyStress =>
      '長期の閉鎖環境ではストレスが高まりがちです。ストレスが上がると、睡眠や集中力にも影響しやすくなります。';

  @override
  String get refTodoStress => '2分間ゆっくり呼吸する、体を動かす、今日の作業を一つ誰かに任せる、のいずれかを試しましょう。';

  @override
  String get refMeasuredSleep =>
      '睡眠トラッカーまたはサンプルデータによる毎晩の睡眠時間です。7〜8時間が健康的な範囲で、6時間以下は短い睡眠です。';

  @override
  String get refWhySleep => '睡眠不足や不規則な生活は反応を鈍らせ、気分を下げ、小さな問題を大きく感じさせます。';

  @override
  String get refTodoSleep => '消灯時刻を固定し、1時間前から画面を暗くし、船室を涼しくして睡眠をリセットしましょう。';

  @override
  String get refMeasuredFocus => '1〜10の集中力の評価と、反応テストでの反応の遅れ（ラプス）の回数を合わせて見ます。';

  @override
  String get refWhyFocus => '睡眠や作業負荷が崩れると、最初に低下するのは注意力です。飛行中はミスの代償が最も大きくなります。';

  @override
  String get refTodoFocus =>
      '画面から離れてしっかり休憩し、一度に一つの作業だけに取り組みましょう。まず睡眠を確認してください。';

  @override
  String get refMeasuredMotivation => '1〜10の意欲・没頭度の評価を、あなた自身の基準値と比較します。';

  @override
  String get refWhyMotivation =>
      '長く単調なミッションは退屈を招きます。意欲の低下は、気分の落ち込みより先に現れることがあります。';

  @override
  String get refTodoMotivation => '小さな新しいプロジェクトを始めるか、一日の順番を変えて変化をつけましょう。';

  @override
  String get refMeasuredConnection => 'クルーとのつながりの評価（1〜10）を、あなた自身の基準値と比較します。';

  @override
  String get refWhyConnection =>
      '良いチームワークは、つながりを感じられるかどうかに左右されます。また、地球からの距離のせいで、家族との連絡は遅く、少なくなります。';

  @override
  String get refTodoConnection =>
      'クルーと食事を共にするか、家族にメッセージを送りましょう。ささやかな交流にも意味があります。';

  @override
  String get refMeasuredWorkload =>
      '1〜10の作業負荷の評価を、あなた自身の基準値と比較します。高いほど好ましくありません。';

  @override
  String get refWhyWorkload =>
      '仕事が多すぎると睡眠が削られます。地球との通信に遅れがあるため、クルーは自分たちでペースを管理する必要があります。';

  @override
  String get refTodoWorkload => '作業を一つ明日に回すか、クルーに分担を頼みましょう。睡眠時間は守ってください。';

  @override
  String get refMeasuredReaction =>
      '3分間の反応テストです。刺激が出たらできるだけ早くタップします。平均反応時間、ラプス（500ミリ秒より遅い反応）、フライングを記録します。';

  @override
  String get refWhyReaction =>
      '反応が遅い、またはラプスが出ることは、疲労や注意力の低下の最も早いサインの一つで、自覚する前に現れることもよくあります。';

  @override
  String get refTodoReaction => '数日おきに同じ時間帯にテストを繰り返し、あなた自身の基準値と比べましょう。';

  @override
  String get actionExerciseTitle => '運動';

  @override
  String get actionExerciseDesc => 'トレッドミルかバイクでの短い運動。';

  @override
  String get actionJournalTitle => '日記';

  @override
  String get actionJournalDesc => '一日について10分間、自分だけの文章を書く。';

  @override
  String get actionFamilyCallTitle => '家族にメッセージ';

  @override
  String get actionFamilyCallDesc => '地球にいる誰かにメッセージを送るか、通話を予約する。';

  @override
  String get actionGardenTitle => '窓と菜園の時間';

  @override
  String get actionGardenDesc => '窓辺や植物のそばで過ごす。';

  @override
  String get actionWindowTimeTitle => '窓の時間';

  @override
  String get actionWindowTimeDesc => '窓辺で10分間、地球や星を眺める。';

  @override
  String get actionNewProjectTitle => '小さなプロジェクトを始める';

  @override
  String get actionNewProjectDesc => 'ルーティンを破るために、短い新しい作業を選ぶ。';

  @override
  String get actionSleepResetTitle => '睡眠のリセット';

  @override
  String get actionSleepResetDesc => '一晩だけ、消灯時刻を固定し、画面を暗くし、船室を涼しくする。';

  @override
  String get aiRuleBasedLabel => 'ルールベース';

  @override
  String get aiRuleBasedDesc => 'この端末内のテンプレート。通信不要。デフォルト。';

  @override
  String get aiOnBoardLabel => 'オンボードモデル';

  @override
  String get aiOnBoardDesc =>
      'このコンピューターまたは船内ネットワークで動くモデル。データは船の外に出ません。動いていない場合はルールベースに切り替わります。';

  @override
  String get aiCloudLabel => 'クラウドモデル';

  @override
  String get aiCloudDesc =>
      'インターネット経由の大規模言語モデル。地球上でのみ使用します。点数と性格プロフィールを送信しますが、名前やメモは送信しません。';

  @override
  String get phaseAdjustment => '適応期';

  @override
  String get phaseAdjustmentNote => '慣れてきた段階です。ルーティンはまだ形成中です。';

  @override
  String get phaseMid => 'ミッション中盤';

  @override
  String get phaseMidNote => '安定期です。ゆるやかなずれに注意しましょう。';

  @override
  String get phaseLate => 'ミッション後半';

  @override
  String get phaseLateNote =>
      '150日目を過ぎると、見守りがより厳しくなります。模擬環境の研究では、5〜6か月後に行動面の症状が増えるとされています。';

  @override
  String get riskBehavioral => '行動面の状態';

  @override
  String get riskTeamwork => 'チームワークの不足';

  @override
  String get riskSleep => '睡眠不足と不規則なスケジュール';

  @override
  String get hazardIsolation => '孤立と閉鎖環境';

  @override
  String get hazardDistance => '地球からの距離';

  @override
  String get toneDirect => '率直';

  @override
  String get toneGentle => 'やさしい';

  @override
  String get framingInternal => '内的：データと選択肢';

  @override
  String get framingMixed => '混合：データと一つの提案';

  @override
  String get framingExternal => '外的：はっきりした一歩';

  @override
  String get copingProblem => '問題焦点型';

  @override
  String get copingEmotion => '情動焦点型';

  @override
  String get copingAvoidant => '回避型';

  @override
  String get sourceMiniIpip => 'Mini-IPIP質問紙';

  @override
  String get sourceIpipNeo120 => 'IPIP-NEO-120質問紙';

  @override
  String get sourceImported => 'インポートしたファイル';

  @override
  String get alertMessage => 'クルーの医療担当者に伝え、地球向けの要約を準備してください';

  @override
  String sourceUnavailableNote(String source) {
    return '$sourceは利用できないため、この読み取りはルールベースで作成されました。';
  }

  @override
  String insOnCourseDirect(int degreesNum) {
    return '針路は順調で、ずれは$degreesNum°。すべての値が基準値に近い状態です。';
  }

  @override
  String insOnCourseGentle(int degreesNum) {
    return '順調です。ずれはわずか$degreesNum°で、数値もあなたの普段に近い状態です。';
  }

  @override
  String insWorstGentle(
    String indicator,
    String current,
    String baseline,
    String trend,
  ) {
    return '$indicatorが少し動きました。普段の$baselineに対して今は$currentで、$trendです。';
  }

  @override
  String insWorstDirect(
    String indicator,
    String status,
    String current,
    String baseline,
    String trend,
  ) {
    return '$indicatorは$statusで、基準値$baselineに対して$current、$trendです。';
  }

  @override
  String insMismatchGentle(int daysNum) {
    return '「大丈夫」という言葉も大切ですが、身体データは$daysNum日間、基準値から外れています。';
  }

  @override
  String insMismatchDirect(int daysNum) {
    return '気分は基準値以上と答えましたが、身体データは$daysNum日間、基準値から外れています。';
  }

  @override
  String get insLifeGentle => '家のことを記録されたので、しばらくは気分を少し注意深く見守ります。';

  @override
  String get insLifeDirect => '家のことを記録したため、14日間は気分をより注意深く見守ります。';

  @override
  String insActionGentle(String action) {
    return '今日は小さな一歩が助けになるかもしれません：$action。';
  }

  @override
  String insActionDirect(String action) {
    return '今日の小さな行動：$action。';
  }

  @override
  String get insEvidenceAllOk => 'すべての値が、あなた自身の基準値から標準偏差1つ分以内に収まっています。';

  @override
  String insEvidence(String indicator, String current, String baseline) {
    return '$indicator：基準値$baselineに対して$current。';
  }

  @override
  String insEvidenceBeyond(
    String indicator,
    String current,
    String baseline,
    String sd,
    int count,
  ) {
    return '$indicator：基準値$baselineに対して$current。標準偏差$sdを超える状態が$count日続いています。';
  }

  @override
  String insNights(int count) {
    return '直近で6時間以下の睡眠が$count晩ありました。';
  }

  @override
  String get insLapses => '反応テストでのラプスが普段より多くなっています。';

  @override
  String insOptions(String options) {
    return '選択肢：$options';
  }

  @override
  String insRecommended(String action, String description) {
    return 'おすすめ：$action。$description';
  }

  @override
  String insRecommendedStep(String action, String description) {
    return 'おすすめの一歩：$action。$description 今日はこの一歩だけで十分です。';
  }

  @override
  String get insLatePhase => 'ミッション150日目を過ぎると見守りが厳しくなり、より小さな変化も指摘されます。';

  @override
  String get insLifeSupport => '家からの知らせは重く感じることがあります。信頼できる人に話してみると楽になるかもしれません。';

  @override
  String get trendsTitle => '針路のずれ';

  @override
  String get trendsSubtitle => 'あなた自身の基準値からどれだけずれているか';

  @override
  String get trendsSleepTitle => '睡眠、過去14夜';

  @override
  String get trendsNoTests => 'テストはまだありません';

  @override
  String trendsLatestReaction(String ms, int count) {
    return '最新 $ms · ラプス$count回';
  }

  @override
  String trendsNasaLine(String risk, String hazards) {
    return 'NASAのリスク：$risk。ハザード：$hazards。';
  }

  @override
  String get correctionsTitle => '針路の修正';

  @override
  String get correctionsHint => '小さな行動を一つ選びましょう。お好みのものが先に表示されます。';

  @override
  String correctionsPlan(String title, String description) {
    return 'あなたのプラン：$title。$description';
  }

  @override
  String get correctionsSuggested => 'おすすめ';

  @override
  String actionSemantics(String title, String description) {
    return '$title。$description';
  }

  @override
  String actionSemanticsSuggested(String title, String description) {
    return '$title。$description 今日のおすすめです。';
  }

  @override
  String get chartNoSleep => '睡眠データはまだありません。';

  @override
  String chartBaselineValue(String value) {
    return '基準値 $value';
  }

  @override
  String get chartBaseline => '基準値';

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
    return '過去$count夜の睡眠。基準値$baseline。直近の夜は$latest、$status。';
  }

  @override
  String get chartToday => '今日';

  @override
  String get chartNeedTests => '反応テストを何度か受けると、推移が見られます。';

  @override
  String chartReactionSemantics(int count, String baseline, String latest) {
    return '直近$count回の反応時間。基準値$baseline。最新は$latest。';
  }

  @override
  String get chartNotEnough => 'データがまだ足りません。';

  @override
  String chartDaysAgo(int daysNum) {
    return '-$daysNum日';
  }

  @override
  String get checkinTitle => '船長日誌';

  @override
  String get checkinSubtitle => '今日の調子はどうですか？正直に答えてください。間違った答えはありません。';

  @override
  String get qEngagement => '意欲';

  @override
  String get qConnection => 'クルーとのつながり';

  @override
  String get scaleLow => '低い';

  @override
  String get scaleHigh => '高い';

  @override
  String get scaleCalm => '穏やか';

  @override
  String get scaleVeryStressed => 'とてもストレスが強い';

  @override
  String get scaleLight => '軽い';

  @override
  String get scaleOverloaded => '過重';

  @override
  String get scaleBored => '退屈';

  @override
  String get scaleAbsorbed => '没頭';

  @override
  String get scaleScattered => '散漫';

  @override
  String get scaleSharp => '冴えている';

  @override
  String get scaleDistant => '離れている';

  @override
  String get scaleClose => '親密';

  @override
  String checkinStreak(int count) {
    return '$count日連続';
  }

  @override
  String checkinStreakSemantics(int count) {
    return '記録の連続日数：$count日';
  }

  @override
  String get checkinStreakNote => '記録した日数だけを数え、点数の良し悪しは見ません。';

  @override
  String get checkinOptional => '任意です。';

  @override
  String get checkinNoteLabel => '非公開のメモ';

  @override
  String get checkinNoteHelper => 'この端末にのみ保存され、どこにも送信されません。';

  @override
  String get checkinUpdate => '今日の記録を更新';

  @override
  String get checkinLogged => '記録しました。ありがとうございます。';

  @override
  String sliderSemantics(String label, int valueNum) {
    return '$label $valueNum/10';
  }

  @override
  String get crewTitle => '船内の士気';

  @override
  String get crewSubtitle => 'クルーの様子を、匿名の一つの数字で';

  @override
  String get moraleHigh => '高い';

  @override
  String get moraleSteady => '安定';

  @override
  String get moraleStrained => '緊張気味';

  @override
  String get moraleLow => '低い';

  @override
  String get crewOutOf100 => '/ 100';

  @override
  String crewMeterSemantics(
    String level,
    int scoreNum,
    int contributedNum,
    int crewNum,
  ) {
    return 'クルーの士気は$level、100点中$scoreNum。今日は$crewNum人中$contributedNum人が記録しました。';
  }

  @override
  String crewCheckedIn(int contributedNum, int crewNum) {
    return '今日は$crewNum人中$contributedNum人が記録しました。名前は表示されません。';
  }

  @override
  String get crewGoalLabel => 'みんなの週間目標';

  @override
  String get crewGoalTitle => '夕食を一緒にとる';

  @override
  String get crewGoalDesc => '今週は6日の夜、クルーと夕食をとりましょう。短く、ゆったりで大丈夫です。';

  @override
  String crewGoalProgress(int doneNum, int segmentsNum, int peopleNum) {
    return '$segmentsNum日中$doneNum日達成 · $peopleNum人が参加';
  }

  @override
  String crewGoalSemantics(int doneNum, int segmentsNum) {
    return '$segmentsNum日中$doneNum日達成';
  }

  @override
  String get crewJoin => 'この目標に参加';

  @override
  String get crewLeave => '参加中です。タップして退出';

  @override
  String get crewPrivacyTitle => 'プライバシー';

  @override
  String get crewPrivacyBody =>
      '表示されるのはグループの平均だけです。あなたの点数、メモ、プロフィールはこの端末から出ません。名前も順位も、人どうしの比較もありません。';

  @override
  String get profileTitle => 'プロフィール';

  @override
  String get profileSubtitle => 'クラウドモデルを選ばない限り、すべてこの端末内にのみ保存されます。';

  @override
  String get profileRetake => '質問紙をやり直す';

  @override
  String get profileSamples => 'サンプルプロフィール';

  @override
  String get profileSamplesHint => '付属のサンプルに切り替えて、アプリが別の人にどう合わせるか確認できます。';

  @override
  String get scienceTitle => '科学的背景について';

  @override
  String profileLoaded(String name) {
    return '$nameを読み込みました。';
  }

  @override
  String get profileCurrent => '現在';

  @override
  String profileCurrentSemantics(String label) {
    return '$label、現在選択中';
  }

  @override
  String get traitOpenness => '開放性';

  @override
  String get traitConscientiousness => '誠実性';

  @override
  String get traitExtraversion => '外向性';

  @override
  String get traitAgreeableness => '協調性';

  @override
  String get traitEmotionalStability => '情緒安定性';

  @override
  String get traitBoredom => '退屈しやすさ';

  @override
  String get facetsTitle => '下位特性';

  @override
  String get facetExcitement => '刺激希求';

  @override
  String get facetGregariousness => '群居性';

  @override
  String get facetVulnerability => '傷つきやすさ';

  @override
  String get facetSelfDiscipline => '自己鍛錬';

  @override
  String get profileAdviceFraming => '助言の伝え方';

  @override
  String get profileCoping => '対処スタイル';

  @override
  String get profileTone => '口調';

  @override
  String get profilePreferred => '好みの行動';

  @override
  String get profileBaseline => '基準値';

  @override
  String dotJoin2(String a, String b) {
    return '$a · $b';
  }

  @override
  String dotJoin3(String a, String b, String c) {
    return '$a · $b · $c';
  }

  @override
  String get restingHeartRate => '安静時心拍数';

  @override
  String get hrvLabel => '心拍変動';

  @override
  String unitBpm(String value) {
    return '$value bpm';
  }

  @override
  String get settingsMissionDay => 'ミッション日数';

  @override
  String get settingsPrevDay => '前の日';

  @override
  String get settingsNextDay => '次の日';

  @override
  String settingsDay(int dayNum) {
    return '$dayNum日目';
  }

  @override
  String settingsMissionDaySemantics(int dayNum, String phase) {
    return 'ミッション$dayNum日目、$phase';
  }

  @override
  String get settingsAiSource => 'AIの提供元';

  @override
  String get settingsAiHint => 'ホームの文章の読み取りの提供元です。警告レベルでは、メッセージは常に固定です。';

  @override
  String get settingsLanguage => '言語';

  @override
  String get settingsLanguageHint => 'アプリの言語を選びます。文章の読み取りも同じ言語になります。';

  @override
  String get languageDevice => '端末の言語';

  @override
  String get importTitle => 'プロフィールをインポート';

  @override
  String get importHint =>
      '付属のサンプルと同じ項目を持つJSONファイルから、別の人を読み込みます。何もアップロードされません。';

  @override
  String get importButton => 'プロフィールJSONをインポート';

  @override
  String importFailed(String error) {
    return 'このファイルをインポートできませんでした。$error';
  }

  @override
  String get importNotJson => 'このファイルは有効なJSONではありません。';

  @override
  String get importUnreadable => 'このファイルを読み取れませんでした。';

  @override
  String importDone(String name) {
    return '$nameをインポートしました。';
  }

  @override
  String get scienceSubtitle => 'Psychonautの考え方の出どころです。';

  @override
  String get scienceAssumptionsTitle => '設計上の前提';

  @override
  String get sciHrpTitle => 'NASA人間研究プログラム：ハザードとリスク';

  @override
  String get sciHrpBody => '孤立と閉鎖環境、地球からの距離を含む宇宙飛行のハザードと、それに関連する人の健康リスクの一覧です。';

  @override
  String get sciBhrTitle => 'NASA行動衛生リスク記録';

  @override
  String get sciBhrBody => '長期ミッションにおける行動面の健康とパフォーマンスのリスク：行動面の状態、チームワーク、睡眠。';

  @override
  String get sciReactionTitle => '反応セルフテストの研究';

  @override
  String get sciReactionBody =>
      'Basner、Mollicone、Dinges（2011）の簡易精神運動覚醒テスト（PVT-B）と、宇宙飛行士が疲労を把握するために使うNASAの反応セルフテストです。';

  @override
  String get sciIpipTitle => '国際パーソナリティ項目プール（IPIP）';

  @override
  String get sciIpipBody =>
      'ipip.ori.orgのパブリックドメインの項目です。20項目のMini-IPIPはDonnellan、Oswald、Baird、Lucas（2006）によるものです。完成版では120項目のIPIP-NEO-120を使い、30の下位特性を測ります。';

  @override
  String get sciAssume1 => '標準偏差による閾値と、変化を指摘するまでの日数は、プロトタイプとしての設計上の選択です。';

  @override
  String get sciAssume2 =>
      '150日目以降に基準を厳しくするのは、5〜6か月後に行動面の症状が増えると報告する模擬環境の研究に基づきます。';

  @override
  String get sciAssume3 => '性格特性が変えるのは、変化を指摘するタイミングだけです。人にレッテルを貼ることはありません。';

  @override
  String get reactionTitle => '反応テスト';

  @override
  String get ipipItem1 => '私はパーティーの人気者だ';

  @override
  String get ipipItem2 => '私は他の人の気持ちに共感する';

  @override
  String get ipipItem3 => '私は雑用をすぐに片付ける';

  @override
  String get ipipItem4 => '私は気分の浮き沈みが多い';

  @override
  String get ipipItem5 => '私は想像力が豊かだ';

  @override
  String get ipipItem6 => '私は口数が少ない';

  @override
  String get ipipItem7 => '私は他の人の悩みに関心がない';

  @override
  String get ipipItem8 => '私は物を元の場所に戻し忘れることがよくある';

  @override
  String get ipipItem9 => '私はたいていリラックスしている';

  @override
  String get ipipItem10 => '私は抽象的な考えに興味がない';

  @override
  String get ipipItem11 => '私はパーティーでいろいろな人と話す';

  @override
  String get ipipItem12 => '私は他の人の感情を感じ取る';

  @override
  String get ipipItem13 => '私は整理整頓が好きだ';

  @override
  String get ipipItem14 => '私はすぐに動揺する';

  @override
  String get ipipItem15 => '私は抽象的な考えを理解するのが難しい';

  @override
  String get ipipItem16 => '私は目立たないようにしている';

  @override
  String get ipipItem17 => '私は他人にあまり関心がない';

  @override
  String get ipipItem18 => '私は物事を散らかしてしまう';

  @override
  String get ipipItem19 => '私はめったに気分が沈まない';

  @override
  String get ipipItem20 => '私は想像力が乏しい';

  @override
  String get ipipAnswer1 => 'まったく当てはまらない';

  @override
  String get ipipAnswer2 => 'あまり当てはまらない';

  @override
  String get ipipAnswer3 => 'どちらともいえない';

  @override
  String get ipipAnswer4 => 'まあ当てはまる';

  @override
  String get ipipAnswer5 => 'とても当てはまる';

  @override
  String ipipAnswerSemantics(String n, String label) {
    return '$n、$label';
  }

  @override
  String onbStep(int stepNum, int totalNum) {
    return 'ステップ$stepNum/$totalNum';
  }

  @override
  String get onbNext => '次へ';

  @override
  String get onbCreate => 'プロフィールを作成';

  @override
  String get onbWelcome => 'ようこそ';

  @override
  String get onbWelcomeSub => 'Psychonaut、毎日のパートナー';

  @override
  String get onbIntro =>
      'Psychonautは、あなた自身の基準値と比べて、毎日小さな行動を一つ提案します。20の文からなる短い質問紙で、変化を指摘するタイミングや話し方を調整します。回答はこの端末にのみ保存されます。';

  @override
  String get onbName => 'お名前';

  @override
  String get onbRole => '役割（例：船長）';

  @override
  String get onbExploring => 'ちょっと試してみたいだけですか？';

  @override
  String get onbSampleHint => '代わりにサンプルプロフィールを読み込みます。';

  @override
  String get onbCancel => 'キャンセルして現在のプロフィールを維持';

  @override
  String get onbAboutYou => 'あなたについて';

  @override
  String onbItemsHint(int pageNum, int pagesNum) {
    return 'なりたい自分ではなく、今の一般的な自分について答えてください。$pageNum/$pagesNumページ。';
  }

  @override
  String get onbLocusTitle => '物事がうまくいくとき、いかないとき';

  @override
  String get onbLocusSub => 'どれが最もあなたに近いですか？助言の伝え方が変わります。';

  @override
  String get onbLocusInternalTitle => '主に自分の選択と努力';

  @override
  String get onbLocusInternalText => '自分に起こることは、たいてい自分の行動次第です。';

  @override
  String get onbLocusMixedTitle => '両方の組み合わせ';

  @override
  String get onbLocusMixedText => '自分の努力も大切ですが、自分では動かせない状況も影響します。';

  @override
  String get onbLocusExternalTitle => '主に状況や他の人';

  @override
  String get onbLocusExternalText => '起こることの多くは、自分の力の及ばないところにあります。';

  @override
  String get onbToneTitle => 'Psychonautにどう話しかけてほしいですか？';

  @override
  String get onbToneSub => 'あとから変更できます。';

  @override
  String get onbToneDirectEx => '「睡眠が0.8時間減っています。今夜は睡眠のリセットを試しましょう。」';

  @override
  String get onbToneGentleEx => '「睡眠が少し動きました。穏やかな夜が助けになるかもしれません。」';

  @override
  String get onbActionsTitle => '何があなたの助けになりますか？';

  @override
  String get onbActionsSub => '好きな行動を選んでください。選んだ順に提案されます。';

  @override
  String get onbYourProfile => 'あなたのプロフィール';

  @override
  String get onbTraits => '性格特性';

  @override
  String get onbTraitsNote =>
      '20項目の短縮版によるものです。特性が変えるのは、変化を指摘するタイミングだけで、あなたにレッテルを貼ることはありません。';

  @override
  String get onbPrefs => 'あなたの設定';

  @override
  String get onbActionsLabel => '行動';

  @override
  String get roleDefault => 'クルー';

  @override
  String get importPickerTitle => 'プロフィールのJSONファイルを選択';

  @override
  String get reactionIntro =>
      'この3分間のテストは、どれだけ注意が保てているかを調べます。画面に「今タップ」と出たら、できるだけ早くタップしてください。表示される前にはタップしないでください。';

  @override
  String get reactionKeyboardHint => 'キーボードの場合はスペースキーを押します。';

  @override
  String get reactionWait => '待って…';

  @override
  String get reactionTapNow => '今タップ';

  @override
  String get reactionTooSoon => '早すぎます。合図を待ってください。';

  @override
  String reactionTimeLeft(String time) {
    return '残り $time';
  }

  @override
  String get reactionDiscardHint => '今戻ると、このテストは破棄されます。';

  @override
  String get reactionDoneTitle => 'テスト完了';

  @override
  String get reactionMean => '平均反応時間';

  @override
  String get reactionResponses => '反応回数';

  @override
  String get reactionLapses => 'ラプス（500ミリ秒より遅い）';

  @override
  String get reactionFalseStarts => 'フライング';

  @override
  String get reactionSaved => '保存しました。「推移」で確認できます。';

  @override
  String get reactionNoResponses => '反応が記録されなかったため、何も保存されませんでした。';

  @override
  String get reactionDone => '完了';
}
