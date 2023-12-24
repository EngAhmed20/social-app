import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_State.dart';


class SocialLoginCubit extends Cubit<SocialLoginState>
{
  SocialLoginCubit():super(SocialLoginInitialState());
  static SocialLoginCubit get(context)=>BlocProvider.of(context);
//  SocialLoginModel? loginModel;
  IconData suffix= Icons.visibility_outlined;
  bool ispass= true;
  void changePassVisablity(){
    suffix= ispass?Icons.visibility_outlined:Icons.visibility_off_outlined;
    ispass=!ispass;
    emit(SocialLoginIShowPassState());

  }

  void UserLogin({required String email,required String password})
  {
    emit(SocialLoginILoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
          emit(SocialLoginSucessState(value.user!.uid));}).catchError((error){
      print(error.toString());
      emit(SocialLoginErrorState(error.toString()));
    });

  }
 /* SocialUserModel? userModel;

  void getUser() {
    emit(GetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(userModel!.uId).get().then((value) {
      userModel = SocialUserModel.fromJson(value.data()!);
      emit(GetUserSuccessState());
    }).catchError((error) {
      print(error);
      emit(GetUserErrorState(error.toString()));
    });*/
  }



