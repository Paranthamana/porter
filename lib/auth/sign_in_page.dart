import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:porter/auth/auth_controller.dart';

import '../base/custom_loader.dart';
import '../base/show_custom_snackbar.dart';
import '../routes/route_helper.dart';
import '../utils/colors.dart';
import '../utils/dimensions.dart';
import '../widgets/app_text_field.dart';
import '../widgets/big_text.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  void initState() {
     super.initState();
     emailController = TextEditingController(text: 'John');
     passwordController = TextEditingController(text: 'Password');
  }

  @override
  Widget build(BuildContext context) {

    void _login(AuthController authController) {
      String name = emailController.text.trim();
      String password = passwordController.text.trim();

      if (name.isEmpty) {
        showCustomSnackBar("check your user name", title: "User name");
      } else if (password.isEmpty) {
        showCustomSnackBar("check your password", title: "Password");
      } else if (password.length < 6) {
        showCustomSnackBar("Password can not be less than six characters",
            title: "Password");
      } else {
        authController.login(name, password).then((status) {
          if (status.isSuccess) {
            Get.toNamed(RouteHelper.getInitial());
            showCustomSnackBar(title: "Great..!","Login Success");
          } else {
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: GetBuilder<AuthController>(builder: (authController) {
          return !authController.isLoading ? Center(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(height: Dimensions.screenHeight * 0.05),
                        //--App logo
                        SizedBox(
                          //height: Dimensions.screenHeight*0.20,
                          child: Center(
                            child: Image(
                                image: const AssetImage("assets/image/applogo.png"),
                                height: Dimensions.height45 * 2,
                                width: Dimensions.height45 * 8),
                            //child: Image( image: AssetImage("assets/image/applogo.png")),
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.only(left: Dimensions.width30),
                          width: double.maxFinite,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BigText(
                                  text: "Sign In",
                                  size: Dimensions.font20 * 1 +
                                      Dimensions.font20 / 2,
                                  color: AppColors.mainBlackColor)
                            ],
                          ),
                        ),
                        SizedBox(height: Dimensions.height30),
                        //-- email field
                        AppTextField(
                            textController: emailController,
                            hintText: "Email",
                            icon: Icons.email,
                            keyBoardType: true,
                            textInput: true),
                        SizedBox(height: Dimensions.height20),

                        //---password field
                        AppTextField(
                            textController: passwordController,
                            hintText: "password",
                            icon: Icons.password_sharp,
                            isObscure: true,
                            keyBoardType: true,
                            textInput: false),
                        SizedBox(height: Dimensions.height30),

                        Row(
                          children: [
                            Expanded(child: Container()),
                            RichText(
                              text: TextSpan(
                                  //recognizer: TapGestureRecognizer()..onTap=()=>Get.back(),
                                  text: "forgot password?",
                                  style: TextStyle(
                                      color: Colors.grey[500],
                                      fontSize: Dimensions.font20)),
                            ),
                            SizedBox(width: Dimensions.width30),
                          ],
                        ),

                        SizedBox(height: Dimensions.height45),
                        //--signIn button
                        GestureDetector(
                          onTap: () {
                            _login(authController);
                          },
                          child: Container(
                            width: Dimensions.screenWidth / 2.4,
                            height: Dimensions.screenHeight / 15,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius30),
                                color: AppColors.appAccentColor),
                            child: Center(
                                child: BigText(
                                    text: "Sign In",
                                    size: Dimensions.font20 +
                                        Dimensions.font20 / 4,
                                    color: Colors.white)),
                          ),
                        ),

                        SizedBox(height: Dimensions.height45),
                        //--- Don't Have account text
                        Visibility(
                          visible: false,
                          child: RichText(
                            text: TextSpan(
                                //recognizer: TapGestureRecognizer()..onTap=()=>Get.back(),
                                text: "Don't have an account?",
                                style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: Dimensions.font26),
                                children: [
                                  TextSpan(
                                      // recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>SignUpPage(), transition: Transition.downToUp),
                                      text: " Create",
                                      style: TextStyle(
                                          color: AppColors.mainBlackColor,
                                          fontSize: Dimensions.font26,
                                          fontWeight: FontWeight.bold))
                                ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ) : CustomLoader();}));
  }


}
