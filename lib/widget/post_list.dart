import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:taskapp/post/screen/model/post_modal.dart';

class PostList extends StatelessWidget {
  PostList({super.key, required this.postModel});
  final PostModel postModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Container(
        padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
            // border: Border.all(color: Colors.blueGrey),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              const BoxShadow(color: Colors.white),
            ]),
        child: Column(
          children: [
            const Row(
              children: [
                CircleAvatar(),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "User name",
                  style: TextStyle(color: Color(0xffb1bbb6), fontSize: 25),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              width: MediaQuery.sizeOf(context).width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    postModel.title,
                    style:
                        const TextStyle(color: Color(0xff98817b), fontSize: 25),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    postModel.description,
                    style:
                        const TextStyle(color: Color(0xff98817b), fontSize: 25),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    height: 170,
                    width: MediaQuery.sizeOf(context).width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.grey)),
                    child: Image.network(
                      postModel.posturl,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Row(
                    children: [
                      Icon(
                        Icons.favorite_border,
                        size: 50,
                        color: Color(0xffA8A3A3),
                      ),
                      SizedBox(
                        width: 35,
                      ),
                      Icon(
                        Icons.share,
                        color: Color(0xffA8A3A3),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
