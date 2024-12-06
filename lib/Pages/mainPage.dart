
import 'package:albalsm/Pages/accountPage.dart';
import 'package:albalsm/Pages/deptPage.dart';
import 'package:albalsm/Pages/drawerPage.dart';
import 'package:albalsm/Pages/homePage.dart';
import 'package:albalsm/Pages/shopPage.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class MainPage extends StatefulWidget {

  const MainPage({super.key,});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  int _CurrnetPage = 3;

  List myPage = [
    const AccountPage(),
    const ShopPage(cart: [],),
    const DeptPage(),
    const HomePage(),
  ];

  void onTap(int index) {
    setState(() {
      _CurrnetPage = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          endDrawer: const DrawerPage(),
          appBar: AppBar(
            toolbarHeight: 50,
            //Icon
            leading: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                IconButton(
                  onPressed: () async {
                    final result = await Share.share('البلسم للعسل اليمني والتمور https://www.facebook.com/albalsamye');
                    if (result.status == ShareResultStatus.success) {
                      showMyAlertShareApp();
                    }
                  },
                  icon: const Icon(Icons.share, size: 25,),
                ),
              ],
            ),
            backgroundColor: Colors.orangeAccent,
            title: SizedBox(
              height: 30,
              //حقل البحث
              child: TextField(
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
                decoration: InputDecoration(
                   focusedBorder: OutlineInputBorder(
                      borderRadius:BorderRadius.circular(10) ,
                      borderSide: const BorderSide( color: Colors.deepPurple, width: 1,)

                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius:BorderRadius.circular(10) ,
                      borderSide: const BorderSide( color: Colors.deepPurple, width: 1,)

                  ),
                  hintText: "....بحث",
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              //Text("البلسم للعسل اليمني والتمور",style: TextStyle(fontFamily: "Ruwudu"),),
            // alignment: Alignment.centerRight,
            ),
          ),
          body: myPage[_CurrnetPage],
          bottomNavigationBar: BottomNavigationBar(
           // backgroundColor: Colors.orangeAccent,
            type: BottomNavigationBarType.fixed,
            currentIndex: _CurrnetPage,
            onTap: onTap,
            selectedLabelStyle: const TextStyle(fontSize: 17,fontWeight: FontWeight.bold),
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.account_circle_outlined, color: Colors.orange), label: "حسابي",),
              BottomNavigationBarItem(icon: Icon(Icons.shopping_cart, color: Colors.orange),label: "السلة",),
              BottomNavigationBarItem(icon: Icon(Icons.dashboard_customize_rounded, color: Colors.orange), label: "الأقسام",),
              BottomNavigationBarItem(icon: Icon(Icons.home, color: Colors.orange), label: "الرئيسية",),
            ],

          ),

        ),
      ),
    );
  }

  // دالة نجاح مشاركة التطبيق
  void showMyAlertShareApp() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content:
            const Text("شكراً لك على مشاركة التطبيق", textAlign: TextAlign.end),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("حسناً")),
            ],
          );
        });
  }
}
