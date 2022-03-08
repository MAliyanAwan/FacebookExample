import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'model.dart';

class ProfileService {
  Future createUser({
    required String email,
    required String password,
  }) async {
    try {
      UserModel userModel = UserModel(
        email: email,
        password: password,
      );
      await FirebaseFirestore.instance
          .collection('users')
          .add(userModel.toJson());
      Fluttertoast.showToast(msg: 'Login Succesfully');
    } catch (e) {
      Fluttertoast.showToast(msg: "Error");
    }
  }
}
