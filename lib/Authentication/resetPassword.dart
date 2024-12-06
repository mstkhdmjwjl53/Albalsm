
import 'package:albalsm/Authentication/ConnectivityProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResetPassword extends StatefulWidget {

  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();

  // bool isConnectedToInternet = false;
  // StreamSubscription? _internetConnectionStreamSubscription;
  //
  // @override
  // void initState() {
  //   super.initState();
  //   _internetConnectionStreamSubscription =
  //       InternetConnection().onStatusChange.listen((event) {
  //         switch (event) {
  //           case InternetStatus.connected:
  //             setState(() {
  //               isConnectedToInternet = true;
  //               showSnackBar(isConnectedToInternet);
  //             });
  //             break;
  //           case InternetStatus.disconnected:
  //             setState(() {
  //               isConnectedToInternet = false;
  //               showSnackBar(isConnectedToInternet);
  //             });
  //             break;
  //           default:
  //             setState(() {
  //               isConnectedToInternet = false;
  //               // showSnackBar(isConnectedToInternet);
  //             });
  //             break;
  //         }
  //       });
  // }
  //
  // @override
  // void dispose() {
  //   _internetConnectionStreamSubscription?.cancel();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold (
        //backgroundColor: Colors.red,
        appBar: AppBar(
          backgroundColor: Colors.orangeAccent,
          title: const Center(child: Text("إعادة تعين كلمة السر")),

        ),
        body: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 50,),
                const Text("سيتم ارسال رمز الى البريد الإلكتروني لإعادة تعين كلمة السر",style: TextStyle(fontWeight: FontWeight.bold),),
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: email,
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                    style: const TextStyle(height: 1.6,  fontWeight: FontWeight.bold,),
                    decoration:  const InputDecoration(

                      label: Align(alignment: Alignment.centerRight,
                        child: Text("الإيميل", style: TextStyle(fontSize: 22),),
                      ),
                      hintText: "اكتب الإيميل هنا",
                      suffixIcon: Icon(Icons.email),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction, // تشغيل التحقق المباشر
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "هذا الحقل مطلوب";
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return "يرجى إدخال إيميل صالح";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 50,),
                TextButton(onPressed: () async {
                  if(checkInternetConnection(context)) {
                    if (_formKey.currentState!.validate()) {
                      await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);
                      showMyAlertdoneemail();
                    }
                  }
                },

                    child: const Text("إرســــــال",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),))

              ],
            ),
          )
        ),
      ),
    );
  }

  //دالة التحقق من الاتصال بالانترنت
  // void showSnackBar(bool isConnectedToInternet) {
  //   final snackBar = SnackBar(
  //     content: Center(
  //       child: Text(
  //         isConnectedToInternet ? "تم الاتصال بالإنترنت" : "لا يوجد اتصال بالإنترنت",
  //       ),
  //     ),
  //     backgroundColor: isConnectedToInternet ? Colors.green : Colors.red,
  //     behavior: SnackBarBehavior.floating,
  //     margin: const EdgeInsets.only(
  //       bottom: 150,
  //       left: 100,
  //       right: 100,
  //
  //     ),
  //     padding: const EdgeInsets.all(1),
  //     duration: const Duration(seconds: 2), // مدة عرض الرسالة
  //   );
  //
  //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
  // }

  //دالة التحقق من الاتصال بالانترنت
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

//دالة تم ارسال الرمز الى الايميل
  void showMyAlertdoneemail() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: const Text(
              "تم ارسال الرمز الى البريد الإلكتروني",
              textAlign: TextAlign.end,
            ),
            title: const Text("إرسال رمز",
                textAlign: TextAlign.end, style: TextStyle()),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("تم")),
            ],
          );
        });
  }
}
