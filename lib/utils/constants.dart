import 'package:porter/pages/home/drawer_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConstants{
  static const String APP_NAME = "Ontabee";
  static const int APP_VERSION = 1;



  //static const String BASE_URL ="http://103.177.225.48/";
  static const String BASE_URL ="http://103.177.225.48/";
  static const String POPULAR_PRODUCT_URI ="/api/v1/products/popular";
  //static const String RECOMMENDED_PRODUCT_URI ="/api/v1/products/recommended";

  //---auth end points
  static const String REGISTRATION_URI ="";
  static const String LOGIN_URI ="assets_api/api/v0/Authenticate";
  //static const String LOGIN_URI ="/api/v1/auth/login";


  static const String TOKEN = "";
  static const String NAME = "";
  static const String PASSWORD = "";

  static const String available = "";
  static const String lunch = "";
  static const String meeting = "";

  static const String UPLOAD_URL = "/uploads/";
  static const String CART_LIST = "cart-list";
  static const String CART_HISTORY_LIST = "cart-history-list";


}