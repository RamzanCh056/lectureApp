import 'package:flutter/material.dart';
import 'package:lecture_app/common/post_card.dart';

class WatchedLecture extends StatelessWidget {
  const WatchedLecture({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Watched Lectures",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,),
          ),
          SizedBox(height: 10,),
          Expanded(
            child: ListView.builder(itemBuilder: (_, index) {
              return PostCard();
            }),
          ),
        ],
      ),
    );
  }
}

