import 'package:flutter/material.dart';
import 'package:food_app/screen/login_page.dart';
import 'package:food_app/screen/sign_up.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);
  Widget button(
      {required String name, required Color color, required Color textcolor,required VoidCallback onTap}) {
    return Container(
      height: 60,
      width: 300,
      child: ElevatedButton(
        onPressed: onTap,
        child: Text(
          name,
          style: TextStyle(
            color: textcolor,
          ),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(color),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.green,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(30.0))),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: Container(
            color: Colors.blue,
            child: Center(
              child: Image.asset('images/logo.jpg'),
            ),
          )),
          Expanded(
              child: Container(
                  child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Welcome To Tastee',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                  fontSize: 30,
                ),
              ),
              Column(
                children: [
                  Text("Order food from our restaueant and"),
                  Text("Make reservation in real-time"),
                ],
              ),
              button(
                onTap: (){
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                  name: 'Login', color: Colors.green, textcolor: Colors.white),
              button(
                  onTap: (){
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => SignUp()));
                  },
                  name: 'SignUp', color: Colors.white, textcolor: Colors.green),
            ],
          ))),
        ],
      ),
    );
  }
}
