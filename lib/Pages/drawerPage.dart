
import 'dart:io';
import 'package:albalsm/Authentication/ConnectivityProvider.dart';
import 'package:albalsm/Controller/Users_Controller.dart';
import 'package:albalsm/Pages/accountPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({super.key,});

  @override
  Widget build(BuildContext context) {
    UsersController us =UsersController();
    return Drawer(
     // backgroundColor: Colors.orangeAccent,
      child: Column(
        children: [
          Column(
            children: [
              const SizedBox(height: 10,),
                const CircleAvatar(backgroundImage: AssetImage(
                  "assets/images/balsamicon.jpg",
              ),
                radius: 50,

              ),
              FutureBuilder<Map<String, String?>?>(
                future: getUserData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  } else if (snapshot.hasData) {
                    final userData = snapshot.data;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("مرحباً, ${userData?['name'] ?? 'N/A'}",style: const TextStyle(fontWeight: FontWeight.bold),),
                        Text(" ${userData?['email'] ?? 'N/A'}",style: const TextStyle(fontWeight: FontWeight.bold),),
                      ],
                    );
                  } else {
                    return const Center(child: Text("لم يتم تسجيل الدخول دخلت كـ زائر"));
                  }
                },

              ),
              // InkWell(
              //     onTap: () {},
              //     child: Text(useremail, style: const TextStyle(fontStyle: FontStyle.italic  , fontSize: 20 ),)),

            ],
          ),
          const Divider(color: Colors.blueAccent,),
          //الرئيسية
          ListTile(
            onTap: (){
            },
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.end  ,
              children: [
                Text("الرئيسية",style: TextStyle(fontSize: 18,),),
                SizedBox(width: 10,),
                Icon(Icons.home_filled)
              ],
            ),
          ),
          //حسابي
          ListTile(
            onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                    return const AccountPage();
                  }));
            },
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.end  ,
              children: [
                Text("حسابي",style: TextStyle(fontSize: 18,),),
                SizedBox(width: 10,),
                Icon(Icons.account_circle)
              ],
            ),
          ),
          //اتصل بنا
          ListTile(
            onTap: (){
            },
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.end  ,
              children: [
                Text("اتصل بنا",style: TextStyle(fontSize: 18,),),
                SizedBox(width: 10,),
                Icon(Icons.call_end)
              ],
            ),
          ),
          //تسجيل الخروج
          ListTile(
            onTap: () {
              if (checkInternetConnection(context)) {
                // Navigator.push(
                //   context,
                //   PageRouteBuilder(
                //     pageBuilder: (context, animation, secondaryAnimation) => const LoginPage(),
                //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
                //       final scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
                //         CurvedAnimation(parent: animation, curve: Curves.easeInExpo),
                //       );
                //
                //       return ScaleTransition(
                //         scale: scaleAnimation,
                //         child: child,
                //       );
                //     },
                //     transitionDuration: const Duration(milliseconds: 800),
                //   ),
                // );
                exit(0);
              }
            },
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("تسجيل الخروج", style: TextStyle(fontSize: 18,),),
                SizedBox(width: 10,),
                Icon(Icons.logout)
              ],
            ),
          ),
          const Divider(color: Colors.red,),
          //حذف الحساب نهائياً
          ListTile(
            onTap: (){
            },
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.end  ,
              children: [
                Text("حذف الحساب نهائياً",style: TextStyle(fontSize: 18,),),
                SizedBox(width: 10,),
                Icon(Icons.delete,color: Colors.red,)
              ],
            ),
          ),
          const Spacer(),

          // const Text("برمجة وتصميم سهيل البازلي",style: TextStyle(fontSize: 18,),),
          // const Text("773624338",style: TextStyle(fontSize: 18,),),
        ],

      ),

    );
  }
// دالة جلب اسم المستخدم من firebase
  Future<Map<String, String?>?> getUserData() async {
    try {
      // الحصول على uid المستخدم الحالي
      String uid = FirebaseAuth.instance.currentUser!.uid;

      // جلب المستند الخاص بالمستخدم من مجموعة users
      DocumentSnapshot userDoc =
      await FirebaseFirestore.instance.collection('users').doc(uid).get();

      // التحقق إذا كان المستند يحتوي على الحقلين name و email
      if (userDoc.exists) {
        return {
          'name': userDoc['name'],
          'email': userDoc['email'],
        }; // استرجاع القيمتين name و email
      }
      return null;
    } catch (e) {
      print("Error fetching user data: $e");
      return null;
    }
  }


  //دالة التحقق من الاتصال بالانترنت

  bool checkInternetConnection(BuildContext context) {
    var connectivityProvider =
        Provider.of<ConnectivityProvider>(context, listen: false);

    if (!connectivityProvider.isConnected) {
      // عرض رسالة عدم الاتصال
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Center(child: Text("لا يوجد اتصال بالإنترنت")),
          backgroundColor: Colors.red,
        ),
      );
      return false; // لا يوجد اتصال بالإنترنت
    }

    return true; // يوجد اتصال بالإنترنت
  }

}
