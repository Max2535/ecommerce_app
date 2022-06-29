import 'dart:typed_data';

import 'package:ecommerce_app/const.dart';
import 'package:ecommerce_app/controllers/auth_controller.dart';
import 'package:ecommerce_app/views/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class SingUpScreen extends StatefulWidget {
  @override
  State<SingUpScreen> createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {
  final TextEditingController _fullNameController = TextEditingController();

  final TextEditingController _userNameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  bool _obscureText = true;

  Uint8List? _image;

  bool _isLoading = false;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  selectImage() async {
    Uint8List image = await AuthController().pickImage(ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    var res = await AuthController().singUpUser(
      _userNameController.text,
      _userNameController.text,
      _emailController.text,
      _passwordController.text,
      _image!,
    );
    setState(() {
      _isLoading = false;
    });
    if (res != "success") {
      return showSnackBar(res, context);
    } else {
      return showSnackBar(
          'Congratulations account has been created for you', context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundColor: Colors.white,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : CircleAvatar(
                          radius: 64,
                          backgroundColor: Colors.blue,
                          backgroundImage: AssetImage('assets/images/user.png'),
                        ),
                  Positioned(
                    right: 5,
                    bottom: 10,
                    child: InkWell(
                      onTap: selectImage,
                      child: Icon(Icons.add_a_photo),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                textInputAction: TextInputAction.next,
                controller: _fullNameController,
                decoration: InputDecoration(
                  filled: true,
                  icon: Icon(Icons.person),
                  hintText: 'Enter your full name',
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                textInputAction: TextInputAction.next,
                controller: _userNameController,
                decoration: InputDecoration(
                  filled: true,
                  icon: Icon(Icons.person_sharp),
                  hintText: 'Enter your username',
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                textInputAction: TextInputAction.next,
                controller: _emailController,
                decoration: InputDecoration(
                  filled: true,
                  icon: Icon(Icons.email_outlined),
                  hintText: 'Enter your email',
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              // Column(
              //   children: [
              //     TextFormField(
              //       obscureText: _obscureText,
              //       enableSuggestions: false,
              //       autocorrect: false,
              //       textInputAction: TextInputAction.done,
              //       controller: _passwordController,
              //       decoration: InputDecoration(
              //         filled: true,
              //         icon: const Padding(
              //             padding: const EdgeInsets.only(top: 15.0),
              //             child: const Icon(Icons.lock)),
              //         hintText: 'Enter your password',
              //         border: OutlineInputBorder(
              //           borderSide: BorderSide.none,
              //         ),
              //         focusedBorder: OutlineInputBorder(
              //           borderSide: BorderSide(
              //             color: Colors.black,
              //           ),
              //         ),
              //       ),
              //     ),
              //     GestureDetector(
              //       onTap: _toggle,
              //       child: Icon(
              //         _obscureText
              //             ? Icons.visibility_off_rounded
              //             : Icons.visibility_rounded,
              //         size: 24,
              //       ),
              //     ),
              //   ],
              // ),
              TextField(
                controller: _passwordController,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.visiblePassword,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior
                      .never, //Hides label on focus or if filled
                  labelText: "Password",
                  filled: true, // Needed for adding a fill color
                  //fillColor: Colors.grey.shade800,
                  //isDense: true, // Reduces height a bit
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none, // No border
                    // borderRadius:
                    //     BorderRadius.circular(12), // Apply corner radius
                  ),
                  prefixIcon: Icon(Icons.lock_rounded, size: 24),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                    child: GestureDetector(
                      onTap: _toggle,
                      child: Icon(
                        _obscureText
                            ? Icons.visibility_off_rounded
                            : Icons.visibility_rounded,
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width - 40,
                height: 50,
                decoration: BoxDecoration(
                  color: buttonColor,
                ),
                child: InkWell(
                  onTap: () async {
                    await signUpUser();
                    _userNameController.clear();
                    _userNameController.clear();
                    _emailController.clear();
                    _passwordController.clear();
                    setState(() {
                      _image = null;
                    });
                  },
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add),
                        SizedBox(
                          width: 10,
                        ),
                        _isLoading
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                'Register',
                                style: TextStyle(
                                  color: textButtonColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an Account?',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
