import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:regl_cycle_app/resources/auth_methods.dart';
import 'package:regl_cycle_app/screens/login_screen.dart';
import 'package:regl_cycle_app/utils/image_helper.dart';
import 'package:regl_cycle_app/utils/pick_image.dart';
import 'package:regl_cycle_app/widget/text_field_input.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  Uint8List? _image;
  bool isLoading = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
  }

  void selectImage() async {
    Uint8List image = await pickImage(ImageSource.gallery);
    setState(() {
      _image = image;
    });
    ImageHelper.setImage(image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Image.asset("assets/signup.png"),
              const SizedBox(
                height: 15,
              ),
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 50,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage("assets/person.jfif"),
                        ),
                  Positioned(
                    right: 0,
                    bottom: -10,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: Icon(
                        Icons.add_a_photo_outlined,
                        color: Color(0xFF355070),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              TextFieldInput(
                  controller: nameController,
                  type: TextInputType.text,
                  hintText: "Enter your name"),
              const SizedBox(
                height: 15,
              ),
              TextFieldInput(
                  controller: emailController,
                  type: TextInputType.emailAddress,
                  hintText: "Enter your email"),
              const SizedBox(
                height: 15,
              ),
              TextFieldInput(
                controller: passwordController,
                type: TextInputType.text,
                hintText: "Enter your password",
                isPassword: true,
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    String? res = await AuthMethods().signUpUser(
                        email: emailController.text,
                        password: passwordController.text,
                        username: nameController.text);

                    if (res == "success") {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) {
                          return LoginScreen();
                        }),
                      );
                    }

                    setState(() {
                      isLoading = false;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 80, vertical: 15),
                      backgroundColor: const Color(0xFFc9ada7)),
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  )),
              const SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already Have an Account? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) {
                          return LoginScreen();
                        }),
                      );
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
