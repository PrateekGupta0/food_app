import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_app/screen/welcome_page.dart';
import 'package:food_app/screen/widget/my_text_feild.dart';

import 'login_page.dart';


class SignUp extends StatefulWidget {
  static Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  const SignUp({super.key});
  @override
  _SignUpState createState() => _SignUpState();
}
class _SignUpState extends State<SignUp> {
  bool change=false;
  bool loading=false;
  late UserCredential userCredential;
  RegExp regExp = RegExp(SignUp.pattern.toString());
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  Future sendData() async {
    try {
      userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      await FirebaseFirestore.instance
          .collection('userData')
          .doc(userCredential.user?.uid)
          .set({
        "firstName": firstName.text.trim(),
        "lastName": lastName.text.trim(),
        "email": email.text.trim(),
        "userid": userCredential.user?.uid,
        "password": password.text.trim(),
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        final snackBar = SnackBar(
            content: Text("The password provided is too weak."));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

      } else if (e.code == 'email-already-in-use') {
        final snackBar = SnackBar(
            content: Text("The account already exists for that email"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

      }
    } catch (e) {
          final snackBar = SnackBar(
            content: Text(e.toString()));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

      setState(() {
        loading=false;
      });
    }
    setState(() {
      loading=false;
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginPage()));
    });
  }

  void validation(BuildContext context) {
    if (firstName.text.trim().isEmpty || firstName.text.trim() == null) {
      final snackBar = SnackBar(
            content: Text("firstName is Empty"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

      return;
    }
    if (lastName.text.trim().isEmpty || lastName.text.trim() == null) {
    final snackBar = SnackBar(
            content: Text("lastName is Empty"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

      return;
    }
    if (email.text.trim().isEmpty || email.text.trim() == null) {
    final snackBar = SnackBar(
            content: Text("Email is Empty"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

      return;
    } else if (!regExp.hasMatch(email.text)) {
    final snackBar = SnackBar(
            content: Text("Please enter vaild Email"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

      return;
    }
    if (password.text.trim().isEmpty || password.text.trim() == null) {
    final snackBar = SnackBar(
            content: Text("Password is empty."));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

      return;
    } else {
      setState(() {
        loading=true;
      });
      sendData();
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: globalKey,
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 50,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Sign Up",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 40),
              ),
              Column(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyTextFeild(controller:firstName,hintText: "firstName",obscureText: false,),
                  SizedBox(height: 15.0,),
                  MyTextFeild(controller:lastName,hintText: "lastName",obscureText: false,),
                  SizedBox(height: 15.0,),
                  MyTextFeild(controller:email,hintText: "Email",obscureText: false,),
                  SizedBox(height: 15.0,),
                  MyTextFeild(controller:password,hintText: "password",obscureText: true,),
                  SizedBox(height: 15.0,),
                ],
              ),
              loading ?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                    ],
                  )
                  :Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: (){
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => WelcomePage()));
                      },
                      child: Text('Cancel',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25.0,
                        ),),
                      style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Colors.white,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(30.0))),

                      ),
                    ),
                  ),
                  SizedBox(width: 25.0,),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: (){
                        validation(context);

                      },
                      child: Text('Register',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25.0,
                        ),),
                      style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Colors.red,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(30.0))),

                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}





