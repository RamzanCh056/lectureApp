import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../admin/models/recomended_lecture_model.dart';
import '../../../../admin/youtube_viewer/youtube.dart';
import '../../../../common/post_card.dart';
import '../../../../res/static_info.dart';


class UnfinishedLecture extends StatefulWidget {
  const UnfinishedLecture({Key? key}) : super(key: key);

  @override
  State<UnfinishedLecture> createState() => _UnfinishedLectureState();
}

class _UnfinishedLectureState extends State<UnfinishedLecture> {
  List<RecommendedLectureModel> recommendedLecture = [];
  YoutubePlayerController? _controller;
 bool  isCheck = false;
  @override
  void initState() {
    getRecommendedLecture();
    super.initState();
  }

  getRecommendedLecture() {
    try {
      recommendedLecture.clear();
      setState(() {});
      FirebaseFirestore.instance
          .collection(StaticInfo.recommendedLecture)
          .snapshots()
          .listen((event) {
        recommendedLecture.clear();
        setState(() {});
        for (int i = 0; i < event.docs.length; i++) {
          RecommendedLectureModel dataModel =
          RecommendedLectureModel.fromJson(event.docs[i].data());
          recommendedLecture.add(dataModel);
        }
        setState(() {

        });
      });
      setState(() {});
    } catch (e) {}
  }
  var dateFor  ;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recent Lectures",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,),
          ),
          SizedBox(height: 10,),
          Expanded(
            child:
            ListView.builder(
                itemCount:
               recommendedLecture.length,
                itemBuilder: (_, index) {

                  var dat = DateFormat('yyyy-MM-dd').format(
                      DateTime.fromMillisecondsSinceEpoch(int.parse(
                        recommendedLecture[index]
                            .uploadTime
                            .toString(),
                      ) )
                  ),

                  dateForCheck = Jiffy(dat , "yyyy-MM-dd" ).fromNow();
                  dateFor = dateForCheck;

                   return
                  dateForCheck.toString().contains("days ago") || dateForCheck.toString().contains("month ago") ? Container():
                    Column(
                    children: [
                      GestureDetector(

                        onTap: () {
                          print("tapped on container== $dateForCheck");
                          print("tapped on container dat== $dat");

                        },
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                recommendedLecture[index].picture.toString()),
                          ),
                          title: Text(
                            recommendedLecture[index].name.toString(),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          subtitle: Text(
                            DateFormat('hh:mm a').format(
                                DateTime.fromMillisecondsSinceEpoch(int.parse(
                                  recommendedLecture[index]
                                      .uploadTime
                                      .toString(),
                                ) )
                            ),
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        //height: 200,
                        child: YoutubeVideo(
                          recommendedLecture[index].video.toString(),
                        ),
                        //  VideoPlay(
                        //   pathh:
                        // )
                      ),
                      SizedBox(
                        height: 10,
                      ),

                    ],
                  ) ;

                })
          )
        ],
      ),
    );
  }
}


