import 'package:flutter/material.dart';


import 'detail_screen.dart';
import 'cart_screen.dart';

import '../models/product.dart';

import '../data/favorite_data.dart';

import '../services/wishlist_service.dart';
import '../services/product_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState
    extends State<HomeScreen> {

  int currentPage = 0;

  final PageController _controller =
      PageController();

  // ☁️ PRODUCT SERVICE
  final ProductService
      productService =
      ProductService();

  // 🔥 SELECTED CATEGORY
  String selectedCategory = "All";

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:
          const Color(0xFFEFEFEF),

      body: SafeArea(
        child: ListView(
          children: [

            const SizedBox(height: 10),

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

                  // 🍔 MENU
                  GestureDetector(
                    onTap: () {

                      showModalBottomSheet(
                        context: context,

                        backgroundColor:
                            Colors.transparent,

                        isScrollControlled:
                            true,

                        builder: (context) {

                          return Container(
                            height:
                                MediaQuery.of(
                                          context,
                                        )
                                        .size
                                        .height *
                                    0.5,

                            decoration:
                                const BoxDecoration(
                              color: Colors.white,

                              borderRadius:
                                  BorderRadius.vertical(
                                top: Radius.circular(
                                    30),
                              ),
                            ),

                            child: Padding(
                              padding:
                                  const EdgeInsets
                                      .all(24),

                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,

                                children: [

                                  // 🔘 HANDLE
                                  Center(
                                    child: Container(
                                      width: 60,
                                      height: 5,

                                      decoration:
                                          BoxDecoration(
                                        color:
                                            Colors
                                                .grey,

                                        borderRadius:
                                            BorderRadius.circular(
                                                10),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(
                                      height: 30),

                                  const Text(
                                    "Categories",

                                    style: TextStyle(
                                      fontSize: 28,
                                      fontWeight:
                                          FontWeight
                                              .bold,
                                    ),
                                  ),

                                  const SizedBox(
                                      height: 30),

                                  categoryItem(
                                    Icons.apps,
                                    "All",
                                  ),

                                  categoryItem(
                                    Icons
                                        .sports_basketball,
                                    "Sneakers",
                                  ),

                                  categoryItem(
                                    Icons.fireplace,
                                    "Hoodies",
                                  ),

                                  categoryItem(
                                    Icons.style,
                                    "Jackets",
                                  ),

                                  categoryItem(
                                    Icons.checkroom,
                                    "T-shirts",
                                  ),

                                  categoryItem(
                                    Icons.shopping_bag,
                                    "Pants",
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },

                    child: const Icon(
                      Icons.menu,
                      size: 28,
                    ),
                  ),

                  // 🏷️ LOGO
                  const Text(
                    "URBNDRIP",

                    style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 20,
                      fontWeight:
                          FontWeight.bold,
                      fontStyle:
                          FontStyle.italic,
                    ),
                  ),

                  // 🛒 CART
                  Stack(
                    children: [

                      IconButton(
                        onPressed: () {

                          Navigator.push(
                            context,

                            MaterialPageRoute(
                              builder: (context) =>
                                  const CartScreen(),
                            ),
                          );
                        },

                        icon: const Icon(
                          Icons.shopping_cart,
                        ),
                      ),

                      const Positioned(
                        right: 8,
                        top: 8,

                        child: CircleAvatar(
                          radius: 6,
                          backgroundColor:
                              Colors.red,

                          child: Text(
                            "2",

                            style: TextStyle(
                              fontSize: 8,
                              color:
                                  Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // 🔥 BANNERS
            SizedBox(
              height: 230,

              child: PageView(
                controller: _controller,

                physics:
                    const BouncingScrollPhysics(),

                padEnds: false,

                onPageChanged: (index) {

                  setState(() {
                    currentPage = index;
                  });
                },

                children: const [

                  BannerCard(
                    title:
                        "New style clothes",

                    discount: "75% OFF",

                    colors: [
                      Color(0xFF1A1A1A),
                      Colors.orange,
                    ],
                  ),

                  BannerCard(
                    title:
                        "Summer Collection",

                    discount: "50% OFF",

                    colors: [
                      Colors.blueGrey,
                      Colors.blue,
                    ],
                  ),

                  BannerCard(
                    title: "Limited Drop",

                    discount: "30% OFF",

                    colors: [
                      Colors.black,
                      Colors.red,
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // 🔘 DOTS
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.center,

              children: List.generate(
                3,
                (index) {

                  return Container(
                    margin:
                        const EdgeInsets.symmetric(
                      horizontal: 4,
                    ),

                    width:
                        currentPage == index
                            ? 12
                            : 8,

                    height:
                        currentPage == index
                            ? 12
                            : 8,

                    decoration: BoxDecoration(
                      color:
                          currentPage == index
                              ? Colors.orange
                              : Colors.grey,

                      shape: BoxShape.circle,
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // ☁️ FIRESTORE PRODUCTS
            StreamBuilder(

              stream:
                  productService
                      .getProducts(),

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
                    child: Padding(
                      padding:
                          EdgeInsets.all(
                              30),

                      child: Text(
                        "No products found 😢",
                      ),
                    ),
                  );
                }

                final productDocs =
                    snapshot
                        .data!
                        .docs;

                // ☁️ PRODUCTS
                List<Product>
                    firestoreProducts =

                    productDocs.map((doc) {

                  final data =
                      doc.data()
                          as Map<String,
                              dynamic>;

                  return Product(

                    name:
                        data["name"],

                    price:
                        data["price"]
                            .toDouble(),

                    image:
                        data["image"],

                    rating:
                        data["rating"]
                            .toDouble(),

                    category:
                        data["category"],
                  );

                }).toList();

                // 🏷️ FILTER
                if (selectedCategory !=
                    "All") {

                  firestoreProducts =
                      firestoreProducts
                          .where((product) {

                    return product
                            .category ==
                        selectedCategory;

                  }).toList();
                }

                // 🛍️ GRID
                return Padding(
                  padding:
                      const EdgeInsets
                          .symmetric(
                    horizontal: 16,
                  ),

                  child: GridView.builder(
                    shrinkWrap: true,
                    primary: false,

                    physics:
                        const NeverScrollableScrollPhysics(),

                    itemCount:
                        firestoreProducts
                            .length,

                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing:
                          16,
                      crossAxisSpacing:
                          16,
                      childAspectRatio:
                          0.9,
                    ),

                    itemBuilder:
                        (context, index) {

                      return ProductCard(
                        product:
                            firestoreProducts[
                                index],
                      );
                    },
                  ),
                );
              },
            ),

            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  // 📂 CATEGORY ITEM
  Widget categoryItem(
    IconData icon,
    String title,
  ) {

    return GestureDetector(
      onTap: () {

        setState(() {
          selectedCategory = title;
        });

        Navigator.pop(context);
      },

      child: Padding(
        padding:
            const EdgeInsets.only(
                bottom: 20),

        child: Row(
          children: [

            Icon(
              icon,
              size: 28,
            ),

            const SizedBox(width: 20),

            Text(
              title,

              style: const TextStyle(
                fontSize: 20,
                fontWeight:
                    FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 🔥 BANNER
class BannerCard extends StatelessWidget {

  final String title;
  final String discount;
  final List<Color> colors;

  const BannerCard({
    required this.title,
    required this.discount,
    required this.colors,
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      margin:
          const EdgeInsets.symmetric(
        horizontal: 12,
      ),

      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(25),

        gradient: LinearGradient(
          colors: colors,

          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),

      child: Padding(
        padding:
            const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [

            Text(
              title,

              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              discount,

              style: const TextStyle(
                color: Colors.white,
                fontSize: 34,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 🛍️ PRODUCT CARD
class ProductCard extends StatefulWidget {

  final Product product;

  const ProductCard({
    required this.product,
    super.key,
  });

  @override
  State<ProductCard> createState() =>
      _ProductCardState();
}

class _ProductCardState
    extends State<ProductCard> {

  bool isFavorite = false;

  final WishlistService
      wishlistService =
      WishlistService();

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {

        Navigator.push(
          context,

          MaterialPageRoute(
            builder: (context) =>
                DetailScreen(
              product: widget.product,
            ),
          ),
        );
      },

      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius:
              BorderRadius.circular(20),
        ),

        child: Column(
          children: [

            Expanded(
              child: Stack(
                children: [

                  Container(
                    margin:
                        const EdgeInsets.all(8),

                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(
                              16),

                      image:
                          DecorationImage(
                        image: AssetImage(
                          widget.product.image,
                        ),

                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  Positioned(
                    top: 10,
                    right: 10,

                    child: GestureDetector(
                      onTap: () async {

                        setState(() {
                          isFavorite =
                              !isFavorite;
                        });

                        if (isFavorite) {

                          favoriteProducts.add(
                            widget.product,
                          );

                          await wishlistService
                              .addToWishlist(
                            widget.product,
                          );

                        } else {

                          favoriteProducts.remove(
                            widget.product,
                          );

                          await wishlistService
                              .removeFromWishlist(
                            widget.product,
                          );
                        }
                      },

                      child: Icon(
                        isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,

                        color: isFavorite
                            ? Colors.red
                            : Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding:
                  const EdgeInsets.all(8),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Text(
                    widget.product.name,

                    style: const TextStyle(
                      fontSize: 13,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Row(
                    children: [

                      const Icon(
                        Icons.star,
                        size: 14,
                        color: Colors.orange,
                      ),

                      const SizedBox(width: 4),

                      Text(
                        widget.product.rating
                            .toString(),
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  Text(
                    "\$${widget.product.price}",

                    style: const TextStyle(
                      color: Colors.orange,
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
  }
}