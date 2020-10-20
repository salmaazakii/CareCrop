import 'package:flutter/material.dart';
import 'package:netninja/authentication/authenticate.dart';
import 'package:netninja/home_screens/home.dart';
import 'models/user.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    //return home folder or authentication
    if (user == null){
      return Authenticate();
    }else{
      return Home();
    }
  }
}
