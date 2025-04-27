import '/data/repositoreis/recomendedRepo.dart';
import 'package:get/get.dart';
import '/controllers/popularProductsController.dart';
import '../models/products_model.dart';

class RecomendedProductsController extends GetxController {
  final RecomendedProDuctRepo recomendedProDuctRepo;

  List<dynamic> _recomendedProductsList = [];
  List<dynamic> get recommendedProductsList =>
      _recomendedProductsList; // cause u dont wanna dy=urectly access the privet one from outside

  RecomendedProductsController({required this.recomendedProDuctRepo});
  bool _isLoaded = false;
  bool get isLoaded  =>_isLoaded;
  Future<void> getRecommendedProductsList() async {
    Response response = await recomendedProDuctRepo.getRecommendedProductList();
    if (response.statusCode == 200) {
      print("got products");
      _recomendedProductsList = []; // u empty it so no left over from previus ops
      _recomendedProductsList.addAll(
          Product.fromJson(response.body).products );
      _isLoaded =true;
      update();
    } else {}
  }
}
