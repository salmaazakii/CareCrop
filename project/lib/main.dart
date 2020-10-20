import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:netninja/models/user.dart';
import 'package:netninja/services/auth.dart';
import 'package:netninja/widget/splashscreen.dart';
import 'package:netninja/wrapper.dart';
import 'authentication/signin.dart';
import 'authentication/signup.dart';
import 'constants.dart';
import 'models/user.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return StreamProvider<User>.value(
      value : AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Login",
        theme: ThemeData(primaryColor: Colors.orange[200]),
        routes: <String, WidgetBuilder>{
          SPLASH_SCREEN: (BuildContext context) =>  SplashScreen(),
          SIGN_IN: (BuildContext context) =>  SignInPage(),
          SIGN_UP: (BuildContext context) =>  SignUpScreen(),
          WRAPPER: (BuildContext context) => Wrapper(),
        },
        initialRoute: SPLASH_SCREEN,
      ),
    );
  }
}