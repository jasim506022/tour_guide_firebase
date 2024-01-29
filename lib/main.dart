import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tour_guides_firebase/const/approutes.dart';
import 'package:tour_guides_firebase/page/auth/signuppage.dart';
import 'package:tour_guides_firebase/page/homepage.dart';
import 'package:tour_guides_firebase/page/splashpage.dart';
import 'package:tour_guides_firebase/service/provider/loadingprovider.dart';

import 'const/const.dart';
import 'page/auth/signinpage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;
  // _initializerFirebase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return MultiProvider(
      providers: [
        Provider<LoadingProvider>(create: (_) => LoadingProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(),
        initialRoute: AppRouters.homepage,
        routes: {
          AppRouters.signPage: (context) => const SigninPage(),
          AppRouters.signupPage: (context) => const SignUpScreen(),
          AppRouters.homepage: (context) => const HomePage(),
          AppRouters.splashPage: (context) => const SplashPage(),
        },
      ),
    );
  }
}

// _initializerFirebase() async {
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
// }
