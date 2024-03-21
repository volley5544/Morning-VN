part of 'topup_bloc.dart';

abstract class TopupState extends Equatable {
  final TopupData topupData;
  late List<LoanDetail> loanList;
  final TopupInstallmentNumber topupInstallmentNumber;
  final UserAddresses userAddressesList;
  late TopupConsent topupConsent;
  final DecodedTopupPdf decodedTopupPdf;
  final List<Uint8List> doccumentList;
  late TopupSubmitForm topupSubmitForm;
  TopupState(
      {required this.topupData,
      required this.topupSubmitForm,
      required this.loanList,
      required this.topupInstallmentNumber,
      required this.userAddressesList,
      required this.doccumentList,
      required this.topupConsent,
      required this.decodedTopupPdf});

  @override
  List<Object> get props => [];
}

class TopupInitial extends TopupState {
  TopupInitial({
    required super.topupData,
    required super.loanList,
    required super.topupInstallmentNumber,
    required super.userAddressesList,
    required super.doccumentList,
    required super.topupConsent,
    required super.decodedTopupPdf,
    required super.topupSubmitForm,
  });
}

class TopupLoading extends TopupState {
  TopupLoading({
    required super.topupData,
    required super.loanList,
    required super.topupInstallmentNumber,
    required super.userAddressesList,
    required super.doccumentList,
    required super.topupConsent,
    required super.decodedTopupPdf,
    required super.topupSubmitForm,
  });
}

class TopupComplete extends TopupState {
  TopupComplete({
    required super.topupData,
    required super.loanList,
    required super.topupInstallmentNumber,
    required super.userAddressesList,
    required super.doccumentList,
    required super.topupConsent,
    required super.decodedTopupPdf,
    required super.topupSubmitForm,
  });
}

class TopupError extends TopupState {
  TopupError({
    required super.topupData,
    required super.loanList,
    required super.topupInstallmentNumber,
    required super.userAddressesList,
    required super.doccumentList,
    required super.topupConsent,
    required super.decodedTopupPdf,
    required super.topupSubmitForm,
  });
}
