import 'package:flutter/material.dart';
import 'package:netninja/widget/custom_shape.dart';
import 'package:netninja/widget/responsive_ui.dart';
import 'package:netninja/home_screens/home.dart';
import 'package:netninja/services/auth.dart';
import '../constants.dart';


class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignInScreen(),
    );
  }
}

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  String _email ='';
  String _password ='';
  String error ='';
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> _key = GlobalKey();
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large =  ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium =  ResponsiveWidget.isScreenMedium(_width, _pixelRatio);

    return Material(
      child: Container(
        height: _height,
        width: _width,
        //  padding: EdgeInsets.only(bottom: 1),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              clipShape(),
              welcomeTextRow(),
              signInTextRow(),
              form(),
              SizedBox(height: 6.0),
              Text(error,style: TextStyle(color: Colors.red,fontSize: 14.0),),
              SizedBox(height: 6.0),
              signUpTextRow(),
              SizedBox(height: 12.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget clipShape() {
    //double height = MediaQuery.of(context).size.height;
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: 0.75,
          child: ClipPath(
            clipper: CustomShapeClipper(),
            child: Container(
              height:_large? _height/4 : (_medium? _height/3.75 : _height/3.5),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [ const Color(0xFF84C442),const Color(0xFF1461A9)],
                ),
              ),
            ),
          ),
        ),
        Opacity(
          opacity: 0.5,
          child: ClipPath(
            clipper: CustomShapeClipper2(),
            child: Container(
              height: _large? _height/4.5 : (_medium? _height/4.25 : _height/4),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [const Color(0xFF84C442),const Color(0xFF1461A9)],
                ),
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.only(top: _large? _height/20 : (_medium? _height/15 : _height/10)),

          child: Image.asset(
            'assets/images/logopng1.png',
            height:  220,
            width: 170,
          ),
        ),
      ],
    );
  }


  final Shader linearGradient = LinearGradient(
    colors: <Color>[const Color(0xFF84C442),const Color(0xFF1461A9)],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));


  Widget welcomeTextRow() {
    return Container(
      margin: EdgeInsets.only(left: _width / 20, top: _height / 100),
      child: Row(
        children: <Widget>[
          RichText(
            text: TextSpan(
              text: 'CARE ',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: _large? 60 : (_medium? 50 : 40),
                  foreground: Paint()..shader = linearGradient
              ),
              children: <TextSpan>[
                TextSpan(text: 'CROP', style: TextStyle(fontWeight: FontWeight.bold,foreground: Paint()..shader = linearGradient)),
              ],
            ),
          ),

        ],
      ),
    );
  }

  Widget signInTextRow() {
    return Container(
      margin: EdgeInsets.only(left: _width / 15.0),
      child: Row(
        children: <Widget>[
          Text(
            "Sign in to your account",
            style: TextStyle(
              fontWeight: FontWeight.w200,
              fontSize: _large? 20 : (_medium? 17.5 : 15),
            ),
          ),
        ],
      ),
    );
  }

  Widget form() {
    return Container(
      margin: EdgeInsets.only(
          left: _width / 12.0,
          right: _width / 12.0,
          top: _height / 15.0),
      child: Form(
        key: _key,
        child: Column(
          children: <Widget>[
            emailTextFormField(),
            SizedBox(height: _height / 40.0),
            passwordTextFormField(),
            SizedBox(height: _height / 12),
            button(),
          ],
        ),
      ),
    );
  }

  Widget emailTextFormField() {

    return Material(
      borderRadius: BorderRadius.circular(30.0),
      elevation: _large? 12 : (_medium? 10 : 8),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        controller: emailController,
        cursorColor:Color(0xFFF89820),
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.person, color: Color(0xFFF89820), size: 20),
          hintText: "E-mail",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none),
        ),
        onChanged: (value){
          setState(() => _email = value );
        },
        validator: (value) {
          if (value.isEmpty) {
            return "ERROR";
          }
          return null;
        },
      ),);

  }

  Widget passwordTextFormField() {
    return Material(
      borderRadius: BorderRadius.circular(30.0),
      elevation: _large? 12 : (_medium? 10 : 8),
      child: TextFormField(
        obscureText: true,
        controller: passwordController,
        cursorColor: Color(0xFFF89820),
        onChanged: (value){
          setState(() => _password = value );
        },
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock, color: Color(0xFFF89820), size: 20),
          hintText: "Password",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none),
        ),
      ),);
  }

  Widget button() {
    return RaisedButton(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      onPressed: () async{
        if(_key.currentState.validate()){
          dynamic result = await _auth.signInWithEmailAndPassword(_email, _password);
          Scaffold
              .of(context)
              .showSnackBar(SnackBar(content: Text('Processing Data')));
          if(result == null){
            setState(() => error ="Can't SignIn with thoes Cedentials!");
            return null;
          }
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Home()),
          );
        }
        // Validate returns true if the form is valid, otherwise false.
//        if (_key.currentState.validate()) {
//          dynamic result = await _auth.signInWithEmailAndPassword(_email, _password);
//          // If the form is valid, display a snackbar. In the real world,
//          // you'd often call a server or save the information in a database.
//          if (result == null){
//            setState(() {
//              error = "couldn't signin with thoes cedentials!";
//            });
//          }
//          Navigator.push(
//            context,
//            MaterialPageRoute(builder: (context) => Home()),
//          );
//
//
//          Scaffold
//              .of(context)
//              .showSnackBar(SnackBar(content: Text('Processing Data')));
//        }
      },
      textColor: Colors.white,
      padding: EdgeInsets.all(0.0),
      child: Container(
        alignment: Alignment.center,
        width: _large? _width/4 : (_medium? _width/3.75: _width/3.5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            color: Color(0xFFF89820)
        ),
        padding: const EdgeInsets.all(12.0),
        child: Text('SIGN IN',style: TextStyle(fontSize: _large? 14: (_medium? 12: 10))),
      ),
    );
  }

  Widget signUpTextRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 120.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Don't have an account?",
            style: TextStyle(fontWeight: FontWeight.w400,fontSize: _large? 17: (_medium? 15: 13)),
          ),
          SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(SIGN_UP);
              print("Routing to Sign up screen");
            },
            child: Text(
              "Sign up",
              style: TextStyle(
                  fontWeight: FontWeight.w800, color: Color(0xFFF89820), fontSize: _large? 19: (_medium? 17: 15)),
            ),
          )
        ],
      ),
    );
  }

}