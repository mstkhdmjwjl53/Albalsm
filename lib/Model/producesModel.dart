
class ProducesModel {

   int id;
   String name;
   String img;
   double price;
  int quantity;
  double totalPrice;

  ProducesModel({
    required this.id,
    required this.name,
    required this.img,
    required this.price,
    this.quantity = 1,
    double? totalPrice,
  }) : totalPrice = totalPrice ?? price;
}
