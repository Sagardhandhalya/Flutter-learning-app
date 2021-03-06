import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter101/screens/cart/cart_page.dart';
import 'package:flutter101/screens/login/login.dart';
import 'package:flutter101/services/auth_service.dart';
import 'package:flutter101/services/firestore_service.dart';
import 'package:flutter101/theme.dart';
import 'package:provider/provider.dart';
import 'screens/Home/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<AuthService>(
            create: (context) => AuthService(FirebaseAuth.instance),
          ),
          Provider<FireStoreService>(
            create: (_) => FireStoreService(
              FirebaseFirestore.instance,
            ),
          ),
          StreamProvider<User?>(
              initialData: null,
              create: (context) => context.read<AuthService>().authStateChanges)
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: MyTheme.lightTheme(context),
          home: const AuthContainer(),
          navigatorObservers: <NavigatorObserver>[observer],
          routes: {
            '/home': (context) => const Home(),
            '/login': (context) => const Login(),
            '/cart': (context) => const Cart()
          },
        ));
  }
}

class AuthContainer extends StatelessWidget {
  const AuthContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    // final firebaseUser = Provider.of<User?>(context);
    if (firebaseUser != null) {
      return const Home();
    } else {
      return const Login();
    }
  }
}
