import 'package:best_social_app/layout/cubit/social_cubit.dart';
import 'package:best_social_app/layout/cubit/social_state.dart';
import 'package:best_social_app/modules/edit_profile/editProfile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/Style/icon_broken.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
    listener: (context,state){},
    builder: (context,state){
      var userModel =SocialCubit.get(context).model;
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [

            Container(
              height: 200,
              child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children:
                  [
                    Align(
                      child: Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(4),topRight:Radius.circular(4) ),
                          image: DecorationImage(image: NetworkImage('${userModel!.cover}'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      alignment: Alignment.topCenter,
                    ),
                    CircleAvatar(
                      radius: 55,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage('${userModel!.image}'),

                      ),
                    ),
                  ]
              ),
            ),
            SizedBox(height: 5,),
            Text('${userModel!.name}',style: Theme.of(context).textTheme.bodyText1,),
            Text('${userModel!.bio}',style: Theme.of(context).textTheme.caption,),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child: Column(
                        children: [
                          Text('100',style: Theme.of(context).textTheme.subtitle1,),
                          Text('Posts',style: Theme.of(context).textTheme.caption,),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Column(
                        children: [
                          Text('100',style: Theme.of(context).textTheme.subtitle1,),
                          Text('Posts',style: Theme.of(context).textTheme.caption,),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Column(
                        children: [
                          Text('100',style: Theme.of(context).textTheme.subtitle1,),
                          Text('Posts',style: Theme.of(context).textTheme.caption,),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Column(
                        children: [
                          Text('100',style: Theme.of(context).textTheme.subtitle1,),
                          Text('Posts',style: Theme.of(context).textTheme.caption,),
                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ),
            Row(
              children: [
                Expanded(child: OutlinedButton(onPressed: (){}, child:Text('Add Photos') )),
                 SizedBox(width: 10,),
                 OutlinedButton(
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  EditProfile()));
                  },
                   child: Icon(IconBroken.Edit,size: 16,)),



              ],
            )
          ],
        ),
      );
    },
    );
  }
}