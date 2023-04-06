import 'package:get/get.dart';

import '../modules/account/bindings/account_binding.dart';
import '../modules/account/views/account_view.dart';
import '../modules/application-detail/bindings/application_detail_binding.dart';
import '../modules/application-detail/views/application_detail_view.dart';
import '../modules/apply-job/bindings/apply_job_binding.dart';
import '../modules/apply-job/views/apply_job_view.dart';
import '../modules/cv-viewer/bindings/cv_viewer_binding.dart';
import '../modules/cv-viewer/views/cv_viewer_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/job-details/bindings/job_details_binding.dart';
import '../modules/job-details/views/job_details_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/my-referral/bindings/my_referral_binding.dart';
import '../modules/my-referral/views/my_referral_view.dart';
import '../modules/post-referral/bindings/post_referral_binding.dart';
import '../modules/post-referral/views/post_referral_view.dart';
import '../modules/post-success/bindings/post_success_binding.dart';
import '../modules/post-success/views/post_success_view.dart';
import '../modules/referral-order-details/bindings/referral_order_details_binding.dart';
import '../modules/referral-order-details/views/referral_order_details_view.dart';
import '../modules/referral-orders/bindings/referral_orders_binding.dart';
import '../modules/referral-orders/views/referral_orders_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/search/bindings/search_binding.dart';
import '../modules/search/views/search_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH,
      page: () => const SearchView(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: _Paths.JOB_DETAILS,
      page: () => const JobDetailsView(),
      binding: JobDetailsBinding(),
    ),
    GetPage(
      name: _Paths.APPLY_JOB,
      page: () => const ApplyJobView(),
      binding: ApplyJobBinding(),
    ),
    GetPage(
      name: _Paths.POST_REFERRAL,
      page: () => const PostReferralView(),
      binding: PostReferralBinding(),
    ),
    GetPage(
      name: _Paths.ACCOUNT,
      page: () => const AccountView(),
      binding: AccountBinding(),
    ),
    GetPage(
      name: _Paths.POST_SUCCESS,
      page: () => const PostSuccessView(),
      binding: PostSuccessBinding(),
    ),
    GetPage(
      name: _Paths.MY_REFERRAL,
      page: () => const MyReferralView(),
      binding: MyReferralBinding(),
    ),
    GetPage(
      name: _Paths.APPLICATION_DETAIL,
      page: () => const ApplicationDetailView(),
      binding: ApplicationDetailBinding(),
    ),
    GetPage(
      name: _Paths.CV_VIEWER,
      page: () => const CvViewerView(),
      binding: CvViewerBinding(),
    ),
    GetPage(
      name: _Paths.REFERRAL_ORDERS,
      page: () => const ReferralOrdersView(),
      binding: ReferralOrdersBinding(),
    ),
    GetPage(
      name: _Paths.REFERRAL_ORDER_DETAILS,
      page: () => const ReferralOrderDetailsView(),
      binding: ReferralOrderDetailsBinding(),
    ),
  ];
}
