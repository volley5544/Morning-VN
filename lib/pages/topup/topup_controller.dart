import '../../models/topup_data.dart';

class TopupController {
  String getNextPage(TopupConsent topupConsent) {
    if (!topupConsent.contactRequst) {
      return 'ใบคำขอสินเชื่อ';
    }
    if (!topupConsent.paySlip) {
      return 'ใบรับเงิน';
    }
    if (!topupConsent.contactDoccument) {
      return 'เอกสารสัญญา';
    }
    return 'gonext';
  }
}
