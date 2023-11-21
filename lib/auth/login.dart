import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_sell/auth/auth_methods.dart';
import 'package:local_sell/auth/sign_up.dart';
import 'package:local_sell/components/delta.dart';
import 'package:local_sell/components/gamma.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController usernameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                children: [
                  const Spacer(),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        "Forgot Password?",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Colors.grey.shade400,
                          decoration: TextDecoration.underline,
                          decorationThickness: 2,
                        ),
                      )),
                ],
              ),
              Center(
                child: Column(
                  children: [
                    Text(
                      "Welcome!!",
                      style: GoogleFonts.lato(
                          fontSize: 30, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Please enter your data to continue",
                      style: GoogleFonts.lato(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              MyTextField(
                title: 'Email',
                hintText: 'johndoe@gmail.com',
                prefixIcon: const Icon(Icons.email_outlined),
                controller: emailController,
              ),
              MyTextField(
                title: "Password",
                hintText: "********",
                prefixIcon: const Icon(Icons.lock_outline),
                controller: passwordController,
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                children: [
                  Text(
                    "Rember me",
                    style: TextStyle(fontSize: 18),
                  ),
                  Spacer(),
                  MySwitch()
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: Divider(
                    color: Colors.grey.shade500,
                  )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Or",
                      style:
                          TextStyle(fontSize: 20, color: Colors.grey.shade500),
                    ),
                  ),
                  Expanded(
                      child: Divider(
                    color: Colors.grey.shade500,
                  )),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SignUpOptions(
                    image: 'assets/google.png',
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  SignUpOptions(
                    image: 'assets/google.png',
                  ),
                  // SignUpOptions(image: 'assets/apple.png',),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              MyButtons(
                text: "Log In",
                ontap: () => AuthMethods().signIn(emailController.text.trim(),
                    passwordController.text.trim()),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  TextButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpPage())),
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(color: Colors.red),
                      ))
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}
