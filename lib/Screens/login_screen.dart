import 'package:flutter/material.dart';
import 'package:vyam_vandor/Services/firebase_auth_api.dart';
import 'package:vyam_vandor/app_colors.dart';
import 'package:vyam_vandor/widgets/custom_text_field.dart';
import 'package:vyam_vandor/widgets/primary_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController? _emailController;
  TextEditingController? _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    // _emailController!.text = "t@gmail.com";
    // _passwordController!.text = "T@gmail.com";
  }

  @override
  void dispose() {
    super.dispose();
    _emailController!.dispose();
    _passwordController!.dispose();
  }

  Future _signIn() async {
    try {
      FirebaseAuthApi().signIn(
        email: _emailController!.text,
        password: _passwordController!.text,
        context: context,
      );
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'VYAM',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTextFiled(
              hintText: 'Email',
              textEditingController: _emailController,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextFiled(
              hintText: 'Password',
              textEditingController: _passwordController,
              obscure: true,
            ),
            const SizedBox(
              height: 20,
            ),
            buildPrimaryButton(
              () {
                _signIn();
              },
              'Login',
            )
          ],
        ),
      ),
    );
  }
}
