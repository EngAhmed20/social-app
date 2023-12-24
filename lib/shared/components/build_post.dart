import 'package:best_social_app/layout/cubit/social_cubit.dart';
import 'package:best_social_app/models/PostModel/Post_Model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Style/icon_broken.dart';

Widget BuildPostItem(context,PostModel model,index)=> Card(
  margin: EdgeInsets.symmetric(horizontal: 8.0,vertical: 10),
  elevation: 10,
  clipBehavior: Clip.antiAliasWithSaveLayer,
  child: Padding(
    padding: const EdgeInsets.all(10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage('${model.image}'),

            ),
            SizedBox(width: 20,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('${model.name}',style: Theme.of(context).textTheme.subtitle1,),
                      SizedBox(width: 5,),
                      Icon(Icons.check_circle,color: Colors.blue,size: 15,),
                    ],
                  ),
                  Text('${model.dateTime}',style: Theme.of(context).textTheme.caption,),
                ],),
            ),
            SizedBox(width: 20,),
            IconButton(onPressed: (){}, icon: Icon(Icons.more_horiz)),

          ],
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Container(width: double.infinity,height: 1,color: Colors.grey[300],),
        ),
        Text('${model.text}'),
        Container(
          padding: EdgeInsets.only(top: 10,bottom: 5),
          width: double.infinity,
          child: Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Container(height: 25,child: MaterialButton(minWidth: 1,padding: EdgeInsets.zero,onPressed: (){}, child:Text('#SoftWare',style: TextStyle(color: Colors.blue),))),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Container(height: 25,child: MaterialButton(minWidth: 1,padding: EdgeInsets.zero,onPressed: (){}, child:Text('#SoftWare',style: TextStyle(color: Colors.blue),))),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Container(height: 25,child: MaterialButton(minWidth: 1,padding: EdgeInsets.zero,onPressed: (){}, child:Text('#SoftWare',style: TextStyle(color: Colors.blue),))),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Container(height: 25,child: MaterialButton(minWidth: 1,padding: EdgeInsets.zero,onPressed: (){}, child:Text('#SoftWare_development',style: TextStyle(color: Colors.blue),))),
              ),



            ],
          ),
        ),
       if(model.PostImage !='')
        Container(
          height: 140,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              image: DecorationImage(image:NetworkImage('${model.PostImage}'),
                fit: BoxFit.cover,
              )
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(

                      children: [
                        Icon(IconBroken.Heart,size: 18,color: Colors.red,),
                        SizedBox(width: 5,),
                        Text('${SocialCubit.get(context).like[index]}',style: Theme.of(context).textTheme.caption,),
                      ],
                    ),
                  ),
                  onTap: (){},
                ),
              ),
              Expanded(
                child: InkWell(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(IconBroken.Chat,size: 18,color: Colors.amber,),
                        SizedBox(width: 5,),
                        Text('0',style: Theme.of(context).textTheme.caption,),
                      ],
                    ),
                  ),
                  onTap: (){},
                ),
              ),

            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Container(width: double.infinity,height: 1,color: Colors.grey[300],),
        ),
        Row(
          children: [
            Expanded(
              child: InkWell(
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 15,
                      backgroundImage: NetworkImage('${SocialCubit.get(context).model!.image}'),

                    ),
                    SizedBox(width: 25,),
                    Text('Write a comment....',style: Theme.of(context).textTheme.caption,),

                  ],
                ),
                onTap: (){},
              ),
            ),
            InkWell(
              child: Row(
                children: [
                  Icon(IconBroken.Heart,size: 25,color: Colors.red,),
                  SizedBox(width: 5 ,),
                  Text('Like'),
                ],
              ),
              onTap: (){
                SocialCubit.get(context).likepost(SocialCubit.get(context).postsid[index]);
              },
            ),

          ],
        ),
      ],
    ),
  ),
);
