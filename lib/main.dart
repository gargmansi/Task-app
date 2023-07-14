import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:taskapp/post/screen/controller/pic_image.dart';
import 'package:taskapp/post/screen/controller/share_controller.dart';
import 'package:taskapp/post/screen/screen/screen/home.dart';
import 'package:taskapp/post/screen/screen/screen/wrapper.dart';

import 'firebase_options.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    // What is this ??
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    runApp(MyApp());
  }, (error, stack) {
    print(error);
  });
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final PicImagecontroller _imagecontroller = PicImagecontroller();
  final ShareController _shareController = ShareController();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _shareController),
        ChangeNotifierProvider.value(value: _imagecontroller)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData.light(
          useMaterial3: true,
        ).copyWith(
          textTheme: GoogleFonts.poppinsTextTheme(),
        ),
        home: const Wrapper(),
      ),
    );
  }
}
