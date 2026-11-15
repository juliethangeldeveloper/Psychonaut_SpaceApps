// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get navHome => 'Inicio';

  @override
  String get navCheckIn => 'Registro';

  @override
  String get navTrends => 'Tendencias';

  @override
  String get navCrew => 'Tripulación';

  @override
  String get profileAndSettings => 'Perfil y ajustes';

  @override
  String get back => 'Atrás';

  @override
  String get sampleData => 'Datos de ejemplo';

  @override
  String get disclaimer =>
      'Psychonaut no diagnostica ni sustituye a un profesional clínico.';

  @override
  String get statusOnCourse => 'En rumbo';

  @override
  String get statusDrifting => 'A la deriva';

  @override
  String get statusOffCourse => 'Fuera de rumbo';

  @override
  String get statusAlert => 'Alerta';

  @override
  String traitSemantics(String label, int valueNum) {
    return '$label $valueNum de 100';
  }

  @override
  String get indicatorMood => 'Ánimo';

  @override
  String get indicatorStress => 'Estrés';

  @override
  String get indicatorSleep => 'Sueño';

  @override
  String get indicatorFocus => 'Concentración';

  @override
  String get indicatorMotivation => 'Motivación';

  @override
  String get indicatorConnection => 'Conexión';

  @override
  String get indicatorWorkload => 'Carga de trabajo';

  @override
  String get indicatorReaction => 'Tiempo de reacción';

  @override
  String get trendImproving => 'mejorando';

  @override
  String get trendSteady => 'estable';

  @override
  String get trendSlipping => 'empeorando';

  @override
  String get homeTitle => 'Tu rumbo';

  @override
  String missionLine(int dayNum, String phase) {
    return 'Día $dayNum de la misión · $phase';
  }

  @override
  String headingSemantics(int degreesNum, String status) {
    return '$degreesNum grados fuera de rumbo. En conjunto: $status.';
  }

  @override
  String get headingOffCourse => 'fuera de rumbo';

  @override
  String get headingMeasured => 'Medido frente a tu propia línea base.';

  @override
  String get mismatchTitle =>
      'Lo que dices y lo que muestra tu cuerpo no coinciden';

  @override
  String mismatchBody(String mood, String details) {
    return 'Valoraste tu ánimo en $mood, igual o por encima de tu línea base, pero $details. Ambas cosas pueden ser ciertas. Merece la pena revisarlo.';
  }

  @override
  String mismatchDetailSleep(int daysNum) {
    return 'tu sueño lleva $daysNum días por debajo de tu línea base';
  }

  @override
  String mismatchDetailReaction(int daysNum) {
    return 'tu tiempo de reacción lleva $daysNum días más lento que tu línea base';
  }

  @override
  String mismatchJoin(String first, String second) {
    return '$first y $second';
  }

  @override
  String get lifeEventTitle => 'Ha pasado algo en casa';

  @override
  String get lifeEventCardBody =>
      'Es difícil llevar eso desde tan lejos. No tienes que afrontarlo solo. Vigilaremos tu ánimo más de cerca durante los próximos 14 días y te ofreceremos primero «Escribir a casa».';

  @override
  String get reactionPromptTitle => 'Es hora de tu prueba de reacción';

  @override
  String get reactionPromptText =>
      'Tres minutos. Muestra la fatiga antes de que la notes.';

  @override
  String get reactionPromptButton => 'Empezar prueba';

  @override
  String get logOpenTitle => 'El diario del capitán está abierto';

  @override
  String get logOpenText => 'Hoy no has registrado nada.';

  @override
  String get logEntry => 'Registrar entrada';

  @override
  String get readingPreparing => 'Preparando tu lectura';

  @override
  String get readingUnavailable => 'Tu lectura no está disponible ahora.';

  @override
  String get readingTitle => 'Lectura de hoy';

  @override
  String get readingFixedAlertNote =>
      'Mensaje de seguridad fijo, no generado por IA.';

  @override
  String get aiGenerated => 'Generado por IA';

  @override
  String get suggestedAction => 'Acción sugerida';

  @override
  String readingSource(String source) {
    return 'Fuente: $source';
  }

  @override
  String get sourceRuleBased => 'Basado en reglas · en este dispositivo';

  @override
  String get sourceOnBoard => 'Modelo a bordo';

  @override
  String get sourceCloud => 'Modelo en la nube';

  @override
  String loadError(String error) {
    return 'No se pudieron cargar tus datos.\n$error';
  }

  @override
  String get indicatorsTitle => 'Indicadores';

  @override
  String get panelMindMap => 'Mapa mental';

  @override
  String get panelSelected => 'Indicador seleccionado';

  @override
  String chartLast14(String indicator) {
    return '$indicator, últimos 14 días';
  }

  @override
  String get chartSleep14 => 'Sueño, 14 noches';

  @override
  String tileSemantics(String indicator, String status, String trend) {
    return '$indicator, $status, $trend';
  }

  @override
  String get trendNoData => 'Aún no hay datos';

  @override
  String get trendAtBaseline => 'En tu línea base';

  @override
  String trendAbove(String amount) {
    return '$amount por encima de la línea base';
  }

  @override
  String trendBelow(String amount) {
    return '$amount por debajo de la línea base';
  }

  @override
  String trendJoin(String where, String trend) {
    return '$where, $trend';
  }

  @override
  String detailNow(String now, String baseline, String trend) {
    return 'Ahora $now · tu línea base $baseline · $trend';
  }

  @override
  String get flaggedSooner =>
      'Se vigila un día antes para ti, según tu perfil.';

  @override
  String get detailHowMeasured => 'Cómo se mide';

  @override
  String get detailWhy => 'Por qué importa';

  @override
  String get detailWhatToDo => 'Qué hacer ahora';

  @override
  String whatToDoOptions(String text, String options) {
    return '$text Opciones: $options.';
  }

  @override
  String whatToDoRecommended(String text, String action) {
    return '$text Recomendado: $action.';
  }

  @override
  String whatToDoOneStep(String action, String description) {
    return 'Un paso: $action. $description';
  }

  @override
  String get nasaRiskLabel => 'Riesgo NASA';

  @override
  String get nasaHazardLabel => 'Peligro';

  @override
  String labelValue(String label, String value) {
    return '$label: $value';
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
      'Tu autovaloración diaria de 1 a 10 en el diario del capitán, comparada con tu propia línea base.';

  @override
  String get refWhyMood =>
      'Las pequeñas bajadas constantes del ánimo son más fáciles de corregir pronto. Comparar el ánimo con tu línea base sirve más que un solo día.';

  @override
  String get refTodoMood =>
      'Registra con sinceridad y elige una acción pequeña. Díselo a un compañero si los días bajos se acumulan.';

  @override
  String get refMeasuredStress =>
      'Tu valoración diaria del estrés de 1 a 10, comparada con tu propia línea base. Más alto es menos favorable.';

  @override
  String get refWhyStress =>
      'El confinamiento prolongado mantiene el estrés elevado. Además, el estrés creciente suele restar sueño y concentración.';

  @override
  String get refTodoStress =>
      'Respira despacio durante dos minutos, mueve el cuerpo o delega una tarea por hoy.';

  @override
  String get refMeasuredSleep =>
      'Horas dormidas cada noche, del rastreador de sueño o de los datos de ejemplo. De 7 a 8 horas es lo saludable; 6 horas o menos es sueño corto.';

  @override
  String get refWhySleep =>
      'La falta de sueño y los horarios irregulares ralentizan los reflejos, bajan el ánimo y agrandan los problemas pequeños.';

  @override
  String get refTodoSleep =>
      'Mantén una hora fija de apagar las luces, baja el brillo de las pantallas una hora antes y refresca la cabina para reiniciar el sueño.';

  @override
  String get refMeasuredFocus =>
      'Tu valoración de concentración de 1 a 10, junto con el recuento de lapsos de la prueba de reacción.';

  @override
  String get refWhyFocus =>
      'La atención es lo primero que falla cuando el sueño o la carga de trabajo van mal, y en vuelo los errores salen más caros.';

  @override
  String get refTodoFocus =>
      'Haz una pausa real lejos de las pantallas y luego haz una tarea cada vez. Revisa primero tu sueño.';

  @override
  String get refMeasuredMotivation =>
      'Tu valoración de implicación de 1 a 10, comparada con tu propia línea base.';

  @override
  String get refWhyMotivation =>
      'Las misiones largas y repetitivas invitan al aburrimiento. La pérdida de implicación puede llegar antes que el ánimo bajo.';

  @override
  String get refTodoMotivation =>
      'Empieza un pequeño proyecto nuevo o cambia el orden de tu día para variar.';

  @override
  String get refMeasuredConnection =>
      'Tu valoración de conexión con la tripulación de 1 a 10, comparada con tu propia línea base.';

  @override
  String get refWhyConnection =>
      'El buen trabajo en equipo depende de sentirse conectado. Además, la distancia de la Tierra hace el contacto con la familia más lento y escaso.';

  @override
  String get refTodoConnection =>
      'Comparte una comida con la tripulación o escribe a casa. Un pequeño contacto cuenta.';

  @override
  String get refMeasuredWorkload =>
      'Tu valoración de carga de trabajo de 1 a 10, comparada con tu propia línea base. Más alto es menos favorable.';

  @override
  String get refWhyWorkload =>
      'El exceso de trabajo le quita horas al sueño. Con retrasos de comunicación con la Tierra, las tripulaciones deben gestionar su propio ritmo.';

  @override
  String get refTodoWorkload =>
      'Pasa una tarea a mañana o pide a la tripulación que la comparta. Protege tu horario de sueño.';

  @override
  String get refMeasuredReaction =>
      'Una prueba de reacción de 3 minutos. Pulsas lo más rápido posible cuando aparece un estímulo. Registramos tu tiempo medio de respuesta, los lapsos (más de 500 ms) y las salidas en falso.';

  @override
  String get refWhyReaction =>
      'Las respuestas lentas o con lapsos son de las primeras señales de fatiga y de atención que se dispersa, a menudo antes de que lo notes.';

  @override
  String get refTodoReaction =>
      'Repite la prueba cada pocos días a una hora parecida y compárala con tu propia línea base.';

  @override
  String get actionExerciseTitle => 'Ejercicio';

  @override
  String get actionExerciseDesc =>
      'Un entrenamiento corto en la cinta o la bicicleta.';

  @override
  String get actionJournalTitle => 'Diario';

  @override
  String get actionJournalDesc =>
      'Diez minutos de escritura privada sobre tu día.';

  @override
  String get actionFamilyCallTitle => 'Escribir a casa';

  @override
  String get actionFamilyCallDesc =>
      'Envía un mensaje o programa una llamada con alguien en la Tierra.';

  @override
  String get actionGardenTitle => 'Ventana y jardín';

  @override
  String get actionGardenDesc =>
      'Pasa un rato en la ventana o con las plantas.';

  @override
  String get actionWindowTimeTitle => 'Rato en la ventana';

  @override
  String get actionWindowTimeDesc =>
      'Pasa diez minutos en la ventana mirando la Tierra o las estrellas.';

  @override
  String get actionNewProjectTitle => 'Empezar un proyecto pequeño';

  @override
  String get actionNewProjectDesc =>
      'Elige una tarea nueva y corta para romper la rutina.';

  @override
  String get actionSleepResetTitle => 'Reinicio del sueño';

  @override
  String get actionSleepResetDesc =>
      'Hora fija de apagado, pantallas tenues y una cabina más fresca durante una noche.';

  @override
  String get aiRuleBasedLabel => 'Basado en reglas';

  @override
  String get aiRuleBasedDesc =>
      'Plantillas en este dispositivo. Sin red. Predeterminado.';

  @override
  String get aiOnBoardLabel => 'Modelo a bordo';

  @override
  String get aiOnBoardDesc =>
      'Un modelo que se ejecuta en este ordenador o en la red de la nave. Nada sale del vehículo. Si no está en marcha, se usa el basado en reglas.';

  @override
  String get aiCloudLabel => 'Modelo en la nube';

  @override
  String get aiCloudDesc =>
      'Un modelo de lenguaje grande por internet. Solo para usar en la Tierra. Envía tus puntuaciones y tu perfil de personalidad, nunca tu nombre ni tus notas.';

  @override
  String get phaseAdjustment => 'Adaptación';

  @override
  String get phaseAdjustmentNote =>
      'Acomodándote. Las rutinas aún se están formando.';

  @override
  String get phaseMid => 'Mitad de la misión';

  @override
  String get phaseMidNote => 'Régimen estable. Atento a la deriva lenta.';

  @override
  String get phaseLate => 'Final de la misión';

  @override
  String get phaseLateNote =>
      'Pasado el día 150 la vigilancia es más estricta. En estudios análogos, los síntomas de conducta aumentan tras 5 o 6 meses.';

  @override
  String get riskBehavioral => 'Condiciones del comportamiento';

  @override
  String get riskTeamwork => 'Trabajo en equipo deficiente';

  @override
  String get riskSleep => 'Sueño insuficiente y horarios irregulares';

  @override
  String get hazardIsolation => 'Aislamiento y confinamiento';

  @override
  String get hazardDistance => 'Distancia de la Tierra';

  @override
  String get toneDirect => 'Directo';

  @override
  String get toneGentle => 'Amable';

  @override
  String get framingInternal => 'Interno: datos y opciones';

  @override
  String get framingMixed => 'Mixto: datos y una recomendación';

  @override
  String get framingExternal => 'Externo: un paso claro';

  @override
  String get copingProblem => 'Centrado en el problema';

  @override
  String get copingEmotion => 'Centrado en las emociones';

  @override
  String get copingAvoidant => 'Evitativo';

  @override
  String get sourceMiniIpip => 'Cuestionario Mini-IPIP';

  @override
  String get sourceIpipNeo120 => 'Cuestionario IPIP-NEO-120';

  @override
  String get sourceImported => 'Archivo importado';

  @override
  String get alertMessage =>
      'Informa al oficial médico de la tripulación y prepara un resumen para la Tierra';

  @override
  String sourceUnavailableNote(String source) {
    return '$source no está disponible, así que esta lectura procede de la fuente basada en reglas.';
  }

  @override
  String insOnCourseDirect(int degreesNum) {
    return 'Vas en rumbo, a $degreesNum° de desvío, y cada lectura está cerca de tu propia línea base.';
  }

  @override
  String insOnCourseGentle(int degreesNum) {
    return 'Vas en rumbo, con solo $degreesNum° de desvío, y tus lecturas están cerca de lo que es normal para ti.';
  }

  @override
  String insWorstGentle(
    String indicator,
    String current,
    String baseline,
    String trend,
  ) {
    return '$indicator se ha movido un poco: ahora $current frente a tu habitual $baseline, y va $trend.';
  }

  @override
  String insWorstDirect(
    String indicator,
    String status,
    String current,
    String baseline,
    String trend,
  ) {
    return '$indicator está $status en $current frente a tu línea base de $baseline, y va $trend.';
  }

  @override
  String insMismatchGentle(int daysNum) {
    return 'Dijiste que te sientes bien, y eso cuenta, pero los datos de tu cuerpo llevan $daysNum días fuera de la línea base.';
  }

  @override
  String insMismatchDirect(int daysNum) {
    return 'Valoraste tu ánimo igual o por encima de la línea base, pero los datos de tu cuerpo llevan $daysNum días fuera de ella.';
  }

  @override
  String get insLifeGentle =>
      'Anotaste algo de casa, así que por ahora vigilamos tu ánimo un poco más de cerca.';

  @override
  String get insLifeDirect =>
      'Registraste algo de casa, así que el ánimo se vigila más de cerca durante 14 días.';

  @override
  String insActionGentle(String action) {
    return 'Un pequeño paso podría ayudar hoy: $action.';
  }

  @override
  String insActionDirect(String action) {
    return 'Una pequeña acción hoy: $action.';
  }

  @override
  String get insEvidenceAllOk =>
      'Todas las lecturas están dentro de una desviación estándar de tu propia línea base.';

  @override
  String insEvidence(String indicator, String current, String baseline) {
    return '$indicator: $current frente a una línea base de $baseline.';
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
      other: '$count días',
      one: '1 día',
    );
    return '$indicator: $current frente a una línea base de $baseline, más allá de $sd DE durante $_temp0.';
  }

  @override
  String insNights(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count noches recientes de 6 horas o menos.',
      one: '1 noche reciente de 6 horas o menos.',
    );
    return '$_temp0';
  }

  @override
  String get insLapses =>
      'Los lapsos en la prueba de reacción superan lo habitual en ti.';

  @override
  String insOptions(String options) {
    return 'Opciones: $options';
  }

  @override
  String insRecommended(String action, String description) {
    return 'Recomendado: $action. $description';
  }

  @override
  String insRecommendedStep(String action, String description) {
    return 'Paso recomendado: $action. $description Solo este paso hoy.';
  }

  @override
  String get insLatePhase =>
      'Después del día 150 de la misión la vigilancia es más estricta, así que se señalan cambios más pequeños.';

  @override
  String get insLifeSupport =>
      'Recibir noticias de casa puede ser duro. Hablar con alguien de confianza puede ayudar.';

  @override
  String get trendsTitle => 'Desviación de rumbo';

  @override
  String get trendsSubtitle => 'Cómo te alejas de tu propia línea base';

  @override
  String get trendsSleepTitle => 'Sueño, últimas 14 noches';

  @override
  String get trendsNoTests => 'Aún no hay pruebas';

  @override
  String trendsLatestReaction(String ms, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lapsos',
      one: '1 lapso',
    );
    return 'Último $ms · $_temp0';
  }

  @override
  String trendsNasaLine(String risk, String hazards) {
    return 'Riesgo NASA: $risk. Peligro: $hazards.';
  }

  @override
  String get correctionsTitle => 'Correcciones de rumbo';

  @override
  String get correctionsHint =>
      'Elige una acción pequeña. Las que prefieres van primero.';

  @override
  String correctionsPlan(String title, String description) {
    return 'Tu plan: $title. $description';
  }

  @override
  String get correctionsSuggested => 'Sugerida';

  @override
  String actionSemantics(String title, String description) {
    return '$title. $description';
  }

  @override
  String actionSemanticsSuggested(String title, String description) {
    return '$title. $description Sugerida para hoy.';
  }

  @override
  String get chartNoSleep => 'Aún no hay datos de sueño.';

  @override
  String chartBaselineValue(String value) {
    return 'Tu línea base $value';
  }

  @override
  String get chartBaseline => 'Tu línea base';

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
    return 'Sueño en las últimas $count noches. Línea base $baseline. Última noche $latest, $status.';
  }

  @override
  String get chartToday => 'Hoy';

  @override
  String get chartNeedTests =>
      'Haz la prueba de reacción varias veces para ver tu tendencia.';

  @override
  String chartReactionSemantics(int count, String baseline, String latest) {
    return 'Tiempo de reacción en las últimas $count pruebas. Línea base $baseline. Última $latest.';
  }

  @override
  String get chartNotEnough => 'Aún no hay suficientes datos.';

  @override
  String chartDaysAgo(int daysNum) {
    return '-$daysNum d';
  }

  @override
  String get checkinTitle => 'Diario del capitán';

  @override
  String get checkinSubtitle =>
      '¿Cómo estás hoy? Sé sincero. No hay respuestas incorrectas.';

  @override
  String get qEngagement => 'Implicación';

  @override
  String get qConnection => 'Conexión con la tripulación';

  @override
  String get scaleLow => 'Bajo';

  @override
  String get scaleHigh => 'Alto';

  @override
  String get scaleCalm => 'Tranquilo';

  @override
  String get scaleVeryStressed => 'Muy estresado';

  @override
  String get scaleLight => 'Ligera';

  @override
  String get scaleOverloaded => 'Sobrecargado';

  @override
  String get scaleBored => 'Aburrido';

  @override
  String get scaleAbsorbed => 'Absorto';

  @override
  String get scaleScattered => 'Disperso';

  @override
  String get scaleSharp => 'Agudo';

  @override
  String get scaleDistant => 'Distante';

  @override
  String get scaleClose => 'Cercana';

  @override
  String checkinStreak(int count) {
    return 'Racha de $count días';
  }

  @override
  String checkinStreakSemantics(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count días',
      one: '1 día',
    );
    return 'Racha de registro: $_temp0';
  }

  @override
  String get checkinStreakNote =>
      'Cuenta los días que registraste, nunca cómo son las puntuaciones.';

  @override
  String get checkinOptional => 'Opcional.';

  @override
  String get checkinNoteLabel => 'Nota privada';

  @override
  String get checkinNoteHelper =>
      'Se queda en este dispositivo. Nunca se envía a ningún sitio.';

  @override
  String get checkinUpdate => 'Actualizar la entrada de hoy';

  @override
  String get checkinLogged => 'Entrada registrada. Gracias.';

  @override
  String sliderSemantics(String label, int valueNum) {
    return '$label $valueNum de 10';
  }

  @override
  String get crewTitle => 'Moral de la nave';

  @override
  String get crewSubtitle => 'Cómo está la tripulación, en un número anónimo';

  @override
  String get moraleHigh => 'Alta';

  @override
  String get moraleSteady => 'Estable';

  @override
  String get moraleStrained => 'Tensa';

  @override
  String get moraleLow => 'Baja';

  @override
  String get crewOutOf100 => '/ 100';

  @override
  String crewMeterSemantics(
    String level,
    int scoreNum,
    int contributedNum,
    int crewNum,
  ) {
    return 'Moral de la tripulación $level, $scoreNum de 100. $contributedNum de $crewNum miembros han registrado hoy.';
  }

  @override
  String crewCheckedIn(int contributedNum, int crewNum) {
    return '$contributedNum de $crewNum miembros han registrado hoy. Los nombres nunca se muestran.';
  }

  @override
  String get crewGoalLabel => 'Meta semanal compartida';

  @override
  String get crewGoalTitle => 'Compartir una cena juntos';

  @override
  String get crewGoalDesc =>
      'Cena con la tripulación 6 noches esta semana. Algo breve y sin prisa está bien.';

  @override
  String crewGoalProgress(int doneNum, int segmentsNum, int peopleNum) {
    return '$doneNum de $segmentsNum noches hechas · $peopleNum se han unido';
  }

  @override
  String crewGoalSemantics(int doneNum, int segmentsNum) {
    return '$doneNum de $segmentsNum noches hechas';
  }

  @override
  String get crewJoin => 'Unirme a esta meta';

  @override
  String get crewLeave => 'Te has unido. Toca para salir';

  @override
  String get crewPrivacyTitle => 'Tu privacidad';

  @override
  String get crewPrivacyBody =>
      'Solo se muestra un promedio del grupo. Tus puntuaciones, notas y perfil se quedan en este dispositivo. No hay nombres, clasificaciones ni comparaciones entre personas.';

  @override
  String get profileTitle => 'Perfil';

  @override
  String get profileSubtitle =>
      'Todo se queda en este dispositivo, salvo que elijas el modelo en la nube.';

  @override
  String get profileRetake => 'Repetir el cuestionario';

  @override
  String get profileSamples => 'Perfiles de ejemplo';

  @override
  String get profileSamplesHint =>
      'Cambia a un ejemplo incluido para ver cómo se adapta la app a otra persona.';

  @override
  String get scienceTitle => 'Sobre la ciencia';

  @override
  String profileLoaded(String name) {
    return 'Se cargó a $name.';
  }

  @override
  String get profileCurrent => 'Actual';

  @override
  String profileCurrentSemantics(String label) {
    return '$label, actual';
  }

  @override
  String get traitOpenness => 'Apertura';

  @override
  String get traitConscientiousness => 'Responsabilidad';

  @override
  String get traitExtraversion => 'Extraversión';

  @override
  String get traitAgreeableness => 'Amabilidad';

  @override
  String get traitEmotionalStability => 'Estabilidad emocional';

  @override
  String get traitBoredom => 'Propensión al aburrimiento';

  @override
  String get facetsTitle => 'Facetas';

  @override
  String get facetExcitement => 'Búsqueda de emociones';

  @override
  String get facetGregariousness => 'Sociabilidad';

  @override
  String get facetVulnerability => 'Vulnerabilidad';

  @override
  String get facetSelfDiscipline => 'Autodisciplina';

  @override
  String get profileAdviceFraming => 'Enfoque de los consejos';

  @override
  String get profileCoping => 'Estilo de afrontamiento';

  @override
  String get profileTone => 'Tono';

  @override
  String get profilePreferred => 'Acciones preferidas';

  @override
  String get profileBaseline => 'Línea base';

  @override
  String dotJoin2(String a, String b) {
    return '$a · $b';
  }

  @override
  String dotJoin3(String a, String b, String c) {
    return '$a · $b · $c';
  }

  @override
  String get restingHeartRate => 'Frecuencia cardíaca en reposo';

  @override
  String get hrvLabel => 'VFC';

  @override
  String unitBpm(String value) {
    return '$value lpm';
  }

  @override
  String get settingsMissionDay => 'Día de la misión';

  @override
  String get settingsPrevDay => 'Día anterior';

  @override
  String get settingsNextDay => 'Día siguiente';

  @override
  String settingsDay(int dayNum) {
    return 'Día $dayNum';
  }

  @override
  String settingsMissionDaySemantics(int dayNum, String phase) {
    return 'Día $dayNum de la misión, $phase';
  }

  @override
  String get settingsAiSource => 'Fuente de IA';

  @override
  String get settingsAiHint =>
      'De dónde viene la lectura escrita de Inicio. En nivel de alerta el mensaje siempre es fijo.';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get settingsLanguageHint =>
      'Elige el idioma de la app. La lectura escrita lo sigue.';

  @override
  String get languageDevice => 'Idioma del dispositivo';

  @override
  String get importTitle => 'Importar un perfil';

  @override
  String get importHint =>
      'Carga a otra persona desde un archivo JSON con los mismos campos que los ejemplos incluidos. No se sube nada.';

  @override
  String get importButton => 'Importar perfil JSON';

  @override
  String importFailed(String error) {
    return 'No se pudo importar este archivo. $error';
  }

  @override
  String get importNotJson => 'Ese archivo no es un JSON válido.';

  @override
  String get importUnreadable => 'No se pudo leer ese archivo.';

  @override
  String importDone(String name) {
    return 'Se importó a $name.';
  }

  @override
  String get scienceSubtitle => 'De dónde vienen las ideas de Psychonaut.';

  @override
  String get scienceAssumptionsTitle => 'Supuestos de diseño';

  @override
  String get sciHrpTitle =>
      'Programa de Investigación Humana de la NASA: peligros y riesgos';

  @override
  String get sciHrpBody =>
      'La lista de peligros del vuelo espacial, incluidos el aislamiento y confinamiento y la distancia de la Tierra, y los riesgos para la salud humana asociados.';

  @override
  String get sciBhrTitle =>
      'Registro de riesgos de salud conductual de la NASA';

  @override
  String get sciBhrBody =>
      'Los riesgos de salud conductual y rendimiento en misiones largas: condiciones del comportamiento, trabajo en equipo y sueño.';

  @override
  String get sciReactionTitle => 'Investigación de la autoprueba de reacción';

  @override
  String get sciReactionBody =>
      'Basner, Mollicone y Dinges (2011), una prueba breve de vigilancia psicomotora (PVT-B), y la autoprueba de reacción de la NASA que usan los astronautas para seguir la fatiga.';

  @override
  String get sciIpipTitle => 'International Personality Item Pool (IPIP)';

  @override
  String get sciIpipBody =>
      'Ítems de dominio público de ipip.ori.org. El Mini-IPIP de 20 ítems es de Donnellan, Oswald, Baird y Lucas (2006). El producto completo usaría el IPIP-NEO-120, de 120 ítems, para 30 facetas.';

  @override
  String get sciAssume1 =>
      'Los umbrales en desviaciones estándar y los días necesarios para señalar un cambio son decisiones de diseño de un prototipo.';

  @override
  String get sciAssume2 =>
      'El límite más estricto tras el día 150 sigue estudios análogos que indican que los síntomas conductuales aumentan tras 5 o 6 meses.';

  @override
  String get sciAssume3 =>
      'Los rasgos de personalidad solo cambian lo pronto que se señala un cambio. Nunca etiquetan a una persona.';

  @override
  String get reactionTitle => 'Prueba de reacción';

  @override
  String get ipipItem1 => 'Soy el alma de la fiesta';

  @override
  String get ipipItem2 => 'Simpatizo con los sentimientos de los demás';

  @override
  String get ipipItem3 => 'Hago las tareas domésticas enseguida';

  @override
  String get ipipItem4 => 'Tengo cambios de humor frecuentes';

  @override
  String get ipipItem5 => 'Tengo una imaginación vívida';

  @override
  String get ipipItem6 => 'No hablo mucho';

  @override
  String get ipipItem7 => 'No me interesan los problemas de otras personas';

  @override
  String get ipipItem8 => 'A menudo olvido devolver las cosas a su sitio';

  @override
  String get ipipItem9 => 'Estoy relajado la mayor parte del tiempo';

  @override
  String get ipipItem10 => 'No me interesan las ideas abstractas';

  @override
  String get ipipItem11 => 'Hablo con mucha gente distinta en las fiestas';

  @override
  String get ipipItem12 => 'Siento las emociones de los demás';

  @override
  String get ipipItem13 => 'Me gusta el orden';

  @override
  String get ipipItem14 => 'Me altero con facilidad';

  @override
  String get ipipItem15 => 'Me cuesta entender las ideas abstractas';

  @override
  String get ipipItem16 => 'Me mantengo en un segundo plano';

  @override
  String get ipipItem17 => 'Realmente no me interesan los demás';

  @override
  String get ipipItem18 => 'Lo desordeno todo';

  @override
  String get ipipItem19 => 'Rara vez me siento triste';

  @override
  String get ipipItem20 => 'No tengo buena imaginación';

  @override
  String get ipipAnswer1 => 'Muy inexacto';

  @override
  String get ipipAnswer2 => 'Algo inexacto';

  @override
  String get ipipAnswer3 => 'Ni inexacto ni exacto';

  @override
  String get ipipAnswer4 => 'Algo exacto';

  @override
  String get ipipAnswer5 => 'Muy exacto';

  @override
  String ipipAnswerSemantics(String n, String label) {
    return '$n, $label';
  }

  @override
  String onbStep(int stepNum, int totalNum) {
    return 'Paso $stepNum de $totalNum';
  }

  @override
  String get onbNext => 'Siguiente';

  @override
  String get onbCreate => 'Crear perfil';

  @override
  String get onbWelcome => 'Bienvenido a bordo';

  @override
  String get onbWelcomeSub => 'Psychonaut, tu compañero diario';

  @override
  String get onbIntro =>
      'Psychonaut te compara con tu propia línea base y sugiere una pequeña acción al día. Un cuestionario corto de 20 afirmaciones ajusta lo pronto que señala cambios y cómo te habla. Tus respuestas se quedan en este dispositivo.';

  @override
  String get onbName => 'Tu nombre';

  @override
  String get onbRole => 'Tu cargo, por ejemplo Comandante';

  @override
  String get onbExploring => '¿Solo quieres explorar?';

  @override
  String get onbSampleHint => 'Carga un perfil de ejemplo.';

  @override
  String get onbCancel => 'Cancelar y conservar mi perfil actual';

  @override
  String get onbAboutYou => 'Sobre ti';

  @override
  String onbItemsHint(int pageNum, int pagesNum) {
    return 'Descríbete como eres en general ahora, no como te gustaría ser. Página $pageNum de $pagesNum.';
  }

  @override
  String get onbLocusTitle => 'Cuando las cosas van bien o mal';

  @override
  String get onbLocusSub =>
      '¿Cuál se parece más a ti? Esto da forma a cómo se presentan los consejos.';

  @override
  String get onbLocusInternalTitle => 'Sobre todo mis decisiones y mi esfuerzo';

  @override
  String get onbLocusInternalText =>
      'Lo que me pasa depende sobre todo de lo que hago.';

  @override
  String get onbLocusMixedTitle => 'Una mezcla de ambas';

  @override
  String get onbLocusMixedText =>
      'Mi esfuerzo importa, y también las circunstancias que no controlo.';

  @override
  String get onbLocusExternalTitle =>
      'Sobre todo las circunstancias y otras personas';

  @override
  String get onbLocusExternalText =>
      'Gran parte de lo que ocurre escapa a mi control.';

  @override
  String get onbToneTitle => '¿Cómo debería hablarte Psychonaut?';

  @override
  String get onbToneSub => 'Puedes cambiarlo más tarde.';

  @override
  String get onbToneDirectEx =>
      '«El sueño ha bajado 0,8 h. Prueba un reinicio del sueño esta noche.»';

  @override
  String get onbToneGentleEx =>
      '«El sueño se ha movido un poco. Una tarde tranquila podría ayudar.»';

  @override
  String get onbActionsTitle => '¿Qué te ayuda a recuperarte?';

  @override
  String get onbActionsSub =>
      'Elige las acciones que te gusten. El orden en que las pulses es el orden en que se ofrecen.';

  @override
  String get onbYourProfile => 'Tu perfil';

  @override
  String get onbTraits => 'Rasgos de personalidad';

  @override
  String get onbTraitsNote =>
      'De una versión corta de 20 ítems. Los rasgos solo cambian lo pronto que se señala un cambio. Nunca te etiquetan.';

  @override
  String get onbPrefs => 'Tus preferencias';

  @override
  String get onbActionsLabel => 'Acciones';

  @override
  String get roleDefault => 'Miembro de la tripulación';

  @override
  String get importPickerTitle => 'Elige un archivo JSON de perfil';

  @override
  String get reactionIntro =>
      'Esta prueba de 3 minutos comprueba lo alerta que estás. Cuando la pantalla diga «Pulsa ahora», pulsa lo más rápido que puedas. No pulses antes de que aparezca.';

  @override
  String get reactionKeyboardHint => 'Con teclado, pulsa la barra espaciadora.';

  @override
  String get reactionWait => 'Espera…';

  @override
  String get reactionTapNow => 'Pulsa ahora';

  @override
  String get reactionTooSoon => 'Demasiado pronto. Espera la señal.';

  @override
  String reactionTimeLeft(String time) {
    return 'Quedan $time';
  }

  @override
  String get reactionDiscardHint =>
      'Si vuelves atrás ahora, esta prueba se descarta.';

  @override
  String get reactionDoneTitle => 'Prueba completada';

  @override
  String get reactionMean => 'Tiempo medio de reacción';

  @override
  String get reactionResponses => 'Respuestas';

  @override
  String get reactionLapses => 'Lapsos (más de 500 ms)';

  @override
  String get reactionFalseStarts => 'Salidas en falso';

  @override
  String get reactionSaved => 'Guardado. Puedes verlo en Tendencias.';

  @override
  String get reactionNoResponses =>
      'No se registró ninguna respuesta, así que no se guardó nada.';

  @override
  String get reactionDone => 'Listo';
}
