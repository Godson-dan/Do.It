import 'package:do_it/Pages/sign_up_page.dart';
import 'package:do_it/Pages/task_screen.dart';
import "package:flutter/material.dart";
import 'package:flutter/gestures.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Colors.blue.shade100,
            ],
          ),
        ),
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(45),
            // alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //Welcome Message
                    const SizedBox(
                      height: 10,
                    ),
                    RichText(
                        text: const TextSpan(
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                          text: "Welcom to Do.",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: "It",
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    )),

                    // Instruction message
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Please sign in or sign up below.",
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),

                    // Textform for email
                    const SizedBox(
                      height: 30,
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: emailController,
                            validator: (value) =>
                                value!.isEmpty ? "Please enter an email" : null,
                            style: const TextStyle(
                              overflow: TextOverflow.visible,
                              height: 1,
                            ),
                            decoration: const InputDecoration(
                              label: Text("Email"),
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 10),
                              border: OutlineInputBorder(),
                            ),
                          ),

                          // Textform for password
                          const SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            controller: passwordController,
                            validator: (value) => value!.isEmpty
                                ? "Please enter a password"
                                : null,
                            obscureText: true,
                            style: const TextStyle(
                              overflow: TextOverflow.visible,
                              height: 1,
                            ),
                            decoration: const InputDecoration(
                              label: Text("Password"),
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 10),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Button to sign in
                    const SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AddTask()));
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: double.infinity,
                        height: 40,
                        child: const Text(
                          "Sign In",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),

                    // Sign up message
                    const SizedBox(
                      height: 10,
                    ),
                    RichText(
                        text: TextSpan(
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black.withOpacity(0.5),
                      ),
                      children: [
                        const TextSpan(
                          text: "Don't have an account? ",
                        ),
                        TextSpan(
                          text: "Sign Up",
                          style: const TextStyle(
                            color: Colors.blue,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignUp(),
                                ),
                              );
                            },
                        ),
                      ],
                    ))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
