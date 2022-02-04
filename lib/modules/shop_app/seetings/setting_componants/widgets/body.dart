import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:shop_app_app/modules/shop_app/cubit/cubit.dart';
import 'package:shop_app_app/modules/shop_app/cubit/states.dart';
import 'package:shop_app_app/modules/shop_app/seetings/setting_componants/widgets/custom_rounded_fieled.dart';
import 'package:shop_app_app/modules/shop_app/seetings/setting_componants/widgets/profile_pc.dart';
import 'package:shop_app_app/shared/componants/componants/componants.dart';
import 'package:shop_app_app/shared/componants/constants/constants.dart';
import 'package:shop_app_app/shared/styles/colors.dart';

class  SettingBody extends StatefulWidget {

  @override
  _SettingBodyState createState() => _SettingBodyState();
}

class _SettingBodyState extends State<SettingBody> {
  var formKey = GlobalKey<FormState>();

  var emailContrller = TextEditingController();

  var nameContrller = TextEditingController();
  var phoneContrller = TextEditingController();



  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){

        // if (state is ShopSuccessUserModelDataState){
        //   nameContrller.text=state.shopUserModel.data!.name!;
        // emailContrller .text=state.shopUserModel.data!.email!;
        //   phoneContrller.text=state.shopUserModel.data!.phone!;
        //}

      },
      builder: (context,state){
        var model =ShopCubit.get(context).shopUserModel;
        nameContrller.text=model.data!.name!;
        emailContrller.text=model.data!.email!;
        phoneContrller.text=model.data!.phone!;


        return

          Conditional.single(
            context: context,
            conditionBuilder: (BuildContext context) =>
         ShopCubit.get(context).shopUserModel != null,

        widgetBuilder: (BuildContext context) =>  SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(children: [

              if(state is ShopLoadingUpdateUserModelDataState)
                LinearProgressIndicator(),
              SizedBox(
                  height: 20
              ),

              ProfilePic(),
              SizedBox(
                  height: 60
              ),


              Container(
                  width: size.width * .9,
                  height: size.height * .06,

                  child: CostumFormField(
                    controller: nameContrller,
                    type: TextInputType.emailAddress,
                    label: 'Name',
                    prefix: Icons.person,
                    iconcolor: iconColor,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return (' Please enter your Name');
                      }
                      return null;
                    },
                    onSubmit: (String value) {
                      print(value);
                    },
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                  width: size.width * .9,
                  height: size.height * .06,

                  child: CostumFormField(
                    controller: emailContrller,
                    type: TextInputType.emailAddress,
                    label: 'Email',
                    prefix: Icons.email,
                    iconcolor: iconColor,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return (' Please enter your email address');
                      }
                      return null;
                    },
                    onSubmit: (String value) {
                      print(value);
                    },
                    isPassword: false,
                  )),

              SizedBox(
                height: 20,
              ),
              Container(
                  width: size.width * .9,
                  height: size.height * .06,

                  child: CostumFormField(
                    controller: phoneContrller,
                    type: TextInputType.phone,
                    label: 'Phone',
                    prefix: Icons.phone_android,
                    iconcolor: iconColor,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return (' Please enter your email address');
                      }
                      return null;
                    },
                    onSubmit: (String value) {
                      print(value);
                    },
                    isPassword: false,
                  )),
              SizedBox(
                height: 20,
              ),
              defultButton(function: (){
                if(
                formKey.currentState!.validate()
                ){
                  ShopCubit.get(context).getUpdateUserData(
                    email: emailContrller.text,
                    name: nameContrller.text,
                    phone: phoneContrller.text,

                  );

                }


              }, text: 'UPDATE'),
              SizedBox(
                height: 20,
              ),
               defultButton(function: (){

                 signOut(context);
               }, text: 'SIGIN OUT'),

            ]),
          ),
        ),


        fallbackBuilder: (BuildContext context) =>  Center(
          child: CircularProgressIndicator(),
        ));


















      },

    );
  }
}
