import 'package:albalsm/Pages/deptDetails.dart';
import 'package:flutter/material.dart';
import 'package:albalsm/Model/producesModel.dart';

class ShopPage extends StatelessWidget {
  final List<ProducesModel> cart; // استقبال السلة كمعلمة

  const ShopPage({Key? key, required this.cart}) : super(key: key); // اجعل cart معلمة مطلوبة

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('السلة')),
          backgroundColor: Colors.blueAccent,
          leading: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              IconButton(
                onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                        return const DeptDetails();
                      }));
                },
                icon: const Icon(Icons.keyboard_backspace_sharp, size: 28,
                ),
              ),
            ],
          ),
        ),
        body: cart.isEmpty
            ? const Center(
                child: Text(
                  "السلة فارغة",
                  style: TextStyle(fontSize: 20),
                ),
              )
            : ListView.builder(
          itemCount: cart.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading: Image.asset(cart[index].img),
                title: Text(cart[index].name),
                subtitle: Text('السعر : ${cart[index].totalPrice} ر.ي'),
                trailing: Text('الكمية  :  ${cart[index].quantity}'),
              ),
            );
          },
        ),
      ),
    );
  }
}
