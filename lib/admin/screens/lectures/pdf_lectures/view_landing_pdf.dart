import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lecture_app/admin/screens/lectures/pdf_lectures/pfd_view.dart';

import '../../../../res/static_info.dart';
import '../../../models/add_pdf_model.dart';
class ViewPdfLecture extends StatefulWidget {
  const ViewPdfLecture({Key? key}) : super(key: key);

  @override
  State<ViewPdfLecture> createState() => _ViewPdfLectureState();
}

class _ViewPdfLectureState extends State<ViewPdfLecture> {

  List<AddPdfModel> data = [];

  @override
  void initState() {
    getPdfLecture();
    super.initState();
  }

  getPdfLecture() {
    try {
      data.clear();
      setState(() {});
      FirebaseFirestore.instance.collection(StaticInfo.PdfLecture).snapshots().listen((event) {
        data.clear();
        setState(() {});
        for (int i = 0; i < event.docs.length; i++) {
          AddPdfModel dataModel = AddPdfModel.fromJson(event.docs[i].data());
          data.add(dataModel);
        }
        setState(() {});
      });
      setState(() {});
    } catch (e) {}
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF292b2e),
      appBar: AppBar(
        title: Text("View Pdf"),
        centerTitle: true,
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: GridView.builder(
                  itemCount: data.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.65,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      crossAxisCount: 3),
                  itemBuilder: (_, index) {
                    return GestureDetector(
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>DocumentView(
                            data , index
                        )));
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xFF4c4d4e),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            ClipRRect(
                              child: Image.asset('assets/Image.png'),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: Text(
                                data[index].topic.toString(),
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w700,color: Colors.white),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),

                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
