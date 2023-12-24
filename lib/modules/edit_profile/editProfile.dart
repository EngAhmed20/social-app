import 'package:best_social_app/layout/cubit/social_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/social_state.dart';
import '../../shared/Style/icon_broken.dart';
import '../../shared/components/Custom_text_filed.dart';
import '../../shared/components/default_app_bar.dart';

class EditProfile extends StatelessWidget {
   EditProfile({Key? key}) : super(key: key);
  var nameController=TextEditingController();
  var bioController=TextEditingController();
  var phoneController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        var userModel= SocialCubit.get(context).model;
        var cubit=SocialCubit.get(context);
        nameController.text=userModel!.name!;
        bioController.text=userModel!.bio!;
        phoneController.text=userModel!.phone!;

        return Scaffold(
          appBar:DefaultAppBar(context: context,title: 'Add Post',
              actions: [
                MaterialButton(onPressed: (){
                  cubit.updateUser(name: nameController.text, phone: phoneController.text, bio: bioController.text);
                },child: Text('UpDate',style: TextStyle(color: Colors.blue,fontSize: 18),)
                ),
                SizedBox(width: 15,)]),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(

                children: [
                  if(state is LoadingUpateUserState)
                    LinearProgressIndicator(),
                  Container(
                    height: 200,
                    child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children:
                        [
                          Align(
                            child:Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                Container(
                                  height: 150,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(4),topRight:Radius.circular(4) ),
                                    image: DecorationImage(image: NetworkImage('${userModel!.cover}'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                    IconButton(onPressed: (){
                                      cubit.getCoverImage();
                                    }, icon:
                                    CircleAvatar(child: Icon(IconBroken.Camera,size: 20,),
                                    radius: 20,
                                    )
                                    ),
                              ],
                            ),
                            alignment: Alignment.topCenter,
                          ),
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 55,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundImage: NetworkImage('${userModel!.image}'),

                                ),
                              ),
                              IconButton(onPressed: (){                                      cubit.getProfileImage();
                              }, icon:
                              CircleAvatar(child: Icon(IconBroken.Camera,size: 20,),
                                radius: 20,
                              )
                              ),
                            ],
                          ),
                        ]
                    ),
                  ),
                  if(cubit.ProfileImage!=null||cubit.coverImage!=null)
                  Row(
                    children: [
                      SizedBox(height: 10,),
        if(cubit.ProfileImage!=null)
                      Expanded(
                        child: Column(
                          children: [
                            OutlinedButton(onPressed: (){
                              cubit.uploadProfileImage(name: nameController.text,
                                  phone: phoneController.text,
                                  bio: bioController.text);
                            }, child:Text('Upload Profile') ),
                          ],
                        ),
                      ),
                      SizedBox(width: 5,),
        if(cubit.coverImage!=null)
                      Expanded(
                        child: Column(
                          children: [
                            OutlinedButton(onPressed: (){
                              cubit.uploadCoverImage(name: nameController.text
                                  , phone: phoneController.text, bio: bioController.text);
                            }, child:Text('Upload Cover') ),
                          ],
                        ),
                      ),

                    ]
                  ),
                  SizedBox(height: 5,),
                  defaulttextform(controller: nameController,
                    type: TextInputType.text,
                    validator: (String?value ) {
                      if(value!.isEmpty)
                      {
                        return 'name must not be empty';
                      }
                    }, label: 'Name', preficon: IconBroken.User,
                  ),
                  SizedBox(height: 10,),


                  defaulttextform(controller: bioController,
                    type: TextInputType.text,
                    validator: (String?value ) {
                      if(value!.isEmpty)
                      {
                        return 'bio must not be empty';
                      }
                    }, label: 'Bio', preficon: IconBroken.Info_Circle,
                  ),
                  SizedBox(height: 10,),
                  defaulttextform(controller: phoneController,
                    type: TextInputType.phone,
                    validator: (String?value ) {
                      if(value!.isEmpty)
                      {
                        return 'phone must not be empty';
                      }
                    }, label: 'Phone', preficon: IconBroken.Call,
                  ),

                ],
              ),
            ),
          ),
        );
      },
    );
  }
}