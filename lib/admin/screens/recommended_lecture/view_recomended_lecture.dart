import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lecture_app/admin/screens/recommended_lecture/video_player.dart';

import '../../../common/post_card.dart';
import '../../../res/static_info.dart';
import '../../models/recomended_lecture_model.dart';
import '../../youtube_viewer/youtube.dart';
class ViewRecommendedLecture extends StatefulWidget {
  const ViewRecommendedLecture({Key? key}) : super(key: key);

  @override
  State<ViewRecommendedLecture> createState() => _ViewRecommendedLectureState();
}

class _ViewRecommendedLectureState extends State<ViewRecommendedLecture> {


  List<RecommendedLectureModel> recommendedLecture = [];

  @override
  void initState() {
    getRecommendedLecture();
    super.initState();
  }

  getRecommendedLecture() {
    try {
      recommendedLecture.clear();
      setState(() {});
      FirebaseFirestore.instance.collection(StaticInfo.recommendedLecture).snapshots().listen((event) {
        recommendedLecture.clear();
        setState(() {});
        for (int i = 0; i < event.docs.length; i++) {
          RecommendedLectureModel dataModel = RecommendedLectureModel.fromJson(event.docs[i].data());
          recommendedLecture.add(dataModel);
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
        title: Text("View Recommended lecture"),
        centerTitle: true,
      ),
      body: Column(children: [
        Expanded(
          child: ListView.builder(
            itemCount: recommendedLecture.length,

              itemBuilder: (_, index) {
              return Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(recommendedLecture[index].picture.toString()),
                  ),
                  title: Text(
                    recommendedLecture[index].name.toString(),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,),
                  ),
                  subtitle: Text(
                    DateFormat('hh:mm a')
                        .format(DateTime
                        .fromMillisecondsSinceEpoch(
                        int.parse(
                          recommendedLecture[index].uploadTime.toString(),
                        ) *
                            1000)),
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,),
                  ),
                  trailing: GestureDetector(
                    onTap: (){
                      FirebaseFirestore.instance.collection(StaticInfo.recommendedLecture).doc(recommendedLecture[index].doc.toString()).delete().then(
                            (doc) => print("Document deleted"),
                        onError: (e) => print("Error updating document $e"),);
                    },
                      child: Icon(Icons.delete,color: Colors.white,)),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 200,
                  //width: double.infinity,
                  // decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(10),
                  //     image: DecorationImage(
                  //       fit: BoxFit.cover,
                  //       image: AssetImage("assets/7.jpg"),
                  //     )),
                  child: YoutubeVideo(
                    recommendedLecture[index].video.toString(),
                  ),
                  // VideoPlay(
                  //   pathh: recommendedLecture[index].video.toString(),
                  // )
                  // Padding(
                  //   padding: const EdgeInsets.all(20.0),
                  //   child: Center(
                  //     child: Column(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         Text(
                  //           "Look up at the stars and not down at your feet. Try to make sense of what you see,",
                  //           style: TextStyle(
                  //               fontWeight: FontWeight.w500, color: Colors.white),
                  //         ),
                  //         Spacer(),
                  //         Container(
                  //           height: 50,
                  //           width: 50,
                  //           decoration: BoxDecoration(
                  //             color: Color(0xFF5a5c64),
                  //             shape: BoxShape.circle,
                  //           ),
                  //           child: Icon(
                  //             Icons.play_arrow,
                  //             color: Colors.white,
                  //           ),
                  //         ),
                  //         Spacer(),
                  //         Align(
                  //           alignment: Alignment.centerRight,
                  //           child: Container(
                  //             padding: EdgeInsets.all(5),
                  //             width: 100,
                  //             decoration: BoxDecoration(
                  //               color: Color.fromRGBO(80, 80, 81, 0.4),
                  //               borderRadius: BorderRadius.circular(20),
                  //             ),
                  //             child: Row(
                  //               children: [
                  //                 Icon(
                  //                   Icons.access_time_outlined,
                  //                   color: Colors.white,
                  //                 ),
                  //                 SizedBox(
                  //                   width: 10,
                  //                 ),
                  //                 Text(
                  //                   "duration",
                  //                   style: TextStyle(
                  //                       fontWeight: FontWeight.w500,
                  //                       color: Colors.white),
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            );
          }),
        ),
      ],),
    );

  }
}

