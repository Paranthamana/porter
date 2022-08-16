import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:porter/routes/route_helper.dart';
import 'package:porter/utils/colors.dart';
import 'helper/dependencies.dart'as dep;


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PORTER',
      theme: ThemeData(primarySwatch: Colors.cyan),
      initialRoute: RouteHelper.getSplashPage(),
      getPages: RouteHelper.routes,
    );
  }
}
