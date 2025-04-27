import 'package:ecoomerce_dbestech/data/repositoreis/auth_repo.dart';
import 'package:ecoomerce_dbestech/models/responseModel.dart';
import 'package:ecoomerce_dbestech/models/sign_up_body.dart';
import 'package:get/get.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;

  AuthController({required this.authRepo});

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<ResponseModel> registeration(SignUpBody signUpBody) async {
    _isLoading = true;
    update();
    ResponseModel responseModele;
    Response response = await authRepo.registeration(signUpBody);
    if (response.statusCode == 200) {
      print(response.body.toString());
      authRepo.saveUserToken(response.body['token']);
      responseModele = ResponseModel(true, response.body['token']);
    } else {
      responseModele = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModele;
  }

  Future<ResponseModel> logIn(String email, String password) async {
    print(authRepo.getUserToken().toString());

    _isLoading = true;
    update();
    ResponseModel responseModele;
    Response response = await authRepo.logIn(email, password);
    if (response.statusCode == 200) {
      print(response.body.toString());
      authRepo.saveUserToken(response.body['token']);
      responseModele = ResponseModel(true, response.body['token']);
    } else {
      responseModele = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModele;
  }

  void saveUserNumberandPassword(String number, String password) {
    authRepo.saveUserNumberandPassword(number, password);
  }

  bool isUserLoggedIn() {
    return authRepo.isUserLoggedIn();
  }

  bool clearSharedPrefrences() {
       return authRepo.clearSharedPrefrences();
  }
}
