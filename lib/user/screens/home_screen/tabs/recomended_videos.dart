import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../../../admin/models/recomended_lecture_model.dart';
import '../../../../admin/screens/recommended_lecture/video_player.dart';
import '../../../../admin/youtube_viewer/youtube.dart';
import '../../../../res/static_info.dart';
import '../../../../video_player/video_players.dart';

class RecommendedVideos extends StatefulWidget {
  const RecommendedVideos({Key? key}) : super(key: key);

  @override
  State<RecommendedVideos> createState() => _RecommendedVideosState();
}

class _RecommendedVideosState extends State<RecommendedVideos> {
  List<RecommendedLectureModel> recommendedLecture = [];
 YoutubePlayerController? _controller;
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
           
            child: Text(
              "Recommended Lectures",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: recommendedLecture.length,
                itemBuilder: (_, index) {
                  return Column(
                    children: [
                      ListTile(
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
                                  ) )),
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
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
                  );
                }),
          ),
        ],
      ),
    );
  }
}
