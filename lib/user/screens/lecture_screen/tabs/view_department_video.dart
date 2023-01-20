
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../admin/models/add_lecture_model.dart';
import '../../../../admin/models/add_topics_model.dart';
import '../../../../admin/screens/recommended_lecture/video_player.dart';

class ViewVideoDepatment extends StatefulWidget {
  ViewVideoDepatment(this.topics, this.currentIndex,{Key? key}) : super(key: key);
  List<AddTopic> topics ;
  int currentIndex;

  @override
  State<ViewVideoDepatment> createState() => _ViewVideoDepatmentState();
}

class _ViewVideoDepatmentState extends State<ViewVideoDepatment> {
  List<AddLectureTopicModel> video = [];

  @override
  void initState() {
    getVideo();
    super.initState();
  }

  getVideo() {
    try {
      video.clear();
      setState(() {});
      FirebaseFirestore.instance.collection(widget.topics[widget.currentIndex].topics.toString()).snapshots().listen((event) {
        video.clear();
        setState(() {});
        for (int i = 0; i < event.docs.length; i++) {
          AddLectureTopicModel dataModel = AddLectureTopicModel.fromJson(event.docs[i].data());
          video.add(dataModel);
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
        title: Text(widget.topics[widget.currentIndex].topics.toString()),
        centerTitle: true,
      ),
      body: Column(children: [

        Expanded(
          child: ListView.builder(
              itemCount: video.length,

              itemBuilder: (_, index) {
                return Column(
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(video[index].picture.toString()),
                      ),
                      title: Text(
                        video[index].name.toString(),
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
                                video[index].uploadTime.toString()
                            ) *
                                1000)),
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,),
                      ),

                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        height: 180,
                        child: VideoPlay(
                          pathh: video[index].video.toString(),
                        )
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
