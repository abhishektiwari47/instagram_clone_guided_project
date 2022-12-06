import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/resources/auth_method.dart';
import 'package:instagram/screens/login_screen.dart';
import 'package:instagram/utils/colors.dart';
import 'package:instagram/utils/utils.dart';
import 'package:instagram/widgets/text_field_input.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

// for disposing the password and email
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethod().signUpUser(
      username: _usernameController.text,
      email: _emailController.text,
      password: _passwordController.text,
      bio: _bioController.text,
      file: _image!,
    );
    if (res == "sucess") {
      //
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(res),
        ),
      );
    }
    setState(
      () => _isLoading = false,
    );
  }

  void navigateToLoginScreen() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 32,
        ),
        width: double.infinity,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Flexible(
            child: Container(),
            flex: 2,
          ),
          //svg image
          SvgPicture.asset(
            'assets/image/ic_instagram.svg',
            color: primaryColor,
            height: 64,
          ),
          const SizedBox(
            height: 24,
          ),
          //circular widget to accept and show our selected file

          Stack(
            children: [
              _image != null
                  ? CircleAvatar(
                      radius: 64,
                      backgroundImage: MemoryImage(_image!),
                    )
                  : const CircleAvatar(
                      radius: 64,
                      backgroundImage:
                          AssetImage('assets/image/instaAvatar.jpg'),
                    ),
              Positioned(
                  bottom: -10,
                  left: 80,
                  child: IconButton(
                    onPressed: selectImage,
                    icon: const Icon(
                      Icons.add_a_photo,
                    ),
                  ))
            ],
          ),
          SizedBox(
            height: 24,
          ),

          TextFieldInput(
              textEditingController: _usernameController,
              hintText: 'Enter your username',
              textInputType: TextInputType.text),
          SizedBox(
            height: 24,
          ),
          //text field input for email
          TextFieldInput(
              textEditingController: _emailController,
              hintText: 'Enter your email',
              textInputType: TextInputType.emailAddress),
          SizedBox(
            height: 24,
          ),
          //text field input for password
          TextFieldInput(
            textEditingController: _passwordController,
            hintText: 'Enter your password',
            textInputType: TextInputType.text,
            isPass: true,
          ),
          SizedBox(
            height: 24,
          ),
          TextFieldInput(
              textEditingController: _bioController,
              hintText: 'Enter your bio',
              textInputType: TextInputType.text),
          SizedBox(
            height: 24,
          ),

          //button signup
          InkWell(
            onTap: signUpUser,
            child: Container(
              child: _isLoading
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : const Text('Create new account'),
              width: double.infinity,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: const ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                color: Colors.blue,
              ),
            ),
          ),
          SizedBox(
            height: 24,
          ),
          Flexible(
            child: Container(),
            flex: 2,
          ),

          //Transitioning to signing up
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Text("Allready have an account?"),
                padding: const EdgeInsets.symmetric(vertical: 8),
              ),
              GestureDetector(
                onTap: navigateToLoginScreen,
                child: Container(
                  child: const Text(
                    " Log in",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 86, 179, 255),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 24,
          ),
        ]),
      )),
    );
  }
}
