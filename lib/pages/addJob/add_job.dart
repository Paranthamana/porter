import 'package:flutter/material.dart';
import 'package:porter/utils/colors.dart';
import 'package:porter/utils/dimensions.dart';
import 'package:porter/widgets/app_text_field.dart';
import 'package:porter/widgets/big_text.dart';

class AddJobDetails extends StatefulWidget {
  const AddJobDetails({Key? key}) : super(key: key);

  @override
  State<AddJobDetails> createState() => _AddJobDetailsState();
}

class _AddJobDetailsState extends State<AddJobDetails> {

  @override
  Widget build(BuildContext context) {

    var activityController = TextEditingController();
    var patientTagController = TextEditingController();
    var patientNameController = TextEditingController();
    var fromLocationController = TextEditingController();
    var toLocationController = TextEditingController();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          backgroundColor: AppColors.appAccentColor,
          title: BigText(text: "Add Job", size: Dimensions.font26, color: Colors.white),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
          child: Form(
            child: Column(
                 children: [
                 //--- activity field
                   SizedBox(height: Dimensions.height30),
                   AppTextField(
                     textController: activityController,
                     hintText: "Activity",
                     icon: Icons.local_activity,
                     keyBoardType: true,
                     textInput: true),
                   SizedBox(height: Dimensions.height15),

                 //---patient tag no field
                   AppTextField(
                     textController: patientTagController,
                     hintText: "Patient Tag Number",
                     icon: Icons.tag,
                     keyBoardType: true,
                     textInput: true),
                   SizedBox(height: Dimensions.height15),

                 //---- patient name field
                   AppTextField(
                       textController: patientNameController,
                       hintText: "Patient Name",
                       icon: Icons.person,
                       keyBoardType: true,
                       textInput: true),
                   SizedBox(height: Dimensions.height15),

                  //--- patient form location field
                   AppTextField(
                       textController: fromLocationController,
                       hintText: "From Location",
                       icon: Icons.location_on,
                       keyBoardType: true,
                       textInput: true),
                   SizedBox(height: Dimensions.height15),

                 //--- patient to location field
                   AppTextField(
                       textController: toLocationController,
                       hintText: "To Location",
                       icon: Icons.my_location,
                       keyBoardType: true,
                       textInput: true),
                   SizedBox(height: Dimensions.height45),

                  //---- submit button
                   Container(
                       width: Dimensions.width30*10,
                       height: Dimensions.height45+5,
                       decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(Dimensions.radius30),
                           color: AppColors.appAccentColor
                       ),
                       child: RaisedButton(
                           color: AppColors.appAccentColor,
                           onPressed: () {},
                           child: BigText(
                               text: "Submit job details",
                               color: Colors.white,
                               size: Dimensions.font26),
                       ))],
          ),
        ),
        ),
      ),

    );
  }
}
