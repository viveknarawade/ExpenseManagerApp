import 'package:expense_manager_frontend/view/widget/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TrashScreen extends StatefulWidget {
  const TrashScreen({super.key});

  @override
  State<TrashScreen> createState() => _TrashScreenState();
}

class _TrashScreenState extends State<TrashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trash'),
      ),
      drawer: CustomDrawer.showDrawer(context),
      body: ListView.builder(
        itemCount: 7,
        itemBuilder: (context, index) {
          return trashCard();
        },
      ),
    );
  }

  Widget trashCard() {
    return Column(
      children: [
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/Svg/trashSubtract.svg',
                height: 30,
              ),
              const SizedBox(
                width: 10,
              ),
              const Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('Medicine'),
                        Spacer(),
                        SizedBox(
                          width: 10,
                        ),
                        Text('300'),
                      ],
                    ),
                    Text(
                      'Lorem Ipsum Lorem Ipsum is simply dummy text of the printing and dummy text of the printing and typesetting industry more',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("3 June | 11:50 AM"),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}
