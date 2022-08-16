import 'package:get/get.dart';

import '../auth/sign_in_page.dart';
import '../pages/addJob/add_job.dart';
import '../pages/home/home_page.dart';
import '../splash/splash_page.dart';

class RouteHelper{

  static const String initial ="/";
  static const String splashPage = "/splash-page";
  static const String signIn = "/sign-in";
  static const String addJob = "/add-job";


  static String getInitial()=>initial;
  static String getSplashPage()=>splashPage;
  static String getSignInPage()=>signIn;
  static String getAddJob()=>addJob;

  static List<GetPage> routes =[
  GetPage(name: splashPage, page: ()=>const SplashScreen()),
  GetPage(name: signIn, page: ()=>const SignInPage(),transition: Transition.fadeIn),
  GetPage(name: initial, page: ()=>const HomePage()),
  GetPage(name: addJob, page: ()=>const AddJobDetails(),transition: Transition.fadeIn),
  ];
}