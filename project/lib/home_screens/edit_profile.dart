import 'package:flutter/material.dart';
import 'package:netninja/models/user.dart';
import 'package:netninja/services/database.dart';
import 'package:netninja/widget/responsive_ui.dart';
import 'package:provider/provider.dart';

class EditProf extends StatefulWidget {
  @override
  _EditProfState createState() => _EditProfState();
}

class _EditProfState extends State<EditProf> {

  GlobalKey<FormState> _key = GlobalKey();
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;
  String _selectedType;
  String _currentFName;
  String _currentLName;
  int _currentWeight;
  int _currentHeight;
  int _currentAge;
  int _currentPhone;

  final List<String> bloodTypes = ['A','B','AB','O'];

  @override
  Widget build(BuildContext context) {

     _height = MediaQuery.of(context).size.height;
     _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large =  ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium =  ResponsiveWidget.isScreenMedium(_width, _pixelRatio);

     final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseServices(uid: user.uid).userData,
        builder:(context,snapshot){
        if(snapshot.hasData) {
          UserData userData = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              title: Text('Settings', style: TextStyle(fontSize: 25.0),),
              elevation: 0.0,
              flexibleSpace: Container(
                width: _width,
                height: _height,
                padding: EdgeInsets.only(left: 15, top: 25),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [const Color(0xFF84C442), const Color(0xFF1461A9)]
                  ),),),),
            body: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(
                    left:_width/ 12.0,
                    right: _width / 12.0,
                    top: _height / 20.0),
                child: Form(
                  key: _key,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        onChanged: (val) => setState(()=> _currentFName = val ),
                        initialValue: userData.firstName,
                        //controller: firstNameController,
                        cursorColor: Color(0xFF1461A9),
                        validator: (value) => value.isEmpty
                            ? 'Enter Your Name'
                            : RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(value)
                            ? 'Enter a Valid Name'
                            : null,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person, color:Color(0xFF1461A9), size: 20),
                          hintText: "First Name",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: new BorderSide(color: Color(0xFF1461A9))),
                        ),
                      ),
                      SizedBox(height: _height / 60.0),
                      TextFormField(
                        onChanged: (val) => setState(()=> _currentLName = val ),
                        initialValue: userData.lastName,
                        cursorColor: Color(0xFF1461A9),
                        validator: (value) => value.isEmpty
                            ? 'Enter Your Name'
                            : RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(value)
                            ? 'Enter a Valid Name'
                            : null,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person, color: Color(0xFF1461A9), size: 20),
                          hintText: "Last Name",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide(color: Color(0xFF1461A9))),
                        ),
                      ),
                      SizedBox(height: _height / 60.0),
                      TextFormField(
                        onChanged: (val) => setState(()=> _currentHeight = int.parse(val)),
                        initialValue: (userData.height).toString(),
                        cursorColor: Color(0xFF1461A9),
                        keyboardType: TextInputType.number,
                        validator: (value) => value.isEmpty
                            ? 'Enter Your height'
                            : RegExp(r"^[a-zA-Z]").hasMatch(value)
                            ? 'Enter a valid Height'
                            : !(int.parse(value)>110 && int.parse(value)<220)
                            ? 'Enter a Valid height'
                            : null,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.accessibility_new, color: Color(0xFF1461A9), size: 20),
                          hintText: "Height",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide(color: Color(0xFF1461A9))),
                        ),
                      ),
                      SizedBox(height: _height / 60.0),
                      TextFormField(
                        onChanged: (val) => setState(()=> _currentWeight = int.parse(val)),
                        initialValue: (userData.weight).toString(),
                        cursorColor:Color(0xFF1461A9),
                        keyboardType: TextInputType.number,
                        validator: (value) => value.isEmpty
                            ? 'Enter Your weight'
                            : RegExp(r"^[a-zA-Z]").hasMatch(value)
                            ? 'Enter a valid weight'
                            : !(int.parse(value)>45 && int.parse(value)<200)
                            ? 'Enter a Valid weight'
                            : null,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.spa, color: Color(0xFF1461A9), size: 20),
                          hintText: "Weight",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide(color: Color(0xFF1461A9))),
                        ),
                      ),
                      SizedBox(height: _height / 60.0),
                      TextFormField(
                        onChanged: (val) => setState(()=> _currentAge = int.parse(val)),
                        initialValue: (userData.age).toString(),
                        keyboardType: TextInputType.number,
                        cursorColor:Color(0xFF1461A9),
                        validator: (value) => value.isEmpty
                            ? 'Enter Your Age'
                            : RegExp(r"^[a-zA-Z]").hasMatch(value)
                            ? 'Enter a valid Age'
                            : !(int.parse(value)>12 && int.parse(value)<100)
                            ? 'Enter a Valid Age'
                            : null,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.calendar_today, color: Color(0xFF1461A9), size: 20),
                          hintText: "Age",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide(color: Color(0xFF1461A9))),
                        ),
                      ),
                      SizedBox(height: _height / 60.0),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.whatshot, color: Color(0xFF1461A9), size: 20),
                          hintText: "Select your Blood Type",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide(color: Color(0xFF1461A9))),
                        ),
                        value: _selectedType ?? userData.blood.toString(),
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
                      ),
                      SizedBox(height: _height / 60.0),
                      TextFormField(
                        initialValue: (userData.phoneNumber).toString(),
                        onChanged: (val) => setState(()=> _currentPhone = int.parse(val)),
                        cursorColor: Color(0xFF1461A9),
                        keyboardType: TextInputType.number,
                        validator: (value) => value.isEmpty
                            ? 'Enter Your Phone Number'
                            : value.length != 11
                            ? 'Enter a valid Phone Number'
                            : null,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.phone, color: Color(0xFF1461A9), size: 20),
                          hintText: "Phone Number",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide(color: Color(0xFF1461A9))),
                        ),
                      ),
                      SizedBox(height: _height /20.0,),
                      RaisedButton(
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                        onPressed: () async {
                          if( _key.currentState.validate()){
                            await DatabaseServices(uid: user.uid).updateUserData(
                                _currentFName ?? userData.firstName,
                                _currentLName ?? userData.lastName,
                                _currentHeight ?? userData.height,
                                _currentWeight ?? userData.weight,
                                _currentAge ?? userData.age,
                                _currentPhone ?? userData.phoneNumber,
                                _selectedType ?? userData.blood);
                            Navigator.pop(context);
                          }
                        },
                        textColor: Colors.white,
                        padding: EdgeInsets.all(0.0),
                        child: Container(
                          alignment: Alignment.center,
                          height: _height / 15,
                          width:_large? _width/4 : (_medium? _width/3.75: _width/3.5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                            color: Color(0xFF1461A9),

                          ),
                          padding: const EdgeInsets.all(12.0),
                          child: Text('Update', style: TextStyle(fontSize: _large? 14: (_medium? 12: 10)),),
                        ),
                      ),
                      SizedBox(height: _height / 60.0),
                    ],
                  ),
                ),
              ),
            ),
          );
        }else{
          print("loading");
          return Container();
        }
        }
    );
  }
}
