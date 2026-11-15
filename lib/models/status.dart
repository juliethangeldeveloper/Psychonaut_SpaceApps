enum Status {
  onCourse,
  drifting,
  offCourse,
  alert;

  bool get isAlert => this == Status.alert;

  static Status worst(Iterable<Status> statuses) =>
      statuses.fold(Status.onCourse, (a, b) => b.index > a.index ? b : a);
}
