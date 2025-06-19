import 'package:expense_manager_frontend/view/screens/graph_screen.dart';
import 'package:expense_manager_frontend/view/screens/home_screen.dart';
import 'package:expense_manager_frontend/view/screens/category_screen.dart';
import 'package:expense_manager_frontend/view/screens/trash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomDrawer {
  static Widget showDrawer(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 18.0),
                child: Text(
                  "Expense Manager",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Text(
                  "Saves all your Transactions",
                  style: TextStyle(fontSize: 17, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: 250,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(14, 161, 125, 0.15),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                ),
                child: ListTile(
                  leading: SvgPicture.asset(
                    'assets/Svg/transaction.svg',
                    height: 25,
                    width: 25,
                  ),
                  title: const Text(
                    "Transaction",
                    style: TextStyle(
                      color: Color.fromRGBO(14, 161, 125, 1),
                      fontSize: 21,
                    ),
                  ),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const HomeScreen();
                        },
                      ),
                    );
                  },
                ),
              ),
              ListTile(
                leading: SvgPicture.asset(
                  'assets/Svg/iconPieChart.svg',
                  height: 25,
                  width: 25,
                ),
                title: const Text("Graphs"),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const GraphScreen();
                      },
                    ),
                  );
                },
              ),
              ListTile(
                leading: SvgPicture.asset(
                  'assets/Svg/category.svg',
                  width: 30,
                ),
                title: const Text("Category"),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const CategoryScreen();
                      },
                    ),
                  );
                },
              ),
              ListTile(
                leading: SvgPicture.asset(
                  'assets/Svg/trash.svg',
                  height: 25,
                  width: 25,
                ),
                title: const Text("Trash"),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const TrashScreen();
                      },
                    ),
                  );
                },
              ),
              ListTile(
                leading: SvgPicture.asset(
                  'assets/Svg/aboutUs.svg',
                  height: 25,
                  width: 25,
                ),
                title: const Text("About us"),
                onTap: () {},
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
