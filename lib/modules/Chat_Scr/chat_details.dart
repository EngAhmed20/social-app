import 'package:best_social_app/layout/cubit/social_cubit.dart';
import 'package:best_social_app/layout/cubit/social_state.dart';
import 'package:best_social_app/models/message_model/msssg_model.dart';
import 'package:best_social_app/models/user_model/UserModel.dart';
import 'package:best_social_app/shared/Style/icon_broken.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatDetailsScreen extends StatelessWidget {
  SocialUserModel usermodel;
  ChatDetailsScreen({
    required this.usermodel
});
var msgcontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (BuildContext context)
            {
              SocialCubit.get(context).getMessages(reciverId: usermodel.uId!);
              return BlocConsumer<SocialCubit,SocialStates>(
                listener: (context,state){},
                builder: (context,state){
                  return Scaffold(
                    backgroundColor: Colors.white,
                    appBar: AppBar(
                      backgroundColor: Colors.white,
                      elevation: 0,
                      leading: IconButton(
                        icon: Icon(Icons.arrow_back,color: Colors.black,),
                        onPressed: (){
                          Navigator.pop(context);
                        },
                      ),
                      title: Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage('${usermodel.image}'),
                          ),
                          SizedBox(width: 15,),
                          Text('${usermodel.name}',style: TextStyle(color: Colors.black),),
                        ],
                      ),
                    ),
                    body: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Expanded(
                                child: ListView.separated(
                                    physics: BouncingScrollPhysics(),
                                    itemBuilder: (context,index)
                                    {
                                      var msg= SocialCubit.get(context).messages[index];
                                      if(SocialCubit.get(context).model!.uId == msg.senderId)
                                        return buildMyMessage(msg);

                                      return buildMessage(msg);
                                    },
                                    separatorBuilder: (context,index)=>SizedBox(height: 15,),
                                    itemCount: SocialCubit.get(context).messages.length),
                              ),
                              Spacer(),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  border: Border.all(
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          controller:msgcontroller,
                                          decoration: InputDecoration(
                                            border:InputBorder.none,
                                            hintText: 'Enter your message here ....',
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 50,
                                        color: Colors.blue,
                                        child: MaterialButton(onPressed: (){
                                          SocialCubit.get(context)
                                              .SendMsg(reciverId: usermodel.uId!,
                                              dateTime: DateTime.now.toString(),
                                              text: msgcontroller.text);
                                          msgcontroller.clear();
                                        },
                                          child: Icon(IconBroken.Send,
                                            size: 16.0,
                                            color: Colors.white,
                                          ),),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                  );
                },
              );

            }


    );
  }
  Widget buildMessage(MessageModel msmodel)=>Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
      decoration:BoxDecoration(
        borderRadius: BorderRadiusDirectional.only(
          bottomEnd: Radius.circular(10.0),
          topEnd: Radius.circular(10.0),
          topStart: Radius.circular(10.0),
        ),
        color: Colors.grey[300],
      ),
      padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
      child: Text(
          '${msmodel.Text} '
      ),
    ),
  );
  Widget buildMyMessage(MessageModel msmodel)=> Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
      decoration:BoxDecoration(
        borderRadius: BorderRadiusDirectional.only(
          topStart: Radius.circular(10.0),
          bottomStart: Radius.circular(10.0),
          topEnd: Radius.circular(10.0),
        ),
        color: Colors.blue.withOpacity(.2),
      ),
      padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
      child: Text(
          '${msmodel.Text} '
      ),
    ),
  );



}
