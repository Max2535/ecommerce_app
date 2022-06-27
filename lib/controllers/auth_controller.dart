class AuthController {
  //function to sign up users
  singUpUser(
      String full_name, String username, String email, String password) async {
    String res = '';
    try {
      if (full_name.isNotEmpty &&
          username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty) {}
    } catch (error) {
      print(error);
    }
  }
}
