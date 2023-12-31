import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthMethods {
  void signUp(String email, String password, String username, String phone) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await FirebaseFirestore.instance.collection("users").doc(email).set({
        "username": username,
        "phone":phone,
        "email": email,
        "password": password,
      });
    } catch (e) {
      Text("An error $e occured");
    }
  }

  void signIn(String email, String password) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
