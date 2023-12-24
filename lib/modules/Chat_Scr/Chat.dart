import 'package:best_social_app/layout/cubit/social_cubit.dart';
import 'package:best_social_app/layout/cubit/social_state.dart';
import 'package:best_social_app/models/user_model/UserModel.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/social_cubit.dart';
import '../../layout/cubit/social_cubit.dart';
import 'chat_details.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        return  ConditionalBuilder(
          condition: SocialCubit.get(context).users.length>0,
          builder:(context)=>ListView.separated(itemBuilder: (context,index)=>buildChatItem(context,SocialCubit.get(context).users[index]),
              separatorBuilder: (context,state)=>Container(
                height: 1,
                width: double.infinity,
                color: Colors.grey[100],
              ) ,
              itemCount: SocialCubit.get(context).users.length) ,
          fallback:(context)=> Center(child: CircularProgressIndicator()),
        );
      },
    );

  }
  Widget buildChatItem(context,SocialUserModel model)=>InkWell(
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage('${model.image}'),

          ),
          SizedBox(width: 20,),
          Text('${model.name}',style: Theme.of(context).textTheme.subtitle1,),


        ],
      ),
    ),
    onTap: (){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>
         ChatDetailsScreen(usermodel: model,)),
      );
    },
  );
}

