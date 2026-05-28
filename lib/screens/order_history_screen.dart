import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OrderHistoryScreen
    extends StatelessWidget {

  const OrderHistoryScreen({
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

            // 🔝 HEADER
            Padding(
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
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
                    "ORDER HISTORY",

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

            // ☁️ ORDERS
            Expanded(
              child: StreamBuilder(

                stream:
                    FirebaseFirestore
                        .instance
                        .collection("users")
                        .doc(user!.uid)
                        .collection("orders")
                        .orderBy(
                          "createdAt",
                          descending: true,
                        )
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

                        "No orders yet 📦",

                        style: TextStyle(
                          fontSize: 18,

                          fontWeight:
                              FontWeight
                                  .w500,
                        ),
                      ),
                    );
                  }

                  final orders =
                      snapshot
                          .data!
                          .docs;

                  return ListView.builder(

                    padding:
                        const EdgeInsets.all(
                            16),

                    itemCount:
                        orders.length,

                    itemBuilder:
                        (
                          context,
                          index,
                        ) {

                      final order =
                          orders[index]
                              .data();

                      final items =
                          order["items"]
                              as List;

                      return Container(
                        margin:
                            const EdgeInsets.only(
                          bottom: 16,
                        ),

                        padding:
                            const EdgeInsets
                                .all(16),

                        decoration:
                            BoxDecoration(
                          color:
                              Colors.white,

                          borderRadius:
                              BorderRadius.circular(
                                  20),
                        ),

                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,

                          children: [

                            // 📦 ORDER TITLE
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceBetween,

                              children: [

                                const Text(
                                  "Order",

                                  style:
                                      TextStyle(
                                    fontWeight:
                                        FontWeight.bold,

                                    fontSize:
                                        16,
                                  ),
                                ),

                                Text(
                                  order[
                                      "paymentMethod"],

                                  style:
                                      const TextStyle(
                                    color:
                                        Colors.orange,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(
                                height: 10),

                            // 🛍️ ITEMS
                            Column(
                              children:
                                  List.generate(

                                items.length,

                                (itemIndex) {

                                  final item =
                                      items[
                                          itemIndex];

                                  return Padding(
                                    padding:
                                        const EdgeInsets
                                            .only(
                                      bottom: 10,
                                    ),

                                    child: Row(
                                      children: [

                                        // 🖼️ IMAGE
                                        Container(
                                          width:
                                              60,

                                          height:
                                              60,

                                          decoration:
                                              BoxDecoration(

                                            borderRadius:
                                                BorderRadius.circular(
                                                    12),

                                            image:
                                                DecorationImage(

                                              image:
                                                  AssetImage(
                                                item["image"],
                                              ),

                                              fit:
                                                  BoxFit.cover,
                                            ),
                                          ),
                                        ),

                                        const SizedBox(
                                            width:
                                                12),

                                        // 📦 DETAILS
                                        Expanded(
                                          child:
                                              Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,

                                            children: [

                                              Text(
                                                item["name"],

                                                style:
                                                    const TextStyle(
                                                  fontWeight:
                                                      FontWeight.bold,
                                                ),
                                              ),

                                              const SizedBox(
                                                  height:
                                                      4),

                                              Text(
                                                "Qty: ${item["quantity"]}",
                                              ),
                                            ],
                                          ),
                                        ),

                                        // 💰 PRICE
                                        Text(

                                          "\$${item["price"]}",

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
                                  );
                                },
                              ),
                            ),

                            const Divider(),

                            // 💰 TOTAL
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceBetween,

                              children: [

                                const Text(
                                  "Total",

                                  style:
                                      TextStyle(
                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                ),

                                Text(

                                  "\$${order["total"].toStringAsFixed(2)}",

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

                            const SizedBox(
                                height: 8),

                            // 📍 ADDRESS
                            Text(
                              order["address"],

                              style:
                                  const TextStyle(
                                color:
                                    Colors.grey,
                              ),
                            ),
                          ],
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