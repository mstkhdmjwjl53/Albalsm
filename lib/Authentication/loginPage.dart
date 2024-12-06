
import 'dart:async';
import 'dart:ui';
import 'package:albalsm/Authentication/ConnectivityProvider.dart';
import 'package:albalsm/Authentication/resetPassword.dart';
import 'package:albalsm/Authentication/signupPage.dart';
import 'package:albalsm/Controller/Users_Controller.dart';
import 'package:albalsm/Pages/mainPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  UsersController uS = UsersController();
  String? _errorMessage;
  final _formKey = GlobalKey<FormState>(); // إنشاء مفتاح الـ Form

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: WillPopScope(
          onWillPop: showMyAlertExit,
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/balsam.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Center(
                child: Container(
                  height: 400,
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black.withOpacity(0.1),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                      child: Padding(
                        padding: const EdgeInsets.all(25),
                        child: Form(
                          key: _formKey, // ربط مفتاح الـ Form
                          child: ListView(
                            children: [
                              const Center(
                                child: Text(
                                  "تسجيل الدخول",
                                  style: TextStyle(fontSize: 27),
                                ),
                              ),
                              const SizedBox(height: 20),
                              // حقل الإيميل مع التحقق
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                controller: email,
                                textAlign: TextAlign.right,
                                textDirection: TextDirection.rtl,
                                style: const TextStyle(height: 1.6, fontWeight: FontWeight.bold,),
                                decoration: const InputDecoration(
                                  label: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text("الإيميل", style: TextStyle(fontSize: 22),),
                                  ),
                                  hintText: "اكتب الإيميل هنا",
                                  // hintStyle: TextStyle(fontFamily: "Arial"),
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
                              const SizedBox(height: 25),
                              // حقل كلمة السر مع التحقق من الطول
                              TextFormField(
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    setState(() {
                                      if (value.length >= 6) {
                                        _errorMessage = null;
                                      } else {
                                        _errorMessage = "كلمة السر يجب أن لا تقل عن 6 أرقام";
                                      }
                                    });
                                  },
                                  controller: password,
                                  obscureText: true,
                                  textAlign: TextAlign.right,
                                  textDirection: TextDirection.rtl,
                                  style: const TextStyle(height: 1.6,  fontWeight: FontWeight.bold),
                                  decoration: InputDecoration(
                                    errorText: _errorMessage,
                                    label: const Align(
                                      alignment: Alignment.centerRight,
                                      child: Text("كلمة السر", style: TextStyle(fontSize: 22, ),),
                                    ),
                                    hintText: "اكتب كلمة السر هنا",
                                    suffixIcon: const Icon(Icons.lock),
                                  ),
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  validator: (value){
                                    if (value == null || value.isEmpty) {
                                      return "هذا الحقل مطلوب";
                                    }
                                    return null;
                                  }
                              ),
                              //نسيت كلمة السر
                              SizedBox(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap: (){
                                        Navigator.push(context,
                                          PageRouteBuilder(
                                            pageBuilder: (context, animation, secondaryAnimation) => const ResetPassword(),
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
      
                                      },child:  const Text("نسيت كلمة السر؟",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
                                    )
                                  ],
                                ),
                              ),
                              //الدخول كــ زائر
                              SizedBox(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap: (){
                                        if(checkInternetConnection(context)) {
                                          Navigator.push(context,
                                            PageRouteBuilder(
                                              pageBuilder: (context, animation, secondaryAnimation) => const MainPage(),
                                              transitionsBuilder: (context, animation, secondaryAnimation, child)
                                              {
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
                                        }
                                      },child:  const Text("الدخول كـ زائر",style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold,fontSize: 20),),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 25),
      
                              // زر تسجيل الدخول
                              SizedBox(
                                height: 50,
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0x0fff77d2),
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            topRight: Radius.circular(28),
                                            bottomRight: Radius.circular(8),
                                            bottomLeft: Radius.circular(28),
                                          )
                                      )
                                  ),
                                  onPressed: () async {
                                    if(checkInternetConnection(context)) {
                                      if (_formKey.currentState!.validate()) {
                                        // يتم التحقق من صحة الحقول هنا
                                        String userEmail = email.text.trim().toLowerCase();
                                        String userPassword = password.text.trim();
                                        // SharedPreferences pref = await SharedPreferences.getInstance();
                                        // pref.setString("email",userEmail);
                                        bool res = await uS.login(userEmail, userPassword);
                                        if (res) {
                                          Navigator.push(context,
                                            PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => const MainPage(),
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
                                        } else {
                                          if(checkInternetConnection(context)) {
                                            showMyAlertFiled();
                                          }
                                        }
                                      }
                                    }
                                  },
                                  icon: const Icon(Icons.login, size: 20,color: Colors.white70,),
                                  label: const Text("دخـــول", style: TextStyle( fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white70),
                                  ),
                                ),
                              ),
                              //انشاء حساب
                              SizedBox(
                                height: 70,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          Navigator.push(context,
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
                                    const Text(
                                      " لا تمتلك حساب؟",
                                      style: TextStyle( fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // دالة خطأ في اسم المستخدم أو كلمة السر
  void showMyAlertFiled() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("خطأ", style: TextStyle()),
        content: const Text("اسم المستخدم أو كلمة المرور غير صحيحة", style: TextStyle( fontSize: 18)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("حسنًا", style: TextStyle( fontSize: 20)),
          ),
        ],
      ),
    );
  }

//داله الخروج
  Future<bool> showMyAlertExit() async {
    {
      return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("خروج", textAlign: TextAlign.end /*style: TextStyle(fontFamily: "Arial")*/,),
          content: const Text("هل تريد الخروج؟",
              textAlign: TextAlign.end,
              style: TextStyle(fontSize: 18,)),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text("لا")),
            ElevatedButton(
                onPressed: () {
                  SystemNavigator.pop();
                },
                child: const Text("نعم")),
          ],
        ),
      );
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

