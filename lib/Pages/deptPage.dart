
import 'package:albalsm/Authentication/ConnectivityProvider.dart';
import 'package:albalsm/Pages/deptDetails.dart';
import 'package:albalsm/Pages/mainPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeptPage extends StatefulWidget {
  const DeptPage({super.key});

  @override
  State<DeptPage> createState() => _DeptPageState();
}

class _DeptPageState extends State<DeptPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold (
          appBar: AppBar(
            title: const Center(child: Text('الأقســـام')),
            //backgroundColor: Colors.blueAccent,
            leading: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                IconButton(
                  onPressed: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                          return const MainPage();
                        }));
                  },
                  icon: const Icon(Icons.keyboard_backspace_sharp, size: 28,
                  ),
                ),
              ],
            ),
          ),

        body: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                    children: [

                      // منتجات طبيعية
                      InkWell(
                      onTap: () {
                        if(checkInternetConnection(context)) {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                                return const DeptDetails();
                              }));
                        }
                      },
                      child: Container(
                          width: 335, // عرض كل عنصر على حدة
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "منتجات طبيعية ",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 45,),
                              ClipRRect(
                                borderRadius:  BorderRadius.circular(10),
                                child: Image.asset(
                                  "assets/dept/img_2.png",
                                  fit: BoxFit.fill,
                                  width:110,
                                  height: 90,
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 15,),

                      // عــســـــل
                      InkWell(
                        onTap: () {
                          if(checkInternetConnection(context)) {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                                  return const DeptDetails();
                                }));
                          }
                        },
                        child: Container(
                          width: 335, // عرض كل عنصر على حدة
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "عـــســـل",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 45,),
                              ClipRRect(
                                borderRadius:  BorderRadius.circular(10),
                                child: Image.asset(
                                  "assets/dept/honey.png",
                                  fit: BoxFit.fill,
                                  width:110,
                                  height: 90,
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 15,),
                      // تمور
                      InkWell(
                        onTap: () {
                          if(checkInternetConnection(context)) {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                                  return const DeptDetails();
                                }));
                          }
                        },
                        child: Container(
                          width: 335, // عرض كل عنصر على حدة
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "تـــمـــور",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 45,),
                              ClipRRect(
                                borderRadius:  BorderRadius.circular(10),
                                child: Image.asset(
                                  "assets/dept/temoor.jpg",
                                  fit: BoxFit.fill,
                                  width:110,
                                  height: 90,
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 15,),
                      // زيــــوت
                      InkWell(
                        onTap: () {
                          if(checkInternetConnection(context)) {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                                  return const DeptDetails();
                                }));
                          }
                        },
                        child: Container(
                          width: 335, // عرض كل عنصر على حدة
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "زيــــوت ",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 45,),
                              ClipRRect(
                                borderRadius:  BorderRadius.circular(10),
                                child: Image.asset(
                                  "assets/dept/oil.png",
                                  fit: BoxFit.fill,
                                  width:110,
                                  height: 90,
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 15,),
                      // عطور
                      InkWell(
                        onTap: () {
                          if(checkInternetConnection(context)) {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                                  return const DeptDetails();
                                }));
                          }
                        },
                        child: Container(
                          width: 335, // عرض كل عنصر على حدة
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "عـــطــور",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 45,),
                              ClipRRect(
                                borderRadius:  BorderRadius.circular(10),
                                child: Image.asset(
                                  "assets/dept/img.png",
                                  fit: BoxFit.fill,
                                  width:110,
                                  height: 90,
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 15,),
                      // بخور
                      InkWell(
                        onTap: () {
                          if(checkInternetConnection(context)) {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                                  return const DeptDetails();
                                }));
                          }
                        },
                        child: Container(
                          width: 335, // عرض كل عنصر على حدة
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "بخـــور",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 45,),                          ClipRRect(
                                borderRadius:  BorderRadius.circular(10),
                                child: Image.asset(
                                  "assets/dept/img_1.png",
                                  fit: BoxFit.fill,
                                  width:110,
                                  height: 90,
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 15,),
                      // مكسرات
                      InkWell(
                        onTap: () {
                          if(checkInternetConnection(context)) {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                                  return const DeptDetails();
                                }));
                          }
                        },
                        child: Container(
                          width: 335, // عرض كل عنصر على حدة
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "مكــســرات",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 45,),                          ClipRRect(
                                borderRadius:  BorderRadius.circular(10),
                                child: Image.asset(
                                  "assets/dept/img_3.png",
                                  fit: BoxFit.fill,
                                  width:110,
                                  height: 90,
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )


      ),
    );
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
