import 'package:go_router/go_router.dart';
import 'package:simple_chat/app/services/get_it_service.dart';
import 'package:simple_chat/src/auth/application/auth_handler.dart';
import 'package:simple_chat/ui/pages/home/home_page.dart';
import 'package:simple_chat/ui/pages/sign_in/sign_in_page.dart';
import 'package:simple_chat/ui/pages/splash/splash_page.dart';
import 'package:simple_chat/ui/routes/route_name.dart';

class RoutePage {
  const RoutePage._();

  static final GoRouter router = GoRouter(
    initialLocation: RouteName.home,
    redirect: (context, state) async {
      if ((await getIt<AuthHandler>().currentUser) == null) {
        return RouteName.signIn;
      }
      return null;
    },
    routes: [
      GoRoute(
        name: RouteName.home,
        path: RouteName.home,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        name: RouteName.signIn,
        path: RouteName.signIn,
        builder: (context, state) => const SignInPage(),
      ),
      GoRoute(
        name: RouteName.splash,
        path: RouteName.signIn,
        builder: (context, state) => const SplashPage(),
      ),
    ],
  );
}
