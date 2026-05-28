import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() =>
      _SettingsScreenState();
}

class _SettingsScreenState
    extends State<SettingsScreen> {

  bool darkMode = false;
  bool notifications = true;

  String selectedLanguage = "English";

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

            // ⚙️ TITLE
            const Padding(
              padding:
                  EdgeInsets.symmetric(
                horizontal: 16,
              ),

              child: Align(
                alignment:
                    Alignment.centerLeft,

                child: Text(
                  "Settings",

                  style: TextStyle(
                    fontSize: 28,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ⚙️ SETTINGS CARD
            Padding(
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 16,
              ),

              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,

                  borderRadius:
                      BorderRadius.circular(
                          20),
                ),

                child: Column(
                  children: [

                    // 🌙 DARK MODE
                    SwitchListTile(
                      value: darkMode,

                      onChanged: (value) {
                        setState(() {
                          darkMode = value;
                        });
                      },

                      secondary:
                          const Icon(Icons.dark_mode),

                      title:
                          const Text("Dark Mode"),
                    ),

                    const Divider(height: 1),

                    // 🔔 NOTIFICATIONS
                    SwitchListTile(
                      value: notifications,

                      onChanged: (value) {
                        setState(() {
                          notifications =
                              value;
                        });
                      },

                      secondary:
                          const Icon(Icons.notifications),

                      title: const Text(
                        "Notifications",
                      ),
                    ),

                    const Divider(height: 1),

                    // 🌍 LANGUAGE
                    ListTile(
                      leading:
                          const Icon(Icons.language),

                      title:
                          const Text("Language"),

                      trailing:
                          DropdownButton<String>(
                        value: selectedLanguage,

                        underline:
                            const SizedBox(),

                        items: const [

                          DropdownMenuItem(
                            value: "English",
                            child:
                                Text("English"),
                          ),

                          DropdownMenuItem(
                            value: "Sinhala",
                            child:
                                Text("Sinhala"),
                          ),

                          DropdownMenuItem(
                            value: "Tamil",
                            child:
                                Text("Tamil"),
                          ),
                        ],

                        onChanged: (value) {
                          setState(() {
                            selectedLanguage =
                                value!;
                          });
                        },
                      ),
                    ),

                    const Divider(height: 1),

                    // 📱 VERSION
                    const ListTile(
                      leading:
                          Icon(Icons.info_outline),

                      title:
                          Text("App Version"),

                      trailing:
                          Text("v1.0.0"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}