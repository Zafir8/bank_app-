import 'package:flutter/material.dart';

class PayScreen extends StatefulWidget {
  const PayScreen({super.key});

  @override
  State<PayScreen> createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
  bool _isCardRotated = false;
  final List<Map<String, dynamic>> _paymentMethods = [
    {'icon': Icons.credit_card, 'name': 'Credit Card', 'color': Colors.blue},
    {'icon': Icons.phone_android, 'name': 'Mobile Pay', 'color': Colors.green},
    {'icon': Icons.qr_code, 'name': 'QR Code', 'color': Colors.purple},
    {'icon': Icons.receipt_long, 'name': 'Bills', 'color': Colors.orange},
    {'icon': Icons.account_balance, 'name': 'Bank', 'color': Colors.red},
    {'icon': Icons.more_horiz, 'name': 'More', 'color': Colors.grey},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pay', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF2E5CB8),
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF2E5CB8), Color(0xFFFFFFFF)],
            stops: [0.0, 0.3],
          ),
        ),
        child: Column(
          children: [
            _buildCardSection(),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Payment Methods',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildPaymentGrid(),
                    const SizedBox(height: 30),
                    const Text(
                      'Recent Payments',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(child: _buildRecentPayments()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showPaymentDialog(context),
        backgroundColor: const Color(0xFF2E5CB8),
        child: const Icon(Icons.payment, color: Colors.white),
      ),
    );
  }

  Widget _buildCardSection() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isCardRotated = !_isCardRotated;  // Toggle rotation state
        });
      },
      child: TweenAnimationBuilder(
        tween: Tween<double>(
          begin: 0,
          end: _isCardRotated ? 180 : 0,  // Rotate 180 degrees when tapped
        ),
        duration: const Duration(milliseconds: 500),
        builder: (context, double value, child) {
          return Transform(
            transform: Matrix4.rotationY(value * 3.14159 / 180),
            alignment: Alignment.center,
            child: Container(
              height: 200,
              margin: const EdgeInsets.all(20),
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1E3C72), Color(0xFF2A5298)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Transform(
                transform: Matrix4.rotationY(value >= 90 ? 3.14159 : 0),
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: value >= 90 
                          ? const Center(
                              child: Text(
                                'CVV: ***',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                ),
                              ),
                            )
                          : const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Available Balance',
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 14,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      '\$12,345.67',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  '**** **** **** 1234',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    letterSpacing: 2,
                                  ),
                                ),
                              ],
                            ),
                    ),
                    if (value < 90)
                      Positioned(
                        right: 20,
                        top: 20,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.credit_card,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPaymentGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
      ),
      itemCount: _paymentMethods.length,
      itemBuilder: (context, index) {
        final method = _paymentMethods[index];
        return GestureDetector(
          onTap: () => _showPaymentDialog(context),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  method['icon'],
                  color: method['color'],
                  size: 32,
                ),
                const SizedBox(height: 8),
                Text(
                  method['name'],
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildRecentPayments() {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.primaries[index % Colors.primaries.length].withOpacity(0.2),
              child: Icon(
                Icons.shopping_bag,
                color: Colors.primaries[index % Colors.primaries.length],
              ),
            ),
            title: Text('Payment ${index + 1}'),
            subtitle: Text('October ${index + 1}, 2023'),
            trailing: Text(
              '-\$${(index + 1) * 10}.00',
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _showPaymentDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Payment Details'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Amount',
                prefixText: '\$',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2E5CB8),
            ),
            child: const Text('Pay'),
          ),
        ],
      ),
    );
  }
}