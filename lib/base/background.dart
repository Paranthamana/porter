import 'dart:async';
import 'dart:io';
import 'dart:developer' as developer;

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:wifi_hunter/wifi_hunter.dart';
import 'package:wifi_hunter/wifi_hunter_result.dart';


class BackGroundData{

  String _connectionStatus = 'Unknown';
  bool isStopped = false;
  var currentLatValue = ""; var currentLongValue = "";
  var connectionStrength = "", jsonString = "", jsonDataNew = "";
  WiFiHunterResult wiFiHunterResult = WiFiHunterResult();
  final NetworkInfo _networkInfo = NetworkInfo();


  /*Future<void> initNetworkInfo() async {
    String? wifiName,
        wifiBSSID,
        wifiIPv4,
        wifiIPv6,
        wifiGatewayIP,
        wifiBroadcast,
        wifiSubmask;

    try {
      if (!kIsWeb && Platform.isIOS) {
        var status = await _networkInfo.getLocationServiceAuthorization();
        if (status == LocationAuthorizationStatus.notDetermined) {
          status = await _networkInfo.requestLocationServiceAuthorization();
        }
        if (status == LocationAuthorizationStatus.authorizedAlways ||
            status == LocationAuthorizationStatus.authorizedWhenInUse) {
          wifiName = await _networkInfo.getWifiName();
        } else {
          wifiName = await _networkInfo.getWifiName();
        }
      } else {
        wifiName = await _networkInfo.getWifiName();
      }
    } on PlatformException catch (e) {
      developer.log('Failed to get Wifi Name', error: e);
      wifiName = 'Failed to get Wifi Name';
    }

    try {
      if (!kIsWeb && Platform.isIOS) {
        var status = await _networkInfo.getLocationServiceAuthorization();
        if (status == LocationAuthorizationStatus.notDetermined) {
          status = await _networkInfo.requestLocationServiceAuthorization();
        }
        if (status == LocationAuthorizationStatus.authorizedAlways ||
            status == LocationAuthorizationStatus.authorizedWhenInUse) {
          wifiBSSID = await _networkInfo.getWifiBSSID();
        } else {
          wifiBSSID = await _networkInfo.getWifiBSSID();
        }
      } else {
        wifiBSSID = await _networkInfo.getWifiBSSID();
      }
    } on PlatformException catch (e) {
      developer.log('Failed to get Wifi BSSID', error: e);
      wifiBSSID = 'Failed to get Wifi BSSID';
    }

    try {
      wifiIPv4 = await _networkInfo.getWifiIP();
    } on PlatformException catch (e) {
      developer.log('Failed to get Wifi IPv4', error: e);
      wifiIPv4 = 'Failed to get Wifi IPv4';
    }

    try {
      wifiIPv6 = await _networkInfo.getWifiIPv6();
    } on PlatformException catch (e) {
      developer.log('Failed to get Wifi IPv6', error: e);
      wifiIPv6 = 'Failed to get Wifi IPv6';
    }

    try {
      wifiSubmask = await _networkInfo.getWifiSubmask();
    } on PlatformException catch (e) {
      developer.log('Failed to get Wifi submask address', error: e);
      wifiSubmask = 'Failed to get Wifi submask address';
    }

    try {
      wifiBroadcast = await _networkInfo.getWifiBroadcast();
    } on PlatformException catch (e) {
      developer.log('Failed to get Wifi broadcast', error: e);
      wifiBroadcast = 'Failed to get Wifi broadcast';
    }

    try {
      wifiGatewayIP = await _networkInfo.getWifiGatewayIP();
    } on PlatformException catch (e) {
      developer.log('Failed to get Wifi gateway address', error: e);
      wifiGatewayIP = 'Failed to get Wifi gateway address';
    }

    try {
      wifiSubmask = await _networkInfo.getWifiSubmask();
    } on PlatformException catch (e) {
      developer.log('Failed to get Wifi submask', error: e);
      wifiSubmask = 'Failed to get Wifi submask';
    }

    setState(() {
      _connectionStatus = 'Wifi Name: $wifiName\n'
          'Wifi BSSID: $wifiBSSID\n'
          'Wifi IPv4: $wifiIPv4\n'
          'Wifi IPv6: $wifiIPv6\n'
          'Wifi Broadcast: $wifiBroadcast\n'
          'Wifi Gateway: $wifiGatewayIP\n'
          'Wifi Submask: $wifiSubmask\n';
    });
  }*/

  /*Future<void> initNetworkInfo() async {
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
  }*/

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

  Future<void> huntWiFis() async {
    try {
      wiFiHunterResult = (await WiFiHunter.huntWiFiNetworks)!;
      String? wifiName = await _networkInfo.getWifiName();
      var connectedWIFi = (await _networkInfo.getWifiName());
      String? deviceId = await _getId();
      String? buildingId = "12";
      String? spaceId = "14784";
      String? relativePosition = "14784";
      String? userId = "03";
      for (int index = 0; index < wiFiHunterResult.results.length; index++) {
        DateTime now = DateTime.now();
        String convertedDateTime =
            "${now.year.toString()}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}"
            " ${now.hour.toString().padLeft(2, '0')}-${now.minute.toString().padLeft(2, '0')}";

        if (wifiName == wiFiHunterResult.results[index].SSID) {
          //print("Strength : ${wiFiHunterResult.results[index].level}");
          connectionStrength = wiFiHunterResult.results[index].level.toString();
          jsonString =
          "{'connectedWIFI' : $connectedWIFi, 'wifiStrength': $connectionStrength,"
              "'timeStamp': $convertedDateTime, 'phoneID' : $deviceId,'buildingId' : $buildingId',"
              "'spaceId' : $spaceId' 'relativePosition' : $relativePosition,'USER ID':$userId, 'latitude' : $currentLatValue, 'longtitude': $currentLongValue}";
          //save("wifiData.txt", jsonString);
          //print("jsonData : $jsonString");
          //showMessage(currentLongValue + currentLatValue);
        }
      }
    } on PlatformException catch (exception) {
      print("WIFI STRENGTH ERROR : $exception");
    }
  }

  /*static Future<void> save(String filename, String content) async {
    final directory = await DownloadsPathProvider.downloadsDirectory;
    final path = '${directory.path}/$filename';
    final file = File(path);
    file.delete(recursive: true);
    print("saving $path");
    await file.writeAsString(content);
  }*/

}

