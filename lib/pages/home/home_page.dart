import 'dart:async';
import 'dart:io';
import 'dart:developer' as developer;

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:porter/utils/colors.dart';
import 'package:porter/widgets/big_text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wifi_hunter/wifi_hunter.dart';
import 'package:wifi_hunter/wifi_hunter_result.dart';
import '../../utils/dimensions.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';

import 'drawer_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String _connectionStatus = 'Unknown';
  var currentLatValue = ""; var currentLongValue = "";
  var connectedWIFi = ""; var connectionStrength = "";
  var jsonString = "";var jsonDataNew = "";

  bool isStopped = false;
  WiFiHunterResult wiFiHunterResult = WiFiHunterResult();
  final NetworkInfo _networkInfo = NetworkInfo();

  @override
  void initState() {
    _saveSwitch();
    getValueStatus();
    super.initState();
    timerLoading();
  }


  @override
  void dispose() {
    isStopped = true;
    super.dispose();
  }

  //--- save check in status
  _saveSwitch() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      isSwitched = preferences.getBool("checkIn")!;
    });
  }

  void getValueStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if(prefs.getInt("available") != null){
      setState(() => selectedValue = prefs.getInt("available")!);
    } else if(prefs.getInt("lunch") != null) {
      setState(() => selectedValue = prefs.getInt("lunch")!);
    } else if(prefs.getInt("meeting") != null) {
      setState(() => selectedValue = prefs.getInt("meeting")!);
    }
    print("getting status : " + selectedValue.toString());
  }

  //---timer fetching background data 10 seconds once.
  Future<void> timerLoading() async {
    Timer.periodic(const Duration(seconds: 10), (timer) {
      if(isStopped){
          timer.cancel();
      }
      _initNetworkInfo();
      huntWiFis();
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.appAccentColor,
          title: const Text(
            'My Task',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        drawer: const DrawerScreen(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: Dimensions.height45*5.5,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, left: 5.0, right: 5.0, bottom: 8.0),
                child: GestureDetector(
                  onTap: () {
                    /* Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProgressJobListScreen()));*/
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    color: const Color(0xffFFB38F),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BigText(text: "New Job", size: Dimensions.font20,
                                    color: AppColors.mainBlackColor),
                                SizedBox(height: Dimensions.height20),
                                Text("patient Name : " " " + "Hello",
                                    style: TextStyle(
                                      fontSize: Dimensions.font20,
                                      color: AppColors.mainBlackColor,
                                    )),
                                 SizedBox(height: Dimensions.height20),
                                const Text("Job Id : " " " + "Hello",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: AppColors.paraColor,
                                    )),
                                SizedBox(height: Dimensions.height20),
                                const Text("Location : " " " + "Hello",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: AppColors.paraColor,
                                    )),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: Dimensions.width20),
                        Image.asset("assets/image/correct.png",
                          height: 50,
                          width: 80,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: Dimensions.height10),
            Container(
              margin: EdgeInsets.symmetric(horizontal: Dimensions.width15),
              child: const Text("Previous Task",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black,
                  )),
            ), //SizedBox(height: size.height * 0.01),
          ],
        ),
      ),
    );
  }



  /* WiFi and background data fetching details using wifi_hunter plugin*/

  Future<void> huntWiFis() async {
    try {
      wiFiHunterResult = (await WiFiHunter.huntWiFiNetworks)!;
      String? wifiName = await _networkInfo.getWifiName();
      connectedWIFi = (await _networkInfo.getWifiName())!;

      String? deviceId = await _getId();
      String? buildingId = "12";
      String? spaceId = "14784";
      String? relativePosition = "14784";
      String? userId = "03";

      for (int index = 0; index < wiFiHunterResult.results.length; index++) {
        DateTime now = DateTime.now();
        String convertedDateTime = "${now.year.toString()}-"
            "${now.month.toString().padLeft(2, '0')}-"
            "${now.day.toString().padLeft(2, '0')}"
            " ${now.hour.toString().padLeft(2, '0')}-"
            "${now.minute.toString().padLeft(2, '0')}";

        if (wifiName == wiFiHunterResult.results[index].SSID) {
         // print("Strength : ${wiFiHunterResult.results[index].level}");
          connectionStrength = wiFiHunterResult.results[index].level.toString();
          jsonString = "{'connectedWIFI' : $connectedWIFi, "
              "'wifiStrength': $connectionStrength,"
              "'timeStamp': $convertedDateTime, "
              "'phoneID' : $deviceId,"
              "'buildingId' : $buildingId',"
              "'spaceId' : $spaceId' "
              "'relativePosition' : $relativePosition,"
              "'USER ID':$userId, "
              "'latitude' : $currentLatValue, "
              "'longtitude': $currentLongValue}";

          save("wifiData.txt", jsonString);
          //print("jsonData : $jsonString");
          //showMessage(currentLongValue + currentLatValue);
        }
      }
    } on PlatformException catch (exception) {
      print("WIFI STRENGTH ERROR : $exception");
    }
  }


  /*save current data into local storage as txt format using downloads_path_provider plugin */
  static Future<void> save(String filename, String content) async {
    final directory = await DownloadsPathProvider.downloadsDirectory;
    final path = '${directory.path}/$filename';
    final file = File(path);
    file.delete(recursive: true);
    //print("saving $path");
    await file.writeAsString(content);
  }

  /*Fetching mobile device id using device_info_plus plugin */
  Future<String?> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) { // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if(Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId; // unique ID on Android
    }
  }

  //--- need any other data check in pub dev using this plugin details.
  Future<void> _initNetworkInfo() async {
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
