import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_application_srisawad/util/logger_service.dart';

import '../../models/notify_model.dart';
import '../../connector/firestore/notify.dart';

part 'notify_event.dart';
part 'notify_state.dart';

class NotifyBloc extends Bloc<NotifyEvent, NotifyState> {
  NotifyBloc() : super(NotifyBlocInitial(notifyData: [], alreadySeen: false)) {
    on<GetNotifyList>((event, emit) async {
      try {
        emit(NotifyBlocLoading(
            notifyData: state.notifyData, alreadySeen: state.alreadySeen));
        final List<NotifyModel> result = await event.getNotify();
        emit(NotifyBlocComplete(
            notifyData: result, alreadySeen: state.alreadySeen));
      } catch (e) {
        emit(NotifyBlocError(
            notifyData: state.notifyData, alreadySeen: state.alreadySeen));
      }
      ;
    });

    on<SetNotifyListComplete>((event, emit) async {
      try {
        emit(NotifyBlocLoading(
            notifyData: state.notifyData, alreadySeen: state.alreadySeen));

        // await event.notifyConnector.setNotify(event.inputNotifyData);
        await event.notifyConnector.setFlagNotify(event.alreadySeenFlag);
        emit(NotifyBlocComplete(
            notifyData: [], alreadySeen: event.alreadySeenFlag));
      } catch (_, stack) {
        logger.e('Exception: ' + _.toString());
        logger.e('Stacktrace: ' + stack.toString());
        emit(NotifyBlocError(
            notifyData: state.notifyData, alreadySeen: state.alreadySeen));
      }
      ;
    });

    on<GetNotifySeenStatus>((event, emit) async {
      try {
        emit(NotifyBlocLoading(
            notifyData: state.notifyData, alreadySeen: state.alreadySeen));
        final status = await event.notifyConnector.getFlagNotify();
        emit(NotifyBlocComplete(
            notifyData: state.notifyData, alreadySeen: status));
      } catch (e) {
        logger.e('GetNotifySeenStatus this err called $e');
        emit(NotifyBlocError(
            notifyData: state.notifyData, alreadySeen: state.alreadySeen));
      }
      ;
    });
  }
}
