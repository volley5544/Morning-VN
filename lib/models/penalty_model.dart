class PenaltyStorage {
  bool lockPin;
  int failedCounter;
  int timer;
  int nextPenaltyTime;

  PenaltyStorage(
      {required this.lockPin,
      required this.failedCounter,
      required this.timer,
      required this.nextPenaltyTime});

  factory PenaltyStorage.fromJson(Map<String, dynamic> json) {
    return PenaltyStorage(
        lockPin: json['lock_pin'],
        failedCounter: json['failed_counter'],
        timer: json['timer'],
        nextPenaltyTime: json['nextPenaltyTime']);
  }
}
