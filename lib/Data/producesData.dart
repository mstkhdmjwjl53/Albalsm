import 'package:albalsm/Model/producesModel.dart';

class ProducesData {
  List<ProducesModel> produces = [];

  List<ProducesModel> getproducesData() {

    produces.add(ProducesModel(id: 1, name: "عسل سدر", price:40000, img: "assets/images/honey.png",));
    produces.add(ProducesModel(id: 2, name: "عسل سمر", price:20000, img: "assets/images/honey.png",));
    produces.add(ProducesModel(id: 3, name: "عسل سدر", price:40000, img: "assets/images/honey.png",));
    produces.add(ProducesModel(id: 1, name: "عسل سدر", price:40000, img: "assets/images/honey.png",));
    produces.add(ProducesModel(id: 2, name: "عسل سمر", price:20000, img: "assets/images/honey.png",));
    produces.add(ProducesModel(id: 3, name: "عسل سدر", price:40000, img: "assets/images/honey.png",));

    return produces;
  }
}
