
import 'package:flutter/material.dart';

import 'youtube.dart';


class HomePage extends StatelessWidget {
   HomePage({Key? key}) : super(key: key);
List <String> Urls = [
  "https://youtube.com/watch?v=26iXuJSBG-w&feature=shares",
  "https://www.youtube.com/watch?v=Ci4t-NkOY3I&list=PLjxrf2q8roU23XGwz3Km7sQZFTdB996iG",
];
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title:const Text("Youtube player Demo")),
        body:SingleChildScrollView(
          child: Column(children: [


            ListView.builder(
                //physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: Urls.length,
                itemBuilder: (context ,index){
                  return  YoutubeVideo(
                      Urls[index].toString(),
                  );
                })
          ],),
        ));
  }
}