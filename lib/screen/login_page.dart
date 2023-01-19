import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app/screen/home_page.dart';
import 'package:food_app/screen/sign_up.dart';
import 'package:food_app/screen/welcome_page.dart';
import 'package:food_app/screen/widget/my_text_feild.dart';

class LoginPage extends StatefulWidget {
  static Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool loadding = false;
  RegExp regExp = RegExp(LoginPage.pattern.toString());
  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();
  late UserCredential userCredential;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future loginAuth() async {
    try {
      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text, password: password.text);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        final snackBar =
            SnackBar(content: Text("No user found for that email."));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else if (e.code == 'wrong-password') {
        final snackBar =
            SnackBar(content: Text("Wrong password provided for that user."));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        setState(() {
          loadding = false;
        });
      }
    }
    setState(() {
      loadding = false;
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomePage()));
    });
  }
  void validation(){

    if(email.text.trim().isEmpty || email.text.trim() == null && password.text.trim().isEmpty || password.text.trim() == null ){
      final snackBar =
      SnackBar(content: Text("All field is empty."));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }
    if(email.text.trim().isEmpty || email.text.trim() == null){
      final snackBar =
      SnackBar(content: Text("Email is empty."));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }
    else if (!regExp.hasMatch(email.text)) {
      final snackBar =
      SnackBar(content: Text("Please enter valid email."));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }
    if(password.text.trim().isEmpty || password.text.trim() == null){
      final snackBar =
      SnackBar(content: Text("Password is empty."));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return ;
    }
    else {
      setState(() {
        loadding = true;
      });
      loginAuth();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => WelcomePage()));
          },
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 200),
              child: Text(
                "Login ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MyTextFeild(
                    controller: email, hintText: "Email", obscureText: false),
                SizedBox(
                  height: 30,
                ),
                MyTextFeild(
                    controller: password,
                    hintText: "password",
                    obscureText: true),
              ],
            ),
            loadding? CircularProgressIndicator():Container(
              width: 200,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  validation();
                  print(loadding);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.red,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(30.0))),
                ),
                child: Text(
                  "Login",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "New user?",
                  style: TextStyle(color: Colors.grey),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) =>SignUp()));
                  },
                  child: Text(
                    "Register now",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
