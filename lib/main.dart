import 'package:chat_app/utils/constants.dart';
import 'package:chat_app/utils/providers/provider_list.dart';
import 'package:chat_app/utils/routes/navigations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: Constants.apikey,
          appId: Constants.appId,
          messagingSenderId: Constants.messagingSenderId,
          projectId: Constants.projectId),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: ProviderList.provider,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "ChatApp",
        routes: Navigations.routes(),
        initialRoute: Navigations.splashScreen,
        navigatorKey: Navigations.navigatorKey,
      ),
    );
  }
}
