//import 'dart:html';

import 'dart:io';

import 'package:best_social_app/constants/constants.dart';
import 'package:best_social_app/layout/cubit/social_state.dart';
import 'package:best_social_app/models/message_model/msssg_model.dart';
import 'package:best_social_app/models/user_model/UserModel.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../models/PostModel/Post_Model.dart';
import '../../modules/Chat_Scr/Chat.dart';
import '../../modules/Feed_Scr/Feed.dart';
import '../../modules/New_Post/New_Post.dart';
import '../../modules/Setting_Scr/Setting.dart';
import '../../modules/Users_Scr/Users.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates>
{
  SocialCubit(): super (SocialInatialState());
  static SocialCubit get(context)=>BlocProvider.of(context);
  SocialUserModel? model;
  Future GetUserData() async
  {
    emit(SocialGetUserLoadingState());
    return await FirebaseFirestore.instance.collection('users').doc(uId).get()
    .then((value) {
      model=SocialUserModel.fromJson(value.data()!);
      emit(SocialGetUserSuccessState());
    }).catchError((error){
      emit(SocialGetUserErrorState(error));
    });
  }
  int CurrentIndex=0;
  List<Widget>Screens=[
    FeedsScreen(),
    ChatScreen(),
    NewPost_Scr(),
    UsersScreen(),
    SettingsScreen(),
  ];
  void ChangeBottomNav(int index)
  {
    if(index==1)
      getUsers();
    if(index==2)
        emit(SocialAddPostState());

    else
      {
        CurrentIndex=index;
        emit(SocialChangeBottomNav());

      }
  }
  List<String>titles=[
    'Home',
    'Chat',
    'Post',
    'User'
    ,'Setting'
  ];
  //////////////////////////////////////////profileImage select
File? ProfileImage;
final picker=ImagePicker();
Future<void>getProfileImage()async
{
  final pickedImage=await picker.pickImage(source: ImageSource.gallery);
  if(pickedImage!=null)
    {
      ProfileImage=File(pickedImage.path);
      emit(ImageProfilePickedSucess());}
  else{
    print('NO image selected');
    emit(ImageProfilePickedError());

  }
}
////////////////////////////cover image select
  File? coverImage;
  Future<void> getCoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(ImageCoverPickedSucess());
    } else {
      print('No image selected');
      emit(ImageCoverPickedError());
    }
  }
///////////////////////////////////////upload image///////
void uploadProfileImage({required String name,
  required String phone,
  required String bio,}){
  firebase_storage
      .FirebaseStorage
      .instance
      .ref()
      .child('users/${Uri.file(ProfileImage!.path).pathSegments.last}')
  .putFile(ProfileImage!)
  .then((value){
    value.ref.getDownloadURL().then((value){
      updateUser(name: name, phone: phone, bio: bio,image: value);
      emit(UploadImageProfilePickedSucess());

    })
    .catchError((error){
      emit(UploadImageProfilePickedError());
    });
  }).catchError((error){emit(UploadImageProfilePickedError());});
}
////////////////////////////////////////////////upload cover into storage

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
}){
    firebase_storage
        .FirebaseStorage
        .instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value){
      value.ref.getDownloadURL().then((value){
        updateUser(name: name, phone: phone, bio: bio,cover: value);
        emit(UploadImageCoverPickedSucess());

      })
          .catchError((error){
            emit(UploadImageCoverPickedError());
      });
    }).catchError((error){emit(UploadImageCoverPickedError());});
  }
  ////////////////////////////////////////////////////////////////updateUser
  Future<void>updateUser({required String name,
    required String phone,
    required String bio,
    String? cover ,
    String? image,
  })async{
    emit(LoadingUpateUserState());
    SocialUserModel usermodel = SocialUserModel(
      name: name,
      phone: phone,
      email: model!.email,
      cover:cover?? model!.cover,
      image:image?? model!.image,
      uId: model!.uId,
      isEmailVer: false,
      bio: bio,
    );
   FirebaseFirestore.instance
       .collection('users')
       .doc(model!.uId).update(usermodel.toMap()).then((value){
         GetUserData();
   })
       .catchError((error){
         emit(updateusererrorstate(error));
   });
  }
  ///////////////////////////////////////////////////////////////////////////get post image
  File? postImage;
    Future<void> getpostImage() async{
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        postImage = File(pickedFile.path);
        emit(PostImagePickedSucess());
      } else {
        print('No image selected');
        emit(PostImagePickedError());
      }
    }
//////////////////////////upload/create new post image
  void UploadPostImage({
    required String dateTime,
    required String text,
  })
  {
    emit(SocialCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance.ref().
    child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value){
      value.ref.getDownloadURL().then((value) {
        CreatePost(dateTime: dateTime, text: text,PostImage: value);
        //emit(UploadImageCoverPickedSucess());
      }).catchError((error){
        emit(SocialCreatePostErrorState());

      });
    })
        .catchError((error){emit(SocialCreatePostErrorState());
    });


  }
///////////////////////////////////////create post
  Future<void>CreatePost({
    required String dateTime,
    required String text,
    String? PostImage,
  })async
  {
    emit(SocialCreatePostLoadingState());

    PostModel postmodel = PostModel(
      name: model!.name,
      uId: model!.uId,
      image: model!.image,
      dateTime: dateTime,
      text: text,
      PostImage: PostImage??'',
    );
    {
      return await FirebaseFirestore.instance
          .collection('posts').
      add(postmodel!.toMap())
          .then((value) {
        emit(SocialCreatePostSucessState());
      }).catchError((error) {
        print(error);
        emit(SocialCreatePostErrorState());
      });
    }
  }
  void removePostImage(){

    postImage =null;
    emit(SocialRemovePostSucessState());
  }

////////////////////////////////////////get posts
List<PostModel>posts=[];
  List<String>postsid=[];
  List<int>like=[];

  void getposts()
     {
       FirebaseFirestore.instance
           .collection('posts')
           .get()
           .then((value) {
             value.docs.forEach((element) {
               element.reference
               .collection('likes')
               .get()
               .then((value){
                 like.add(value.docs.length);
                 postsid.add(element.id);
                 posts.add(PostModel.fromJson(element.data()));
               })
               .catchError((error){});

             });
       })
           .catchError((error){
             emit(SocialGetPostsSucessState());
       }).catchError((error){
         emit(SocialGetPostsErrorState(error.toString()));
       });

             }

void likepost(String postid){
FirebaseFirestore.instance
    .collection('posts')
    .doc(postid)
    .collection('likes')
    .doc(model!.uId)
    .set({
  'like':true,
})
    .then((value) {
      emit(SocialLikePostsSucessState());
})
    .catchError((error){
      emit(SocialLikePostsErrorState(error));
});
}
///////////////////////////get all user
List<SocialUserModel> users=[];
void getUsers()
{
  //////to not bring user twice for each enter make list empty
  //users =[];
 if(users.length==0)
  FirebaseFirestore.instance.collection('users').get()
      .then((value)  {
     value.docs.forEach((element) {
       /////not bring myself
      if(element.data()['uId'] != model!.uId)
        users.add(SocialUserModel.fromJson(element.data()));
     });
     emit(SocialGetallUserSuccessState());
  }).catchError((error){
    emit(SocialGetallUserErrorState(error));
  });
}
////////////////////////////////////send sender  msg
void SendMsg({
  required String reciverId,
  required String dateTime,
  required String text,})
{
  MessageModel msgmodel=MessageModel(
    Text: text,
    dateTime: dateTime,
    receiverId: reciverId,
    senderId: model!.uId,
  );
  //////set sender msg
  FirebaseFirestore.instance
  //me make chat with frind inside chat there is msg inside msg insert data
  .collection('users')
  .doc(model!.uId)
  .collection('chats')
  .doc(reciverId)
  .collection('message')
  .add(msgmodel.toMap())
  .then((value) {
    emit(SocialSendMessageSucessState());
  })
  .catchError((error){
    emit(SocialSendMessageErrorState());
  });
  /////set reciver msg
  FirebaseFirestore.instance
  //me make chat with frind inside chat there is msg inside msg insert data
      .collection('users')
      .doc(reciverId)
      .collection('chats')
      .doc(model!.uId)
      .collection('message')
      .add(msgmodel.toMap())
      .then((value) {
    emit(SocialSendMessageSucessState());
  })
      .catchError((error){
    emit(SocialSendMessageErrorState());
  });

}
/////////////////////////////////get msg
List<MessageModel> messages=[];
void getMessages({
  required String reciverId,
})
{
  FirebaseFirestore.instance
  .collection('users')
  .doc(model!.uId)
   .collection('chats')
   .doc(reciverId)
   .collection('message')
  .orderBy('dateTime')
  /////////////////return strem of future retrive all time  
   .snapshots()
   .listen((event) {
     messages=[];
     event.docs.forEach((element) {
      // to prevent duplicate
       messages.add((MessageModel.fromJson(element.data())));
     });
     emit(SocialGetMessageSucessState());
  }) ;  
}
}