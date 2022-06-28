import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

var backgroundColor = Colors.black;

var buttonColor = Colors.black;

var textButtonColor = Colors.white;

//FIREBASE
var firebaseAuth = FirebaseAuth.instance;
var firebaseStore = FirebaseFirestore.instance;
var firebaseStorage = FirebaseStorage.instance;
