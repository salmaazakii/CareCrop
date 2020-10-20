import 'package:flutter/material.dart';
import 'package:netninja/home_screens/home.dart';
import 'package:netninja/services/auth.dart';
import 'package:netninja/widget/custom_shape.dart';
import 'package:netninja/widget/customappbar.dart';
import 'package:netninja/widget/responsive_ui.dart';



class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  String _email ='';
  String _password ='';
  String error='';
  bool checkBoxValue = false;
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;
  String _currentFName;
  String _currentLName;
  int _currentWeight;
  int _currentHeight;
  int _currentAge;
  int _currentPhone;
  String _selectedType;
  GlobalKey<FormState> _key = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController bloodController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  final AuthService _auth = AuthService();

  final List<String> bloodTypes = ['A','B','AB','O'];

  @override
  Widget build(BuildContext context) {

    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large =  ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium =  ResponsiveWidget.isScreenMedium(_width, _pixelRatio);



    return Material(
      child: Scaffold(
        body: Container(
          height: _height,
          width: _width,
          margin: EdgeInsets.only(bottom: 5),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Opacity(opacity: 0.88,child: CustomAppBar()),
                clipShape(),
                form(),
                SizedBox(height: 12.0),
                Text(error,style: TextStyle(color: Colors.red,fontSize: 14.0),),
                //signInTextRow(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget clipShape() {
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: 0.75,
          child: ClipPath(
            clipper: CustomShapeClipper(),
            child: Container(
              height: _large? _height/8 : (_medium? _height/7 : _height/6.5),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [const Color(0xFF84C442),const Color(0xFF1461A9)],
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
              height: _large? _height/12 : (_medium? _height/11 : _height/10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [const Color(0xFF84C442),const Color(0xFF1461A9)],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget form() {
    return Container(
      margin: EdgeInsets.only(
          left:_width/ 12.0,
          right: _width / 12.0,
          top: _height / 20.0),
      child: Form(
        key: _key,
        child: Column(
          children: <Widget>[
            firstNameTextFormField(),
            SizedBox(height: _height / 60.0),
            lastNameTextFormField(),
            SizedBox(height: _height/ 60.0),
            emailTextFormField(),
            SizedBox(height: _height / 60.0),
            passwordTextFormField(),
            SizedBox(height: _height / 60.0),
            Row(
              children: <Widget>[
               Expanded( child: heightTextFormField()),
                SizedBox(width: _width/ 50.0),
                Expanded( child: weightTextFormField()),
              ],
            ),
            SizedBox(height: _height / 60.0),
            ageTextFormField(),
            SizedBox(height: _height / 60.0),
            bloodTextFormField(),
            SizedBox(height: _height / 60.0),
            phoneTextFormField(),
            SizedBox(height: _height/35,),
            button(),
          ],
        ),
      ),
    );
  }

  Widget firstNameTextFormField() {
    return Material(
      borderRadius: BorderRadius.circular(30.0),
      elevation: _large? 12 : (_medium? 10 : 8),
      child: TextFormField(
        onChanged: (val) => setState(()=> _currentFName = val ),
        controller: firstNameController,
        cursorColor: Color(0xFFF89820),
        validator: (value) => value.isEmpty
            ? 'Enter Your Name'
            : RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(value)
            ? 'Enter a Valid Name'
            : null,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.person, color:Color(0xFFF89820), size: 20),
          hintText: "First Name",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none),
        ),
      ),);
  }

  Widget lastNameTextFormField() {
    return Material(
      borderRadius: BorderRadius.circular(30.0),
      elevation: _large? 12 : (_medium? 10 : 8),
      child: TextFormField(
        onChanged: (val) => setState(()=> _currentLName = val ),
        controller: lastNameController,
        cursorColor: Color(0xFFF89820),
        validator: (value) => value.isEmpty
            ? 'Enter Your Name'
            : RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(value)
            ? 'Enter a Valid Name'
            : null,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.person, color: Color(0xFFF89820), size: 20),
          hintText: "Last Name",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none),
        ),
      ),);
  }

  Widget emailTextFormField() {
    return Material(
      borderRadius: BorderRadius.circular(30.0),
      elevation: _large? 12 : (_medium? 10 : 8),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        controller: emailController,
        cursorColor: Color(0xFFF89820),
        onChanged: (value){
          setState(() {
            _email = value;
          });
        },
        validator: (value) => value.isEmpty
            ? 'Enter Your Email'
            : RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)
            ? null
            : "Enter a Valid Email",
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.email, color: Color(0xFFF89820), size: 20),
          hintText: "Email",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none),
        ),
      ),);
  }

  Widget heightTextFormField(){
    return Material(
      borderRadius: BorderRadius.circular(30.0),
      elevation: _large? 12 : (_medium? 10 : 8),
      child: TextFormField(
        onChanged: (val) => setState(()=> _currentHeight = int.parse(val) ),
        controller: heightController,
        cursorColor: Color(0xFFF89820),
        keyboardType: TextInputType.number,
        validator: (value) => value.isEmpty
            ? 'Enter Your height'
            : RegExp(r"^[a-zA-Z]").hasMatch(value)
            ? 'Enter a valid Height'
            : !(int.parse(value)>110 && int.parse(value)<220)
            ? 'Enter a Valid height'
            : null,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.accessibility_new, color: Color(0xFFF89820), size: 20),
          hintText: "Height",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none),
        ),
      ),);

  }

  Widget weightTextFormField(){
    return Material(
      borderRadius: BorderRadius.circular(30.0),
      elevation: _large? 12 : (_medium? 10 : 8),
      child: TextFormField(
        onChanged: (val) => setState(()=> _currentWeight = int.parse(val) ),
        controller: weightController,
        cursorColor:Color(0xFFF89820),
        keyboardType: TextInputType.number,
        validator: (value) => value.isEmpty
            ? 'Enter Your weight'
            : RegExp(r"^[a-zA-Z]").hasMatch(value)
            ? 'Enter a valid weight'
            : !(int.parse(value)>45 && int.parse(value)<200)
            ? 'Enter a Valid weight'
            : null,
        decoration: InputDecoration(
          hintText: "Weight",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none),
        ),
      ),);

  }

  Widget ageTextFormField(){
    return Material(
      borderRadius: BorderRadius.circular(30.0),
      elevation: _large? 12 : (_medium? 10 : 8),
      child: TextFormField(
        onChanged: (val) => setState(()=> _currentAge = int.parse(val) ),
        controller: ageController,
        keyboardType: TextInputType.number,
        cursorColor:Color(0xFFF89820),
        validator: (value) => value.isEmpty
            ? 'Enter Your Age'
            : RegExp(r"^[a-zA-Z]").hasMatch(value)
            ? 'Enter a valid Age'
            : !(int.parse(value)>12 && int.parse(value)<100)
            ? 'Enter a Valid Age'
            : null,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.calendar_today, color: Color(0xFFF89820), size: 20),
          hintText: "Age",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none),
        ),
      ),);

  }

  Widget bloodTextFormField(){
    return Material(
        borderRadius: BorderRadius.circular(30.0),
        elevation: _large? 12 : (_medium? 10 : 8),
     child:  DropdownButtonFormField<String>(
       decoration: InputDecoration(
         hintText: "Select your Blood Type",
         border: OutlineInputBorder(
             borderRadius: BorderRadius.circular(30.0),
             borderSide: BorderSide.none),
       ),
       value: _selectedType ?? 'AB',
       onChanged: (newValue) {
         setState(() {
           _selectedType = newValue;
         });
       },
        items: bloodTypes.map((String value) {
        return new DropdownMenuItem<String>(
          value: value,
          child: new Text(value),
        );
      }).toList(),
    ));


  }

  Widget phoneTextFormField() {
    return Material(
      borderRadius: BorderRadius.circular(30.0),
      elevation: _large? 12 : (_medium? 10 : 8),
      child: TextFormField(
        onChanged: (val) => setState(()=> _currentPhone = int.parse(val) ),
        controller: phoneController,
        cursorColor: Color(0xFFF89820),
        keyboardType: TextInputType.number,
        validator: (value) => value.isEmpty
            ? 'Enter Your Phone Number'
            : value.length != 11
            ? 'Enter a valid Phone Number'
            : null,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.phone, color: Color(0xFFF89820), size: 20),
          hintText: "Phone Number",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none),
        ),
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
          setState(() {
            _password = value;
          });
        },
        validator: (value) => value.isEmpty
            ? 'Enter Your Password'
            : ! RegExp(r'^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{6,}$').hasMatch(value)
            ? 'At least (one letter,one number,six char)'
            : null,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock, color:Color(0xFFF89820), size: 20),
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
      onPressed: () async {
        if( _key.currentState.validate()){
          dynamic result = await _auth.registerWithEmailAndPassword(_email, _password,_currentFName,
            _currentLName,_selectedType,_currentPhone,_currentAge,_currentWeight,_currentHeight);
          if(result == null){
            setState(() => error = "Can't Sign up! Please try again");
          }
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Home()),
          );
        }
      },
      textColor: Colors.white,
      padding: EdgeInsets.all(0.0),
      child: Container(
        alignment: Alignment.center,
//        height: _height / 20,
        width:_large? _width/4 : (_medium? _width/3.75: _width/3.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
            color: Color(0xFFF89820),

        ),
        padding: const EdgeInsets.all(12.0),
        child: Text('SIGN UP', style: TextStyle(fontSize: _large? 14: (_medium? 12: 10)),),
      ),
    );
  }

}
