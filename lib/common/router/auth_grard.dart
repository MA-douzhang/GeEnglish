import 'package:auto_route/auto_route.dart';
import 'package:ge_english/common/utils/utils.dart';

class AuthGuard extends AutoRouteGuard {

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    var isAuth = await isAuthenticated();
    if (isAuth == false) {
      router.pushNamed("/sign-in-page-route");
    }else{
      resolver.next(true);
    }
  }
}
