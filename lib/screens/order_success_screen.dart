import 'dart:ui';
import 'package:flutter/material.dart';
import 'main_screen.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFEFEF),

      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),

            // 🔥 RIGHT LOGO
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "URBNDRIP",
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontSize: 18,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 🧾 TITLE
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Order Successful",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 🧊 CARD
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Stack(
                    children: [
                      // 🔥 BACKGROUND
                      Positioned.fill(
                        child: Image.asset(
                          "assets/checkoutbg.jpeg",
                          fit: BoxFit.cover,
                        ),
                      ),

                      // 🌑 OVERLAY
                      Positioned.fill(
                        child: Container(
                          color: Colors.black.withOpacity(0.2),
                        ),
                      ),

                      // 💎 GLASS BOX
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                                sigmaX: 12, sigmaY: 12),
                            child: Container(
                              width: 250,
                              height: 200,
                              decoration: BoxDecoration(
                                color:
                                    Colors.orange.withOpacity(0.3),
                                borderRadius:
                                    BorderRadius.circular(30),
                                border: Border.all(
                                  color: Colors.white
                                      .withOpacity(0.3),
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  "Thank You for\n your purchase!",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // 🔘 BUTTON
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainScreen(),
                    ),
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  minimumSize:
                      const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(30),
                  ),
                ),
                child: const Text("Back to Home"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}