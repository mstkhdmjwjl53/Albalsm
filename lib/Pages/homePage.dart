
import 'dart:async';
import 'package:albalsm/Authentication/ConnectivityProvider.dart';
import 'package:albalsm/Pages/deptPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final PageController _controller = PageController();
  late Timer _timer;

  @override
  void initState() {

    super.initState();

    // إعداد التايمر لتغيير الصفحة تلقائيًا
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_controller.page == 3) { // إذا كانت هذه هي الصفحة الأخيرة
        _controller.jumpToPage(0); // ابدأ من البداية
      } else {
        _controller.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    }
    );

  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel(); // تأكد من إيقاف التايمر عند التخلص من الصفحة
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // شريط تمرير الصور
              const SizedBox(height: 20,),
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: SizedBox(
                  height: 150, // ارتفاع الصور
                  width: double.infinity,
                  child: PageView(
                    controller: _controller,
                    children: [
                      Image.asset('assets/images/zamzm.png', fit: BoxFit.fill),
                      Image.asset('assets/images/friday.png', fit: BoxFit.fill),
                      Image.asset('assets/images/balsam.jpg', fit: BoxFit.fill),
                      Image.asset('assets/images/cartoon.png', fit: BoxFit.fill),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // المؤشر السفلي
              SmoothPageIndicator(
                controller: _controller,
                count: 4,
                effect: const WormEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  activeDotColor: Colors.orange,
                  dotColor: Colors.grey,
                ),
              ),

              // الايقونات
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    //خدمة توصيل
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,

                            )
                        ),
                        child: IconButton(
                            onPressed: (){
                              if(checkInternetConnection(context)) {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                      return const DeptPage();
                                    }));
                              }
                            },
                            icon: const Icon(Icons.delivery_dining,color: Colors.blueAccent,size: 35,)),
                      ),

                    ),
                    //خدمة العملاء
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,

                            )
                        ),
                        child: IconButton(
                            onPressed: (){
                              if(checkInternetConnection(context)) {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                      return const DeptPage();
                                    }));
                              }
                            },
                            icon: const Icon(Icons.support_agent,color: Colors.blueAccent,size: 35,)),
                      ),

                    ),
                    //العروض
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,

                            )
                        ),
                        child: IconButton(
                            onPressed: (){
                              if(checkInternetConnection(context)) {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                      return const DeptPage();
                                    }));
                              }
                            },
                            icon: const Icon(Icons.local_offer,color: Colors.blueAccent,size: 35,)),
                      ),

                    ),
                    //الاقسام
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,

                            )
                        ),
                        child: IconButton(
                            onPressed: (){
                              if(checkInternetConnection(context)) {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                      return const DeptPage();
                                    }));
                              }
                            },
                            icon: const Icon(Icons.dashboard_customize_rounded,color: Colors.blueAccent,size: 35,)),
                      ),

                    ),
                  ],
                ),
              ),
              //نصوص الايقونات
              const Padding(
                padding: EdgeInsets.only(top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("خدمة\nتوصيل"),
                    Text("خدمة\nالعملاء"),
                    Text("العروض"),
                    Text("الأقسام "),
                  ],
                ),
              ),
              const SizedBox(height: 20,),

              //العروض
              const Align(
                // heightFactor: 1,
                  alignment: Alignment.centerRight,
                  child: Text("العروض",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20) ,),
              ),
              const SizedBox(height: 15,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // الصورة الأولى مع نصها
                    Container(
                      width: 150, // عرض كل عنصر على حدة
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                            child: Image.asset(
                              "assets/images/offer/img_0.png",
                              fit: BoxFit.fill,
                              width: double.infinity,
                              height: 150,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                           child: Column(
                             children: [
                                Text("عِـــروض البلـسم", style: TextStyle(fontSize: 16, color: Colors.black,),),
                               // Row(
                               //   children: [
                               //     Text("30000ر.ي", style: TextStyle(fontSize: 16, color: Colors.red,),),SizedBox(width: 3,),
                               //     Text("20000 ", style: TextStyle(fontSize: 16, color: Colors.grey,decoration: TextDecoration.lineThrough),),
                               //   ],
                               // ),
                             ],
                           ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 10), // مسافة بين العناصر

                    // الصورة الثانية مع نصها
                    Container(
                      width: 150,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                            child: Image.asset(
                              "assets/images/offer/img_1.png",
                              fit: BoxFit.fill,
                              width: double.infinity,
                              height: 150,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                             "ملكــي (VIP) مجدول ",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 10),

                    // الصورة الثالثة مع نصها
                    Container(
                      width: 150, // عرض كل عنصر على حدة
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                            child: Image.asset(
                              "assets/images/offer/img_2.png",
                              fit: BoxFit.fill,
                              width: double.infinity,
                              height: 150,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "سكــري مفتل فاخر",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 10),

                    // الصورة الرابعة مع نصها
                    Container(
                      width: 150,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                            child: Image.asset(
                              "assets/images/offer/img_3.png",
                              fit: BoxFit.fill,
                              width: double.infinity,
                              height: 150,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                             "رطب سكري ملكــي",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 15,),
              //الأكثر مبيعاً
              const Align(
                // heightFactor: 1,
                alignment: Alignment.centerRight,
                child: Text("الأكثر مبيعاً",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20) ,),
              ),
              const SizedBox(height: 15,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // الصورة الأولى مع نصها
                    Container(
                      width: 150, // عرض كل عنصر على حدة
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                            child: Image.asset(
                              "assets/images/offer/img_0.png",
                              fit: BoxFit.fill,
                              width: double.infinity,
                              height: 150,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text("عِـــروض البلـسم", style: TextStyle(fontSize: 16, color: Colors.black,),),
                                // Row(
                                //   children: [
                                //     Text("30000ر.ي", style: TextStyle(fontSize: 16, color: Colors.red,),),SizedBox(width: 3,),
                                //     Text("20000 ", style: TextStyle(fontSize: 16, color: Colors.grey,decoration: TextDecoration.lineThrough),),
                                //   ],
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 10), // مسافة بين العناصر

                    // الصورة الثانية مع نصها
                    Container(
                      width: 150, // عرض كل عنصر على حدة
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                            child: Image.asset(
                              "assets/images/offer/img_1.png",
                              fit: BoxFit.fill,
                              width: double.infinity,
                              height: 150,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "ملكــي (VIP) مجدول ",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 10),

                    // الصورة الثالثة مع نصها
                    Container(
                      width: 150, // عرض كل عنصر على حدة
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                            child: Image.asset(
                              "assets/images/offer/img_2.png",
                              fit: BoxFit.fill,
                              width: double.infinity,
                              height: 150,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "سكــري مفتل فاخر",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 10),

                    // الصورة الرابعة مع نصها
                    Container(
                      width: 150, // عرض كل عنصر على حدة
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                            child: Image.asset(
                              "assets/images/offer/img_3.png",
                              fit: BoxFit.fill,
                              width: double.infinity,
                              height: 150,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "رطب سكري ملكــي",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 15,),
              //أحدث المنتجات
              const Align(
                // heightFactor: 1,
                alignment: Alignment.centerRight,
                child: Text("أحدث المنتجات",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20) ,),
              ),
              const SizedBox(height: 15,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // الصورة الأولى مع نصها
                    Container(
                      width: 150, // عرض كل عنصر على حدة
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                            child: Image.asset(
                              "assets/images/offer/img_0.png",
                              fit: BoxFit.fill,
                              width: double.infinity,
                              height: 150,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text("عِـــروض البلـسم", style: TextStyle(fontSize: 16, color: Colors.black,),),
                                // Row(
                                //   children: [
                                //     Text("30000ر.ي", style: TextStyle(fontSize: 16, color: Colors.red,),),SizedBox(width: 3,),
                                //     Text("20000 ", style: TextStyle(fontSize: 16, color: Colors.grey,decoration: TextDecoration.lineThrough),),
                                //   ],
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 10), // مسافة بين العناصر

                    // الصورة الثانية مع نصها
                    Container(
                      width: 150, // عرض كل عنصر على حدة
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                            child: Image.asset(
                              "assets/images/offer/img_1.png",
                              fit: BoxFit.fill,
                              width: double.infinity,
                              height: 150,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "ملكــي (VIP) مجدول ",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 10),

                    // الصورة الثالثة مع نصها
                    Container(
                      width: 150, // عرض كل عنصر على حدة
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                            child: Image.asset(
                              "assets/images/offer/img_2.png",
                              fit: BoxFit.fill,
                              width: double.infinity,
                              height: 150,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "سكــري مفتل فاخر",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 10),

                    // الصورة الرابعة مع نصها
                    Container(
                      width: 150, // عرض كل عنصر على حدة
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                            child: Image.asset(
                              "assets/images/offer/img_3.png",
                              fit: BoxFit.fill,
                              width: double.infinity,
                              height: 150,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "رطب سكري ملكــي",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),


            ],

          ),
        ),
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
        SnackBar(
          content: Center(child: Text("لا يوجد اتصال بالإنترنت")),
          backgroundColor: Colors.red,
        ),
      );
      return false; // لا يوجد اتصال بالإنترنت
    }

    return true; // يوجد اتصال بالإنترنت
  }
}
