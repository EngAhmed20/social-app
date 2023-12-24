import 'package:best_social_app/constants/constants.dart';
import 'package:best_social_app/layout/cubit/social_cubit.dart';
import 'package:best_social_app/layout/layout.dart';
import 'package:best_social_app/shared/components/toast.dart';
import 'package:best_social_app/shared/network/local/shared_pref/cache_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc_observe.dart';
import 'firebase_options.dart';
import 'modules/login/login_Scr.dart';
//import 'dart:html';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('on background  msg  ');
  print(message.data.toString());
  MyToast(msg: 'onBackgroundMessage ', state: ToastStates.SUCCESS).showToast();
}
  Future<void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseApp app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  ////////////////////send msg while app is open notification
  ///////////token for the device
  var token =await FirebaseMessaging.instance.getToken();
  print(token);
  ///////when app is open
  FirebaseMessaging.onMessage.listen((event) {
    print('on msg');
    print(event.data.toString());
    MyToast(msg: 'onMessage', state: ToastStates.SUCCESS).showToast();


  });
  ////click to open app
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print('on msg open app');
    print(event.data.toString());
    MyToast(msg: 'onMessage Opened', state: ToastStates.SUCCESS).showToast();

  });
  /////////////////////////////when app is closed
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  Widget widget;
  uId = CacheHelper.getData(key: 'uId') ;
  print(uId);
  if(uId !=null)
  {
    widget= SocialLayout();
  }
  else widget =SocialLoginScreen();

  runApp( MyApp(startWidget: widget,));
}

class MyApp extends StatelessWidget {
   MyApp({super.key,required this.startWidget});
final Widget startWidget;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
     return BlocProvider(
       create: (context)=>SocialCubit()..GetUserData()..getposts(),
       child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(

          primarySwatch: Colors.blue,
        ),
        home: startWidget,
        debugShowCheckedModeBanner: false,
    ),
     );
  }
}



