import 'package:flutter/material.dart';
import 'package:porter/utils/colors.dart';
import 'package:porter/utils/dimensions.dart';

enum StatusProfile { Lunch, Meeting, Available, none }

class customRadioButton extends StatelessWidget {
  customRadioButton({Key? key,
  required this.title,
  required this.value,
  required this.statusEnum,
  required this.onChanged
  }) : super(key: key);

  String title;
  StatusProfile value;
  StatusProfile? statusEnum;
  Function(StatusProfile?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return RadioListTile<StatusProfile>(
        contentPadding: EdgeInsets.all(0.8),
        value: value,
        groupValue: statusEnum,
        dense: true,
        title: Text(
          title,
          style: TextStyle(
              fontSize: Dimensions.font16,
              color: AppColors.mainBlackColor)),
        onChanged: onChanged
    );
  }
}
