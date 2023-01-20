import 'package:flutter/material.dart';
import 'package:lecture_app/user/screens/lecture_screen/tabs/pdf.dart';

import 'tabs/department.dart';

class LecturesScreen extends StatefulWidget {
  const LecturesScreen({Key? key}) : super(key: key);

  @override
  State<LecturesScreen> createState() => _LecturesScreenState();
}

class _LecturesScreenState extends State<LecturesScreen> {
  final List<String> department = [
    'Cardiology',
    'Radiology',
    'Urology',
    'Nephrology',
    'Hematology',
    'Geriatrics',
    'Obstetrics',
    'Gynaecology',
    'Neurology',
    'Pediatrics',
    'Neurology',
    'ENT',
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xFF292b2e),
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            elevation: 0,
            title: Text("Lectures",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.white),),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade700,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TabBar(
                      isScrollable: false,
                      labelStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),
                      indicator: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      tabs: [
                        Tab(
                          text: 'Lectures',
                        ),
                        Tab(
                          text: 'Pdf Lectures',
                        ),
                      ],
                    )),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      Department(departmentNames: department,),
                      Pdf()
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
