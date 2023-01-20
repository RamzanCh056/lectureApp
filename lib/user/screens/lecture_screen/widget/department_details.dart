import 'package:flutter/material.dart';

import '../../../../common/post_card.dart';


class DepartmentDetails extends StatelessWidget {
  final String ? departmentName;
  const DepartmentDetails({Key? key, this.departmentName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            departmentName!,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,),
          ),
          centerTitle: true,
        ),
        backgroundColor: Color(0xFF292b2e),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
              Expanded(
                child: ListView.builder(
                    itemCount: 30,
                    itemBuilder: (_, index) {
                  return PostCard();
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
