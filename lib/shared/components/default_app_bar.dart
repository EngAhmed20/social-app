import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Style/icon_broken.dart';

PreferredSizeWidget DefaultAppBar({
  required BuildContext context,
  String? title,
  List<Widget>?actions,
})=>AppBar(
  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
   elevation: 0,
   leading: IconButton(
     onPressed: (){
       Navigator.pop(context);
     },
     icon: Icon(IconBroken.Arrow___Left_2,color: Colors.black,)

   ),
  titleSpacing: 5.0,
  title: Text('${title}',style:TextStyle(color: Colors.black),),
  actions: actions,




);