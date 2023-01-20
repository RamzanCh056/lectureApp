// import 'dart:io';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:intl/intl.dart';
// import 'package:lecture_app/admin/screens/admin_page.dart';
// import 'package:lecture_app/admin/screens/lectures/video_lectures/view_lecture_topic.dart';
// import 'package:lecture_app/admin/screens/recommended_lecture/view_recomended_lecture.dart';
// import 'package:lecture_app/common/custom_textfield.dart';
//
// import 'package:path/path.dart' as Path;
//
// import '../../../../res/static_info.dart';
// import '../../../models/add_lecture_model.dart';
//
//
//
// class AddVideoLecture extends StatefulWidget {
//   const AddVideoLecture({Key? key}) : super(key: key);
//
//   @override
//   State<AddVideoLecture> createState() => _AddVideoLectureState();
// }
//
// class _AddVideoLectureState extends State<AddVideoLecture> {
//   TextEditingController name = TextEditingController();
//   TextEditingController videoTitle = TextEditingController();
//   TextEditingController time = TextEditingController();
//   TextEditingController topicLecture = TextEditingController();
//   UploadTask? task;
//   String? firebasePictureUrl;
//   String? firebaseVideoUrl;
//   bool isLoadFile = false;
//   bool isLoad = false;
//   bool isLoading = false;
//   File? file;
//   DateTime? fDate;
//   final formKey = GlobalKey<FormState>();
//
//
//
//   uploadLecture() async {
//     isLoading = true;
//     setState(() {});
//     int id = DateTime.now().millisecondsSinceEpoch;
//     AddLectureTopicModel dataModel = AddLectureTopicModel(
//       Subject:topicLecture.text,
//       name: name.text,
//       picture: firebasePictureUrl,
//       video: firebaseVideoUrl,
//       videoTitle: videoTitle.text,
//       uploadTime: fDate!.millisecondsSinceEpoch,
//       doc: id.toString(),
//     );
//     try {
//       await FirebaseFirestore.instance
//           .collection(StaticInfo.AddVideoLecture)
//           .doc('$id')
//           .set(dataModel.toJson());
//       isLoading = false;
//       setState(() {});
//       Fluttertoast.showToast(msg: 'Lecture added successfully');
//       showDialogForSuccess();
//
//
//     } catch (e) {
//       isLoading = false;
//       setState(() {});
//       Fluttertoast.showToast(msg: 'Some error occurred');
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Add Video lecture"),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 15),
//         child: SingleChildScrollView(
//
//           child: Form(
//             key: formKey,
//             child: Column(
//               children: [
//                 SizedBox(height: 20,),
//                 CommonTextFieldWithTitle('Topic', 'Enter Subject Title', topicLecture,
//                         (val) {
//                       if (val!.isEmpty) {
//                         return 'This is required field';
//                       }
//                     }),
//                 SizedBox(height: 15,),
//                 CommonTextFieldWithTitle('Name', 'Enter name', name,
//                         (val) {
//                       if (val!.isEmpty) {
//                         return 'This is required field';
//                       }
//                     }),
//                 SizedBox(height: 15,),
//                 CommonTextFieldWithTitle('Title', 'Enter video Title', videoTitle,
//                         (val) {
//                       if (val!.isEmpty) {
//                         return 'This is required field';
//                       }
//                     }),
//                 SizedBox(height: 15,),
//
//                 GestureDetector(
//                   onTap: () {
//                     FocusScope.of(context).requestFocus(FocusNode());
//                     selectDate(context, 0);
//                   },
//                   child: CommonTextFieldWithTitle('Time', 'Enter date', time,
//                       enabled: false,
//                       suffixIcon:
//                       const InkWell(child: Icon(Icons.arrow_drop_down)),
//                           (val) {
//                         if (val!.isEmpty) {
//                           return 'This is required field';
//                         }
//                       }),
//                 ),
//                 SizedBox(height: 20,),
//                 Container(
//                   height: 150,
//                   width: 450,
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       color: Colors.black,
//                     ),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       isLoadFile
//                           ? Center(child: CircularProgressIndicator())
//                           : Expanded(
//                           child: Center(
//                             child: Padding(
//                               padding: EdgeInsets.only(left: 40, right: 40),
//                               child: Container(
//                                 height: 50,
//                                 // width: 190,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(50),
//                                   color: Colors.blue,
//                                 ),
//                                 child: Center(
//                                     child: Row(
//                                       children: [
//                                         SizedBox(
//                                           width: 10,
//                                         ),
//                                         Icon(
//                                           Icons.picture_as_pdf,
//                                           color: Colors.white,
//                                         ),
//                                         SizedBox(
//                                           width: 10,
//                                         ),
//                                         Expanded(
//                                           child: Text(
//                                             firebasePictureUrl ?? "",
//                                             style: TextStyle(color: Colors.white),
//                                           ),
//                                         ),
//                                       ],
//                                     )),
//                               ),
//                             ),
//                           )),
//                       Padding(
//                         padding: const EdgeInsets.all(15),
//                         child: InkWell(
//                           onTap: () async {
//                             await selectFile();
//                             setState(() {});
//                           },
//                           child: Container(
//                             height: 30,
//                             width: 150,
//                             decoration:
//                             const BoxDecoration(color: Colors.black12),
//                             child: const Center(
//                                 child: Text(
//                                   "Upload picture",
//                                   style: TextStyle(
//                                       fontSize: 18, fontWeight: FontWeight.bold),
//                                 )),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 20,),
//                 Container(
//                   height: 150,
//                   width: 450,
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       color: Colors.black,
//                     ),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//
//                       isLoad? Center(child: CircularProgressIndicator())
//                           : Expanded(
//                           child: Center(
//                             child: Padding(
//                               padding: EdgeInsets.only(left: 40, right: 40),
//                               child: Container(
//                                 height: 50,
//                                 // width: 190,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(50),
//                                   color: Colors.blue,
//                                 ),
//                                 child: Center(
//                                     child: Row(
//                                       children: [
//                                         SizedBox(
//                                           width: 10,
//                                         ),
//                                         Icon(
//                                           Icons.picture_as_pdf,
//                                           color: Colors.white,
//                                         ),
//                                         SizedBox(
//                                           width: 10,
//                                         ),
//                                         Expanded(
//                                           child: Text(
//                                             firebaseVideoUrl ?? "",
//                                             style: TextStyle(color: Colors.white),
//                                           ),
//                                         ),
//                                       ],
//                                     )),
//                               ),
//                             ),
//                           )),
//                       Padding(
//                         padding: const EdgeInsets.all(15),
//                         child: InkWell(
//                           onTap: () async {
//                             await selectForVideo();
//                             setState(() {});
//                           },
//                           child: Container(
//                             height: 30,
//                             width: 150,
//                             decoration:
//                             const BoxDecoration(color: Colors.black12),
//                             child: const Center(
//                                 child: Text(
//                                   "Upload Video",
//                                   style: TextStyle(
//                                       fontSize: 18, fontWeight: FontWeight.bold),
//                                 )),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 20,),
//                 isLoading? CircularProgressIndicator():
//                 GestureDetector(
//                   onTap: (){
//                     if(formKey.currentState!.validate()){
//                       uploadLecture();
//                     }
//
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20),
//                         color: Colors.blue,
//                       ),
//
//                       height: 50,
//                       width: double.infinity,
//                       child: Center(child: Text("Upload Lecture", style: TextStyle(
//                           color: Colors.white
//
//                       ),),),),
//                   ),
//                 ),
//               ],),
//           ),
//         ),
//       ),
//     );
//   }
//   Future selectFile() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['jpg'],
//     );
//     if (result == null) return;
//     final path = result.files.single.path!;
//     setState(() {
//       file = File(path);
//       uploadFile();
//     });
//   }
//   Future selectForVideo() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['mp4'],
//     );
//
//     if (result == null) return;
//     final path = result.files.single.path!;
//     setState(() {
//       file = File(path);
//       uploadFileVideo();
//     });
//   }
//
//   Future uploadFile() async {
//     setState(() {
//       isLoadFile =true;
//     });
//     if (file == null) return;
//     final fileName = Path.basename(file!.path);
//     final destination = 'files/$fileName';
//
//     task = FirebaseApi.uploadFile(destination, file!);
//     setState(() {});
//
//     if (task == null) return;
//
//     final snapshot = await task!.whenComplete(() {});
//     final urlDownload = await snapshot.ref.getDownloadURL();
//
//     print('Download-Link: $urlDownload');
//     firebasePictureUrl = urlDownload;
//     setState(() {
//       isLoadFile = false;
//     });
//
//   }
//   Future uploadFileVideo() async {
//     setState(() {
//       isLoad =true;
//     });
//     if (file == null) return;
//     final fileName = Path.basename(file!.path);
//     final destination = 'videos/$fileName';
//
//     task = FirebaseApi.uploadFile(destination, file!);
//     setState(() {});
//
//     if (task == null) return;
//
//     final snapshot = await task!.whenComplete(() {});
//     final urlDownload = await snapshot.ref.getDownloadURL();
//
//     print('Download-Link: $urlDownload');
//     firebaseVideoUrl = urlDownload;
//     setState(() {
//       isLoad = false;
//     });
//
//   }
//   selectDate(BuildContext context, int index) async {
//     DateTime? selectDate;
//     await DatePicker.showDateTimePicker(context,
//         showTitleActions: true, onChanged: (date) {}, onConfirm: (date) {
//           selectDate = date;
//         }, currentTime: DateTime.now());
//     if (selectDate != null) {
//       setState(() {
//         if (index == 0) {
//           time.text = DateFormat('hh:mm a').format(selectDate!);
//           fDate = selectDate;
//         }
//       });
//     }
//
//   }
//   showDialogForSuccess(){
//     showDialog(
//       context: context,
//       builder: (ctx) {
//         return AlertDialog(
//           content: Container(
//             height: 213,
//             child: Column(
//               children: [
//                 Image.asset("assets/cng1.png"),
//                 const SizedBox(
//                   height: 5,
//                 ),
//                 const     Text("Lecture Added",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
//                 const SizedBox(
//                   height: 13,
//                 ),
//                 Container(
//                   child: const Text(
//                     "Lecture Added please click on view for view Uploads",textAlign: TextAlign.center,style: TextStyle( fontWeight: FontWeight.w500),),
//                 ),
//               ],
//             ),
//           ),
//           actions: [
//             TextButton(
//               child: Text("View",style: TextStyle(color: Colors.red),),
//               onPressed: () {
//                 topicLecture.text= "";
//                 name.text="";
//                 firebaseVideoUrl="";
//                 firebasePictureUrl="";
//                 fDate= null;
//                 time.text="";
//
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=>VideoLectureGridView()));
//               },
//             )
//           ],
//         );
//       },
//     );
//   }
//
//
// }
