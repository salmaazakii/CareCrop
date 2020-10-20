
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:netninja/home_screens/home_menu.dart';
import 'package:netninja/models/user_info.dart';
import 'package:netninja/services/database.dart';
import 'package:provider/provider.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<UserInfo>>.value(
      value: DatabaseServices().users,
      catchError: (context,e) => null ,
      child: MenuPage(),
    );
  }
}