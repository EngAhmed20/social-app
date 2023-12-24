import 'package:best_social_app/layout/cubit/social_cubit.dart';
import 'package:best_social_app/layout/cubit/social_state.dart';
import 'package:best_social_app/shared/Style/icon_broken.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../modules/New_Post/New_Post.dart';

class SocialLayout extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){
        if(state is SocialAddPostState)
        {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  NewPost_Scr()),
          );
        }
      },
        builder: (context,state){
        var cubit =SocialCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title: Text(
                cubit.titles[cubit.CurrentIndex],style: TextStyle(color: Colors.black),
              ),
              actions: [
                IconButton(onPressed: (){}, icon:Icon( IconBroken.Notification,color: Colors.black,)),
                IconButton(onPressed: (){}, icon:Icon( IconBroken.Search,color: Colors.black,)),
              ],
            ),
            body:cubit.Screens[cubit.CurrentIndex],
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              selectedItemColor:Colors.blue,
              unselectedItemColor: Colors.grey,
              elevation: 20.0,
              backgroundColor:Colors.white,
              onTap: (index){
                cubit.ChangeBottomNav(index);
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Home),label: 'home' ),
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Chat),label: 'Chat'),
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Paper_Upload),label: 'Post'),
                BottomNavigationBarItem(
                  icon: Icon(IconBroken.Location),label: 'Users',),
                BottomNavigationBarItem(
                    icon: Icon(IconBroken.Setting),label: 'Setting'),
              ],
            ),
            );

        },

    );

  }

}