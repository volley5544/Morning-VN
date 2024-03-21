part of 'topup_bloc.dart';

abstract class TopupEvent extends Equatable {
  const TopupEvent();

  @override
  List<Object> get props => [];
}

class SetTopupList extends TopupEvent {
  late List<LoanDetail> loanList;
  SetTopupList({required this.loanList});
}

class GetTopupByid extends TopupEvent {
  late String contractId;
  late TopupRepository topupRepository;
  final BuildContext context;
  TextEditingController installmentNumberController;
  final String dbName;
  late TopupConclusion topupConclusion;
  GetTopupByid({
    required this.contractId,
    required this.topupRepository,
    required this.context,
    required this.installmentNumberController,
    required this.dbName,
    required this.topupConclusion,
  });
}

class GetInstallmentNumberByID extends TopupEvent {
  late String contractId;
  late double amount;
  late String transactionNo;
  late double interestRate;
  late String dbName;
  late double topupFeeAmount;
  late double feeAmount;
  late TopupRepository topupRepository;
  final BuildContext context;
  late IndexSetter indexSetter;
  final Function setState;
  GetInstallmentNumberByID(
      {required this.contractId,
      required this.amount,
      required this.topupRepository,
      required this.context,
      required this.dbName,
      required this.feeAmount,
      required this.interestRate,
      required this.topupFeeAmount,
      required this.transactionNo,
      required this.indexSetter,
      required this.setState});
}

class GetUsreAddreses extends TopupEvent {
  late String hashThaiId;
  late TopupRepository topupRepository;
  final BuildContext context;
  GetUsreAddreses(
      {required this.hashThaiId,
      required this.topupRepository,
      required this.context});
}

class GetContractDoccument extends TopupEvent {
  late TopupSubmitForm topupSubmitForm;
  late TopupRepository topupRepository;
  final BuildContext context;
  GetContractDoccument(
      {required this.topupSubmitForm,
      required this.topupRepository,
      required this.context});
}

class SetTopupConsent extends TopupEvent {
  late TopupConsent topupConsent;
  SetTopupConsent({required this.topupConsent});
}

class SetTopupComplete extends TopupEvent {
  SetTopupComplete();
}

class ReSetTopupComplete extends TopupEvent {
  ReSetTopupComplete();
}

class ResetTopupState extends TopupEvent {
  ResetTopupState();
}
