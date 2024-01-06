
import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:ge_english/common/router/router.gr.dart';


@AutoRouterConfig()
class AppRouter extends $AppRouter {

  @override
  List<AutoRoute> get routes => [
    /// routes go here
    AutoRoute(page: IndexPageRoute.page,path: '/'),
    AutoRoute(page: WelcomePageRoute.page,path: '/welcome-page-route'),
    AutoRoute(page: SignInPageRoute.page,path: '/sign-in-page-route'),
    AutoRoute(page: SignUpPageRoute.page,path: '/sign-up-page-route'),
    AutoRoute(page: ApplicationPageRoute.page,path: '/application-page-route'),
    AutoRoute(page: SearchResultRoute.page,path: '/search-result-route'),
    AutoRoute(page: MyBookMarkRoute.page,path: '/my-book-mark-route'),
    AutoRoute(page: RemeberedWordDetailRoute.page,path: '/remebered-word-detail-route'),
    AutoRoute(page: StarDetailsRoute.page,path: '/star-details-route'),
    AutoRoute(page: NewBookMarkRoute.page,path: '/new-book-mark-route'),
    AutoRoute(page: BookMarkDetailRoute.page,path: '/book-mark-detail-route'),
    AutoRoute(page: CameraPageRoute.page,path: '/camera-page-route'),
    AutoRoute(page: CropPageRoute.page,path: '/crop-page-route'),
    AutoRoute(page: ResultPageRoute.page,path: '/result-page-route'),
    AutoRoute(page: LearnPageRoute.page,path: '/learn-page-route'),
    AutoRoute(page: ReviewPageRoute.page,path: '/review-page-route'),
    RedirectRoute(path: '*', redirectTo: '/'),
  ];
}
