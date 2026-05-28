import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

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

            // 📦 TITLE
            const Padding(
              padding:
                  EdgeInsets.symmetric(
                horizontal: 16,
              ),

              child: Align(
                alignment:
                    Alignment.centerLeft,

                child: Text(
                  "My Orders",

                  style: TextStyle(
                    fontSize: 28,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 📦 ORDER LIST
            Expanded(
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 16,
                ),

                children: const [

                  OrderCard(
                    orderId: "#1024",
                    date: "12 May 2026",
                    total: "\$142.00",
                    status: "Delivered",
                    statusColor: Colors.green,
                  ),

                  SizedBox(height: 16),

                  OrderCard(
                    orderId: "#1025",
                    date: "15 May 2026",
                    total: "\$86.00",
                    status: "Shipped",
                    statusColor: Colors.orange,
                  ),

                  SizedBox(height: 16),

                  OrderCard(
                    orderId: "#1026",
                    date: "18 May 2026",
                    total: "\$230.00",
                    status: "Processing",
                    statusColor: Colors.blue,
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

// 📦 ORDER CARD
class OrderCard extends StatelessWidget {
  final String orderId;
  final String date;
  final String total;
  final String status;
  final Color statusColor;

  const OrderCard({
    required this.orderId,
    required this.date,
    required this.total,
    required this.status,
    required this.statusColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
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

          // 🧾 ORDER ID
          Text(
            orderId,

            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          // 📅 DATE
          Text(
            date,

            style: TextStyle(
              color: Colors.grey.shade600,
            ),
          ),

          const SizedBox(height: 12),

          // 💰 TOTAL
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,

            children: [

              Text(
                total,

                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),

              // 🚚 STATUS
              Container(
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),

                decoration: BoxDecoration(
                  color:
                      statusColor.withOpacity(0.12),

                  borderRadius:
                      BorderRadius.circular(20),
                ),

                child: Text(
                  status,

                  style: TextStyle(
                    color: statusColor,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}