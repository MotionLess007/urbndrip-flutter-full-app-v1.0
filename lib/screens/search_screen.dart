import 'package:flutter/material.dart';

import 'detail_screen.dart';
import 'cart_screen.dart';

import '../models/product.dart';

import '../data/favorite_data.dart';

import '../services/wishlist_service.dart';
import '../services/product_service.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() =>
      _SearchScreenState();
}

class _SearchScreenState
    extends State<SearchScreen> {

  // ☁️ PRODUCT SERVICE
  final ProductService
      productService =
      ProductService();

  // 🏷️ SELECTED CATEGORY
  String selectedCategory = "All";

  // 🔍 SEARCH TEXT
  String searchQuery = "";

  // 🔄 SORT
  bool sortLowToHigh = true;

  // ⭐ FILTER MODE
  String selectedFilter = "";

  @override
  Widget build(BuildContext context) {

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

                  const SizedBox(
                    width: 40,
                  ),

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

            // 🔍 SEARCH BAR
            Padding(
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 16,
              ),

              child: Row(
                children: [

                  Expanded(
                    child: Container(
                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 12,
                      ),

                      decoration:
                          BoxDecoration(
                        color: Colors.white,

                        borderRadius:
                            BorderRadius.circular(
                                30),
                      ),

                      child: Row(
                        children: [

                          const Icon(
                            Icons.search,
                          ),

                          const SizedBox(
                              width: 8),

                          Expanded(
                            child: TextField(

                              onChanged:
                                  (value) {

                                setState(() {

                                  searchQuery =
                                      value;
                                });
                              },

                              decoration:
                                  const InputDecoration(
                                hintText:
                                    "Search",

                                border:
                                    InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  // 🎛️ FILTER BUTTON
                  GestureDetector(
                    onTap: () {

                      showModalBottomSheet(
                        context: context,

                        backgroundColor:
                            Colors.white,

                        shape:
                            const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(
                            top: Radius.circular(
                                30),
                          ),
                        ),

                        builder: (context) {

                          return Container(
                            padding:
                                const EdgeInsets
                                    .all(20),

                            height: 320,

                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,

                              children: [

                                const Center(
                                  child: Text(
                                    "Filters",

                                    style:
                                        TextStyle(
                                      fontSize:
                                          24,
                                      fontWeight:
                                          FontWeight
                                              .bold,
                                    ),
                                  ),
                                ),

                                const SizedBox(
                                    height: 25),

                                ListTile(
                                  leading:
                                      const Icon(
                                    Icons.star,
                                  ),

                                  title:
                                      const Text(
                                    "Highest Rated",
                                  ),

                                  onTap: () {

                                    setState(() {

                                      selectedFilter =
                                          "rating";
                                    });

                                    Navigator.pop(
                                        context);
                                  },
                                ),

                                ListTile(
                                  leading:
                                      const Icon(
                                    Icons
                                        .attach_money,
                                  ),

                                  title:
                                      const Text(
                                    "Lowest Price",
                                  ),

                                  onTap: () {

                                    setState(() {

                                      selectedFilter =
                                          "low";
                                    });

                                    Navigator.pop(
                                        context);
                                  },
                                ),

                                ListTile(
                                  leading:
                                      const Icon(
                                    Icons
                                        .trending_up,
                                  ),

                                  title:
                                      const Text(
                                    "Highest Price",
                                  ),

                                  onTap: () {

                                    setState(() {

                                      selectedFilter =
                                          "high";
                                    });

                                    Navigator.pop(
                                        context);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },

                    child: circleButton(
                      Icons.tune,
                    ),
                  ),

                  const SizedBox(width: 8),

                  // 🔄 SORT BUTTON
                  GestureDetector(
                    onTap: () {

                      setState(() {

                        sortLowToHigh =
                            !sortLowToHigh;
                      });
                    },

                    child: circleButton(
                      Icons.swap_vert,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            // 🏷️ CATEGORYS
            SizedBox(
              height: 50,

              child: ListView(
                scrollDirection:
                    Axis.horizontal,

                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 16,
                ),

                children: [

                  buildCategoryChip("All"),

                  buildCategoryChip(
                      "T-shirts"),

                  buildCategoryChip(
                      "Pants"),

                  buildCategoryChip(
                      "Hoodies"),

                  buildCategoryChip(
                      "Jackets"),

                  buildCategoryChip(
                      "Sneakers"),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // ☁️ FIRESTORE PRODUCTS
            Expanded(
              child: StreamBuilder(

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
                      child: Text(
                        "No products found 😢",
                      ),
                    );
                  }

                  final productDocs =
                      snapshot
                          .data!
                          .docs;

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

                  // 🔍 SEARCH
                  if (searchQuery
                      .isNotEmpty) {

                    firestoreProducts =
                        firestoreProducts
                            .where((product) {

                      return product.name
                          .toLowerCase()
                          .contains(
                            searchQuery
                                .toLowerCase(),
                          );

                    }).toList();
                  }

                  // 🏷️ CATEGORY FILTER
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

                  // ⭐ FILTERS
                  if (selectedFilter ==
                      "rating") {

                    firestoreProducts.sort(
                      (a, b) =>
                          b.rating.compareTo(
                        a.rating,
                      ),
                    );
                  }

                  if (selectedFilter ==
                      "low") {

                    firestoreProducts.sort(
                      (a, b) =>
                          a.price.compareTo(
                        b.price,
                      ),
                    );
                  }

                  if (selectedFilter ==
                      "high") {

                    firestoreProducts.sort(
                      (a, b) =>
                          b.price.compareTo(
                        a.price,
                      ),
                    );
                  }

                  // 🔄 SORT BUTTON
                  if (sortLowToHigh) {

                    firestoreProducts.sort(
                      (a, b) =>
                          a.price.compareTo(
                        b.price,
                      ),
                    );

                  } else {

                    firestoreProducts.sort(
                      (a, b) =>
                          b.price.compareTo(
                        a.price,
                      ),
                    );
                  }

                  return Padding(
                    padding:
                        const EdgeInsets
                            .symmetric(
                      horizontal: 16,
                    ),

                    child: GridView.builder(

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
                            0.68,
                      ),

                      itemBuilder:
                          (
                            context,
                            index,
                          ) {

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
            ),
          ],
        ),
      ),
    );
  }

  // 🏷️ CATEGORY CHIP
  Widget buildCategoryChip(
    String category,
  ) {

    final isActive =
        selectedCategory ==
            category;

    return GestureDetector(
      onTap: () {

        setState(() {

          selectedCategory =
              category;
        });
      },

      child: Container(
        margin:
            const EdgeInsets.only(
                right: 10),

        padding:
            const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),

        decoration: BoxDecoration(
          color:
              isActive
                  ? Colors.orange
                  : Colors.white,

          borderRadius:
              BorderRadius.circular(
                  20),
        ),

        child: Text(
          category,

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

// 🔘 BUTTON
Widget circleButton(
  IconData icon,
) {

  return Container(
    padding:
        const EdgeInsets.all(10),

    decoration:
        const BoxDecoration(
      color: Colors.white,
      shape: BoxShape.circle,
    ),

    child: Icon(icon),
  );
}

// 🛍️ PRODUCT CARD
class ProductCard
    extends StatefulWidget {

  final Product product;

  const ProductCard({
    required this.product,
    super.key,
  });

  @override
  State<ProductCard>
      createState() =>
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
              product:
                  widget.product,
            ),
          ),
        );
      },

      child: Container(

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius:
              BorderRadius.circular(
                  20),
        ),

        child: Column(
          children: [

            Expanded(
              child: Stack(
                children: [

                  Container(
                    margin:
                        const EdgeInsets
                            .all(8),

                    decoration:
                        BoxDecoration(

                      borderRadius:
                          BorderRadius
                              .circular(
                                  16),

                      image:
                          DecorationImage(

                        image: AssetImage(
                          widget.product
                              .image,
                        ),

                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  Positioned(
                    top: 10,
                    right: 10,

                    child:
                        GestureDetector(

                      onTap: () async {

                        setState(() {

                          isFavorite =
                              !isFavorite;
                        });

                        if (isFavorite) {

                          favoriteProducts
                              .add(
                            widget.product,
                          );

                          await wishlistService
                              .addToWishlist(
                            widget.product,
                          );

                        } else {

                          favoriteProducts
                              .remove(
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

                            : Icons
                                .favorite_border,

                        color:
                            isFavorite

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
                  const EdgeInsets
                      .all(8),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                children: [

                  Text(
                    widget.product.name,

                    style:
                        const TextStyle(
                      fontSize: 13,
                    ),
                  ),

                  const SizedBox(
                      height: 4),

                  Row(
                    children: [

                      const Icon(
                        Icons.star,

                        size: 14,

                        color:
                            Colors.orange,
                      ),

                      const SizedBox(
                          width: 4),

                      Text(
                        widget
                            .product.rating
                            .toString(),
                      ),
                    ],
                  ),

                  const SizedBox(
                      height: 4),

                  Text(
                    "\$${widget.product.price}",

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
  }
}