class UserProfile {
  String? name;
  String? url;
  String? uid;
  String? email;

  UserProfile({
    required this.name,
    required this.url,
    required this.email,
    required this.uid,
  });
  factory UserProfile.frommap(Map<String, dynamic> map) {
    return UserProfile(
        name: map['name'],
        url: map['url'],
        email: map['email'],
        uid: map['uid']);
  }
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map['name'] = name;
    map['url'] = url;
    map['email'] = email;
    map['uid'] = uid;
    return map;
  }
}
