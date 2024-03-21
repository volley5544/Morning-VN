class NotifyModel {
  String title = '', body = '', sentTime = '';
  int sendTimestamp;

  NotifyModel(
      {required this.title,
      required this.body,
      required this.sentTime,
      required this.sendTimestamp});

  factory NotifyModel.fromJson(Map<String, dynamic> json) {
    return NotifyModel(
        title: json['title'],
        body: json['body'],
        sentTime: json['sentTime'],
        sendTimestamp: json['sendTimestamp']);
  }

  Map<String, dynamic> toJson() {
    return {
      "title": this.title,
      "body": this.body,
      "sentTime": this.sentTime,
      "sendTimestamp": this.sendTimestamp
    };
  }

  static NotifyModel fromMap(Map<String, dynamic> json) {
    return NotifyModel(
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      sentTime: json['sentTime'] ?? '',
      sendTimestamp: json['sendTimestamp'] ?? 0,
    );
  }
}

class FirestoreNotifyModel {
  bool alreadySeen;
  List<NotifyModel> notify;

  FirestoreNotifyModel(
      {required bool this.alreadySeen, required List<NotifyModel> this.notify});

  factory FirestoreNotifyModel.fromJson(Map<String, dynamic> json) {
    final tmpAlreadySeen =
        json.containsKey('alreadySeen') ? json['alreadySeen'] : [];
    final tmpNotify = json.containsKey('notify') ? json['notify'] : [];
    return FirestoreNotifyModel(
        alreadySeen: tmpAlreadySeen,
        notify: (tmpNotify as List).map((e) {
          if (e.runtimeType == NotifyModel) {
            return e as NotifyModel;
          }
          return NotifyModel.fromMap(e);
        }).toList());
  }

  Map<String, dynamic> toJson() {
    return {
      "alreadySeen": this.alreadySeen,
      "notify": this.notify,
    };
  }

  static FirestoreNotifyModel fromMap(Map<String, dynamic> json) {
    return FirestoreNotifyModel(
        alreadySeen: json['alreadySeen'],
        notify: (json['notify'] as List)
            .map((e) => NotifyModel.fromJson(e))
            .toList());
  }
}
