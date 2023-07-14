import 'package:taskapp/post/screen/screen/screen/post.dart';

class PostModel {
  final String title;
  final String description;
  final String posturl;
  final String uid;
  final DateTime timeStamp;

  PostModel({
    required this.title,
    required this.description,
    required this.posturl,
    required this.uid,
    required this.timeStamp,
  });
  factory PostModel.frommap(Map<String, dynamic> map) {
    return PostModel(
      title: map["title"],
      description: map['description'],
      posturl: map['Posturl'],
      uid: map['uid'],
      timeStamp: map['timeStamp'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['timeStamp'] as int)
          : DateTime.now(),
    );
  }
  PostModel copyWith({String? title, String? description, String? posturl}) {
    return PostModel(
      posturl: posturl ?? this.posturl,
      title: title ?? this.title,
      description: description ?? this.description,
      uid: uid,
      timeStamp: timeStamp,
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map["title"] = title;
    map['description'] = description;
    map['Posturl'] = posturl;
    map['uid'] = uid;
    map['timeStamp'] = timeStamp.millisecondsSinceEpoch;
    return map;
  }
}
