import 'package:flutter/material.dart';

class TagList extends StatelessWidget {
  final tag_list = [
    'Woman',
    'T-shirt',
    'Dress',
  ];
  @override
  Widget build(BuildContext context) {
    return Row(
      children: tag_list
          .map((e) => Container(
                margin: EdgeInsets.all(14),
                decoration: BoxDecoration(
                    // color: Colors.black,
                    // borderRadius: BorderRadius.circular(10),
                    ),
                padding: EdgeInsets.all(10),
                child: Text(
                  e,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ))
          .toList(),
    );
  }
}
