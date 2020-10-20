import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:netninja/models/user.dart';
import 'package:netninja/models/user_info.dart';


class DatabaseServices {

  final String uid;
  DatabaseServices({ this.uid });

  //collection reference
  final CollectionReference userCollection = Firestore.instance.collection('users');

  Future storeUserData(String fname,String lname,int height,int weight,
      int age,int phone,String blood) async {
    print('storing ...');
        return await userCollection.document(uid).setData({
          'first_name' : fname, 'last_name' : lname,
          'height' : height, 'weight' : weight,
          'age' : age, 'phone_number' : phone,
          'blood_type' : blood
        }).then((result){
          print('Done!');
        }).catchError((onError){
          print('error updating!');
        });
  }


  Future updateUserData(String fname,String lname,int height,int weight,
      int age,int phone,String blood) async {
    print('updating ...');
    return await userCollection.document(uid).updateData({
      'first_name' : fname, 'last_name' : lname,
      'height' : height, 'weight' : weight,
      'age' : age, 'phone_number' : phone,
      'blood_type' : blood
    }).then((result){
      print('updated!');
    }).catchError((onError){
      print('error updating!');
    });
  }


  // users list from snapshot
  List<UserInfo> _usersListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return UserInfo(
        firstName: doc.data['first_name'] ?? '',
        lastName: doc.data['last_name'] ?? '',
        height: doc.data['height'] ?? 0,
        weight: doc.data['weight'] ?? 0,
        age: doc.data['age'] ?? 0,
        phoneNumber: doc.data['phone_number'] ?? 0,
        blood: doc.data['blood_type'] ?? ''
      );
    });
  }

  //userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
        uid: uid, firstName: snapshot.data['first_name'],lastName: snapshot.data['last_name'],
        height: snapshot.data['height'],weight: snapshot.data['weight'],
        age: snapshot.data['age'],phoneNumber: snapshot.data['phone_number'],
        blood: snapshot.data['blood_type']
    );
  }

  // get users stream
  Stream<List<UserInfo>> get users {
    return userCollection.snapshots()
        .map(_usersListFromSnapshot);
  }
  // get user doc stream
  Stream <UserData> get userData {
    return userCollection.document(uid).snapshots()
        .map(_userDataFromSnapshot);
  }

}