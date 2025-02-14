
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // Add to pubspec.yaml: fl_chart: ^0.65.0

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  String _selectedPeriod = 'Monthly';
  final List<String> _periods = ['Weekly', 'Monthly', 'Yearly'];

  @override
  Widget build(BuildContext context) {
    return Container(
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
          const SizedBox(height: 20),
          _buildPeriodSelector(),
          const SizedBox(height: 20),
          _buildSummaryCards(),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  _buildExpenseChart(),
                  const SizedBox(height: 20),
                  _buildCategoryBreakdown(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPeriodSelector() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedPeriod,
          isExpanded: true,
          items: _periods.map((String period) {
            return DropdownMenuItem<String>(
              value: period,
              child: Text(period),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _selectedPeriod = newValue!;
            });
          },
        ),
      ),
    );
  }

  Widget _buildSummaryCards() {
    return Row(
      children: [
        _buildSummaryCard(
          'Income',
          '\$8,240.00',
          Icons.arrow_upward,
          Colors.green,
        ),
        _buildSummaryCard(
          'Expenses',
          '\$5,230.00',
          Icons.arrow_downward,
          Colors.red,
        ),
      ],
    );
  }

  Widget _buildSummaryCard(
    String title,
    String amount,
    IconData icon,
    Color color,
  ) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              amount,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Icon(icon, color: color),
          ],
        ),
      ),
    );
  }

  Widget _buildExpenseChart() {
    return SizedBox(
      height: 300,
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: false),
          titlesData: FlTitlesData(
            leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  const style = TextStyle(fontSize: 12, color: Colors.grey);
                  String text = '';
                  switch (value.toInt()) {
                    case 0:
                      text = 'Jan';
                      break;
                    case 2:
                      text = 'Mar';
                      break;
                    case 4:
                      text = 'May';
                      break;
                    case 6:
                      text = 'Jul';
                      break;
                  }
                  return Text(text, style: style);
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: const [
                FlSpot(0, 3),
                FlSpot(1, 1),
                FlSpot(2, 4),
                FlSpot(3, 2),
                FlSpot(4, 5),
                FlSpot(5, 3),
                FlSpot(6, 4),
              ],
              isCurved: true,
              color: const Color(0xFF2E5CB8),
              barWidth: 3,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                color: const Color(0xFF2E5CB8).withOpacity(0.1),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryBreakdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Spending by Category',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        _buildCategoryItem('Shopping', 2100.00, 0.4, Colors.blue),
        _buildCategoryItem('Food & Dining', 1500.00, 0.3, Colors.green),
        _buildCategoryItem('Transport', 800.00, 0.15, Colors.orange),
        _buildCategoryItem('Entertainment', 830.00, 0.15, Colors.purple),
      ],
    );
  }

  Widget _buildCategoryItem(
    String category,
    double amount,
    double percentage,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(category),
              Text(
                '\$${amount.toStringAsFixed(2)}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: percentage,
            backgroundColor: Colors.grey.shade200,
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }
}
