import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lecture_app/user/screens/lecture_screen/tabs/view_department_video.dart';

import '../../../../admin/models/add_lecture_model.dart';
import '../../../../admin/models/add_topics_model.dart';
import '../../../../res/static_info.dart';

class Department extends StatefulWidget {
  final List ? departmentNames;
  const Department({Key? key, this.departmentNames}) : super(key: key);

  @override
  State<Department> createState() => _DepartmentState();
}

class _DepartmentState extends State<Department> {
  List<AddTopic> topics = [];

  @override
  void initState() {
    getQuotes();
    super.initState();
  }

  getQuotes() {
    try {
      topics.clear();
      setState(() {});
      FirebaseFirestore.instance.collection("topics").snapshots().listen((event) {
        topics.clear();
        setState(() {});
        for (int i = 0; i < event.docs.length; i++) {
          AddTopic dataModel = AddTopic.fromJson(event.docs[i].data());
          topics.add(dataModel);
        }
        setState(() {});
      });
      setState(() {});
    } catch (e) {}
  }
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          GridView.builder(
            shrinkWrap: true,
            itemCount: topics.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,crossAxisSpacing: 10,mainAxisSpacing: 10),
            itemBuilder: (context, index){
              return  InkWell(
                  onTap: (){
                    FocusScope.of(context).requestFocus(FocusNode());
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  ViewVideoDepatment(topics, index)),
                    );

                  },
                  child: Container(
                      height: 100,
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(topics[index].topics.toString(), style: TextStyle(fontSize: 16,color: Colors.white),)
                          ],
                        ),
                      )));
            },

          ),
        ],),
    );
  }
}
