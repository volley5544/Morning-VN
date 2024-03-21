part of 'notify_bloc.dart';

abstract class NotifyEvent extends Equatable {
  const NotifyEvent();

  @override
  List<Object> get props => [];
}

class GetNotifyList extends NotifyEvent {
  final Function getNotify;
  const GetNotifyList(this.getNotify);
}

class SetNotifyListComplete extends NotifyEvent {
  final NotifyModel inputNotifyData;
  final NotifyConnector notifyConnector;
  final bool alreadySeenFlag;
  const SetNotifyListComplete(
      this.notifyConnector, this.inputNotifyData, this.alreadySeenFlag);
}

class GetNotifySeenStatus extends NotifyEvent {
  final NotifyConnector notifyConnector;
  const GetNotifySeenStatus(this.notifyConnector);
}
