import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_application_srisawad/modules/retention/index.dart';

part 'loan_retention_event.dart';
part 'loan_retention_state.dart';

class LoanRetentionBloc extends Bloc<LoanRetentionEvent, LoanRetentionState> {
  LoanRetentionBloc() : super(LoanRetentionInitial()) {
    on<LoadLoanRetention>((event, emit) async {
      try {
        Retention retention = Retention();
        emit(LoanRetentionLoading());
        String loanRetention = await retention.getRetensionNumber();
        print('getRetensionNumber is called');
        emit(LoanRetentionComplete(loanRetentionNumber: loanRetention));
      } catch (e) {
        emit(
            LoanRetentionError(loanRetentionNumber: state.loanRetentionNumber));
      }
    });
  }
}
