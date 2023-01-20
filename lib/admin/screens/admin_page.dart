import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:lecture_app/admin/screens/recommended_lecture/add_recommended_lecture.dart';
import 'package:lecture_app/admin/screens/tpics/add_topics.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'drawer/drawer.dart';
import 'lectures/pdf_lectures/Upload_Pdf.dart';
import 'lectures/video_lectures/add_lecture.dart';
import 'qoutes/add_qoutes.dart';

class AdminSide extends StatefulWidget {
  const AdminSide({super.key});

  @override
  State<AdminSide> createState() => _AdminSideState();
}

class _AdminSideState extends State<AdminSide> {
  UploadTask? task;
  File? file;
  @override
  Widget build(BuildContext context) {
    final FileName = file!=null?basename(file!.path):'No File Selected';
    return Scaffold(
      drawer: DrawerScreen(),
      appBar: AppBar(
        title: Text("Admin"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
              child: Column(
            children: [
              SizedBox(
                height: 55,
              ),

              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AddQuotes()));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue,
                    ),

                    height: 50,
                    width: double.infinity,
                    child: Center(child: Text("Add quotes", style: TextStyle(
                      color: Colors.white

                    ),),),),
                ),
              ),
              SizedBox(height: 15,),
              GestureDetector(
                onTap: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>RecommendedLecture()));
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blue,
                  ),

                  height: 50,
                  width: double.infinity,
                  child: Center(child: Text("Add Recommended YouTube", style: TextStyle(
                      color: Colors.white

                  ),),),),
              ),
              SizedBox(height: 15,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AddTopics()));
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blue,
                  ),

                  height: 50,
                  width: double.infinity,
                  child: Center(child: Text("Add Topics", style: TextStyle(
                      color: Colors.white

                  ),),),),
              ),

              SizedBox(height: 15,),
              GestureDetector(
                onTap: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>UploadPdf()));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue,
                    ),

                    height: 50,
                    width: double.infinity,
                    child: Center(child: Text("Add Pdf Lecture", style: TextStyle(
                        color: Colors.white

                    ),),),),
                ),
              ),
              SizedBox(
                height: 55,
              ),

              Padding(
                padding: const EdgeInsets.only(left: 88.0, right: 88),
                child: MaterialButton(
                  color: Colors.blue,
                  height: 45,
                  onPressed: selectFile,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(),
                      Icon(
                        Icons.attach_file,
                        color: Colors.white,
                      ),
                      Spacer(),
                      Text(
                        'Select File',
                        style: TextStyle(color: Colors.white),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
              Center(
                  child: Text(
                FileName.toString(),
                style: TextStyle(color: Colors.black),
              )),
              SizedBox(
                height: 55,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 88.0, right: 88),
                child: MaterialButton(
                  color: Colors.blue,
                  height: 45,
                  onPressed: uploadFile,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(),
                      Icon(
                        Icons.upload_file,
                        color: Colors.white,
                      ),
                      Spacer(),
                      Text(
                        'Upload File',
                        style: TextStyle(color: Colors.white),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              )
            ],
          )),
        ),
      ),
    );
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;
    final path = result.files.single.path!;
    setState(() {
      file = File(path);
    });
  }

  Future uploadFile() async {
    if (file == null) return;
    final fileName = basename(file!.path);
      final destination = 'files/$fileName';

    task = FirebaseApi.uploadFile(destination, file!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    print('Download-Link: $urlDownload');
  }
  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data!;
            final progress = snap.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).toStringAsFixed(2);

            return Text(
              '$percentage %',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            );
          } else {
            return Container();
          }
        },
      );
}

class FirebaseApi {
  static UploadTask? uploadFile(String destination, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putFile(file);
    } on FirebaseException catch (e) {
      return null;
    }
  }

  static UploadTask? uploadBytes(String destination, Uint8List data) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putData(data);
    } on FirebaseException catch (e) {
      return null;
    }
  }
}
