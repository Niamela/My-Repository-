import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:local_mining_supplier/view/home/home.dart';
import 'package:local_mining_supplier/view/profile/profile.dart';
import 'package:local_mining_supplier/view/profile/supplier_profile.dart';
import 'package:local_mining_supplier/view/searchpage/searchpage.dart';
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
  static const userProfileScreen = "userprofile";
  static const supplierProfileScreen = "supplier";
  static const searchpage = "searchpage";
}

class AppPaths {
  static const initialPath = "/";
  static const homepath = "/dashboard";
  static const loginPath = "/login";
  static const signUpPath = "/signup";
  static const userProfilePath = "/userprofile";
  static const supplierProfilePath = "/supplier";
  static const searchPath = "/searchpage";
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
        // if (goingToSignup && !loggedIn) {
        //   return AppPaths.signUpPath;
        // } else if (!loggedIn && !goingToLogin) {
        //   return AppPaths.initialPath;
        // } else
        if (loggedIn && (goingToLogin || goingToSignup)) {
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
          name: AppRoutes.searchpage,
          path: AppPaths.searchPath,
          pageBuilder: (context, state) {
            return MaterialPage(child:UserSearchPage());
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
        GoRoute(
          name: AppRoutes.userProfileScreen,
          path: AppPaths.userProfilePath,
          pageBuilder: (context, state) {
            return MaterialPage(child: ProfileScreen());
          },
        ),
        GoRoute(
          name: AppRoutes.supplierProfileScreen,
          path: AppPaths.supplierProfilePath,
          pageBuilder: (context, state) {
            return MaterialPage(child: SupplierProfile());
          },
        ),
      ],
      errorPageBuilder: (context, state) {
        return MaterialPage(key: state.pageKey, child: ErrorPage());
      });
}
