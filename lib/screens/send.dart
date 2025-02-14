import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SendMoneyScreen extends StatefulWidget {
  const SendMoneyScreen({super.key});

  @override
  State<SendMoneyScreen> createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends State<SendMoneyScreen> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  final _currencyFormat = NumberFormat.currency(symbol: '\$');
  
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  
  int? _selectedAccountIndex;
  bool _isProcessing = false;

  final List<Map<String, dynamic>> _recentRecipients = [
    {
      'name': 'John Doe',
      'avatar': 'JD',
      'accountNumber': '**** 1234',
      'bankName': 'Chase Bank',
      'color': const Color(0xFF4A90E2),
      'recent': true,
    },
    {
      'name': 'Sarah Wilson',
      'avatar': 'SW',
      'accountNumber': '**** 5678',
      'bankName': 'Bank of America',
      'color': const Color(0xFF50E3C2),
      'recent': true,
    },
    {
      'name': 'Mike Brown',
      'avatar': 'MB',
      'accountNumber': '**** 9012',
      'bankName': 'Wells Fargo',
      'color': const Color(0xFFFFB74D),
      'recent': false,
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Send Money', 
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        backgroundColor: const Color(0xFF2E5CB8),
        elevation: 0,
        centerTitle: true,
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Column(
          children: [
            _buildHeaderSection(),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: _buildTransferForm(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF2E5CB8), Color(0xFF1E3F7D)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select Recipient',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 110,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _recentRecipients.length,
              itemBuilder: (context, index) => _buildRecipientCard(index),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecipientCard(int index) {
    final recipient = _recentRecipients[index];
    final isSelected = _selectedAccountIndex == index;

    return GestureDetector(
      onTap: () => setState(() => _selectedAccountIndex = index),
      child: Container(
        width: 90,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: recipient['color'],
                  child: Text(
                    recipient['avatar'],
                    style: TextStyle(
                      color: isSelected ? Colors.black87 : Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (recipient['recent'])
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: recipient['color'], width: 2),
                      ),
                      child: Icon(
                        Icons.star,
                        size: 10,
                        color: recipient['color'],
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              recipient['name'].split(' ')[0],
              style: TextStyle(
                color: isSelected ? Colors.black87 : Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              recipient['accountNumber'],
              style: TextStyle(
                color: isSelected ? Colors.black54 : Colors.white70,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransferForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildAmountInput(),
          const SizedBox(height: 24),
          _buildNoteInput(),
          const SizedBox(height: 32),
          if (_selectedAccountIndex != null) _buildTransferDetails(),
          const SizedBox(height: 32),
          _buildSendButton(),
        ],
      ),
    );
  }

  Widget _buildAmountInput() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Amount',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _amountController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2E5CB8),
            ),
            decoration: InputDecoration(
              prefixText: '\$ ',
              prefixStyle: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E5CB8),
              ),
              hintText: '0.00',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey[100],
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter an amount';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNoteInput() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Note',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _noteController,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: 'Add a note (optional)',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey[100],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransferDetails() {
    final recipient = _recentRecipients[_selectedAccountIndex!];
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Transfer Details',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              CircleAvatar(
                backgroundColor: recipient['color'],
                child: Text(
                  recipient['avatar'],
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipient['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '${recipient['bankName']} - ${recipient['accountNumber']}',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSendButton() {
    return SizedBox(
      height: 56,
      child: ElevatedButton(
        onPressed: _selectedAccountIndex == null || _isProcessing
            ? null
            : () {
                if (_formKey.currentState!.validate()) {
                  _showConfirmDialog();
                }
              },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2E5CB8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
        child: _isProcessing
            ? const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : const Text(
                'Send Money',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }

  Future<void> _showConfirmDialog() async {
    final amount = double.parse(_amountController.text);
    final recipient = _recentRecipients[_selectedAccountIndex!];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Transfer'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                backgroundColor: recipient['color'],
                child: Text(
                  recipient['avatar'],
                  style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                ),
              ),
              title: Text(recipient['name']),
              subtitle: Text(recipient['accountNumber']),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Amount:'),
                Text(_currencyFormat.format(amount)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Note:'),
                Text(_noteController.text.isNotEmpty
                    ? _noteController.text
                    : 'No note'),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() => _isProcessing = true);
              _animationController.reverse().then((value) {
                Navigator.pop(context);
                _showSuccessDialog();
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2E5CB8),
            ),

            child: const Text('Confirm', style: TextStyle(color: Colors.white)),
            
          ),
        ],
      ),
    );
  }

  Future<void> _showSuccessDialog() async {
    await Future.delayed(const Duration(seconds: 2));
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Transfer Successful'),
        content: const Text('Your money has been sent successfully.'),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2E5CB8),
            ),
            child: const Text('Close', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}




