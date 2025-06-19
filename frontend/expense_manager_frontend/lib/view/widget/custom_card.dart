import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomCard {
  static Widget showCard() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              SvgPicture.asset(
               'assets/Svg/food.svg',
              ),
              const Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('Medicine'),
                        Spacer(),
                        Text('inco'),
                        SizedBox(
                          width: 10,
                        ),
                        Text('300'),
                      ],
                    ),
                    Text('Lorem Ipsum is simply dummy text of the '),
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
