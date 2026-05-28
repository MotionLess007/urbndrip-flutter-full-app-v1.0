import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'wishlist_screen.dart';
import 'main_screen.dart';
import 'settings_screen.dart';
import 'edit_profile_screen.dart';

import 'order_history_screen.dart';

import 'help_screen.dart';
import 'login_screen.dart';

class ProfileScreen
    extends StatelessWidget {

  const ProfileScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    // ☁️ CURRENT USER
    final user =
        FirebaseAuth
            .instance
            .currentUser;

    return Scaffold(
      backgroundColor:
          const Color(0xFFEFEFEF),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [

              const SizedBox(height: 10),

              // 🔝 HEADER
              Padding(
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 16,
                ),

                child: Row(
                  children: [

                    // 🔙 BACK
                    GestureDetector(
                      onTap: () {

                        Navigator.pushReplacement(

                          context,

                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    const MainScreen(),
                          ),
                        );
                      },

                      child: Container(
                        padding:
                            const EdgeInsets
                                .all(10),

                        decoration:
                            BoxDecoration(
                          shape:
                              BoxShape.circle,

                          border: Border.all(
                            color: Colors
                                .grey
                                .shade300,
                          ),
                        ),

                        child: const Icon(
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

              const SizedBox(height: 20),

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
                    "Profile",

                    style: TextStyle(
                      fontSize: 26,

                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // 💎 PROFILE CARD
              Padding(
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 16,
                ),

                child: Container(
                  width: double.infinity,

                  padding:
                      const EdgeInsets
                          .symmetric(
                    vertical: 30,
                  ),

                  decoration: BoxDecoration(
                    color:
                        Colors.grey.shade300,

                    borderRadius:
                        BorderRadius.circular(
                            25),

                    boxShadow: [

                      BoxShadow(
                        color: Colors.black
                            .withOpacity(
                                0.05),

                        blurRadius: 10,

                        offset:
                            const Offset(
                          0,
                          5,
                        ),
                      ),
                    ],
                  ),

                  child: Column(
                    children: [

                      // 👤 PROFILE IMAGE
                      Stack(
                        children: [

                          const CircleAvatar(
                            radius: 45,

                            backgroundColor:
                                Colors.white,

                            child: Icon(
                              Icons.person,

                              size: 45,
                            ),
                          ),

                          // ✨ EDIT PROFILE
                          Positioned(
                            top: 0,
                            right: -10,

                            child:
                                GestureDetector(
                              onTap: () {

                                Navigator.push(
                                  context,

                                  MaterialPageRoute(
                                    builder:
                                        (context) =>
                                            const EditProfileScreen(),
                                  ),
                                );
                              },

                              child: Container(
                                padding:
                                    const EdgeInsets
                                        .symmetric(
                                  horizontal:
                                      10,

                                  vertical:
                                      4,
                                ),

                                decoration:
                                    BoxDecoration(

                                  color: Colors
                                      .grey
                                      .shade500,

                                  borderRadius:
                                      BorderRadius.circular(
                                          12),
                                ),

                                child:
                                    const Text(
                                  "Edit Profile",

                                  style:
                                      TextStyle(
                                    fontSize:
                                        10,

                                    color:
                                        Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                          height: 12),

                      // 👤 NAME
                      Text(

                        user?.email
                                ?.split(
                                    "@")
                                .first ??

                            "URBNDRIP User",

                        style:
                            const TextStyle(
                          fontWeight:
                              FontWeight
                                  .bold,

                          fontSize: 16,
                        ),
                      ),

                      const SizedBox(
                          height: 4),

                      // 📧 EMAIL
                      Text(

                        user?.email ??
                            "No Email",

                        style:
                            const TextStyle(
                          color:
                              Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // 📦 MENU CARD
              Padding(
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 16,
                ),

                child: Container(
                  decoration: BoxDecoration(
                    color:
                        Colors.grey.shade300,

                    borderRadius:
                        BorderRadius.circular(
                            20),
                  ),

                  child: Column(
                    children: [

                      // 📦 ORDER HISTORY
                      ProfileItem(

                        Icons.inventory_2,

                        "Order History",

                        onTap: () {

                          Navigator.push(
                            context,

                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      const OrderHistoryScreen(),
                            ),
                          );
                        },
                      ),

                      const Divider(
                          height: 1),

                      // ❤️ WISHLIST
                      ProfileItem(

                        Icons.favorite_border,

                        "My Wishlist",

                        onTap: () {

                          Navigator.push(
                            context,

                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      const WishlistScreen(),
                            ),
                          );
                        },
                      ),

                      const Divider(
                          height: 1),

                      // ⚙️ SETTINGS
                      ProfileItem(

                        Icons.settings,

                        "Settings",

                        onTap: () {

                          Navigator.push(
                            context,

                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      const SettingsScreen(),
                            ),
                          );
                        },
                      ),

                      const Divider(
                          height: 1),

                      // ❓ HELP
                      ProfileItem(

                        Icons.help_outline,

                        "Help & Support",

                        onTap: () {

                          Navigator.push(
                            context,

                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      const HelpScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // 🚪 LOGOUT
              Padding(
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 40,
                ),

                child: GestureDetector(

                  onTap: () async {

                    // ☁️ FIREBASE LOGOUT
                    await FirebaseAuth
                        .instance
                        .signOut();

                    // 🚀 MESSAGE
                    ScaffoldMessenger.of(
                            context)
                        .showSnackBar(

                      const SnackBar(
                        content: Text(

                          "Logged out successfully 👋",
                        ),
                      ),
                    );

                    // 🔙 LOGIN
                    Future.delayed(
                      const Duration(
                        milliseconds:
                            800,
                      ),

                      () {

                        Navigator.pushAndRemoveUntil(

                          context,

                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    const LoginScreen(),
                          ),

                          (route) =>
                              false,
                        );
                      },
                    );
                  },

                  child: Container(
                    padding:
                        const EdgeInsets
                            .symmetric(
                      vertical: 14,
                    ),

                    decoration: BoxDecoration(

                      borderRadius:
                          BorderRadius.circular(
                              30),

                      border: Border.all(
                        color: Colors.red,
                      ),
                    ),

                    child: const Center(
                      child: Text(
                        "Logout",

                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

// 🔹 PROFILE ITEM
class ProfileItem
    extends StatelessWidget {

  final IconData icon;
  final String text;
  final VoidCallback? onTap;

  const ProfileItem(
    this.icon,
    this.text, {

    this.onTap,

    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return ListTile(
      onTap: onTap,

      leading: Icon(icon),

      title: Text(text),

      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
      ),
    );
  }
}