import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_app/provider/my_provider.dart';
import 'package:food_app/screen/cart_page.dart';
import 'package:food_app/screen/detail_page.dart';
import 'package:food_app/screen/login_page.dart';
import 'package:food_app/screen/welcome_page.dart';
import 'package:food_app/screen/sign_up.dart';
import 'package:food_app/screen/home_page.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) =>MyProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: Color(0xff2b2b2b),
          appBarTheme: AppBarTheme(
            color: Color(0xff2b2b2b),
          ),

        ),
        home: StreamBuilder(
          stream:  FirebaseAuth.instance.authStateChanges(),
          builder: (index,snapshot){
            if(snapshot.hasData){
              return HomePage();
            }
            else {
              return WelcomePage();
            }
          },),
      ),
    );
  }
}


