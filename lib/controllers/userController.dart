import 'package:ecoomerce_dbestech/data/repositoreis/auth_repo.dart';
import 'package:ecoomerce_dbestech/data/repositoreis/user_repo.dart';
import 'package:ecoomerce_dbestech/models/responseModel.dart';
import 'package:ecoomerce_dbestech/models/sign_up_body.dart';
import 'package:ecoomerce_dbestech/models/userModel.dart';
import 'package:get/get.dart';

class UserController extends GetxController implements GetxService {
  final UserRepo userRepo;

  UserController({required this.userRepo});

  bool _isLoading = true;
  late UserModel _userModel;

  bool get isLoading => _isLoading;

  UserModel get userModel => _userModel;

  Future<ResponseModel> getUserInfo() async {
    late ResponseModel responseModele;
    Response response = await userRepo.getUserInfo();
    if (response.statusCode == 200) {
      print(response.body.toString());
      //used this cause u want the hole body not only one field
      _userModel = UserModel.fromJson(response.body);
      // userRepo.saveUserToken(response.body['token']);
      responseModele = ResponseModel(true, "successful");
      _isLoading = false;
    } else {
      responseModele = ResponseModel(false, response.statusText!);
    }

    update();
    return responseModele;
  }
}
