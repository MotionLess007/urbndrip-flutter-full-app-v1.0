import 'package:flutter/material.dart';
import '../data/profile_data.dart';
class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() =>
      _EditProfileScreenState();
}

class _EditProfileScreenState
    extends State<EditProfileScreen> {

  final TextEditingController nameController =
      TextEditingController(
    text: profileName,
  );

  final TextEditingController emailController =
      TextEditingController(
    text: profileEmail,
  );

  final TextEditingController phoneController =
      TextEditingController(
    text: profilePhone,
  );

  final TextEditingController addressController =
      TextEditingController(
    text: profileAddress,
  );

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFFEFEFEF),

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

                    // 🔙 BACK BUTTON
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },

                      child: Container(
                        padding:
                            const EdgeInsets.all(10),

                        decoration: BoxDecoration(
                          shape: BoxShape.circle,

                          border: Border.all(
                            color:
                                Colors.grey.shade300,
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
                        fontFamily: "Inter",
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

              const SizedBox(height: 20),

              // 👤 TITLE
              const Padding(
                padding:
                    EdgeInsets.symmetric(
                  horizontal: 16,
                ),

                child: Align(
                  alignment:
                      Alignment.centerLeft,

                  child: Text(
                    "Edit Profile",

                    style: TextStyle(
                      fontSize: 28,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // 👤 PROFILE IMAGE
              Stack(
                children: [

                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,

                    child: Icon(
                      Icons.person,
                      size: 50,
                    ),
                  ),

                  Positioned(
                    bottom: 0,
                    right: 0,

                    child: Container(
                      padding:
                          const EdgeInsets.all(8),

                      decoration: const BoxDecoration(
                        color: Colors.orange,
                        shape: BoxShape.circle,
                      ),

                      child: const Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // 🧾 FORM
              Padding(
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 16,
                ),

                child: Column(
                  children: [

                    // 👤 NAME
                    profileField(
                      controller:
                          nameController,

                      hint: "Full Name",

                      icon: Icons.person,
                    ),

                    const SizedBox(height: 16),

                    // 📧 EMAIL
                    profileField(
                      controller:
                          emailController,

                      hint:
                          "Email Address",

                      icon: Icons.email,
                    ),

                    const SizedBox(height: 16),

                    // 📱 PHONE
                    profileField(
                      controller:
                          phoneController,

                      hint:
                          "Phone Number",

                      icon: Icons.phone,
                    ),

                    const SizedBox(height: 16),

                    // 📍 ADDRESS
                    profileField(
                      controller:
                          addressController,

                      hint: "Address",

                      icon:
                          Icons.location_on,
                    ),

                    const SizedBox(height: 30),

                  // 💾 SAVE BUTTON
                ElevatedButton(
                  onPressed: () {

                    // 💾 SAVE PROFILE DATA
                    profileName =
                        nameController.text;

                    profileEmail =
                        emailController.text;

                    profilePhone =
                        phoneController.text;

                    profileAddress =
                        addressController.text;

                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Profile Updated Successfully 😮‍🔥",
                        ),
                      ),
                    );

                    Navigator.pop(context);
                  },

                  style:
                      ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.orange,

                    minimumSize:
                        const Size(
                            double.infinity,
                            55),

                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius
                              .circular(
                                  30),
                    ),
                  ),

                  child: const Text(
                    "Save Changes",
                  ),
),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🧾 INPUT FIELD
  Widget profileField({
    required TextEditingController
        controller,

    required String hint,

    required IconData icon,
  }) {

    return TextField(
      controller: controller,

      decoration: InputDecoration(
        prefixIcon: Icon(icon),

        hintText: hint,

        filled: true,
        fillColor: Colors.white,

        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(18),

          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}