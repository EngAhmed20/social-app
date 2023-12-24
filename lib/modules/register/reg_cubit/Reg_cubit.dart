
import 'package:best_social_app/models/user_model/UserModel.dart';
import 'package:best_social_app/modules/register/reg_cubit/regState.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class SocialRegCubit extends Cubit<SocialRegState>
{
 SocialRegCubit():super(SocialRegInitialState());
  static SocialRegCubit get(context)=>BlocProvider.of(context);
 void UserRegister({
  required String name,
  required String email,
  required String pass,
  required String phone,
})
  {
    emit(SocialRegLoadingState());
  FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: pass)
      .then((value) {
        print(value.user!.email);
        UserCreate(name: name, email: email, phone: phone, uId: value.user!.uid);
        })
      .catchError((error){emit(SocialRegErrorState(error.toString()));
    });

    }
    void UserCreate({
      required String name,
      required String email,
      required String phone,
      required String uId,
})
{
  SocialUserModel model =SocialUserModel(
    name: name,
    email: email,
    phone: phone,
    uId: uId,
    image: 'https://img.freepik.com/free-photo/charming-beautiful-girl-has-afro-hairstyle_273609-28021.jpg?w=996&t=st=1676731913~exp=1676732513~hmac=33ebae0b63f520c04072545daf6f98ebf55b5a89f4877186c79b3e36c43cb45c',
    bio: 'Write your bio .......',
    cover: 'https://img.freepik.com/free-photo/happy-dark-skinned-girl-enjoys-every-moment-life-dances-moves-raises-arms-clenches-fists-closes-eyes-has-good-mood-wears-denim-sarafan-turtleneck-isolated-pink-wall_273609-42165.jpg?t=st=1670188670~exp=1670189270~hmac=f46da2a4279b52824a9e0227402f975cc3806a1d72ee8873233f646032068fc4',


  );
  FirebaseFirestore.instance.collection('users')
      .doc(uId)
      .set(model.toMap()).then((value) {
        emit(SocialCreateUserSucessState(uId));
  }).catchError((error){
    emit(SocialCreateUserErrorState(error));
  });

}

  IconData suffix= Icons.visibility_outlined;
  bool ispass=true;
  void ChangePassVisablity(){
    ispass=!ispass;
    suffix =ispass? Icons.visibility_outlined: Icons.visibility_off_outlined;
    emit(SocialRegShowPassState());

  }
}
//https://img.freepik.com/free-photo/charming-beautiful-girl-has-afro-hairstyle_273609-28021.jpg?w=996&t=st=1676731913~exp=1676732513~hmac=33ebae0b63f520c04072545daf6f98ebf55b5a89f4877186c79b3e36c43cb45c