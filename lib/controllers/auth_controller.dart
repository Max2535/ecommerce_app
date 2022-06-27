import 'package:ecommerce_app/const.dart';

class AuthController {
  //function to sign up users
  Future<String> singUpUser(
      String full_name, String username, String email, String password) async {
    String res = 'error';
    try {
      if (full_name.isNotEmpty &&
          username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty) {
        var cred = await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        print(cred.user!.email);
        res = 'success';
      } else {
        res = 'Please fields must not be empty';
      }
    } catch (error) {
      print(error);
      res = error.toString();
    }
    return res;
  }
}
