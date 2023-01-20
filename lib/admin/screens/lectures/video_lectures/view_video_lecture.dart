// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
// import '../../../../res/static_info.dart';
// import '../../../models/add_lecture_model.dart';
// import '../../recommended_lecture/video_player.dart';
// class ViewVideos extends StatefulWidget {
//    ViewVideos(this.AddLecture, this.currentIndex,{Key? key}) : super(key: key);
//   List<AddLectureTopicModel> AddLecture;
//   int currentIndex;
//
//   @override
//   State<ViewVideos> createState() => _ViewVideosState();
// }
//
// class _ViewVideosState extends State<ViewVideos> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFF292b2e),
//       appBar: AppBar(
//         title: Text(widget.AddLecture[widget.currentIndex].Subject.toString()),
//         centerTitle: true,
//       ),
//       body: Column(children: [
//
//         Expanded(
//           child: ListView.builder(
//               itemCount: widget.AddLecture.length,
//
//               itemBuilder: (_, index) {
//                 return Column(
//                   children: [
//                     ListTile(
//                       contentPadding: EdgeInsets.zero,
//                       leading: CircleAvatar(
//                         backgroundImage: NetworkImage(widget.AddLecture[widget.currentIndex].picture.toString()),
//                       ),
//                       title: Text(
//                         widget.AddLecture[widget.currentIndex].name.toString(),
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,),
//                       ),
//                       subtitle: Text(
//                         DateFormat('hh:mm a')
//                             .format(DateTime
//                             .fromMillisecondsSinceEpoch(
//                             int.parse(
//                               widget.AddLecture[widget.currentIndex].uploadTime.toString(),
//                             ) *
//                                 1000)),
//                         style: TextStyle(
//                           fontWeight: FontWeight.w500,
//                           color: Colors.grey,),
//                       ),
//                       trailing: GestureDetector(
//                           onTap: (){
//                             FirebaseFirestore.instance.collection(StaticInfo.AddVideoLecture).doc(widget.AddLecture[widget.currentIndex].doc.toString()).delete().then(
//                                   (doc) => print("Document deleted"),
//                               onError: (e) => print("Error updating document $e"),);
//                           },
//                           child: Icon(Icons.delete,color: Colors.white,)),
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Container(
//                         height: 180,
//                         child: VideoPlay(
//                           pathh: widget.AddLecture[widget.currentIndex].video.toString(),
//                         )
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                   ],
//                 );
//               }),
//         ),
//
//       ],),
//     );
//   }
// }
