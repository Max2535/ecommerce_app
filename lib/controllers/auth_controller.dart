import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/const.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AuthController {
  //function to enable users pick image

  pickImage(ImageSource source) async {
    final ImagePicker _pickedImage = ImagePicker();

    XFile? _file = await _pickedImage.pickImage(source: source);

    if (_file != null) {
      return await _file.readAsBytes();
    } else {
      print('No Image selected');
    }
  }

  //function to sign up users
  Future<String> singUpUser(String full_name, String username, String email,
      String password, Uint8List? image) async {
    String res = 'error';
    try {
      if (full_name.isNotEmpty &&
          username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        var cred = await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        var downloadUrl = await _uploadImageToStorage(image);

        await firebaseStore.collection('users').doc(cred.user!.uid).set({
          'fullName': full_name,
          'username': username,
          'email': email,
          'image': downloadUrl,
        });
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

//function to add image to store
_uploadImageToStorage(Uint8List? image) async {
  var ref = firebaseStorage
      .ref()
      .child('profilePic')
      .child(firebaseAuth.currentUser!.uid);

  var uploadTask = ref.putData(image!);
  var snap = await uploadTask;
  var downloadUrl = await snap.ref.getDownloadURL();
  return downloadUrl;
}

showSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}
