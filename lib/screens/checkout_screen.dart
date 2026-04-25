import 'dart:ui';
import 'package:flutter/material.dart';
import 'order_success_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String selectedPayment = "Credit Card";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFEFEF),

      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),

            // 🔝 HEADER
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back),
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    "URBNDRIP",
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 18,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 🧾 TITLE
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Checkout",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            //  MAIN CARD
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.asset(
                          "assets/checkoutbg.jpeg",
                          fit: BoxFit.cover,
                        ),
                      ),

                      Positioned.fill(
                        child: Container(
                          color: Colors.black.withOpacity(0.2),
                        ),
                      ),

                      SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //  ADDRESS
                            sectionTitle("Delivery Address"),
                            const SizedBox(height: 10),

                            glassContainer(
                              child: const TextField(
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: "Enter your address",
                                  hintStyle:
                                      TextStyle(color: Colors.white70),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),

                            //  ORDER SUMMARY
                            sectionTitle("Order Summary"),
                            const SizedBox(height: 10),

                            glassContainer(
                              child: const CheckoutItem(
                                name: "Twill Overshirt",
                                detail: "M / Black",
                                price: "\$56",
                              ),
                            ),

                            glassContainer(
                              child: const CheckoutItem(
                                name: "Slim Fit Polo Shirt",
                                detail: "M / White",
                                price: "\$76",
                              ),
                            ),

                            const SizedBox(height: 20),

                            //  PRICE
                            glassContainer(
                              child: const Column(
                                children: [
                                  PriceRow("Subtotal", "\$132"),
                                  PriceRow("Delivery", "\$10"),
                                  Divider(color: Colors.white30),
                                  PriceRow("Total", "\$142", isBold: true),
                                ],
                              ),
                            ),

                            const SizedBox(height: 20),

                            // 💳 PAYMENT (DROPDOWN VERSION)
                            sectionTitle("Payment Method"),
                            const SizedBox(height: 10),

                            glassContainer(
                              child: DropdownButtonFormField<String>(
                                value: selectedPayment,
                                dropdownColor: Colors.grey[900],
                                icon: const Icon(Icons.keyboard_arrow_down,
                                    color: Colors.white),
                                style: const TextStyle(color: Colors.white),

                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),

                                items: const [
                                  DropdownMenuItem(
                                    value: "Credit Card",
                                    child: Text("Credit Card"),
                                  ),
                                  DropdownMenuItem(
                                    value: "Cash on Delivery",
                                    child: Text("Cash on Delivery"),
                                  ),
                                ],

                                onChanged: (value) {
                                  setState(() {
                                    selectedPayment = value!;
                                  });
                                },
                              ),
                            ),

                            const SizedBox(height: 100),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            //  BUTTON
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const OrderSuccessScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text("Place Order"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget sectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: Colors.white,
      ),
    );
  }
}

//  GLASS CONTAINER
Widget glassContainer({required Widget child}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
            ),
          ),
          child: child,
        ),
      ),
    ),
  );
}

//  ITEM
class CheckoutItem extends StatelessWidget {
  final String name;
  final String detail;
  final String price;

  const CheckoutItem({
    required this.name,
    required this.detail,
    required this.price,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white24,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  style: const TextStyle(color: Colors.white)),
              Text(detail,
                  style: const TextStyle(color: Colors.white70)),
            ],
          ),
        ),
        Text(
          price,
          style: const TextStyle(
            color: Colors.orange,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

//  PRICE ROW
class PriceRow extends StatelessWidget {
  final String title;
  final String price;
  final bool isBold;

  const PriceRow(this.title, this.price,
      {this.isBold = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: const TextStyle(color: Colors.white)),
          Text(
            price,
            style: TextStyle(
              color: Colors.white,
              fontWeight:
                  isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}