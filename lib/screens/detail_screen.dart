import 'package:flutter/material.dart';

import '../models/product.dart';

import 'cart_screen.dart';

import '../services/cart_service.dart';

class DetailScreen extends StatefulWidget {

  final Product product;

  const DetailScreen({
    required this.product,
    super.key,
  });

  @override
  State<DetailScreen>
      createState() =>
          _DetailScreenState();
}

class _DetailScreenState
    extends State<DetailScreen> {

  String selectedSize = "L";

  // ☁️ CART SERVICE
  final CartService
      cartService =
      CartService();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:
          const Color(0xFFEFEFEF),

      body: SafeArea(
        child: Column(
          children: [

            // 🔝 TOP BAR
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
                    "URBNDRIP",

                    style: TextStyle(
                      fontFamily:
                          "Inter",

                      fontSize: 20,

                      fontWeight:
                          FontWeight.bold,

                      fontStyle:
                          FontStyle.italic,
                    ),
                  ),

                  Row(
                    children: [

                      const Icon(
                        Icons.share,
                      ),

                      const SizedBox(
                          width: 10),

                      IconButton(
                        onPressed: () {

                          Navigator.push(
                            context,

                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      const CartScreen(),
                            ),
                          );
                        },

                        icon: const Icon(
                          Icons.shopping_cart,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // 🖼️ PRODUCT IMAGE
            Container(
              margin:
                  const EdgeInsets.symmetric(
                horizontal: 16,
              ),

              height: 300,

              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(
                        20),

                image:
                    DecorationImage(
                  image: AssetImage(
                    widget.product.image,
                  ),

                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 📦 DETAILS
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.all(
                        16),

                decoration:
                    const BoxDecoration(
                  color: Colors.white,

                  borderRadius:
                      BorderRadius.vertical(
                    top: Radius.circular(
                        30),
                  ),
                ),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,

                  children: [

                    Text(
                      widget.product.name,

                      style:
                          const TextStyle(
                        fontSize: 18,

                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                        height: 10),

                    Row(
                      children: [

                        const Icon(
                          Icons.star,

                          size: 16,

                          color:
                              Colors.orange,
                        ),

                        const SizedBox(
                            width: 5),

                        Text(
                          "${widget.product.rating} (245 sold)",
                        ),
                      ],
                    ),

                    const SizedBox(
                        height: 10),

                    Text(
                      "\$${widget.product.price}",

                      style:
                          const TextStyle(
                        color:
                            Colors.orange,

                        fontSize: 18,

                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                        height: 20),

                    const Text(
                      "Size",
                    ),

                    const SizedBox(
                        height: 10),

                    Row(
                      children: [

                        sizeBox("S"),

                        sizeBox("M"),

                        sizeBox("L"),

                        sizeBox("XL"),
                      ],
                    ),

                    const SizedBox(
                        height: 20),

                    const Text(
                      "Premium streetwear fashion piece designed for comfort and modern style.",

                      style: TextStyle(
                        color: Colors.grey,

                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 🛒 ADD TO CART
            Padding(
              padding:
                  const EdgeInsets.all(
                      16),

              child: ElevatedButton(

                onPressed: () async {

                  // ☁️ ADD TO FIRESTORE CART
                  await cartService
                      .addToCart(
                    widget.product,
                  );

                  // 🚀 GO TO CART
                  Navigator.push(
                    context,

                    MaterialPageRoute(
                      builder: (context) =>
                          const CartScreen(),
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

                child: const Text(
                  "Add to Cart",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔘 SIZE BOX
  Widget sizeBox(
    String size,
  ) {

    final isActive =
        selectedSize == size;

    return GestureDetector(
      onTap: () {

        setState(() {

          selectedSize = size;
        });
      },

      child: Container(
        margin:
            const EdgeInsets.only(
                right: 10),

        padding:
            const EdgeInsets.all(
                12),

        decoration: BoxDecoration(
          color:

              isActive

                  ? Colors.black

                  : Colors.grey[200],

          shape: BoxShape.circle,
        ),

        child: Text(
          size,

          style: TextStyle(
            color:

                isActive

                    ? Colors.white

                    : Colors.black,
          ),
        ),
      ),
    );
  }
}