import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskapp/post/screen/controller/pic_image.dart';
import 'package:taskapp/post/screen/utils/image_picker.dart';
import 'package:taskapp/post/screen/utils/loading_dialog.dart';
import 'package:taskapp/post/screen/utils/storage_util.dart';

import '../../service/post_api.dart';

class Postadd extends StatefulWidget {
  Postadd({super.key});

  @override
  State<Postadd> createState() => _PostaddState();
}

class _PostaddState extends State<Postadd> {
  FireBasePost fireBasePost = FireBasePost();
  ImageUtil imageUtil = ImageUtil();
  StorageUtil storageUtil = StorageUtil();
  final TextEditingController _titlecontroller = TextEditingController();
  final TextEditingController _descriptioncontroller = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey();
  String? _validateUrl(String? value) {
    if (value == null || value.isEmpty) {
      return 'URL is required.';
    }

    RegExp urlRegExp = RegExp(
      r"^(https?|ftp):\/\/[^\s/$.?#].[^\s]*$",
      caseSensitive: false,
      multiLine: false,
    );

    if (!urlRegExp.hasMatch(value)) {
      return 'Invalid URL.';
    }

    return null;
  }

  void _hideKeyboard() {
    FocusScope.of(context).unfocus();
  }

  bool isLoading = false;

  //TODO: Add post should have a image,title,desc and save these things in the provider
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFAF0),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xffF4C2C2),
          ),
        ),
        backgroundColor: const Color(0xffC8A4CA),
        title: const Text(
          "Post page",
          style: TextStyle(
              color: Color(0xffF4C2C2),
              fontWeight: FontWeight.bold,
              fontSize: 25),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "Please enter some title";
                  }
                  return null;
                },
                controller: _titlecontroller,
                decoration: InputDecoration(
                    hintText: "Title",
                    hintStyle: const TextStyle(
                      color: Color(0xff98817b),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                textInputAction: TextInputAction.newline,
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "Please enter some description";
                  }
                  return null;
                },
                controller: _descriptioncontroller,
                decoration: InputDecoration(
                    hintText: "Description",
                    hintStyle: const TextStyle(
                      color: Color(0xff98817b),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              const SizedBox(
                height: 20,
              ),
              Consumer<PicImagecontroller>(
                builder: (context, value, child) {
                  return (value.imageUrl != null)
                      ? Column(
                          children: [
                            Container(
                              height: 200,
                              width: MediaQuery.sizeOf(context).width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(value.imageUrl!))),
                            ),
                            TextButton(
                              onPressed: () async {
                                final navigator = Navigator.of(context);
                                loadinDialog(context);
                                await storageUtil.removeImage(value.imageUrl!);
                                value.removeImage();
                                navigator.pop();
                              },
                              child: const Text("Remove Image"),
                            )
                          ],
                        )
                      : InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          FilledButton(
                                            child: const Text(
                                              " gallery",
                                              style: TextStyle(
                                                color: Color(0xff98817b),
                                              ),
                                            ),
                                            onPressed: () async {
                                              final navigator =
                                                  Navigator.of(context);
                                              final buildContext = context;
                                              final picked = await imageUtil
                                                  .pickImageGallery();
                                              if (picked != null) {
                                                navigator.pop();
                                                loadinDialog(buildContext);

                                                final url = await storageUtil
                                                    .uploadImage(picked);
                                                value.addImage(url);
                                                navigator.pop();
                                              }
                                            },
                                          ),
                                          FilledButton(
                                              child: const Text(
                                                " camera",
                                                style: TextStyle(
                                                  color: Color(0xff98817b),
                                                ),
                                              ),
                                              onPressed: () async {
                                                final navigator =
                                                    Navigator.of(context);
                                                final buildContext = context;
                                                final picked = await imageUtil
                                                    .pickImageCamera();
                                                if (picked != null) {
                                                  navigator.pop();
                                                  loadinDialog(buildContext);
                                                  setState(() async {
                                                    final url =
                                                        await storageUtil
                                                            .uploadImage(
                                                                picked);
                                                    value.addImage(url);
                                                    navigator.pop();
                                                  });
                                                }
                                              }),
                                        ],
                                      ),
                                    ));
                          },
                          child: Container(
                            padding: const EdgeInsets.only(top: 10),
                            height: 200,
                            width: MediaQuery.sizeOf(context).width,
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.1),
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(25)),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_a_photo,
                                  color: Color(0xff98817b),
                                ),
                                Text(
                                  "Add image",
                                  style: TextStyle(
                                    color: Color(0xff98817b),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                },
              ),
              const SizedBox(
                height: 60,
              ),
              ElevatedButton(
                  onPressed: () async {
                    final navigator = Navigator.of(context);
                    final FireBasePost firebasepost = FireBasePost();
                    final pro =
                        Provider.of<PicImagecontroller>(context, listen: false);
                    if (_formkey.currentState!.validate() &&
                        pro.imageUrl != null) {
                      loadinDialog(context);
                      await firebasepost.CreatePostAdding(
                        _titlecontroller.text,
                        _descriptioncontroller.text,
                        pro.imageUrl!,
                      );
                      pro.removeImage();
                      navigator
                        ..pop()
                        ..pop();
                    } else if (pro.imageUrl == null) {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          content: const Text(
                            'Pick an Image',
                            style: TextStyle(
                              color: Color(0xff98817b),
                            ),
                          ),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  navigator.pop();
                                },
                                child: const Text(
                                  'Ok',
                                  style: TextStyle(
                                    color: Color(0xff98817b),
                                  ),
                                ))
                          ],
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffC8A4CA),
                    fixedSize: Size(MediaQuery.sizeOf(context).width, 50),
                  ),
                  child: const Text(
                    "Share post",
                    style: TextStyle(
                        color: Color(0xff98817b),
                        fontSize: 22,
                        fontWeight: FontWeight.w300),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
