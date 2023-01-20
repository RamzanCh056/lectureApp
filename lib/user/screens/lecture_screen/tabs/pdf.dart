import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../admin/models/add_pdf_model.dart';
import '../../../../admin/screens/lectures/pdf_lectures/pfd_view.dart';
import '../../../../res/static_info.dart';


class Pdf extends StatefulWidget {
  const Pdf({Key? key}) : super(key: key);

  @override
  State<Pdf> createState() => _PdfState();
}

class _PdfState extends State<Pdf> {
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                            height: 12,
                          ),
                          Center(
                            child: Text(
                              data[index].topic.toString(),
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w700,color: Colors.white),
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
    );
  }
}
