
import 'dart:io';

import 'package:albalsm/Authentication/signupPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {

  String name = "";
  String email = "";
  String password = "";
  String phone = "";
  String address = "";

  File? file;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.grey,
                child: Column(
                  children: [
                    Center(
                    heightFactor: 1.5,
                      child: CircleAvatar(backgroundImage: const AssetImage(
                          "assets/images/balsamicon.jpg",
                      ),
                      // backgroundColor: Colors.red,
                        radius: 60,
                        child: Align(
                            alignment: Alignment.bottomLeft,
                            child: IconButton(
                                onPressed: () async {
                                  final ImagePicker picker = ImagePicker();
                                  final XFile? photo = await picker.pickImage(
                                      source: ImageSource.camera);
                                  if (photo != null) {
                                    setState(() {
                                      file = File(photo!.path);
                                    });
                                    
                                  }
                                  
                                },
                                icon: const Icon(Icons.camera_alt, color: Colors.black, size: 30,)
                            ),
                        ),
                      ),

                    ),

                  ],
                ),
              ),
              FutureBuilder(
                future: getUsersData(),
                builder: (context, snapshot) {
                  // تحقق من حالة التحميل أو الخطأ
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator()); // أثناء التحميل
                  } else if (snapshot.hasError) {
                    return const Center(child: Text("حدث خطأ أثناء تحميل البيانات")); // في حال وجود خطأ
                  } else if (!snapshot.hasData || snapshot.data == null) {
                    return Center(
                        child:Column(
                          children: [
                            const Text("عليك تسجيل الدخول أولاً"), // في حال عدم وجود بيانات
                            InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation, secondaryAnimation) => const SignupPage(),
                                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                        final scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
                                          CurvedAnimation(parent: animation, curve: Curves.easeInExpo),
                                        );
                                        return ScaleTransition(
                                          scale: scaleAnimation,
                                          child: child,
                                        );
                                      },
                                      transitionDuration: const Duration(milliseconds: 700),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "إنشاء حساب",
                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue,  fontSize: 20),
                                )),
                          ],
                        )
                    );
                  } else {
                    // إذا كانت البيانات موجودة
                    final userData = snapshot.data as Map<String, dynamic>;

                    return Column(
                      children: [
                        // الاسم
                        ListTile(
                          title: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
                                const SizedBox(width: 122),
                                Text("الإسم  :   ${userData['name']}",
                                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                        // الإيميل
                        ListTile(
                          title: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
                                Text("${userData['email']}  : الإيميل ",
                                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                        // الهاتف
                        ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
                              Text("${userData['phone']}  : الهاتف ",
                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        // العنوان
                        ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
                              Text("العنوان  :   ${userData['address']}",
                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 25),
                        // زر تعديل البيانات
                        SizedBox(
                          height: 55,
                          width: 280,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0x0f5f75d1),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(28),
                                  bottomRight: Radius.circular(8),
                                  bottomLeft: Radius.circular(28),
                                ),
                              ),
                            ),
                            onPressed: () {},
                            icon: const Icon(Icons.edit_calendar_rounded,
                                size: 20, color: Colors.white70),
                            label: const Text(
                              "تعديل بياناتك",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white70),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),

            ],
          ),
        ),

      ),
    );
  }

  // دالة لاسترجاع بيانات المستخدم المسجل دخوله
  Future<Map<String, dynamic>?> getUsersData() async {
    // الحصول على المستخدم الحالي
    User? user = FirebaseAuth.instance.currentUser;

    // التأكد من أن المستخدم مسجل دخوله
    if (user != null) {
      String documentId = user.uid; // استخدام UID للمستخدم

      DocumentReference documentReference =
      FirebaseFirestore.instance.collection("users").doc(documentId);

      DocumentSnapshot snapshot = await documentReference.get();

      if (snapshot.exists) {
        var data = snapshot.data() as Map<String, dynamic>;
        return data;
      } else {
        print('Document does not exist');
        return null;
      }
    } else {
      print("المستخدم غير مسجل الدخول");
      return null;
    }
  }


}
