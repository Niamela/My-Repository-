import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:local_mining_supplier/flutter_gen/gen_l10n/app_localizations.dart';
import 'package:local_mining_supplier/provider/locale_provider.dart';
import 'package:local_mining_supplier/router/login_state_check.dart';
import 'package:local_mining_supplier/router/routes.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:url_strategy/url_strategy.dart';

import 'controllers/google_signin_provider.dart';

Future<void> main() async {
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyAHkMtxcfGPIYBpzkTG_ETr8KO7kmZNNEc",
          appId: "1:783100640985:web:008a904a33ac42e72148c8",
          messagingSenderId: "783100640985",
          projectId: "local-mining-supplier",
          storageBucket: "local-mining-supplier.appspot.com"));
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  final state = LoginState(await SharedPreferences.getInstance());
  state.checkLoggedIn();
  runApp(MyApp(
    loginState: state,
  ));
}

MaterialColor goldenSwatch = MaterialColor(
  0xFFB8860B, // This is a golden color (Hex: B8860B)
  <int, Color>{
    50: Color(0xFFFFD700), // Lightest
    100: Color(0xFFDAA520),
    200: Color(0xFFB8860B),
    300: Color(0xFFCD7F32),
    400: Color(0xFF8B6914),
    500: Color(0xFFB8860B), // Middle shade
    600: Color(0xFFA67C00),
    700: Color(0xFF836FFF),
    800: Color(0xFF5C5C3D),
    900: Color(0xFF2E2E1F), // Darkest
  },
);

class MyApp extends StatelessWidget {
  final LoginState loginState;

  MyApp({required this.loginState});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<LoginState>(
            lazy: false,
            create: (BuildContext createContext) => loginState,
          ),
          Provider<MyRouter>(
            lazy: false,
            create: (BuildContext createContext) => MyRouter(loginState),
          ),
        ],
        child: Sizer(builder: (context, orientation, deviceType) {
          final router = Provider.of<MyRouter>(context, listen: false).routes;
         return ChangeNotifierProvider(
              create: (context) => LocaleProvider(),
              builder: (context, child) {
                return Consumer<LocaleProvider>(
                    builder: (context, provider, child) {
                  return GetMaterialApp.router(
                    routerDelegate: router.routerDelegate,
                    routeInformationProvider: router.routeInformationProvider,
                    routeInformationParser: router.routeInformationParser,
                    title: 'Local Mining Supplier',
                    localizationsDelegates:
                        AppLocalizations.localizationsDelegates,
                    supportedLocales: AppLocalizations.supportedLocales,
                    locale:provider.locale,
                    debugShowCheckedModeBanner: false,
                    theme: ThemeData(
                        primarySwatch: goldenSwatch,
                        primaryColor: Colors.white,
                        textTheme: TextTheme(
                            subtitle1: TextStyle(color: Color(0xFFA67C00)))),
                  );
                });
              });
        }),
      ),
    );
  }
}
