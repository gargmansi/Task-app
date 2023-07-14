import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskapp/post/screen/controller/share_controller.dart';
import 'package:taskapp/post/screen/model/user_modal.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _imageurlcontroller = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _hideKeyboard,
      child: Scaffold(
        backgroundColor: const Color(0xffFFFAF0),
        appBar: AppBar(
          backgroundColor: const Color(0xffC8A4CA),
          title: const Text(
            "User Information",
            style: TextStyle(color: Colors.blueGrey),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  validator: (val) {
                    if (val!.trim().isEmpty) {
                      return "Please Enter the name";
                    }
                  },
                  controller: _namecontroller,
                  decoration: InputDecoration(
                      hintText: "Name",
                      hintStyle: const TextStyle(color: Colors.blueGrey),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25))),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: _imageurlcontroller,
                  validator: _validateUrl,
                  decoration: InputDecoration(
                      hintText: "upload Images",
                      hintStyle: const TextStyle(color: Colors.blueGrey),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide:
                              const BorderSide(color: Colors.lightBlue))),
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: ElevatedButton(
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          final pro = Provider.of<ShareController>(context,
                              listen: false);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffC8A4CA),
                      ),
                      child: Text(
                        "Update",
                        style: TextStyle(
                            color: Colors.blueAccent.withOpacity(0.6),
                            fontSize: 22,
                            fontWeight: FontWeight.w300),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
