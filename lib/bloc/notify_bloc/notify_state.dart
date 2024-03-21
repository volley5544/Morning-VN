part of 'notify_bloc.dart';

abstract class NotifyState extends Equatable {
  final List<NotifyModel> notifyData;
  final bool alreadySeen;
  const NotifyState({
    required this.alreadySeen,
    required this.notifyData,
  });

  @override
  List<Object> get props => [];
}

class NotifyBlocInitial extends NotifyState {
  NotifyBlocInitial({
    required super.notifyData,
    required super.alreadySeen,
  });
}

class NotifyBlocError extends NotifyState {
  NotifyBlocError({
    required super.notifyData,
    required super.alreadySeen,
  });
}

class NotifyBlocLoading extends NotifyState {
  NotifyBlocLoading({
    required super.notifyData,
    required super.alreadySeen,
  });
}

class NotifyBlocComplete extends NotifyState {
  NotifyBlocComplete({
    required super.notifyData,
    required super.alreadySeen,
  });
}
