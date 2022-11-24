import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram/utils/colors.dart';
import 'package:instagram/widgets/text_field_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

// for disposing the password and email
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
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
            height: 64,
          ),
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
            hintText: 'Enter your email',
            textInputType: TextInputType.text,
            isPass: true,
          ),
          SizedBox(
            height: 24,
          ),

          //button login
          InkWell(
            onTap: () {},
            child: Container(
              child: const Text('Log in'),
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
                child: Text("Don't have an account?"),
                padding: const EdgeInsets.symmetric(vertical: 8),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  child: const Text(
                    " Sign Up",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 86, 179, 255),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                ),
              )
            ],
          )
        ]),
      )),
    );
  }
}
