import 'package:flutter/material.dart';

void main() {
  runApp(const ExpenseTrackerApp());
}

class ExpenseTrackerApp extends StatelessWidget {
  const ExpenseTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PocketFinance',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // These are the 3 main tabs
  final List<Widget> _pages = [
    const DashboardTab(),
    const HistoryTab(),
    const BudgetTab(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.pie_chart), label: 'Budget'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[800],
        onTap: _onItemTapped,
      ),
      // The FAB is only visible on the Dashboard (Index 0)
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddTransactionPage(),
            ),
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
      )
          : null,
    );
  }
}

// ==========================================
// 1. DASHBOARD TAB
// ==========================================
class DashboardTab extends StatelessWidget {
  const DashboardTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Balance Card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              color: Colors.blue[800],
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const Text(
                      "Total Balance",
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "\$1,250.00",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildSummaryItem(
                          "Income",
                          "\$1,700",
                          Colors.greenAccent,
                        ),
                        _buildSummaryItem("Expense", "\$450", Colors.redAccent),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Visual Chart Placeholder
            const Center(
              child: Text(
                "Spending Distribution",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: Center(
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.blue, width: 8),
                    color: Colors.white,
                  ),
                  child: const Center(
                    child: Text(
                      "Pie Chart\nGoes Here",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),
            const Text(
              "Recent Activity",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Recent Transactions List
            _buildTransactionTile(
              Icons.shopping_bag,
              "Groceries",
              "Today",
              "-\$50.00",
            ),
            _buildTransactionTile(
              Icons.directions_car,
              "Uber Ride",
              "Yesterday",
              "-\$15.00",
            ),
            _buildTransactionTile(
              Icons.local_cafe,
              "Coffee",
              "Yesterday",
              "-\$5.00",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(String label, String amount, Color color) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: Colors.white70)),
        Text(
          amount,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionTile(
      IconData icon,
      String title,
      String date,
      String amount,
      ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue[50],
          child: Icon(icon, color: Colors.blue),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(date),
        trailing: Text(
          amount,
          style: const TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

// ==========================================
// 2. HISTORY TAB
// ==========================================
class HistoryTab extends StatelessWidget {
  const HistoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("History"),
        backgroundColor: Colors.white,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.filter_list)),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            "Today, Jan 19",
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          _buildHistoryItem("Starbucks Coffee", "Food", "-\$5.00"),
          _buildHistoryItem("Lunch at Cafe", "Food", "-\$15.00"),

          const SizedBox(height: 20),
          const Text(
            "Yesterday, Jan 18",
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          _buildHistoryItem("Uber Ride", "Travel", "-\$12.50"),
          _buildHistoryItem("Groceries", "Shopping", "-\$45.00"),
          _buildHistoryItem("Cinema", "Entertainment", "-\$20.00"),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(String title, String category, String amount) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(category),
        trailing: Text(
          amount,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

// ==========================================
// 3. BUDGET TAB
// ==========================================
class BudgetTab extends StatelessWidget {
  const BudgetTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Budget"),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildBudgetCard("Food Budget", 400, 500, Colors.green),
          _buildBudgetCard("Travel Budget", 150, 500, Colors.green),
          _buildBudgetCard(
            "Shopping Budget",
            220,
            200,
            Colors.red,
          ), // Over budget example
        ],
      ),
    );
  }

  Widget _buildBudgetCard(
      String title,
      double spent,
      double total,
      Color color,
      ) {
    double progress = spent / total;
    if (progress > 1.0) progress = 1.0;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[300],
              color: color,
              minHeight: 10,
              borderRadius: BorderRadius.circular(5),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("\$${spent.toStringAsFixed(0)} spent"),
                Text(
                  "Limit: \$${total.toStringAsFixed(0)}",
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 4. ADD TRANSACTION PAGE (Navigated to)
// ==========================================
class AddTransactionPage extends StatelessWidget {
  const AddTransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Transaction")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Income / Expense Switch
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Income"),
                Switch(
                  value: true,
                  onChanged: (val) {},
                  activeThumbColor: Colors.blue,
                ),
                const Text("Expense"),
              ],
            ),
            const SizedBox(height: 20),

            // Amount Field
            const TextField(
              decoration: InputDecoration(
                labelText: "Amount",
                prefixText: "\$ ",
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 15,
                ),
              ),
              keyboardType: TextInputType.number,
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),

            // Category Selection (Simple mock)
            const Align(
              alignment: Alignment.centerLeft,
              child: Text("Category", style: TextStyle(fontSize: 16)),
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildCategoryChip("Food", Icons.restaurant, true),
                  _buildCategoryChip("Travel", Icons.directions_car, false),
                  _buildCategoryChip("Shopping", Icons.shopping_bag, false),
                  _buildCategoryChip("Bills", Icons.receipt, false),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Date Picker (Mock)
            TextField(
              decoration: const InputDecoration(
                labelText: "Date",
                prefixIcon: Icon(Icons.calendar_today),
                border: OutlineInputBorder(),
              ),
              controller: TextEditingController(text: "Today, Jan 19"),
              readOnly: true,
            ),

            const Spacer(),

            // Save Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Go back to dashboard
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Save Transaction",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String label, IconData icon, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Chip(
        avatar: Icon(
          icon,
          size: 18,
          color: isSelected ? Colors.white : Colors.black54,
        ),
        label: Text(label),
        backgroundColor: isSelected ? Colors.blue : Colors.grey[200],
        labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
      ),
    );
  }
}
