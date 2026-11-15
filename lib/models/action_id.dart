/// Allowed action ids. Anything outside this list is rejected, including AI output.
enum ActionId {
  exercise('exercise'),
  journal('journal'),
  familyCall('family_call'),
  garden('garden'),
  windowTime('window_time'),
  newProject('new_project'),
  sleepReset('sleep_reset');

  const ActionId(this.id);

  final String id;

  static ActionId? tryParse(Object? id) {
    for (final a in ActionId.values) {
      if (a.id == id) return a;
    }
    return null;
  }

  static ActionId parse(Object? id) =>
      tryParse(id) ?? (throw FormatException('Unknown action id: $id'));
}
