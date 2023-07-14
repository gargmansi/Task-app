import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskapp/post/screen/controller/share_controller.dart';
import 'package:taskapp/post/screen/screen/screen/update.dart';
import 'package:taskapp/post/screen/screen/screen/postadd.dart';
import 'package:taskapp/post/screen/service/auth_service.dart';
import 'package:taskapp/widget/post_list.dart';

import '../../service/post_api.dart';

class Post extends StatefulWidget {
  const Post({super.key});

  @override
  State<Post> createState() => _PostState();
}

//TODO: I want to experience your design to code knowledge so please copy instagram to display post

class _PostState extends State<Post> {
  FireBasePost post = FireBasePost();
  final AuthService _authService = AuthService();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: const Color(0xffFFFAF0),

        appBar: AppBar(
          backgroundColor: const Color(0xffC8A4CA),
          leading: DrawerButton(
            onPressed: () => _scaffoldKey.currentState!.openDrawer(),
          ),
        ),
        drawer: _HomeDrawer(),
        //TODO: add appbar and then add a drawer and then have user image in drawer header and my post , saved post and logout
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Postadd()));
          },
          backgroundColor: const Color(0xffC8A4CA),
          child: const Icon(Icons.add),
        ),
        body: StreamBuilder(
          stream: post.streamAllPost(),
          builder: (context, snapshot) {
            print(snapshot.data);
            if (snapshot.hasData) {
              print(snapshot.data);
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, Index) {
                  return PostList(postModel: snapshot.data![Index]);
                },
              );
            }
            if (snapshot.hasError) {
              print(snapshot.error);
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

class _HomeDrawer extends StatelessWidget {
  _HomeDrawer({
    super.key,
  });
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Consumer<ShareController>(builder: (context, value, _) {
      return Drawer(
        child: value.userProfile != null
            ? ListView(
                children: [
                  UserAccountsDrawerHeader(
                    onDetailsPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()));
                    },
                    accountEmail: const SizedBox(),
                    decoration:
                        BoxDecoration(color: Colors.blueGrey.withOpacity(0.2)),
                    accountName: Text(
                      value.userProfile!.name ?? 'User ',
                      style: const TextStyle(
                        color: Color(0xff98817b),
                        fontSize: 18,
                      ),
                    ),
                    currentAccountPicture: CircleAvatar(
                      radius: 30,
                      backgroundImage: value.userProfile!.url != null &&
                              value.userProfile!.url!.isNotEmpty
                          ? NetworkImage(value.userProfile!.url!)
                          : null,
                    ),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.post_add_outlined,
                      color: Color(0xff98817b),
                    ),
                    title: const Text(
                      'My Posts',
                      style: TextStyle(
                        color: Color(0xff98817b),
                      ),
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.bookmark,
                      color: Color(0xff98817b),
                    ),
                    title: const Text(
                      "saved post",
                      style: TextStyle(
                        color: Color(0xff98817b),
                      ),
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.logout,
                      color: Color(0xff98817b),
                    ),
                    title: const Text(
                      "Log out",
                      style: TextStyle(
                        color: Color(0xff98817b),
                      ),
                    ),
                    onTap: () async {
                      await _authService.signout(context);
                    },
                  ),
                ],
              )
            : const SizedBox(),
      );
    });
  }
}
