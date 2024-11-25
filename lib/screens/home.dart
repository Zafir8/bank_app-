import 'package:flutter/material.dart';
import 'package:bank_app/components/navbar.dart';
import 'card.dart';
import 'settings.dart';
import 'statistics.dart';
import 'package:bank_app/screens/send.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeContent(),
    const StatisticsScreen(),
    const CardScreen(),
    const SettingsScreen(),
  ];

  void _onNavigationItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bank', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF2E5CB8),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.person, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: CustomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onNavigationItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF2E5CB8),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF2E5CB8), Color(0xFFFFFFFF)],
          stops: [0.0, 0.3],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome, Zafir!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 12,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF3366CC), Color(0xFF2E5CB8)],
                    ),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Balance',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '\$12,345.67',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildActionButton(
                  icon: Icons.send,
                  label: 'Send',
                  color: const Color(0xFF2E5CB8),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SendMoneyScreen(),
                      ),
                    );
                  },
                ),
                _buildActionButton(
                  icon: Icons.account_balance_wallet,
                  label: 'Deposit',
                  color: const Color(0xFF2E5CB8),
                  onTap: () {},
                ),
                _buildActionButton(
                  icon: Icons.payments,
                  label: 'Pay',
                  color: const Color(0xFF2E5CB8),
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              const Text(
                'Recent Transactions',
                style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                'See All',
                style: TextStyle(color: Color(0xFF2E5CB8)),
                ),
              ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                  children: [
                    Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: index % 2 == 0
                        ? Colors.red.withOpacity(0.1)
                        : Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      index % 2 == 0
                        ? Icons.shopping_bag
                        : Icons.account_balance_wallet,
                      color: index % 2 == 0 ? Colors.red : Colors.green,
                    ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Text(
                        index % 2 == 0 ? 'Payment to Store' : 'Salary Deposit',
                        style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Oct 1, 2023 • 10:30 AM',
                        style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 13,
                        ),
                      ),
                      ],
                    ),
                    ),
                    Text(
                    index % 2 == 0 ? '-\$50.00' : '+\$5,000.00',
                    style: TextStyle(
                      color: index % 2 == 0 ? Colors.red : Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    ),
                  ],
                  ),
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

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: color,
              size: 28,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

// Placeholder for StatisticsScreen





