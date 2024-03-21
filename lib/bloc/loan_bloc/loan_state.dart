part of 'loan_bloc.dart';

abstract class LoanState extends Equatable {
  final bool isQrCodeSelected;
  final PaymentDetail paymentDetail;
  late List<HistoryResult> loanDetailHistory;
  late LoanInstallmentDetailMedel loanInstallmentDetail;
  late List<LoanDetail> loanList;
  late LoanListData loanListData;
  LoanState(
      {required this.isQrCodeSelected,
      required this.loanDetailHistory,
      required this.loanInstallmentDetail,
      required this.loanList,
      required this.paymentDetail,
      required this.loanListData});

  @override
  List<Object> get props =>
      [loanList, loanDetailHistory, loanInstallmentDetail];
}

class LoanInitial extends LoanState {
  LoanInitial(
      {required super.isQrCodeSelected,
      required super.loanDetailHistory,
      required super.loanInstallmentDetail,
      required super.loanList,
      required super.paymentDetail,
      required super.loanListData});
}

class LoanListLoading extends LoanState {
  LoanListLoading(
      {required super.isQrCodeSelected,
      required super.loanDetailHistory,
      required super.loanInstallmentDetail,
      required super.loanList,
      required super.paymentDetail,
      required super.loanListData});
}

class LoanListComplete extends LoanState {
  LoanListComplete(
      {required super.isQrCodeSelected,
      required super.loanDetailHistory,
      required super.loanInstallmentDetail,
      required super.loanList,
      required super.paymentDetail,
      required super.loanListData});
  @override
  List<Object> get props => [
        this.loanList = loanList,
        this.loanDetailHistory = loanDetailHistory,
        this.loanInstallmentDetail = loanInstallmentDetail,
        this.loanListData = loanListData
      ];
}

class LoanListError extends LoanState {
  LoanListError(
      {required super.isQrCodeSelected,
      required super.loanDetailHistory,
      required super.loanInstallmentDetail,
      required super.loanList,
      required super.paymentDetail,
      required super.loanListData});
}

class LoanDetailInitial extends LoanState {
  LoanDetailInitial(
      {required super.isQrCodeSelected,
      required super.loanDetailHistory,
      required super.loanInstallmentDetail,
      required super.loanList,
      required super.paymentDetail,
      required super.loanListData});
}

class LoanDetailNoInternet extends LoanState {
  LoanDetailNoInternet(
      {required super.isQrCodeSelected,
      required super.loanDetailHistory,
      required super.loanInstallmentDetail,
      required super.loanList,
      required super.paymentDetail,
      required super.loanListData});
}
