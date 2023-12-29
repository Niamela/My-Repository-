import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:local_mining_supplier/view/home/home.dart';
import 'package:local_mining_supplier/view/sign_up/sign_up.dart';
import 'package:local_mining_supplier/view/splash/splash.dart';

import '../view/login/login.dart';
import 'error_page.dart';
import 'login_state_check.dart';

class AppRoutes {
  static const initialScreen = "startup";
  static const homeScreen = "dashboard";
  static const loginScreen = "login";
  static const signUpScreen = "signup";
}

class AppPaths {
  static const initialPath = "/";
  static const homepath = "/dashboard";
  static const loginPath = "/login";
  static const signUpPath = "/signup";
}

class MyRouter {
  final LoginState loginState;

  MyRouter(this.loginState);

  late final GoRouter routes = GoRouter(
      initialLocation: "/",
      refreshListenable: loginState,
      redirect: (context, GoRouterState state) {
        final loggedIn = loginState.loggedIn;
        final goingToLogin = state.location == AppPaths.loginPath;
        final goingToSignup = state.location == AppPaths.signUpPath;
        if (goingToSignup) {
          return AppPaths.signUpPath;
        } else if (!loggedIn && !goingToLogin) {
          return AppPaths.initialPath;
        } else if (loggedIn && goingToLogin) {
          return AppPaths.homepath;
        } else {
          return null;
        }

        //ScholarshipQuiz
      },
      routes: <RouteBase>[
        GoRoute(
          name: AppRoutes.initialScreen,
          path: AppPaths.initialPath,
          pageBuilder: (context, state) {
            return MaterialPage(child: SplashScreen());
          },
        ),
        GoRoute(
          name: AppRoutes.loginScreen,
          path: AppPaths.loginPath,
          pageBuilder: (context, state) {
            return MaterialPage(child: LoginScreen());
          },
        ),
        GoRoute(
          name: AppRoutes.signUpScreen,
          path: AppPaths.signUpPath,
          pageBuilder: (context, state) {
            return MaterialPage(child: SignUpScreen());
          },
        ),
        GoRoute(
          name: AppRoutes.homeScreen,
          path: AppPaths.homepath,
          pageBuilder: (context, state) {
            return MaterialPage(child: HomeScreen());
          },
        ),
      ],
      errorPageBuilder: (context, state) {
        return MaterialPage(key: state.pageKey, child: ErrorPage());
      });
}
