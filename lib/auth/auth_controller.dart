
import 'package:get/get.dart';
import '../models/sign_in_response_model.dart';
import '../repository/auth_repo.dart';

class AuthController extends GetxController implements GetxService{

  final AuthRepo authRepo;

  AuthController({required this.authRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<SignInResponseModel> login(String name, String password) async {
    //  print('getting token');
    // print(authRepo.getUserToken().toString());
    _isLoading = true;
    update();
    Response response = await authRepo.login(name, password);
    late SignInResponseModel signUpResponseModel;

    if(response.statusCode == 200){
      //print('Backend token');
      authRepo.saveUserToken(response.body["token"]);
      print(response.body["response token"].toString());
      signUpResponseModel = SignInResponseModel(true, response.body['token']);
    } else{
      signUpResponseModel = SignInResponseModel(false, response.statusText!);
    }
    _isLoading =false;
    update();
    return signUpResponseModel;
  }


  void saveUserNameAndPassword(String name, String password)  {
    authRepo.saveUserNameAndPassword(name, password);
  }

  bool userLoggedIn() {
    return authRepo.userLoggedIn();
  }

}