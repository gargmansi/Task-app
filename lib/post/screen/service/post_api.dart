import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskapp/post/screen/model/post_modal.dart';
import 'package:taskapp/widget/post_list.dart';

class FireBasePost {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> CreatePostAdding(
    String title,
    String description,
    String posturl,
  ) async {
    try {
      var post = await firestore.collection("post").doc().get();
      PostModel postModel = PostModel(
        description: description,
        title: title,
        posturl: posturl,
        uid: post.reference.id,
        timeStamp: DateTime.now(),
      );
      await post.reference.set(postModel.toMap());
    } catch (e) {
      rethrow;
    }
  }

  Future<List<PostModel>?> PostList() async {
    try {
      List<PostModel> postModel = [];
      var postref = await firestore.collection("post").get();
      for (var element in postref.docs) {
        PostModel postuser = PostModel.frommap(element.data());
        postModel.add(postuser);
      }
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<PostModel>> streamAllPost() {
    try {
      var post = firestore
          .collection("post")
          .orderBy('timeStamp', descending: true)
          .snapshots()
          .map((event) =>
              event.docs.map((e) => PostModel.frommap(e.data())).toList());
      return post;
    } catch (e) {
      rethrow;
    }
  }
}
