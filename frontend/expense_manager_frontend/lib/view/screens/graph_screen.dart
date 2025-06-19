import 'package:expense_manager_frontend/view/widget/custom_drawer.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class GraphScreen extends StatefulWidget {
  const GraphScreen({super.key});

  @override
  State<GraphScreen> createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Graphs',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      drawer: CustomDrawer.showDrawer(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 200,
                  width: 200,
                  child: Stack(
                    children: [
                      PieChart(
                        PieChartData(
                          sections: [
                            _buildPieChart(
                                false, 10, Color.fromRGBO(214, 3, 3, 0.7)),
                            _buildPieChart(
                                false, 10, Color.fromRGBO(0, 148, 255, 0.7)),
                            _buildPieChart(
                                false, 10, Color.fromRGBO(0, 174, 91, 0.7)),
                            _buildPieChart(
                                false, 10, Color.fromRGBO(100, 62, 255, 0.7)),
                            _buildPieChart(
                                false, 10, Color.fromRGBO(241, 38, 196, 0.7)),
                          ],
                        ),
                      ),
                      Positioned(
                        left: 85,
                        bottom: 80,
                        child: Column(
                          children: [
                            Text("Total"),
                            Text("4434"),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _buildCircularContainer(Color.fromRGBO(214, 3, 3, 0.7)),
                        SizedBox(width: 10),
                        Text("Food")
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        _buildCircularContainer(
                            Color.fromRGBO(0, 148, 255, 0.7)),
                        SizedBox(width: 10),
                        Text("Fuel")
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        _buildCircularContainer(
                            Color.fromRGBO(0, 174, 91, 0.7)),
                        SizedBox(width: 10),
                        Text("Medicine")
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        _buildCircularContainer(
                          Color.fromRGBO(100, 62, 255, 0.7),
                        ),
                        SizedBox(width: 10),
                        Text("Entertainment")
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        _buildCircularContainer(
                            Color.fromRGBO(241, 38, 196, 0.7)),
                        SizedBox(width: 10),
                        Text("Shopping")
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 40,
            ),
            _buildListTile('Food', Icons.fastfood, Colors.orange, 650.00),
            _buildListTile(
                'Fuel', Icons.local_gas_station, Colors.blue, 600.00),
            _buildListTile(
                'Medicine', Icons.medical_services, Colors.green, 500.00),
            _buildListTile('Entertainment', Icons.movie,
                Color.fromRGBO(100, 62, 255, 0.7), 475.00),
            _buildListTile(
                'Shopping', Icons.shopping_cart, Colors.purple, 325.00),
            SizedBox(
              height: 10,
            ),
            const Divider(
              thickness: 2,
            ),
            SizedBox(
              height: 25,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Total",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "₹ 2,550.00",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }

  /// Pie chart
  _buildPieChart(bool title, double value, Color color) {
    return PieChartSectionData(
      showTitle: title,
      value: value,
      color: color,
    );
  }

  /// Circular Container
  _buildCircularContainer(Color color) {
    return Container(
      height: 20,
      width: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }

  Widget _buildListTile(
      String title, IconData icon, Color color, double amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
          Text(
            "₹${amount.toStringAsFixed(2)}",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.black87),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }
}
