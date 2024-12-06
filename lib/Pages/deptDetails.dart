
import 'package:albalsm/Authentication/ConnectivityProvider.dart';
import 'package:albalsm/Data/producesData.dart';
import 'package:albalsm/Model/producesModel.dart';
import 'package:albalsm/Pages/deptPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:albalsm/Pages/shopPage.dart';

class DeptDetails extends StatefulWidget {
  const DeptDetails({super.key});

  @override
  State<DeptDetails> createState() => _DeptDetailsState();
}

class _DeptDetailsState extends State<DeptDetails> {
  List<ProducesModel> pro = ProducesData().getproducesData();
  List<ProducesModel> cart = []; // قائمة السلة

  void addToCart(ProducesModel item) {
    setState(() {
      cart.add(item); // إضافة العنصر إلى السلة
    });
  }

  // دالة لزيادة الكمية
  void _incrementQuantity(int index) {
    setState(() {
      pro[index].quantity++;
      pro[index].totalPrice = pro[index].price * pro[index].quantity;
    });
  }

  // دالة لتقليل الكمية
  void _decrementQuantity(int index) {
    if (pro[index].quantity > 1) {
      setState(() {
        pro[index].quantity--;
        pro[index].totalPrice = pro[index].price * pro[index].quantity;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('تـسـوق الان')),
          backgroundColor: const Color(0x0f5f75d1),
          leading: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              IconButton(
                onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                        return const DeptPage();
                      }));
                },
                icon: const Icon(Icons.keyboard_backspace_sharp, size: 28,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white70,
        body: StaggeredGridView.countBuilder(
          itemCount: pro.length,
          crossAxisCount: 2,
          itemBuilder: (context, index) {
            return Card(
              color: const Color(0x0fff77d2),
              child: Column(
                children: [
                  Text("${pro[index].name}"),
                  Container(
                    height: 160,
                    width: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20), // نصف القطر
                      image: DecorationImage(
                        image: AssetImage(pro[index].img.toString()),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text("السعر : ${pro[index].price} ر.ي"),

                  // التحكم في الكمية
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () => _incrementQuantity(index),
                      ),
                      Text(
                        '${pro[index].quantity}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () => _decrementQuantity(index),
                      ),
                    ],
                  ),
                  // السعر الإجمالي
                  Text(
                    'الإجمالي: ${pro[index].totalPrice.toStringAsFixed(0)} ر.ي',
                    style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        //backgroundColor: const Color(0x0f5f75d1),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(28),
                              bottomRight: Radius.circular(8),
                              bottomLeft: Radius.circular(28),
                            )
                        )
                    ),
                    onPressed: () {
                      if(checkInternetConnection(context)) {
                        addToCart(pro[index]); // إضافة العنصر للسلة
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShopPage(cart: cart),
                          ),
                        );
                      }
                    },
                    icon: const Icon(
                      Icons.shopping_cart,
                      color: Colors.deepOrange,
                    ),
                    label: const Text(
                      "أضف إلى السلة",
                      style: TextStyle(color: Colors.deepOrange, fontSize: 15),
                    ),
                  ),
                ],
              ),
            );
          },
          staggeredTileBuilder: (index) {
            return const StaggeredTile.count(1, 1.9);
          },
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
