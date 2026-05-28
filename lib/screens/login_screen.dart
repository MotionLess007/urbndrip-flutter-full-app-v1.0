import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import 'main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() =>
      _LoginScreenState();
}

class _LoginScreenState
    extends State<LoginScreen> {

  final TextEditingController
      emailController =
      TextEditingController();

  final TextEditingController
      passwordController =
      TextEditingController();

  final AuthService authService =
      AuthService();

  bool isLogin = true;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [

          // 🔥 BACKGROUND
          Positioned.fill(
            child: Image.asset(
              "assets/bg.jpg",

              fit: BoxFit.cover,
            ),
          ),

          // 🌑 OVERLAY
          Positioned.fill(
            child: Container(
              color:
                  Colors.black.withValues(
                alpha: 0.2,
              ),
            ),
          ),

          // 📦 CONTENT
          Padding(
            padding:
                const EdgeInsets.symmetric(
              horizontal: 24,
            ),

            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center,

              children: [

                const Text(
                  "URBNDRIP",

                  style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: 30,
                    fontWeight:
                        FontWeight.bold,
                    fontStyle:
                          FontStyle.italic,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 60),

                // 📧 EMAIL
                TextField(
                  controller:
                      emailController,

                  decoration:
                      InputDecoration(
                    hintText: "Email",

                    filled: true,

                    fillColor:
                        Colors.white
                            .withValues(
                      alpha: 0.7,
                    ),

                    contentPadding:
                        const EdgeInsets
                            .symmetric(
                      horizontal: 20,
                    ),

                    border:
                        OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(
                              30),

                      borderSide:
                          BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // 🔒 PASSWORD
                TextField(
                  controller:
                      passwordController,

                  obscureText: true,

                  decoration:
                      InputDecoration(
                    hintText: "Password",

                    filled: true,

                    fillColor:
                        Colors.white
                            .withValues(
                      alpha: 0.5,
                    ),

                    contentPadding:
                        const EdgeInsets
                            .symmetric(
                      horizontal: 20,
                    ),

                    border:
                        OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(
                              30),

                      borderSide:
                          BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // 🔥 LOGIN / SIGNUP BUTTON
                ElevatedButton(
                  onPressed: () async {

                    final email =
                        emailController.text
                            .trim();

                    final password =
                        passwordController
                            .text
                            .trim();

                    dynamic user;

                    if (isLogin) {

                      user =
                          await authService
                              .signIn(
                        email,
                        password,
                      );

                    } else {

                      user =
                          await authService
                              .signUp(
                        email,
                        password,
                      );
                    }

                    if (user != null &&
                        context.mounted) {

                      Navigator.pushReplacement(
                        context,

                        MaterialPageRoute(
                          builder:
                              (context) =>
                                  const MainScreen(),
                        ),
                      );

                    } else {

                      ScaffoldMessenger.of(
                              context)
                          .showSnackBar(

                        const SnackBar(
                          content: Text(
                            "Authentication Failed 😢",
                          ),
                        ),
                      );
                    }
                  },

                  style:
                      ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.orange,

                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(
                              30),
                    ),

                    padding:
                        const EdgeInsets
                            .symmetric(
                      horizontal: 80,
                      vertical: 14,
                    ),
                  ),

                  child: Text(
                    isLogin
                        ? "Log in"
                        : "Sign Up",

                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // 🔄 SWITCH LOGIN/SIGNUP
                GestureDetector(
                  onTap: () {

                    setState(() {
                      isLogin = !isLogin;
                    });
                  },

                  child: Text(
                    isLogin

                        ? "Don’t have an account? Sign Up"

                        : "Already have an account? Log In",

                    style:
                        const TextStyle(
                      color:
                          Colors.white70,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}