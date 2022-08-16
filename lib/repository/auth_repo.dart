import 'package:get/get.dart';
import 'package:porter/auth/sign_in_page.dart';
import 'package:porter/models/sign_in_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api_client.dart';
import '../utils/constants.dart';

class AuthRepo{

  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({required this.apiClient,required this.sharedPreferences});

  Future<Response> registration(SignInBody signInBody) async{
    return await apiClient.postData(AppConstants.REGISTRATION_URI, signInBody.toJson());
  }

  bool userLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.TOKEN);
  }

  Future<String> getUserToken() async{
    return await sharedPreferences.getString(AppConstants.TOKEN)??"None";
  }

  Future<Response> login(String name, String password) async{
    return await apiClient.postData(AppConstants.LOGIN_URI, {"userName":name,"password":password});
  }

  Future<bool> saveUserToken(String token)async{
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstants.TOKEN, token);
  }

  Future<void> saveUserNameAndPassword(String name, String password) async {
    try{
      await sharedPreferences.setString(AppConstants.NAME, name);
      await sharedPreferences.setString(AppConstants.PASSWORD, password);
    }catch(e){
      throw e;
    }
  }

  Future<void> saveAvailable(int available)async {
    await sharedPreferences.setInt(AppConstants.available, available);
    var saveddata = sharedPreferences.setInt(AppConstants.available, available);
    print("Here saved" + saveddata.toString());
  }

  Future<void> getStatusAvailable() async{
     await sharedPreferences.getInt(AppConstants.available)??"None";
  }

  Future<void> saveLunch(int lunch)async {
    await sharedPreferences.setInt(AppConstants.lunch, lunch);
    var saveddata = sharedPreferences.setInt(AppConstants.lunch, lunch);
    print("Here saved" + saveddata.toString());
  }

  Future<void> getStatusLunch() async{
    sharedPreferences.getInt(AppConstants.lunch)??"None";
  }

  Future<void> saveMeeting(int meeting)async {
    await sharedPreferences.setInt(AppConstants.meeting, meeting);
    var saveddata = sharedPreferences.setInt(AppConstants.meeting, meeting);
    print("Here saved" + saveddata.toString());
  }

  Future<void> getStatusMeeting() async{
    sharedPreferences.getInt(AppConstants.meeting)??"None";
  }

  bool clearSharedData(){
    sharedPreferences.remove(AppConstants.TOKEN);
    sharedPreferences.remove(AppConstants.PASSWORD);
    sharedPreferences.remove(AppConstants.NAME);
    apiClient.token="";
    apiClient.updateHeader("");
    return true;
  }

}