// import 'dart:typed_data';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class AuthMethod {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   //signup user
//   Future<String> signUpUser({
//     required String email,
//     required String password,
//     required String username,
//     required String bio,
//     required Uint8List file,
//   }) async {
//     String res = "some error occured";
//     try {
//       if (email.isNotEmpty ||
//           password.isNotEmpty ||
//           username.isNotEmpty ||
//           bio.isNotEmpty ||
//           file != Null) {
//         UserCredential cred = await _auth.createUserWithEmailAndPassword(
//             email: email, password: password);
//         print(cred.user!.uid);
//         //add user to our datbase
// _firestore.collection('users').doc(cred.user!.uid).set({
//   'username': username,
//   'uid': cred.user!.uid,
//   'email': email,
//   'bio': bio,
//   'followers': [],
//   'following': [],
// });
// //
//         await _firestore.collection('users').add({
//           'username': username,
//           'uid': cred.user!.uid,
//           'email': email,
//           'bio': bio,
//           'followers': [],
//           'following': [],
//         });

//         res = 'success';
//       }
//     } catch (err) {
//       res = err.toString();
//     }
//     return res;
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthMethod {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> signUpUser({
    required String username,
    required String email,
    required String password,
    required String bio,
    // required Uint8List file,
  }) async {
    String res = "error";
    try {
      if (email.isNotEmpty ||
              username.isNotEmpty ||
              password.isNotEmpty ||
              bio.isNotEmpty //|| file!=null
          ) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print(cred.user!.uid);
        await _firestore.collection('users').doc(cred.user!.uid).set({
          'username': username,
          'uid': cred.user!.uid,
          'email': email,
          'bio': bio,
          'followers': [],
          'following': [],
        });
        res = "success";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
