class HistoryResult {
  int installmentNumber;
  double amount;
  String paidDate;
  HistoryResult({
    required this.installmentNumber,
    required this.amount,
    required this.paidDate,
  });
  factory HistoryResult.fromJson(Map<String, dynamic> json) {
    return HistoryResult(
      installmentNumber: json['installment_number'],
      amount: json['installment_amount'].toDouble(),
      paidDate: json['date'],
    );
  }
}

class LoanDetailHistory {
  String contractNo = '';
  String totalInstallment = '';
  List<HistoryResult> historyResult;

  LoanDetailHistory({
    required this.contractNo,
    required this.totalInstallment,
    required this.historyResult,
  });
  factory LoanDetailHistory.fromJson(Map<String, dynamic> json) {
    return LoanDetailHistory(
        contractNo: json['contract_no'],
        totalInstallment: json['total_installment'],
        historyResult:
            HistoryResult.fromJson(json['results']) as List<HistoryResult>);
  }
}

HistoryResult historyDetault =
    HistoryResult(amount: 0, installmentNumber: 0, paidDate: '');
