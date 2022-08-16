import 'dart:async';
import 'dart:developer' as developer;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:permission_handler/permission_handler.dart' as path;
import 'package:porter/utils/dimensions.dart';
import '../routes/route_helper.dart';
import '../utils/colors.dart';
import 'package:network_info_plus/network_info_plus.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin  {

  late Animation<double> animation;
  late AnimationController controller;
  String _connectionStatus = 'Unknown';
  final NetworkInfo _networkInfo = NetworkInfo();

  @override
  void initState() {
    super.initState();
    askPermission();
    controller = AnimationController(
        vsync: this,duration:
    const Duration(seconds: 10))..forward();

    animation =  CurvedAnimation(
        parent: controller,
        curve: Curves.ease);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
             ScaleTransition(
               scale: animation,
               child: Center(
                  child: Image.asset("assets/image/icon.png",
                      width: Dimensions.spalshImg,height: 100))),
                  SizedBox(height: Dimensions.height20),
                Center(
                    child: Text("Healthnable",
                    style: TextStyle(
                    color: AppColors.appPrimaryColor,
                    fontSize: Dimensions.height45,
                    fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }

  Future<bool> askPermission() async {
    path.PermissionStatus status = await Permission.location.request();
    await Permission.storage.request();
    await Permission.accessMediaLocation.request();
    await Permission.manageExternalStorage.request();
    Permission.storage.request();
    if (status.isDenied == true) {
      askPermission();
    } else {
      Timer(const Duration(seconds: 5), ()=>Get.offNamed(RouteHelper.getSignInPage()));
      initNetworkInfo();
      return true;
    }
    return false;
  }


    Future<void> initNetworkInfo() async {
      String? wifiName, wifiBSSID;
      try {
        wifiName = await _networkInfo.getWifiName();
      } on PlatformException catch (e) {
        developer.log('Failed to get Wifi Name', error: e);
        wifiName = 'Failed to get Wifi Name';
      }
      try {
        wifiBSSID = await _networkInfo.getWifiBSSID();
        //}
      } on PlatformException catch (e) {
        developer.log('Failed to get Wifi BSSID', error: e);
        wifiBSSID = 'Failed to get Wifi BSSID';
      }

      if (mounted) {
        setState(() {
          _connectionStatus = 'Wifi Name: $wifiName\n'
              'Wifi BSSID: $wifiBSSID\n';
        });
      }
    }
}
