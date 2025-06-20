import 'dart:developer';

import 'package:expense_manager_frontend/view/widget/category_bottomsheet.dart';
import 'package:expense_manager_frontend/view/widget/custom_dialog_box.dart';
import 'package:expense_manager_frontend/view/widget/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Categories',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      drawer: CustomDrawer.showDrawer(context),
      body: Padding(
        padding: const EdgeInsets.all(19.0),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: [
            _buildCategoryCard('Food', Icons.fastfood, Colors.orange),
            _buildCategoryCard('Fuel', Icons.local_gas_station, Colors.blue),
            _buildCategoryCard(
                'Medicine', Icons.medical_services, Colors.green),
            _buildCategoryCard('Shopping', Icons.shopping_cart, Colors.purple),
          ],
        ),
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: FloatingActionButton.extended(
          onPressed: () {
            setState(() {
              CategoryBottomSheet.showCategoryBottomSheet(context);
            });
          },
          icon: SvgPicture.asset(
            'assets/Svg/addIcon.svg',
          ),
          label: Text(
            "Add Categories",
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
          elevation: 4,
        ),
      ),
    );
  }

  // Category Card
  Widget _buildCategoryCard(String title, IconData icon, Color color) {
    return GestureDetector(
      onTap: () {},
      onDoubleTap: () {
        log("double tap");

        CustomDialogBox.showCustomDialogBox(
          context,
        );
      },
      child: Card(
        elevation: 8,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 60,
                color: color,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
