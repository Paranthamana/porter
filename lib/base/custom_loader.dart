import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../utils/dimensions.dart';
class CustomLoader extends StatelessWidget {
  const CustomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //print("loading ...."+Get.find<AuthController>().isLoading.toString());
    return Center(
      child: Container(
        height: Dimensions.height20*4,
        width: Dimensions.height20*4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.height20*4/2),
          color: AppColors.appAccentColor
        ),
        alignment: Alignment.center,
        child:const CircularProgressIndicator(color: Colors.white),
      ),
    );
  }
}
