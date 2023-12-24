import 'package:best_social_app/layout/cubit/social_cubit.dart';
import 'package:best_social_app/layout/cubit/social_state.dart';
import 'package:best_social_app/models/PostModel/Post_Model.dart';
import 'package:best_social_app/shared/components/build_post.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/Style/icon_broken.dart';


class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>
      (
      listener: (context,state){},
      builder: (context,state){
        return ConditionalBuilder(condition:SocialCubit.get(context).posts.length>0 ,
            builder: (context)=>SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Card(
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    elevation: 10,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        Image(
                          image: NetworkImage('https://img.freepik.com/free-photo/photo-delighted-cheerful-afro-american-woman-with-crisp-hair-points-away-shows-blank-space-happy-advertise-item-sale-wears-orange-jumper-demonstrates-where-clothes-shop-situated_273609-26392.jpg'),
                          fit: BoxFit.cover,
                          height: 200,
                          width: double.infinity,

                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Comunicate with Friends',style: TextStyle(fontSize:15,color: Colors.white,fontWeight: FontWeight.bold),),
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context,index)=>BuildPostItem(context,SocialCubit.get(context).posts[index],index),
                    separatorBuilder: (context,index)=>SizedBox(height: 10,),
                    itemCount: SocialCubit.get(context).posts.length,),

                ],
              ),
            ),
            fallback: (context)=>Center(child: CircularProgressIndicator(),));
      },

    );
  }
}