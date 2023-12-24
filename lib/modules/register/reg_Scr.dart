import 'package:best_social_app/modules/register/reg_cubit/Reg_cubit.dart';
import 'package:best_social_app/modules/register/reg_cubit/regState.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants/constants.dart';
import '../../layout/layout.dart';
import '../../shared/components/Custom_text_filed.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/local/shared_pref/cache_helper.dart';


class registerScr extends StatelessWidget {
  // const registerScr({Key? key}) : super(key: key);
  var FormKey =GlobalKey<FormState>();
  var passController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>SocialRegCubit(),
      child: BlocConsumer<SocialRegCubit,SocialRegState>(
        listener: (context,state){

          if(state is SocialCreateUserSucessState)
            {
              CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
                uId = state.uId;
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => SocialLayout()));
              }); }


        },
        builder: (context,state){
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: FormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Register',
                          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Register  now to Communicate with friends',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        defaulttextform(
                            controller: nameController,
                            type: TextInputType.name,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'pls enter y name';
                              }
                            },
                            label: 'User Name',
                            preficon: Icons.person),
                        SizedBox(
                          height: 15,
                        ),
                        defaulttextform(
                            controller: passController,
                            type: TextInputType.visiblePassword,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'pls enter y password';
                              }
                            },
                            label: 'Password',
                            preficon: Icons.lock,
                            suficon: SocialRegCubit.get(context).suffix,
                            ispass: SocialRegCubit.get(context).ispass,
                            sufixpress: (){SocialRegCubit.get(context).ChangePassVisablity();}
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        defaulttextform(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'pls enter y email address';
                              }
                            },
                            label: 'Email',
                            preficon: Icons.email),
                        SizedBox(
                          height: 15,
                        ),
                        defaulttextform(
                            controller: phoneController,
                            type: TextInputType.emailAddress,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'pls enter y Phone Number';
                              }
                            },
                            label: 'Phone Number',
                            preficon: Icons.phone),
                        SizedBox(
                          height: 15,
                        ),

                        ConditionalBuilder(condition:state is! SocialRegLoadingState, builder: (context)=>
                            Container(
                              height: 50,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: MaterialButton(onPressed: () {
                                if(FormKey.currentState!.validate())
                                {
                                  SocialRegCubit.get(context).UserRegister(email: emailController.text, pass: passController.text
                                      ,phone: phoneController.text,name: nameController.text);

                                }
                              }
                                  , child: Text('Register')),
                            ),
                            fallback:(context)=> Center(child: CircularProgressIndicator())),

                      ],
                    ),
                  ),
                ),
              ),
            ),



          );
        },
      ),
    );
  }
}
