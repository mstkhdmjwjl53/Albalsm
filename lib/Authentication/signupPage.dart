
import 'dart:ui';
import 'package:albalsm/Authentication/ConnectivityProvider.dart';
import 'package:albalsm/Controller/Users_Controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'loginPage.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController address = TextEditingController();
  String? _errorMassagePass;
  String? _errorMassagephone;
  final _formKey = GlobalKey<FormState>();
  UsersController uS = UsersController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: WillPopScope(
          onWillPop: showMyAlertExit,
          child: Stack(
            children: [
              // خلفية الصورة التي تحتل كامل الشاشة
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/balsam.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // محتوى التطبيق
              Center(
                child: Container(
                  height: 540,
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
                          key: _formKey,
                          child: ListView(
                            children: [
                              const Center(
                                child: Text("إنشاء حساب", style: TextStyle(fontSize: 28,color: Colors.orangeAccent),),
                              ),
                              const SizedBox(height: 10),
                              // حقل اسم المستخدم
                              TextFormField(
                                controller: name,
                                textAlign: TextAlign.right,
                                textDirection: TextDirection.rtl,
                                style: const TextStyle(height: 1.6,fontWeight: FontWeight.bold),
                                decoration: const InputDecoration(
                                  label: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text("اسم المستخدم", style: TextStyle(fontSize: 22,),),
                                  ),
                                  hintText: "اكتب الاسم واللقب  هنا",
                                  suffixIcon: Icon(Icons.person),
                                ),
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: (value){
                                  if (value == null || value.isEmpty){
                                    return "هذا الحقل مطلوب";
                                  }
                                  return null;
                                }
                              ),
                              // حقل ايميل المستخدم
                              TextFormField(
                                controller: email,
                                textAlign: TextAlign.right,
                                textDirection: TextDirection.rtl,
                                style: const TextStyle(height: 1.6,fontWeight: FontWeight.bold),
                                decoration: const InputDecoration(
                                  label: Align(
                                    alignment: Alignment.centerRight,
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
                             const SizedBox(height: 25),
                              // حقل رقم الهاتف
                              TextFormField(
                                maxLength: 9,
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  setState(() {
                                    if (value.length == 9 && value.startsWith('7')) {
                                      _errorMassagephone = null;
                                    } else {
                                      if (!value.startsWith('7')) {
                                        _errorMassagephone = 'الرقم يجب أن يبدأ بـ 7';
                                      } else if (value.length != 9) {
                                        _errorMassagephone = 'الرقم يجب أن يتكون من 9 أرقام';
                                      }
                                    }
                                  });
                                },
                                controller: phone,
                                textAlign: TextAlign.right,
                                textDirection: TextDirection.rtl,
                                style: const TextStyle(height: 1.6,fontWeight: FontWeight.bold),
                                decoration:  InputDecoration(
                                  errorText: _errorMassagephone,
                                  label: const Align(
                                    alignment: Alignment.centerRight,
                                    child: Text("رقم الهاتف", style: TextStyle(fontSize: 22),),
                                  ),
                                  hintText: "اكتب رقم الهاتف هنا",
                                  suffixIcon: const Icon(Icons.phone),
                                ),
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                  validator: (value){
                                    if (value == null || value.isEmpty){
                                      return "هذا الحقل مطلوب";
                                    }
                                    return null;
                                  }
                              ),
                             const SizedBox(height: 25),
                              // حقل كلمة السر
                              TextFormField(
                                keyboardType: TextInputType.number,
                                onChanged: (value){
                                  setState(() {
                                    if(value.length>5)
                                    {
                                      _errorMassagePass=null;
                                    }
                                    else if(value.length<=5){
      
                                      _errorMassagePass ="كلمة السر يحب ان لا تقل عن 6 ارقام";
                                    }
                                  });
                                },
                                controller: password,
                                obscureText: true,
                                textAlign: TextAlign.right,
                                textDirection: TextDirection.rtl,
                                style: const TextStyle(height: 1.6,fontWeight: FontWeight.bold),
                                decoration:  InputDecoration(
                                  errorText: _errorMassagePass,
                                  label: const Align(
                                    alignment: Alignment.centerRight,
                                    child: Text("كلمة السر",),
                                  ),
                                  hintText: "اكتب كلمة السر هنا",
                                  suffixIcon: const Icon(Icons.lock),
                                ),
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  validator: (value){
                                    if (value == null || value.isEmpty){
                                      return "هذا الحقل مطلوب";
                                    }
                                    return null;
                                  }
                              ),
                             const SizedBox(height: 25),
                              // حقل العنوان
                              TextFormField(
                                controller: address,
                                textAlign: TextAlign.right,
                                textDirection: TextDirection.rtl,
                                style: const TextStyle(height: 1.6,fontWeight: FontWeight.bold),
                                decoration: const InputDecoration(
                                  label: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text("العنوان",),
                                  ),
                                  hintText: "اكتب عنوانك  هنا",
                                  suffixIcon: Icon(Icons.location_city_rounded),
                                ),
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  validator: (value){
                                    if (value == null || value.isEmpty){
                                      return "هذا الحقل مطلوب";
                                    }
                                    return null;
                                  }
                              ),
                              const SizedBox(height: 25),
                              //bottom sign
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
                                  onPressed: () async{
                                    if(checkInternetConnection(context)) {
                                      if (_formKey.currentState!.validate()) {
                                        bool res = await uS.register(name.text.trim(), email.text.trim(), phone.text.trim(), password.text.trim(), address.text.trim());
                                        if (res) {
                                          showMyAlertSccess();
                                        }
                                        else {
                                          showMyAlertFiled();
                                        }
                                      }
                                    }
                                  },
                                  icon: const Icon(Icons.create,size: 20,color: Colors.white70,),
                                  label: const Text("إنشاء حساب",style: TextStyle(fontSize: 20,color:Colors.white70,fontWeight: FontWeight.bold),),
                                ),
                              ),
                              //login account
                              SizedBox(
                                height: 50,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                        onTap:(){
                                          setState(() {
                                            Navigator.push(context,
                                              PageRouteBuilder(
                                                pageBuilder: (context, animation, secondaryAnimation) => const LoginPage(),
                                                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                                  final scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
                                                    CurvedAnimation(parent: animation, curve: Curves.easeInExpo),
                                                  );
                                                  return ScaleTransition(
                                                    scale: scaleAnimation,
                                                    child: child,
                                                  );
                                                },
                                                transitionDuration: const Duration(milliseconds: 800),
                                              ),
                                            );
      
                                          });
      
                                        },
                                        child: const Text(" تسحيل الدخول  " , style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue,fontSize: 17),)),
                                    const Text("لديك حساب بالفعل؟ ",style: TextStyle(fontSize: 17,color: Colors.orangeAccent),),
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

//داله الخروج
  Future<bool> showMyAlertExit() async {
    {
      return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("خروج", textAlign: TextAlign.end),
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

//داله نجح إنشاء الحساب
  void showMyAlertSccess() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content:
                const Text("تم إنشاء الحساب بنحاح", textAlign: TextAlign.end),
            title: const Text("إنشاء حساب", textAlign: TextAlign.end,),
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

//داله فشل إنشاء الحساب
  void showMyAlertFiled() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content:
                const Text(" خطأ في  إنشاء الحساب ", textAlign: TextAlign.end),
            title: const Text("إنشاء حساب", textAlign: TextAlign.end),
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

