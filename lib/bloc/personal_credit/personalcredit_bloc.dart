import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_application_srisawad/models/personal_credit.dart';

part 'personalcredit_event.dart';
part 'personalcredit_state.dart';

class PersonalcreditBloc
    extends Bloc<PersonalcreditEvent, PersonalcreditState> {
  PersonalcreditBloc()
      : super(PersonalcreditInitial(
            personalCredit: PersonalCredit(
                vehicelType: 'default',
                leftToPay: 0,
                deadLineDate: DateTime.now()))) {
    on<setNewName>((event, emit) {
      emit(PersonalcreditInitial(
          personalCredit: PersonalCredit(
              vehicelType: 'event.s',
              leftToPay: state.personalCredit.leftToPay,
              deadLineDate: state.personalCredit.deadLineDate)));
    });
    on<setLeftToPay>((event, emit) {
      // TODO: implement event handler
    });
  }
}



//      block

// event     state