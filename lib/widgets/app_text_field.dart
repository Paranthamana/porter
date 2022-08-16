import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../utils/dimensions.dart';

class AppTextField extends StatelessWidget {

  final TextEditingController textController;
  final IconData icon;
  bool keyBoardType;
  bool isObscure;
  bool textInput;
  String hintText;


  AppTextField({Key? key, required this.textController,
    required this.hintText,
    required this.icon,
    this.isObscure=false,
    required this.keyBoardType,
    required this.textInput,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: Dimensions.height20, right: Dimensions.height20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimensions.radius15),
          boxShadow: [
            BoxShadow(
                blurRadius: 3,
                spreadRadius: 3,
                offset: Offset(1,1),
                color: Colors.grey.withOpacity(0.2)
            )
          ]
      ),
      child: TextField(
              obscureText: isObscure?true:false,
              keyboardType: keyBoardType?TextInputType.text:TextInputType.number,
              textInputAction: textInput?TextInputAction.next:TextInputAction.done,
              controller: textController,
              decoration: InputDecoration(
                  hintText: hintText,
                  prefixIcon: Icon(icon,color: AppColors.appAccentColor),
                  focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radius15),
                  borderSide: BorderSide(
                  width: Dimensions.width5,
                  color: Colors.white
              )
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius15),
              borderSide: BorderSide(
                  width: Dimensions.width5,
                  color: Colors.white
              )
          )
      ),
    ),
    );
  }
}
