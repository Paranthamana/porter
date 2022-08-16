import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api_client.dart';
import '../auth/auth_controller.dart';
import '../repository/auth_repo.dart';
import '../utils/constants.dart';

Future<void> init() async{

  final sharedPrefrences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPrefrences);
  //api clients
  Get.lazyPut(() => ApiClient(appBaseUrl:AppConstants.BASE_URL));
  Get.lazyPut(()=>AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));


  // repository
  Get.lazyPut(()=>AuthController(authRepo: Get.find()));
}