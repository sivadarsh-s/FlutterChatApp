import 'package:firebase_demo/components/chat_button.dart';
import 'package:firebase_demo/components/chat_text_field.dart';
import 'package:firebase_demo/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void signUp() async{
    if(passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Passwords do not match")
      ));
    }
    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      await authService.signUpWithEmailandPasssword(emailController.text, passwordController.text);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 125),
              const Icon(
                Icons.message_rounded,
                size: 125,
                color: Colors.black87,
                shadows: <Shadow>[Shadow(color: Colors.black12, blurRadius: 15.0)],
              ),
              const Text("Chat with your friends"),
              const SizedBox(height: 75),
              ChatTextField(controller: emailController, hintText: "Email", obscureText: false),
              const SizedBox(height: 10,),
              ChatTextField(controller: passwordController, hintText: "Password", obscureText: true),
              const SizedBox(height: 10,),
              ChatTextField(controller: confirmPasswordController, hintText: "Password", obscureText: true),
              const SizedBox(height: 25,),
              ChatButton(onTap: signUp, text: "Sign Up"),
              const SizedBox(height: 25,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already a member? "),
                  const SizedBox(width: 4 ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      "Login Now",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
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
