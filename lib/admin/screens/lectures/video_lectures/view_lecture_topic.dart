// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:lecture_app/admin/screens/lectures/video_lectures/view_video_lecture.dart';
//
// import '../../../../res/static_info.dart';
// import '../../../models/add_lecture_model.dart';
//
// class VideoLectureGridView extends StatefulWidget {
//   const VideoLectureGridView({Key? key}) : super(key: key);
//
//   @override
//   State<VideoLectureGridView> createState() => _VideoLectureGridViewState();
// }
//
// class _VideoLectureGridViewState extends State<VideoLectureGridView> {
//   List<AddLectureTopicModel> AddLecture = [];
//
//   @override
//   void initState() {
//     getVideoLecture();
//     super.initState();
//   }
//
//   getVideoLecture() {
//     try {
//       AddLecture.clear();
//       setState(() {});
//       FirebaseFirestore.instance.collection(StaticInfo.AddVideoLecture).snapshots().listen((event) {
//         AddLecture.clear();
//         setState(() {});
//         for (int i = 0; i < event.docs.length; i++) {
//           AddLectureTopicModel dataModel = AddLectureTopicModel.fromJson(event.docs[i].data());
//           AddLecture.add(dataModel);
//         }
//         setState(() {});
//       });
//       setState(() {});
//     } catch (e) {}
//   }
//   @override
//   Widget build(BuildContext context) {
//
//
//     return Scaffold(
//       backgroundColor: Color(0xFF292b2e),
//       appBar: AppBar(
//         title: Text("lectures With Topics/Subject"),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 15),
//         child: Column(
//      //   crossAxisAlignment: CrossAxisAlignment.center,
//
//           children: [
//             SizedBox(height: 20,),
//         GridView.builder(
//           shrinkWrap: true,
//           itemCount: AddLecture.length,
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 3,crossAxisSpacing: 10,mainAxisSpacing: 10),
//           itemBuilder: (context, index){
//             return  InkWell(
//               onTap: (){
//                 FocusScope.of(context).requestFocus(FocusNode());
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) =>  ViewVideos(AddLecture, index)),
//                 );
//
//               },
//               child: Container(
//                 height: 100,
//                 width: double.infinity,
//                 padding: EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   color: Colors.black,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(AddLecture[index].Subject.toString(), style: TextStyle(fontSize: 18,color: Colors.white),)
//                 ],
//               ),
//             )));
//           },
//
//     ),
//         ],),
//       ),
//     );
//   }
// }
