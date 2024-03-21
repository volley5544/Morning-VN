import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'topup_status_bloc_event.dart';
part 'topup_status_bloc_state.dart';

class TopupStatusBlocBloc extends Bloc<TopupStatusBlocEvent, TopupStatusBlocState> {
  TopupStatusBlocBloc() : super(TopupStatusBlocInitial()) {
    on<TopupStatusBlocEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
