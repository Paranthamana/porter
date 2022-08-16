import 'package:flutter/material.dart';
import 'package:porter/widgets/small_text.dart';

class BackGroundData extends StatefulWidget {

  final String connectedWIFI;
  final String strengthWIFI;
  final String timeStamp;
  final String phoneID;
  final String buildingID;
  final String spaceID;
  final String relativePosition;
  final String userID;
  final String latitude;
  final String longitude;

  const BackGroundData({Key? key, required this.connectedWIFI, required this.strengthWIFI,
  required this.timeStamp, required this.phoneID, required this.buildingID, required this.spaceID,
  required this.relativePosition, required this.userID, required this.latitude, required this.longitude}) : super(key: key);

  @override
  State<BackGroundData> createState() => _BackGroundDataState();
}

class _BackGroundDataState extends State<BackGroundData> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [

        ],
      ),
    );
  }
}
