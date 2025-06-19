
import 'package:expense_manager_frontend/view/widget/custom_card.dart';
import 'package:expense_manager_frontend/view/widget/custom_drawer.dart';
import 'package:expense_manager_frontend/view/widget/transcation_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("November"),
      ),
      drawer: CustomDrawer.showDrawer(context),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return CustomCard.showCard();
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: FloatingActionButton.extended(
          onPressed: () =>
              Transcationbottomsheet.showTranscationbottomsheet(context),
          icon: SvgPicture.asset(
            'assets/Svg/addIcon.svg',
          ),
          label: Text(
            "Add Transaction",
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
}
