import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../router/login_state_check.dart';
import '../router/routes.dart';

const String loggedInKey = 'LoggedIn';
const mainColor = Colors.blueGrey;

void saveLoginState(BuildContext context) {
  Provider.of<LoginState>(context, listen: false).loggedIn = true;
}

void saveLoginOutState(BuildContext context) {
  Provider.of<LoginState>(context, listen: false).loggedIn = false;
}

final companyLogo = "assets/mining_black_white.PNG";

Widget topMenuBar(context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    mainAxisSize: MainAxisSize.max,
    children: [
      Image.asset(
        companyLogo,
        scale: 3,
      ),
      GoRouter.of(context).location == AppPaths.loginPath
          ? TextButton(
              onPressed: () {
                GoRouter.of(context).push(AppPaths.signUpPath);
              },
              child: Text("Sign up"))
          : Container()
    ],
  );
}
