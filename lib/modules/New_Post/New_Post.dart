

import 'package:best_social_app/layout/cubit/social_cubit.dart';
import 'package:best_social_app/layout/cubit/social_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/Style/icon_broken.dart';
import '../../shared/components/default_app_bar.dart';

class NewPost_Scr extends StatelessWidget {

  var TextController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
       return Scaffold(
          appBar:DefaultAppBar(context: context,title: 'Create Post'
              ,actions: [
                MaterialButton(onPressed: (){
                  var now =DateTime.now();
                  if(SocialCubit.get(context).postImage==null){
                    SocialCubit.get(context).CreatePost(dateTime:now.toString(), text: TextController.text);
                  }
                  else{
                    SocialCubit.get(context).UploadPostImage(dateTime: now.toString(),
                        text: TextController.text);
                  }
                },
                  child: Text('Post',style: TextStyle(color: Colors.blue,fontSize: 18),),),
              ]
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(State is SocialCreatePostLoadingState)
                  LinearProgressIndicator(),
                SizedBox(height: 10,),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage('${SocialCubit.get(context).model!.image}'),
                    ),
                    SizedBox(width: 20,),
                    Expanded(
                      child:Text('${SocialCubit.get(context).model!.name}',style: Theme.of(context).textTheme.subtitle1,),

                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: TextController,
                    decoration: InputDecoration(
                      hintText: 'What is on your mind',
                      border: InputBorder.none,
                    ),
                  ),
                ),
               if(SocialCubit.get(context).postImage!=null)
                Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children:
                    [
                      Align(
                        child: Container(
                          height: 150,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(4),topRight:Radius.circular(4) ),
                            image: DecorationImage(image: FileImage(SocialCubit.get(context).postImage!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        alignment: Alignment.topCenter,
                      ),
                      IconButton(
                        icon: CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.red,
                          child: Icon(Icons.close),

                          ),
                        onPressed: (){SocialCubit.get(context).removePostImage();},
                      ),

                    ]
                ),
                SizedBox(height: 50,),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(onPressed: (){
                        SocialCubit.get(context).getpostImage();
                      },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(IconBroken.Image),
                              SizedBox(width: 5,),
                              Text('Add Photo'),
                            ],
                          )),
                    ),
                    Expanded(
                      child: TextButton(onPressed: (){},
                          child: Text('# Tags')),
                    ),

                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}