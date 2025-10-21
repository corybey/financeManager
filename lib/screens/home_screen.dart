// BASIC REPORTS AND CATEGORY BREAKDOWN

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../data/sample_data.dart';
import '../widgets/balance.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Personal Finance Manager')),

      // Drawer menu (Options tab)
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.green),
              child: Text(
                'Options',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),

            // Each ListTile navigates to a different screen
            ListTile(
              leading: const Icon(Icons.add_circle),
              title: const Text('Log Income'),
              onTap: () => Navigator.pushNamed(context, '/log_income'),
            ),
            ListTile(
              leading: const Icon(Icons.remove_circle),
              title: const Text('Log Transactions'),
              onTap: () => Navigator.pushNamed(context, '/log_transactions'),
            ),
            ListTile(
              leading: const Icon(Icons.savings),
              title: const Text('Log Savings'),
              onTap: () => Navigator.pushNamed(context, '/log_savings'),
            ),

            //Dyanamic savings update

            // ListTile(
            //   leading: const Icon(Icons.savings),
            //   title: const Text('Log Savings'),
            //   onTap: () async {
            //     final newSavings = await Navigator.pushNamed(context, '/log_savings');
            //     if (newSavings != null && newSavings is double) {
            //       setState(() {
            //         currentSavings += newSavings; //  Update progress bar dynamically
            //       });
            //     }
            //     Navigator.pop(context); //  Closes the drawer after returning
            //   },
            // ),
            ListTile(
              leading: const Icon(Icons.list),
              title: const Text('All Transactions'),
              onTap: () => Navigator.pushNamed(context, '/all_transactions'),
            ),
          ],
        ),
      ),

      //Main
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display total balance card
            BalanceWidget(),
            SizedBox(height: 20),
            Row(
              children: [
                SizedBox(
                  height: 200,
                  width: 200,
                  child: PieChart(
                    PieChartData(
                      sections: [
                        PieChartSectionData(
                          value: 400,
                          title: '',
                          color: Colors.blue,
                        ),
                        PieChartSectionData(
                          value: 600,
                          title: '',
                          color: Colors.green,
                        ),
                        PieChartSectionData(
                          value: 500,
                          title: '',
                          color: Colors.red,
                        ),
                      ],
                      centerSpaceRadius: 0,
                      sectionsSpace: 0,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    _LegendItem(color: Colors.blue, text: 'Savings'),
                    _LegendItem(color: Colors.green, text: 'Income'),
                    _LegendItem(color: Colors.red, text: 'Expenses'),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 30),

            // Savings Goal Progress Bar (matches reference UI bottom bar)
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Savings Goal'),
            ),
            const SizedBox(height: 5),
            LinearProgressIndicator(
              value: 0.6, // 60% complete (adjust later dynamically)
              backgroundColor: Colors.grey[300],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
              minHeight: 8,
            ),
          ],
        ),
      ),
    );
  }
}

// Legend Widget (for Pie Chart labels)
class _LegendItem extends StatelessWidget {
  final Color color;
  final String text;

  const _LegendItem({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Container(width: 14, height: 14, color: color),
          const SizedBox(width: 8),
          Text(text),
        ],
      ),
    );
  }
}



//Code for adding bell for goal reached notification

// appBar: AppBar(
//   title: const Text('Dashboard'),
//   centerTitle: true,
//   actions: [
//     IconButton(
//       icon: Icon(
//         // Bell glows when goal is reached
//         (currentSavings >= savingsGoal)
//             ? Icons.notifications_active
//             : Icons.notifications_none,
//         color: (currentSavings >= savingsGoal)
//             ? Colors.amber
//             : Colors.grey[600],
//       ),
//       onPressed: () {
//         if (currentSavings >= savingsGoal) {
//           // Show success dialog
//           showDialog(
//             context: context,
//             builder: (context) => AlertDialog(
//               title: const Text('Goal Reached!'),
//               content: Text(
//                 'Congratulations! You’ve reached your savings goal of \$${savingsGoal.toStringAsFixed(2)}!',
//               ),
//               actions: [
//                 TextButton(
//                   onPressed: () => Navigator.pop(context),
//                   child: const Text('Awesome!'),
//                 ),
//               ],
//             ),
//           );
//         } else {
//           // Inform how close they are
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text(
//                 'You’re ${(currentSavings / savingsGoal * 100).toStringAsFixed(1)}% of the way to your goal!',
//               ),
//             ),
//           );
//         }
//       },
//     ),
//   ],
// ),


//Autocheck for goal reached
// if (newSavings != null && newSavings is double) {
//   setState(() {
//     currentSavings += newSavings;
//   });

//   // Auto-notify if goal is reached
//   if (currentSavings >= savingsGoal) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Goal Reached! '),
//         content: Text(
//           'You’ve officially reached your savings goal of \$${savingsGoal.toStringAsFixed(2)}!',
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Celebrate!'),
//           ),
//         ],
//       ),
//     );
//   } else {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(
//           'Added \$${newSavings.toStringAsFixed(2)} to savings.',
//         ),
//       ),
//     );
//   }

//   Navigator.pop(context); // Close drawer
// }
