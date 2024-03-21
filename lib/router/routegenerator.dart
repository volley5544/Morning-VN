import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:mobile_application_srisawad/models/loan_product/loan_product_detail_model.dart';
import 'package:mobile_application_srisawad/models/otp_model.dart';
import 'package:mobile_application_srisawad/models/loan_detail.dart';
import 'package:mobile_application_srisawad/pages/loan_installment/loan_installment_detail_page.dart';
import 'package:mobile_application_srisawad/pages/loan_installment/loan_installment_list_page.dart';
import 'package:mobile_application_srisawad/pages/loan_product/loan_product_detail_page.dart';
import 'package:mobile_application_srisawad/pages/loan_product/loan_product_list_page.dart';
import 'package:mobile_application_srisawad/pages/other_menu/aboutus.dart';
import 'package:mobile_application_srisawad/pages/other_menu/agreement_condit.dart';
import 'package:mobile_application_srisawad/pages/other_menu/contact_us.dart';
import 'package:mobile_application_srisawad/pages/other_menu/faq.dart';
import 'package:mobile_application_srisawad/pages/other_menu/privacy_other.dart';
import 'package:mobile_application_srisawad/pages/other_menu/profile/edit_profile.dart';
import 'package:mobile_application_srisawad/pages/root_page.dart';
import 'package:mobile_application_srisawad/pages/topup/setup_installment_number_page.dart';
import 'package:mobile_application_srisawad/pages/topup/topup_status_detail_page.dart';
import 'package:mobile_application_srisawad/pages/topup/topup_status_list_page.dart';
import 'package:mobile_application_srisawad/pages/user_process/introl_other.dart';
import 'package:mobile_application_srisawad/pages/user_process/login_page.dart';
import 'package:mobile_application_srisawad/pages/user_process/pdpa_page.dart';
import 'package:mobile_application_srisawad/pages/user_process/privacy.dart';
import 'package:mobile_application_srisawad/pages/user_process/termandcon.dart';
import 'package:mobile_application_srisawad/pages/user_register/check_information.dart';
import 'package:mobile_application_srisawad/pages/user_register/register_profile.dart';
import 'package:mobile_application_srisawad/widgets/loading_screen.dart';
import 'package:mobile_application_srisawad/pages/loan_management/loan_detail_page.dart';
import 'package:mobile_application_srisawad/pages/loan_management/loan_list_page.dart';
import 'package:mobile_application_srisawad/pages/user_process/introduction_page.dart';
import 'package:mobile_application_srisawad/pages/user_process/otp_page.dart';
import 'package:mobile_application_srisawad/pages/user_register/forgot_passcode.dart';
import 'package:mobile_application_srisawad/pages/user_register/recheck_register.dart';
import 'package:mobile_application_srisawad/widgets/pin_change_controller.dart';
import 'package:mobile_application_srisawad/widgets/pin_login_controller.dart';
import 'package:mobile_application_srisawad/widgets/pin_register_controller.dart';
import 'package:mobile_application_srisawad/widgets/pin_forgot_controller.dart';
import '../models/insurance_product/insurance_product_detail_model.dart';
import '../models/topup_data.dart';
import '../pages/insurance_product/insurance_lead_page.dart';
import '../pages/insurance_product/insurance_product_detail_page.dart';
import '../pages/insurance_product/insurance_product_list_page.dart';
import '../pages/loan_product/loan_lead_page.dart';
import '../pages/other_menu/profile/profile.dart';
import '../pages/other_menu/profile/update_profile.dart';
import '../pages/splashsrceen.dart';
import '../pages/topup/check_topup_infomation_page.dart';
import '../pages/topup/topup_contract_conclusion_page.dart';
import '../pages/topup/topup_detail_page.dart';
import '../pages/topup/topup_doccument_page.dart';
import '../pages/topup/topup_extends_tax.dart';
import '../pages/topup/topup_list_page.dart';
import '../pages/user_register/register_fill_page.dart';
import '../util/logger_service.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final dynamic args = settings.arguments as dynamic;

    logger.i('the route navigation ${settings.name}');
    switch (settings.name) {
      case '/register-fill-page':
        return MaterialPageRoute(
            builder: (_) => RegisterFillPage(), settings: settings);
        break;
      case '/errorsign':
        return MaterialPageRoute(
            builder: (_) => IntroductionPage(), settings: settings);
        break;
      case '/loading-page':
        return MaterialPageRoute(
            builder: (_) => WelcomePage(), settings: settings);
        break;
      case '/middle-screen':
        return MaterialPageRoute(
            builder: (_) => MiddenSrceenLoading(), settings: settings);
        break;
      case '/forgotpasscode-page':
        return MaterialPageRoute(
            builder: (_) => const ForgotPasscode(), settings: settings);
        break;
      case '/pin-change-controller':
        return MaterialPageRoute(
            builder: (_) => const PinChangeController(), settings: settings);
        break;
      case '/pinsetup':
        return MaterialPageRoute(
            builder: (_) => const PinController(), settings: settings);
        break;
      case '/topup-status-list':
        return MaterialPageRoute(
            builder: (_) => const TopUpStatusList(), settings: settings);
        break;
      case '/topup-status-detail':
        return MaterialPageRoute(
            builder: (_) {
              return TopupStatusDetailPage(
                transNo: args['transNo'],
                dbName: args['dbName'],
                loanDetail: args['loanDetail'] as LoanDetail,
              );
            },
            settings: settings);
        break;
      case '/argeement-page':
        return MaterialPageRoute(
            builder: (_) => const AgreeMentPage(), settings: settings);
        break;
      case '/privacy-other-page':
        return MaterialPageRoute(
            builder: (_) => const PrivacyOther(), settings: settings);
        break;
      case '/aboutus-page':
        return MaterialPageRoute(
            builder: (_) => const AboutUs(), settings: settings);
        break;
      case '/contactus-page':
        return MaterialPageRoute(
            builder: (_) => const ContactUs(), settings: settings);
        break;
      case '/faq-page':
        return MaterialPageRoute(
            builder: (_) => const FaqPage(), settings: settings);
        break;
      case '/pinotpsetup':
        return MaterialPageRoute(
            builder: (_) {
              return PinForgotController(
                  phoneNumber: args['phoneNumber'], thaiId: args['thaiId']);
            },
            settings: settings);
        break;
      case '/otp-page':
        return MaterialPageRoute(
            builder: (_) {
              if (settings.arguments != null) {
                final args = ModalRoute.of(_)!.settings.arguments;
              }
              final temp = OtpPageModel.fromJson(args);
              return OtpPage(
                OtpPageModel.fromJson(args),
                phoneNumber: temp.phoneNumber,
                callbackFunction: temp.callbackFunction,
              );
            },
            settings: settings);
        break;
      case '/notify-page':
        return MaterialPageRoute(
            maintainState: false,
            builder: (_) {
              return RootPage(fromNavigate: true, initialIndex: 2);
            },
            settings: settings);
        break;
      case '/home-page':
        return MaterialPageRoute(
            maintainState: false,
            builder: (_) {
              return RootPage(fromNavigate: true, initialIndex: 0);
            },
            settings: settings);
        break;
      case '/map-page':
        return MaterialPageRoute(
            maintainState: false,
            builder: (_) {
              return RootPage(fromNavigate: true, initialIndex: 1);
            },
            settings: settings);
        break;
      case '/otherpage':
        return MaterialPageRoute(
            maintainState: false,
            builder: (_) {
              return RootPage(fromNavigate: true, initialIndex: 3);
            },
            settings: settings);
        break;
      case '/user-detail':
        return MaterialPageRoute(
            builder: (_) => const ReCheckRegister(), settings: settings);
        break;
      case '/check-information':
        return MaterialPageRoute(
            builder: (_) => const CheckInformation(), settings: settings);
        break;
      case '/intro-page':
        return MaterialPageRoute(
            builder: (_) => IntroductionPage(), settings: settings);
        break;
      case '/intro-other':
        return MaterialPageRoute(
            builder: (_) => IntrolOther(), settings: settings);
        break;
      case '/login-page':
        return MaterialPageRoute(
            builder: (_) => const LoginWidget(), settings: settings);
        break;
      case '/loan-list-page':
        return MaterialPageRoute(builder: (_) => const LoanListPage());
        break;
      case '/loan-installment-list':
        return MaterialPageRoute(
            builder: (_) => const LoanInstallmentListPage());
        break;
      case '/loan-installment-detail':
        return MaterialPageRoute(
            builder: (_) {
              final args = ModalRoute.of(_)!.settings.arguments as LoanDetail;
              return LoanInstallmentDetailPage(
                loanDetail: args,
              );
            },
            settings: settings);
        break;
      case '/term-and-con':
        return MaterialPageRoute(builder: (_) => const TermAndCon());
        break;
      case '/pdpa-page':
        return MaterialPageRoute(builder: (_) => const PdpaPage());
        break;
      case '/top-up-list-page':
        return MaterialPageRoute(
            builder: (_) => const TopUpListPage(), settings: settings);
        break;
      case '/top-up-detail-page':
        return MaterialPageRoute(
            builder: (_) {
              final args =
                  ModalRoute.of(_)!.settings.arguments as TopupConclusion;
              return TopupDetailPage(
                topupConclusion: args,
              );
            },
            settings: settings);
        break;
      case '/top-up-installment-number-page':
        return MaterialPageRoute(
            builder: (_) {
              final args =
                  ModalRoute.of(_)!.settings.arguments as TopupConclusion;
              return SetupInstallmentNumberPage(
                topupConclusion: args,
              );
            },
            settings: settings);
        break;
      case '/top-up-extends-tax':
        return MaterialPageRoute(
            builder: (_) {
              final args =
                  ModalRoute.of(_)!.settings.arguments as TopupConclusion;
              return TopupExtendsTax(
                topupConclusion: args,
              );
            },
            settings: settings);
        break;
      case '/top-up-check-infomation':
        return MaterialPageRoute(
            builder: (_) {
              final args =
                  ModalRoute.of(_)!.settings.arguments as TopupConclusion;
              return CheckTopupInfomation(
                topupConclusion: args,
              );
            },
            settings: settings);
        break;
      case '/top-up-contract-conclusion':
        return MaterialPageRoute(
            builder: (_) {
              final args =
                  ModalRoute.of(_)!.settings.arguments as TopupConclusion;
              return TopupContractConclusion(
                topupConclusion: args,
              );
            },
            settings: settings);
        break;
      case '/top-up-doccument':
        return MaterialPageRoute(
            builder: (_) {
              final args =
                  ModalRoute.of(_)!.settings.arguments as TopupConclusion;
              return TopupDoccumentPage(
                topupConclusion: args,
              );
            },
            settings: settings);
        break;
      case '/pin-page':
        return MaterialPageRoute(
            builder: (_) {
              return PinLoginController(
                  existingPin: args['existingPin'],
                  hashThaiId: args['hashThaiId'],
                  phoneNumber: args['phoneNumber'],
                  isRegister: args['isRegister']);
            },
            settings: settings);
        break;
      case '/settings/profile':
        return MaterialPageRoute(builder: (_) => Profile(), settings: settings);
        break;
      case '/settings/profile/update':
        return MaterialPageRoute(
            builder: (_) => UpdateProfile(
                  userThaiId: args['userId'],
                ),
            settings: settings);
        break;
      case '/payment-detail-page':
        return MaterialPageRoute(
            builder: (_) {
              final args = ModalRoute.of(_)!.settings.arguments as LoanDetail;
              return LoanDetailPage(
                loanDetail: args,
              );
            },
            settings: settings);
        break;
      case '/privacy-page':
        return MaterialPageRoute(
            builder: (_) => PrivacyPage(), settings: settings);
        break;
      case '/loan-product-list':
        return MaterialPageRoute(builder: (_) => const LoanProductListPage());
        break;
      case '/loan-product-detail':
        return MaterialPageRoute(
            builder: (_) => LoanProductDetailPage.navigate(args));
        break;
      case '/loan-lead':
        return MaterialPageRoute(
            builder: (_) {
              final args = ModalRoute.of(_)!.settings.arguments
                  as LoanProductDetailModel;
              return LoanLeadPage(
                productDetail: args,
              );
            },
            settings: settings);
        break;
      case '/insurance-product-list':
        return MaterialPageRoute(
            builder: (_) => const InsuranceProductListPage());
        break;
      case '/insurance-product-detail':
        return MaterialPageRoute(
            builder: (_) => InsuranceProductDetailPage.navigate(args));
        break;
      case '/insurance-lead':
        return MaterialPageRoute(
            builder: (_) {
              final args = ModalRoute.of(_)!.settings.arguments
                  as InsuranceProductDetailModel;
              return InsuranceLeadPage(
                productDetail: args,
              );
            },
            settings: settings);
        break;
      case '/register-profile':
        return MaterialPageRoute(
            builder: (_) => const RegisterProfile(), settings: settings);
        break;
      case '/edit-profile':
        return MaterialPageRoute(
            builder: (_) => EditProfile(), settings: settings);
        break;
      default:
        return MaterialPageRoute(builder: (_) => IntroductionPage());
        break;
    }
  }
}
