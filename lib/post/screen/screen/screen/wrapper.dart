import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskapp/post/screen/controller/share_controller.dart';
import 'package:taskapp/post/screen/screen/screen/home.dart';
import 'package:taskapp/post/screen/screen/screen/post.dart';
import 'package:taskapp/post/screen/utils/shared_login.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  SharedUtil sharedUtil = SharedUtil();

  @override
  void initState() {
    checkLoggedIn();
    super.initState();
  }

  void checkLoggedIn() async {
    final navigator = Navigator.of(context);
    final sharePro = Provider.of<ShareController>(context, listen: false);
    await Future.delayed(const Duration(seconds: 1));
    String? uid = await sharedUtil.checkLoggedIn();

    if (uid != null) {
      await sharePro.getUser(uid);
      navigator.push(MaterialPageRoute(builder: (_) => const Post()));
    } else {
      navigator.push(MaterialPageRoute(builder: (_) => Homes()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(40.0),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
