import 'package:best_social_app/shared/components/constants.dart';
import 'package:best_social_app/shared/network/local/shared_pref/cache_helper.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants/constants.dart';
import '../../layout/layout.dart';
import '../../shared/components/Custom_text_filed.dart';
import '../register/reg_Scr.dart';
import 'login_Cubit/login_State.dart';
import 'login_Cubit/login_cubit.dart';

class SocialLoginScreen extends StatelessWidget
{
  var FormKey =GlobalKey<FormState>();
  var passController = TextEditingController();
  var emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create:(context)=>SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit,SocialLoginState>
        (
        listener: (context,state){

          if(state is SocialLoginSucessState)
            {
              CacheHelper.saveData(key: 'uId', value:state.uId ).then((value)
              {
                uId = state.uId;
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SocialLayout()))
                    .catchError((error){print(error.toString());});});
            }
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
                          'LOGIN',
                          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Login now to Communicate with friends',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                        SizedBox(
                          height: 30,
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
                            controller: passController,
                            type: TextInputType.visiblePassword,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'pls enter y password';
                              }
                            },
                            label: 'Password',
                            preficon: Icons.lock,
                            suficon: SocialLoginCubit.get(context).suffix,
                            ispass: SocialLoginCubit.get(context).ispass,
                            sufixpress: (){SocialLoginCubit.get(context).changePassVisablity();}
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        ConditionalBuilder(condition: state is! SocialLoginILoadingState, builder: (context)=>
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
                                  SocialLoginCubit.get(context).UserLogin(email: emailController.text, password: passController.text);

                                }
                              }
                                  , child: Text('Login')),
                            ),
                            fallback:(context)=> Center(child: CircularProgressIndicator())),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'don\'t have an account ',
                              style: TextStyle(color: Colors.black, fontSize: 16),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => registerScr()));
                              },
                              child: Text('Register'),
                            ),
                          ],
                        ),
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