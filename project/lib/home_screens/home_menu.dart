import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:netninja/home_screens/edit_profile.dart';
import 'package:netninja/home_screens/yoga/home.dart';
import 'package:netninja/models/user.dart';
import 'package:netninja/services/auth.dart';
import 'package:netninja/services/database.dart';
import 'package:netninja/widget/custom_shape.dart';
import 'package:netninja/widget/responsive_ui.dart';
import 'map.dart';
import 'chatbot.dart';
import 'notes/screens/home.dart';
import 'youtube.dart';
import 'history/history.dart';
import 'package:provider/provider.dart';
class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}
class Pos {
  final double x;
  final  double y;
  Pos(this.x, this.y);
}

class _MenuPageState extends State<MenuPage> {
  final AuthService _auth = AuthService();
  Position _pos;
  bool checkBoxValue = false;
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  void getCurrentLocation() async {
      print("getCurrentLocation ...");
      try {
        Position currPos = await Geolocator().getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best);
        print(currPos);
        setState(() {
          _pos = currPos;
        });
      }catch(e){ print(e.toString());}
  }

  @override
  Widget build(BuildContext context) {

    _height = MediaQuery
        .of(context)
        .size
        .height;
    _width = MediaQuery
        .of(context)
        .size
        .width;
    _pixelRatio = MediaQuery
        .of(context)
        .devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);

    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseServices(uid: user.uid).userData,
        builder:(context,snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Scaffold(
              appBar:
              AppBar(
                title: Text('Home', style: TextStyle(fontSize: 25.0),),
                elevation: 0.0,
                flexibleSpace: Container(
                  width: _width,
                  height: _height * 0.15,
                  padding: EdgeInsets.only(left: 15, top: 25),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          const Color(0xFF84C442),
                          const Color(0xFF1461A9)
                        ]
                    ),
                  ),
                ),
              ),
              drawer: new Drawer(
                  child: ListView(
                    children: <Widget>[
                      new UserAccountsDrawerHeader(
                        accountName: Text(
                          userData.firstName+' '+userData.lastName, style: TextStyle(
                            fontSize: 25.0
                        ),),
                        accountEmail: Text('0'+userData.phoneNumber.toString()),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [const Color(0xFF84C442), const Color(
                                  0xFF1461A9)
                              ]
                          ),
                        ),),
                      new ListTile(
                        title: Text('Edit Your Profile'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (BuildContext context) {
                              return EditProf();
                            }),
                          );
                        },
                      ),
                      new ListTile(
                        title: Text('Upgrade Premium',
                          style: TextStyle(color: Colors.grey),),
                        onTap: null,
                      ),
                      new Divider(),
                      new ListTile(
                        title: new Text('Logout'),
                        onTap: () async {
                          await _auth.signOut();
                        },
                      ),
                    ],
                  )
              ),
              body: Container(
                height: _height,
                width: _width,
                margin: EdgeInsets.only(bottom: 5.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      //Opacity(opacity: 0.88,child: CustomAppBar()),
                      Stack(
                        children: <Widget>[
                          clipShape(),
                        ],
                      ),
                      Container(
                        width: _width * 0.9,
                        height: _height,
                        child: _screenList(),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          else {
            print("loading");
            return Container();
          }
        }
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

   _navigateHome(BuildContext context) async {
    await getCurrentLocation();
    print("moving to googleMap");
    Pos pos = new Pos(_pos.latitude,_pos.longitude);
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage(
              pos: pos,
            )));
    print(result);
  }

  Widget _screenList(){
    return SizedBox(
        height: _height,
        width: _width,
        child: Center(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  InkWell(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 70,
                          backgroundColor: Color(0xFF84C442),
                          child: CircleAvatar(
                            radius: 65,
                            backgroundImage: AssetImage("assets/images/chat.jpg"),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(bottom: 7.0)),
                        Text("Doctor Ann",textAlign: TextAlign.center, style: TextStyle(
                            fontWeight: FontWeight.w800, color: Color(0xFF1461A9), fontSize:22),),
                      ],),
                    onTap: ()=> {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (BuildContext context) {
                          return ChatBot(); }),
                      )},
                  ),
                  InkWell(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 70,
                          backgroundColor: Color(0xFF84C442),
                          child: CircleAvatar(
                            radius: 65,
                            backgroundImage: AssetImage("assets/images/location.jpg"),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(bottom: 7.0)),
                        Text("Location",textAlign: TextAlign.center, style: TextStyle(
                            fontWeight: FontWeight.w800, color: Color(0xFF1461A9), fontSize:22),),
                      ],),
                    onTap: ()=> {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (BuildContext context) {
                          return _navigateHome(context); }),
                      )},
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.only(bottom: 20.0)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  InkWell(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 70,
                          backgroundColor: Color(0xFF84C442),
                          child: CircleAvatar(
                            radius: 65,
                            backgroundImage: AssetImage("assets/images/yoga.jpg"),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(bottom: 7.0)),
                        Text("Yoga",textAlign: TextAlign.center, style: TextStyle(
                            fontWeight: FontWeight.w800, color: Color(0xFF1461A9), fontSize:22),),
                      ],),
                    onTap: ()=> {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (BuildContext context) {
                          return App(); }),
                      )},
                  ),
                  InkWell(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 70,
                          backgroundColor: Color(0xFF84C442),
                          child: CircleAvatar(
                            radius: 65,
                            backgroundImage: AssetImage("assets/images/notes.jpg"),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(bottom: 7.0)),
                        Text("Notes",textAlign: TextAlign.center, style: TextStyle(
                            fontWeight: FontWeight.w800, color: Color(0xFF1461A9), fontSize:22),),
                      ],),
                    onTap: ()=> {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (BuildContext context) {
                          return MyHomePage(); }),
                      )},
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.only(bottom: 20.0)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  InkWell(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 70,
                          backgroundColor: Color(0xFF84C442),
                          child: CircleAvatar(
                            radius: 65,
                            backgroundImage: AssetImage("assets/images/history.jpg"),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(bottom: 7.0)),
                        Text("History",textAlign: TextAlign.center, style: TextStyle(
                            fontWeight: FontWeight.w800, color: Color(0xFF1461A9), fontSize:22),),
                      ],),
                    onTap: ()=> {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (BuildContext context) { return History(); }),
                      )},
                  ),
                  InkWell(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 70,
                          backgroundColor: Color(0xFF84C442),
                          child: CircleAvatar(
                            radius: 65,
                            backgroundImage: AssetImage("assets/images/video.jpg"),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(bottom: 7.0)),
                        Text("Videos",textAlign: TextAlign.center, style: TextStyle(
                            fontWeight: FontWeight.w800, color: Color(0xFF1461A9), fontSize:22),),
                      ],),
                    onTap: ()=> {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (BuildContext context) { return Youtube(); }),
                      )},
                  ),
                ],
              )
            ],
          ),
        )
    );
  }
}