import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/product.dart';

import 'detail_screen.dart';

class WishlistScreen extends StatelessWidget {

  const WishlistScreen({
    super.key,
  });

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

                  IconButton(
                    onPressed: () {

                      Navigator.pop(
                          context);
                    },

                    icon: const Icon(
                      Icons.arrow_back,
                    ),
                  ),

                  const Spacer(),

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
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(
                height: 20),

            // ❤️ TITLE
            const Padding(
              padding:
                  EdgeInsets.symmetric(
                horizontal: 16,
              ),

              child: Align(
                alignment:
                    Alignment.centerLeft,

                child: Text(
                  "My Wishlist",

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

            // ☁️ FIRESTORE WISHLIST
            Expanded(
              child: StreamBuilder(

                stream:

                    FirebaseFirestore
                        .instance
                        .collection("users")
                        .doc(user!.uid)
                        .collection(
                            "wishlist")
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

                        "No favorite products yet ❤️",

                        style: TextStyle(
                          fontSize: 18,
                          fontWeight:
                              FontWeight
                                  .w500,
                        ),
                      ),
                    );
                  }

                  final wishlistDocs =
                      snapshot
                          .data!
                          .docs;

                  // 🛍️ PRODUCTS
                  return GridView.builder(

                    padding:
                        const EdgeInsets
                            .symmetric(
                      horizontal: 16,
                    ),

                    itemCount:
                        wishlistDocs.length,

                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(

                      crossAxisCount: 2,

                      mainAxisSpacing:
                          16,

                      crossAxisSpacing:
                          16,

                      childAspectRatio:
                          0.68,
                    ),

                    itemBuilder:
                        (context, index) {

                      final data =
                          wishlistDocs[
                                  index]
                              .data();

                      // ☁️ PRODUCT
                      final product =
                          Product(

                        name:
                            data["name"],

                        price:
                            data["price"],

                        image:
                            data["image"],

                        rating:
                            data["rating"],

                        category:
                            data["category"],
                      );

                      return GestureDetector(

                        onTap: () {

                          Navigator.push(
                            context,

                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      DetailScreen(
                                product:
                                    product,
                              ),
                            ),
                          );
                        },

                        child: Container(

                          decoration:
                              BoxDecoration(

                            color:
                                Colors.white,

                            borderRadius:
                                BorderRadius.circular(
                                    20),
                          ),

                          child: Column(
                            children: [

                              // 🖼️ IMAGE
                              Expanded(
                                child: Stack(
                                  children: [

                                    Container(
                                      margin:
                                          const EdgeInsets
                                              .all(
                                                  8),

                                      decoration:
                                          BoxDecoration(

                                        borderRadius:
                                            BorderRadius.circular(
                                                16),

                                        image:
                                            DecorationImage(

                                          image:
                                              AssetImage(
                                            product
                                                .image,
                                          ),

                                          fit:
                                              BoxFit.cover,
                                        ),
                                      ),
                                    ),

                                    const Positioned(
                                      top: 10,
                                      right: 10,

                                      child: Icon(
                                        Icons.favorite,

                                        color:
                                            Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // 📦 DETAILS
                              Padding(
                                padding:
                                    const EdgeInsets
                                        .all(
                                            8),

                                child: Column(

                                  crossAxisAlignment:
                                      CrossAxisAlignment
                                          .start,

                                  children: [

                                    Text(
                                      product.name,
                                    ),

                                    const SizedBox(
                                        height:
                                            4),

                                    Row(
                                      children: [

                                        const Icon(
                                          Icons.star,

                                          size: 14,

                                          color: Colors
                                              .orange,
                                        ),

                                        const SizedBox(
                                            width:
                                                4),

                                        Text(
                                          product
                                              .rating
                                              .toString(),
                                        ),
                                      ],
                                    ),

                                    const SizedBox(
                                        height:
                                            4),

                                    Text(

                                      "\$${product.price}",

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
                            ],
                          ),
                        ),
                      );
                    },
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