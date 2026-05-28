import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

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

              // 💬 TITLE
              const Padding(
                padding:
                    EdgeInsets.symmetric(
                  horizontal: 16,
                ),

                child: Align(
                  alignment:
                      Alignment.centerLeft,

                  child: Text(
                    "Help & Support",

                    style: TextStyle(
                      fontSize: 28,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ❓ FAQ SECTION
              Padding(
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 16,
                ),

                child: Column(
                  children: const [

                    HelpCard(
                      question:
                          "How long does shipping take?",

                      answer:
                          "Orders are usually delivered within 3-5 business days.",
                    ),

                    SizedBox(height: 16),

                    HelpCard(
                      question:
                          "Can I return products?",

                      answer:
                          "Yes, returns are accepted within 7 days of delivery.",
                    ),

                    SizedBox(height: 16),

                    HelpCard(
                      question:
                          "How can I track my order?",

                      answer:
                          "You can track your orders from the My Orders section.",
                    ),

                    SizedBox(height: 16),

                    HelpCard(
                      question:
                          "Do you offer cash on delivery?",

                      answer:
                          "Yes, cash on delivery is available for selected areas.",
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // 📞 CONTACT SUPPORT
              Padding(
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 16,
                ),

                child: Container(
                  width: double.infinity,

                  padding:
                      const EdgeInsets.all(20),

                  decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius:
                        BorderRadius.circular(
                            20),
                  ),

                  child: Column(
                    children: [

                      const Icon(
                        Icons.support_agent,
                        size: 40,
                        color: Colors.orange,
                      ),

                      const SizedBox(height: 12),

                      const Text(
                        "Need More Help?",

                        style: TextStyle(
                          fontSize: 20,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        "Contact our support team for further assistance.",

                        textAlign:
                            TextAlign.center,

                        style: TextStyle(
                          color:
                              Colors.grey.shade600,
                        ),
                      ),

                      const SizedBox(height: 20),

                      ElevatedButton(
                        onPressed: () {

                          ScaffoldMessenger.of(
                                  context)
                              .showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Support contacted successfully 💬",
                              ),
                            ),
                          );
                        },

                        style:
                            ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.orange,

                          shape:
                              RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius
                                    .circular(
                                        30),
                          ),

                          minimumSize:
                              const Size(
                                  double.infinity,
                                  50),
                        ),

                        child: const Text(
                          "Contact Support",
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

// ❓ FAQ CARD
class HelpCard extends StatelessWidget {
  final String question;
  final String answer;

  const HelpCard({
    required this.question,
    required this.answer,
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(20),

        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withOpacity(0.04),

            blurRadius: 8,

            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Text(
            question,

            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            answer,

            style: TextStyle(
              color: Colors.grey.shade700,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}