import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'login_state_check.dart';

class ErrorPage extends StatelessWidget {
  final Exception? error;
  late String message;

  void saveLoginOutState(BuildContext context) {
    Provider.of<LoginState>(context, listen: false).loggedIn = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: InkWell(
                onTap: () {
                  // logOut(context);
                  saveLoginOutState(context);
                  GoRouter.of(context).pushReplacement('/');
                },
                child: Text(message))
        )
    );
  }

  ErrorPage({Key? key, this.error, }) : super(key: key) {
    if (error != null) {
      message = error.toString();
    } else {
      message = 'Please click here';
    }
  }

}