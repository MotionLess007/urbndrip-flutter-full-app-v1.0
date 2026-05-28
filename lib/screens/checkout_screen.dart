import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'order_success_screen.dart';

import '../services/order_service.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() =>
      _CheckoutScreenState();
}

class _CheckoutScreenState
    extends State<CheckoutScreen> {

  String selectedPayment =
      "Credit Card";

  // 👤 CONTROLLERS
  final TextEditingController
      nameController =
      TextEditingController();

  final TextEditingController
      emailController =
      TextEditingController();

  final TextEditingController
      phoneController =
      TextEditingController();

  final TextEditingController
      addressController =
      TextEditingController();

  // ☁️ ORDER SERVICE
  final OrderService
      orderService =
      OrderService();

  @override
  Widget build(BuildContext context) {

    final user =
        FirebaseAuth
            .instance
            .currentUser;

    return Scaffold(
      backgroundColor:
          const Color(0xFFEFEFEF),

      body: SafeArea(
        child: StreamBuilder(

          stream:
              FirebaseFirestore
                  .instance
                  .collection("users")
                  .doc(user!.uid)
                  .collection("cart")
                  .snapshots(),

          builder:
              (context, snapshot) {

            if (!snapshot.hasData) {

              return const Center(
                child:
                    CircularProgressIndicator(),
              );
            }

            final cartDocs =
                snapshot.data!.docs;

            // 💰 TOTALS
            double subtotal = 0;

            for (var doc
                in cartDocs) {

              final data =
                  doc.data();

              subtotal +=

                  data["price"] *

                  data["quantity"];
            }

            double delivery = 10;

            double total =
                subtotal + delivery;

            return Column(
              children: [

                const SizedBox(
                    height: 10),

                // 🔝 HEADER
                Padding(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),

                  child: Row(
                    children: [

                      // 🔙 BACK
                      Container(
                        padding:
                            const EdgeInsets.all(
                                10),

                        decoration:
                            BoxDecoration(
                          shape:
                              BoxShape.circle,

                          border:
                              Border.all(
                            color: Colors
                                .grey
                                .shade300,
                          ),
                        ),

                        child:
                            GestureDetector(
                          onTap: () =>
                              Navigator.pop(
                                  context),

                          child:
                              const Icon(
                            Icons.arrow_back,
                          ),
                        ),
                      ),

                      const Spacer(),

                      // 🏷️ LOGO
                      const Text(
                        "URBNDRIP",

                        style: TextStyle(
                          fontFamily:
                              "Inter",

                          fontWeight:
                              FontWeight.bold,

                          fontStyle:
                              FontStyle.italic,

                          fontSize: 18,

                          letterSpacing:
                              1.2,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                    height: 20),

                // 🧾 TITLE
                const Padding(
                  padding:
                      EdgeInsets.symmetric(
                    horizontal: 16,
                  ),

                  child: Align(
                    alignment:
                        Alignment.centerLeft,

                    child: Text(
                      "Checkout",

                      style: TextStyle(
                        fontSize: 26,

                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                    height: 20),

                // 🧊 MAIN CARD
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.all(
                            16),

                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(
                              30),

                      child: Stack(
                        children: [

                          // 🖼️ BG
                          Positioned.fill(
                            child: Image.asset(
                              "assets/checkoutbg.jpeg",

                              fit: BoxFit.cover,
                            ),
                          ),

                          // 🌑 OVERLAY
                          Positioned.fill(
                            child: Container(
                              color: Colors.black
                                  .withOpacity(
                                      0.2),
                            ),
                          ),

                          // 📜 CONTENT
                          SingleChildScrollView(
                            padding:
                                const EdgeInsets
                                    .all(16),

                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,

                              children: [

                                // 👤 CUSTOMER INFO
                                sectionTitle(
                                  "Customer Information",
                                ),

                                const SizedBox(
                                    height:
                                        10),

                                glassContainer(
                                  child: Column(
                                    children: [

                                      // 👤 NAME
                                      TextField(
                                        controller:
                                            nameController,

                                        style:
                                            const TextStyle(
                                          color:
                                              Colors.white,
                                        ),

                                        decoration:
                                            const InputDecoration(
                                          hintText:
                                              "Full Name",

                                          hintStyle:
                                              TextStyle(
                                            color:
                                                Colors.white70,
                                          ),

                                          border:
                                              InputBorder.none,
                                        ),
                                      ),

                                      const Divider(
                                        color:
                                            Colors.white24,
                                      ),

                                      // 📧 EMAIL
                                      TextField(
                                        controller:
                                            emailController,

                                        style:
                                            const TextStyle(
                                          color:
                                              Colors.white,
                                        ),

                                        decoration:
                                            const InputDecoration(
                                          hintText:
                                              "Email Address",

                                          hintStyle:
                                              TextStyle(
                                            color:
                                                Colors.white70,
                                          ),

                                          border:
                                              InputBorder.none,
                                        ),
                                      ),

                                      const Divider(
                                        color:
                                            Colors.white24,
                                      ),

                                      // 📱 PHONE
                                      TextField(
                                        controller:
                                            phoneController,

                                        style:
                                            const TextStyle(
                                          color:
                                              Colors.white,
                                        ),

                                        decoration:
                                            const InputDecoration(
                                          hintText:
                                              "Contact Number",

                                          hintStyle:
                                              TextStyle(
                                            color:
                                                Colors.white70,
                                          ),

                                          border:
                                              InputBorder.none,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(
                                    height:
                                        20),

                                // 📍 ADDRESS
                                sectionTitle(
                                  "Delivery Address",
                                ),

                                const SizedBox(
                                    height:
                                        10),

                                glassContainer(
                                  child: TextField(
                                    controller:
                                        addressController,

                                    style:
                                        const TextStyle(
                                      color:
                                          Colors.white,
                                    ),

                                    maxLines: 2,

                                    decoration:
                                        const InputDecoration(
                                      hintText:
                                          "Enter your address",

                                      hintStyle:
                                          TextStyle(
                                        color:
                                            Colors.white70,
                                      ),

                                      border:
                                          InputBorder.none,
                                    ),
                                  ),
                                ),

                                const SizedBox(
                                    height:
                                        20),

                                // 🛍️ SUMMARY
                                sectionTitle(
                                  "Order Summary",
                                ),

                                const SizedBox(
                                    height:
                                        10),

                                Column(
                                  children:
                                      List.generate(
                                    cartDocs.length,

                                    (index) {

                                      final item =
                                          cartDocs[
                                                  index]
                                              .data();

                                      return glassContainer(

                                        child:
                                            CheckoutItem(

                                          name:
                                              item["name"],

                                          detail:
                                              "Qty: ${item["quantity"]}",

                                          price:
                                              "\$${(item["price"] * item["quantity"]).toStringAsFixed(2)}",

                                          image:
                                              item["image"],
                                        ),
                                      );
                                    },
                                  ),
                                ),

                                const SizedBox(
                                    height:
                                        20),

                                // 💰 PRICE
                                glassContainer(
                                  child: Column(
                                    children: [

                                      PriceRow(
                                        "Subtotal",

                                        "\$${subtotal.toStringAsFixed(2)}",
                                      ),

                                      PriceRow(
                                        "Delivery",

                                        "\$${delivery.toStringAsFixed(2)}",
                                      ),

                                      const Divider(
                                        color:
                                            Colors.white30,
                                      ),

                                      PriceRow(
                                        "Total",

                                        "\$${total.toStringAsFixed(2)}",

                                        isBold:
                                            true,
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(
                                    height:
                                        20),

                                // 💳 PAYMENT
                                sectionTitle(
                                  "Payment Method",
                                ),

                                const SizedBox(
                                    height:
                                        10),

                                glassContainer(
                                  child:
                                      DropdownButtonFormField<String>(

                                    value:
                                        selectedPayment,

                                    dropdownColor:
                                        Colors.grey[
                                            900],

                                    style:
                                        const TextStyle(
                                      color:
                                          Colors.white,
                                    ),

                                    decoration:
                                        const InputDecoration(
                                      border:
                                          InputBorder.none,
                                    ),

                                    items: const [

                                      DropdownMenuItem(
                                        value:
                                            "Credit Card",

                                        child: Text(
                                          "Credit Card",
                                        ),
                                      ),

                                      DropdownMenuItem(
                                        value:
                                            "Cash on Delivery",

                                        child: Text(
                                          "Cash on Delivery",
                                        ),
                                      ),
                                    ],

                                    onChanged:
                                        (value) {

                                      setState(() {

                                        selectedPayment =
                                            value!;
                                      });
                                    },
                                  ),
                                ),

                                const SizedBox(
                                    height:
                                        100),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // 🔘 PLACE ORDER
                Container(
                  padding:
                      const EdgeInsets.all(
                          16),

                  decoration:
                      const BoxDecoration(
                    color: Colors.white,

                    borderRadius:
                        BorderRadius.vertical(
                      top:
                          Radius.circular(
                              20),
                    ),
                  ),

                  child:
                      ElevatedButton(

                    onPressed:
                        () async {

                      // 📦 ITEMS
                      List<Map<String,
                          dynamic>>
                          orderItems = [];

                      for (var doc
                          in cartDocs) {

                        final item =
                            doc.data();

                        orderItems.add({

                          "name":
                              item["name"],

                          "price":
                              item["price"],

                          "quantity":
                              item["quantity"],

                          "image":
                              item["image"],
                        });
                      }

                      // ☁️ SAVE ORDER
                      await orderService
                          .placeOrder(

                        items:
                            orderItems,

                        total:
                            total,

                        name:
                            nameController
                                .text,

                        email:
                            emailController
                                .text,

                        phone:
                            phoneController
                                .text,

                        address:
                            addressController
                                .text,

                        paymentMethod:
                            selectedPayment,
                      );

                      // 🚀 SUCCESS
                      Navigator.pushReplacement(

                        context,

                        MaterialPageRoute(
                          builder:
                              (context) =>
                                  const OrderSuccessScreen(),
                        ),
                      );
                    },

                    style:
                        ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.orange,

                      minimumSize:
                          const Size(
                        double.infinity,
                        50,
                      ),

                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(
                                30),
                      ),
                    ),

                    child:
                        const Text(
                      "Place Order",
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // 🏷️ TITLE
  Widget sectionTitle(
    String text,
  ) {

    return Text(
      text,

      style: const TextStyle(
        fontWeight:
            FontWeight.bold,

        fontSize: 16,

        color: Colors.white,
      ),
    );
  }
}

// 🧊 GLASS
Widget glassContainer({
  required Widget child,
}) {

  return Container(
    margin:
        const EdgeInsets.only(
            bottom: 10),

    child: ClipRRect(
      borderRadius:
          BorderRadius.circular(
              16),

      child: BackdropFilter(
        filter:
            ImageFilter.blur(
          sigmaX: 10,
          sigmaY: 10,
        ),

        child: Container(
          padding:
              const EdgeInsets.all(
                  16),

          decoration: BoxDecoration(
            color: Colors.white
                .withOpacity(0.15),

            borderRadius:
                BorderRadius.circular(
                    16),

            border: Border.all(
              color: Colors.white
                  .withOpacity(0.2),
            ),
          ),

          child: child,
        ),
      ),
    ),
  );
}

// 🛍️ ITEM
class CheckoutItem
    extends StatelessWidget {

  final String name;
  final String detail;
  final String price;
  final String image;

  const CheckoutItem({

    required this.name,

    required this.detail,

    required this.price,

    required this.image,

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
            borderRadius:
                BorderRadius.circular(
                    12),

            image:
                DecorationImage(
              image:
                  AssetImage(image),

              fit: BoxFit.cover,
            ),
          ),
        ),

        const SizedBox(width: 10),

        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment
                    .start,

            children: [

              Text(
                name,

                style:
                    const TextStyle(
                  color:
                      Colors.white,
                ),
              ),

              Text(
                detail,

                style:
                    const TextStyle(
                  color:
                      Colors.white70,
                ),
              ),
            ],
          ),
        ),

        Text(
          price,

          style: const TextStyle(
            color: Colors.orange,

            fontWeight:
                FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

// 💰 PRICE ROW
class PriceRow
    extends StatelessWidget {

  final String title;
  final String price;
  final bool isBold;

  const PriceRow(
    this.title,
    this.price, {

    this.isBold = false,

    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding:
          const EdgeInsets.symmetric(
        vertical: 4,
      ),

      child: Row(
        mainAxisAlignment:
            MainAxisAlignment
                .spaceBetween,

        children: [

          Text(
            title,

            style:
                const TextStyle(
              color:
                  Colors.white,
            ),
          ),

          Text(
            price,

            style: TextStyle(
              color:
                  Colors.white,

              fontWeight:

                  isBold

                      ? FontWeight.bold

                      : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}