class User {

  final String uid;

  User({ this.uid });

}

class UserData {

  final String uid;
  final String firstName;
  final String lastName;
  final int height;
  final int weight;
  final int age;
  final int phoneNumber;
  final String blood;

  UserData({ this.uid,this.firstName,this.lastName,this.weight,
    this.height,this.age,this.blood, this.phoneNumber });
}