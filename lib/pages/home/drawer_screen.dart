import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:porter/routes/route_helper.dart';
import 'package:porter/widgets/big_text.dart';
import 'package:custom_switch/custom_switch.dart';
import 'package:porter/widgets/radio_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../repository/auth_repo.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import 'package:enum_to_string/enum_to_string.dart';



class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}
bool isSwitched = true;
int selectedValue = 0;
//StatusProfile value = StatusProfile.none;

class _DrawerScreenState extends State<DrawerScreen> {

   _saveSwitch() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool("checkIn", isSwitched);
  }

  Future<void> saveAvailable() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setInt("available", selectedValue);
    await preferences.setInt("lunch", selectedValue);
    await preferences.setInt("meeting", selectedValue);
    print("here set :$selectedValue");
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
          width: Dimensions.width30*9,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(Dimensions.height10),
                color: AppColors.appAccentColor,
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        width: Dimensions.width10*15,
                        height: Dimensions.width10*11,
                        margin: EdgeInsets.only(top: Dimensions.height20),
                        //child: new Image.asset("images/icon.png"),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://randomuser.me/api/portraits/men/11.jpg"),
                              fit: BoxFit.fill),
                        ),
                      ),
                      SizedBox(height: Dimensions.height10),
                      BigText(text: "Porter 1", size: Dimensions.font26,color: Colors.white),
                      SizedBox(height: Dimensions.height10),
                      const Text(
                        "SENIOR PORTER",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                          Padding(
                            padding: EdgeInsets.all(Dimensions.height20),
                            child: BigText(
                                text: "Check In",
                                color: AppColors.mainBlackColor,
                                size: Dimensions.font26-5),
                          ),
                      Padding(
                        padding: EdgeInsets.all(Dimensions.height15),
                        child: CustomSwitch(
                          activeColor: AppColors.appAccentColor,
                          value: isSwitched,
                          onChanged: (bool value) {
                            setState(() {
                              isSwitched = value;
                              _saveSwitch();
                            });
                          },
                        ),
                      ),
                      ],
                  ),
              ),
              const Divider(
                color: AppColors.textColor,
                height: 2.0,
                thickness: 1.0,
              ),
              SizedBox(height: Dimensions.height5-4),
              Center(
                child: Padding(
                  padding: EdgeInsets.all(Dimensions.width5/2),
                  child: BigText(
                    text: "Status Update",
                    size: Dimensions.font20,
                    color: AppColors.mainBlackColor),
                ),
              ),
              const Divider(
                color: Colors.black12,
                height: 2.0,
                thickness: 1.0,
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RadioListTile<int>(
                        value: 1,
                        groupValue: selectedValue,
                        title: const Text('Available'),
                        onChanged: (value) async {
                          setState(() {
                            selectedValue = value!;
                            saveAvailable();
                          });
                          //print("set status values are : " + selectedValue.toString());
                        }
                    ),RadioListTile<int>(
                        value: 2,
                        groupValue: selectedValue,
                        title: const Text('Lunch'),
                        onChanged: (value) async {
                          setState(() {
                            selectedValue = value!;
                            saveAvailable();
                            //saveLunch();
                          });
                         // print("set status values are : " + selectedValue.toString());
                        }
                    ),RadioListTile<int>(
                        value: 3,
                        groupValue: selectedValue,
                        title: const Text('Meeting'),
                        onChanged: (value) async {
                          setState(() {
                            selectedValue = value!;
                            saveAvailable();
                            //saveMeeting();
                          });
                         // print("set status values are : " + selectedValue.toString());
                        }
                    ),
                    const Divider(
                      color: Colors.black12,
                      height: 2.0,
                      thickness: 1.0,
                    ),
                    GestureDetector(
                      onTap: (){
                        Get.toNamed(RouteHelper.getAddJob());
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: BigText(
                          text: "Add Job",
                          color: AppColors.mainBlackColor,
                          size: Dimensions.font26,),
                      ),
                    ),
                    const Divider(
                      color: Colors.black12,
                      height: 2.0,
                      thickness: 1.0,
                    ),
                  ],
                ),
              )
            ],
          ),
      ),
    );
  }

}
