import 'package:flutter/material.dart';
import 'package:taskapp/post/screen/service/auth_service.dart';

class Homes extends StatefulWidget {
  Homes({super.key});

  @override
  State<Homes> createState() => _HomesState();
}

class _HomesState extends State<Homes> {
  final AuthService _authService = AuthService();

  bool isLoading = false;

  //Make it beautiful look for some design inspirations
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xffFFFAF0),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Text(
              //   "Welcome",
              //   style: TextStyle(
              //       color: Colors.blueGrey,
              //       fontSize: 40,
              //       fontWeight: FontWeight.bold),
              // ),
              Image.asset(
                "assets/img.jpg",
                width: MediaQuery.sizeOf(context).width,
                fit: BoxFit.cover,
              ),
              const Spacer(),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.7),
                    fixedSize: Size(MediaQuery.sizeOf(context).width * 0.6, 50),
                  ),
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });

                    await _authService.signWithGoogle(context);
                    setState(() {
                      isLoading = false;
                    });
                  },
                  child: const Text(
                    'Sign in with Google',
                    style: TextStyle(color: Colors.blueGrey),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              isLoading ? const CircularProgressIndicator() : const SizedBox(),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
