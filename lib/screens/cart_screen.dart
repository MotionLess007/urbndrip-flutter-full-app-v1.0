import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'checkout_screen.dart';

import '../services/cart_service.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() =>
      _CartScreenState();
}

class _CartScreenState
    extends State<CartScreen> {

  // ☁️ CART SERVICE
  final CartService
      cartService =
      CartService();

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
        child: Column(
          children: [

            // 🔝 HEADER
            Padding(
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 16,
              ),

              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment
                        .spaceBetween,

                children: [

                  IconButton(
                    onPressed: () =>
                        Navigator.pop(
                            context),

                    icon: const Icon(
                      Icons.arrow_back,
                    ),
                  ),

                  const Text(
                    "CART",

                    style: TextStyle(
                      fontWeight:
                          FontWeight.bold,

                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(
                      width: 40),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // ☁️ FIRESTORE CART
            Expanded(
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

                  // ⏳ LOADING
                  if (snapshot
                          .connectionState ==
                      ConnectionState
                          .waiting) {

                    return const Center(
                      child:
                          CircularProgressIndicator(),
                    );
                  }

                  // ❌ EMPTY
                  if (!snapshot.hasData ||

                      snapshot
                          .data!
                          .docs
                          .isEmpty) {

                    return const Center(
                      child: Text(

                        "Your cart is empty 🛒",

                        style: TextStyle(
                          fontSize: 18,

                          fontWeight:
                              FontWeight
                                  .w500,
                        ),
                      ),
                    );
                  }

                  final cartDocs =
                      snapshot
                          .data!
                          .docs;

                  // 💰 TOTAL
                  double total = 0;

                  for (var doc
                      in cartDocs) {

                    final data =
                        doc.data();

                    total +=

                        data["price"] *

                        data["quantity"];
                  }

                  return Column(
                    children: [

                      // 🛍️ ITEMS
                      Expanded(
                        child: ListView.builder(

                          padding:
                             const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),

                          itemCount:
                              cartDocs.length,

                          itemBuilder:
                              (
                                context,
                                index,
                              ) {

                            final data =
                                cartDocs[
                                        index]
                                    .data();

                            return Padding(
                              padding:
                                  const EdgeInsets
                                      .only(
                                bottom: 12,
                              ),

                              child:
                                  CartProductCard(

                                data: data,

                                onDelete:
                                    () async {

                                  await cartService
                                      .removeFromCart(
                                    data["name"],
                                  );
                                },

                                onIncrease:
                                    () async {

                                  await cartService
                                      .updateQuantity(

                                    data["name"],

                                    data["quantity"] +
                                        1,
                                  );
                                },

                                onDecrease:
                                    () async {

                                  if (data[
                                          "quantity"] >
                                      1) {

                                    await cartService
                                        .updateQuantity(

                                      data["name"],

                                      data["quantity"] -
                                          1,
                                    );
                                  }
                                },
                              ),
                            );
                          },
                        ),
                      ),

                      // 💰 TOTAL + CHECKOUT
                      Container(
                        padding:
                            const EdgeInsets
                                .all(16),

                        decoration:
                            const BoxDecoration(
                          color:
                              Colors.white,

                          borderRadius:
                              BorderRadius.vertical(
                            top: Radius.circular(
                                20),
                          ),
                        ),

                        child: Column(
                          children: [

                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceBetween,

                              children: [

                                const Text(
                                    "Total"),

                                Text(

                                  "\$${total.toStringAsFixed(2)}",

                                  style:
                                      const TextStyle(

                                    fontWeight:
                                        FontWeight
                                            .bold,

                                    color:
                                        Colors.orange,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(
                                height: 12),

                            ElevatedButton(
                              onPressed: () {

                                Navigator.push(
                                  context,

                                  MaterialPageRoute(
                                    builder:
                                        (context) =>
                                            const CheckoutScreen(),
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
                                "Checkout",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 🛍️ PRODUCT CARD
class CartProductCard
    extends StatelessWidget {

  final Map<String, dynamic>
      data;

  final VoidCallback
      onDelete;

  final VoidCallback
      onIncrease;

  final VoidCallback
      onDecrease;

  const CartProductCard({

    required this.data,

    required this.onDelete,

    required this.onIncrease,

    required this.onDecrease,

    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      padding:
          const EdgeInsets.all(12),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(
                16),
      ),

      child: Row(
        children: [

          // 🖼️ IMAGE
          Container(
            width: 70,
            height: 70,

            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(
                      12),

              image:
                  DecorationImage(

                image: AssetImage(
                  data["image"],
                ),

                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(width: 12),

          // 📦 DETAILS
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,

              children: [

                Text(
                  data["name"],

                  style:
                      const TextStyle(
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(
                    height: 4),

                Text(
                  "⭐ ${data["rating"]}",

                  style:
                      const TextStyle(
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(
                    height: 4),

                Text(

                  "\$${data["price"]}",

                  style:
                      const TextStyle(

                    color:
                        Colors.orange,

                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // 🔢 ACTIONS
          Column(
            children: [

              // 🗑️ DELETE
              GestureDetector(
                onTap: onDelete,

                child: const Icon(
                  Icons.delete_outline,

                  color: Colors.red,
                ),
              ),

              const SizedBox(
                  height: 8),

              // ➕
              GestureDetector(
                onTap: onIncrease,

                child: const Icon(
                  Icons
                      .add_circle_outline,
                ),
              ),

              const SizedBox(
                  height: 4),

              Text(
                data["quantity"]
                    .toString(),
              ),

              const SizedBox(
                  height: 4),

              // ➖
              GestureDetector(
                onTap: onDecrease,

                child: const Icon(
                  Icons
                      .remove_circle_outline,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}