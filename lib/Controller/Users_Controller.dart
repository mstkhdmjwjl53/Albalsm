

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UsersController {

  //دالة تسجيل الدخزل
  Future<bool> login(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      // إذا تم تسجيل الدخول بنجاح، يتم إعادة true
      return true;
    } catch (e) {
      print("Login failed: $e");
      // إذا كانت البيانات خاطئة أو حدث خطأ آخر، يتم إعادة false
      return false;
    }
  }
//دالة إنشاء حساب
  Future<bool> register(String name, String email,String phone, String  password,  String address) async {
    try {

      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email, password: password
      );
      String uid =userCredential.user!.uid;
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'uid':uid,
        'name':name,
        'email':email,
        'password':password,
        'phone':phone,
        'address':address,
        'createdAt': FieldValue.serverTimestamp(),
      });
      return true;
    } catch (e) {
      print("register failed: $e");
      // إذا كانت البيانات خاطئة أو حدث خطأ آخر، يتم إعادة false
      return false;
    }
  }



}