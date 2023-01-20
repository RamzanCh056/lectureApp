import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lecture_app/user/screens/home_screen/tabs/recomended_videos.dart';
import 'package:lecture_app/user/screens/home_screen/tabs/unfinished_lecture.dart';
import 'package:lecture_app/user/screens/home_screen/tabs/wached_lecture.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../admin/models/quotes_model.dart';
import '../../../res/static_info.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _controller = PageController();
  DateTime currentDate = DateTime.now();
  List<QuotesModel> quotes = [];

  @override
  void initState() {
    getQuotes();
    super.initState();
  }

  getQuotes() {
    try {
      quotes.clear();
      setState(() {});
      FirebaseFirestore.instance.collection(StaticInfo.dailyQuotes).snapshots().listen((event) {
        quotes.clear();
        setState(() {});
        for (int i = 0; i < event.docs.length; i++) {
          QuotesModel dataModel = QuotesModel.fromJson(event.docs[i].data());
          quotes.add(dataModel);
        }
        setState(() {});
      });
      setState(() {});
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xFF292b2e),
          body: Column(
            children: [
              SizedBox(
                height: 200,
                child: Stack(
                  children: [
                    PageView(
                      controller: _controller,
                      children: List.generate(quotes.length, (index) =>
                          Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xFF949c9d)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              SizedBox(height: 20,),
                              Text(
                                quotes[index].quotes.toString(),
                                textAlign: TextAlign.center,style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500,color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SmoothPageIndicator(
                          controller: _controller,
                          count: quotes.length, 
                          effect: WormEffect(
                              dotColor: Colors.black,
                              activeDotColor: Colors.white,
                              dotHeight: 10,
                              dotWidth: 10),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10,),
              TabBar(

                labelPadding: EdgeInsets.symmetric(horizontal: 2),
                padding: EdgeInsets.symmetric(horizontal: 5),
                labelStyle: TextStyle(fontSize: 12,fontWeight: FontWeight.w500),
                indicator: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(5)
                ),
                tabs: [
                  Tab(text: 'Recent Lectures',),
                 // Tab(text: 'Watched Lectures',),
                  Tab(text: "Recommended Videos",),
                ],),
              SizedBox(height: 20,),
              Expanded(child: TabBarView(children: [
                UnfinishedLecture(),
              //  WatchedLecture(),
                RecommendedVideos(),
              ],)),
            ],
          ),
        ),
      ),
    );
  }
}

// class mm extends StatelessWidget {
//   const mm({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(20.0),
//       child: ListView(
//         children: [
//           Row(
//             children: [
//               Text("Home Screen",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
//               Spacer(),
//               Icon(
//                 Icons.search,
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Text(
//             "Hello Ramazan! Welcome",
//             style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Container(
//             height: 191,
//             width: double.infinity,
//             child: PageView.builder(
//                 controller: _controller,
//                 itemCount: 3,
//                 itemBuilder: (_, index) {
//                   return Container(
//                     width: double.infinity,
//                     height: 190,
//                     margin: EdgeInsets.symmetric(horizontal: 5),
//                     padding: EdgeInsets.all(15),
//                     decoration: BoxDecoration(
//                       color: Color(0xFF0C331F),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Column(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               "${currentDate.year}/${currentDate.month}/${currentDate.day}",
//                               style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500,color: Colors.white),
//                             ),
//
//                             Text(
//                               "Quote of the Day",
//                               style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500,color: Colors.white),
//                             ),
//                           ],
//                         ),
//                         Divider(color: Colors.white,thickness: 2,),
//                         SizedBox(height: 20,),
//                         Text(
//                           "Look up at the stars and not down at your feet. Try to make sense of what you see, and wonder about what makes the universe exist. Be curious.",
//                           textAlign: TextAlign.center,style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500,color: Colors.white),
//                         ),
//                       ],
//                     ),
//                   );
//                 }),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Center(
//             child: SmoothPageIndicator(
//               controller: _controller,
//               count: 3,
//               effect: WormEffect(
//                   dotColor: Colors.grey.shade500,
//                   activeDotColor: Colors.black,
//                   dotHeight: 10,
//                   dotWidth: 10),
//             ),
//           ),
//
//           SizedBox(
//             height: 20,
//           ),
//
//           Text(
//             "Recent unfinished Lectures",
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Container(
//             height: 180,
//             width: 130,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10)
//             ),
//             child: ListView.builder(
//               itemCount: 6,
//               shrinkWrap: true,
//               scrollDirection: Axis.horizontal,
//               itemBuilder: (context, index) {
//                 return Container(
//                   margin: EdgeInsets.only(right: 10),
//                   decoration: BoxDecoration(
//                       color: Colors.grey.shade200,
//                       borderRadius: BorderRadius.circular(10)
//                   ),
//                   child: Column(
//                     children: [
//                       Stack(
//                         alignment: Alignment.center,
//                         children: [
//                           Image.asset('assets/Image.png',fit: BoxFit.cover,),
//                           Icon(Icons.play_circle_fill,size: 30,color: Colors.white,),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       Text(
//                         "Aunty Lee’s\nDelights",textAlign: TextAlign.center,
//                         style: TextStyle(
//                             fontSize: 15, fontWeight: FontWeight.w500),
//                       ),
//
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Text(
//             "Watched Lectures",
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Container(
//             height: 180,
//             width: 130,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10)
//             ),
//             child: ListView.builder(
//               itemCount: 6,
//               shrinkWrap: true,
//               scrollDirection: Axis.horizontal,
//               itemBuilder: (context, index) {
//                 return Container(
//                   margin: EdgeInsets.only(right: 10),
//                   decoration: BoxDecoration(
//                       color: Colors.grey.shade200,
//                       borderRadius: BorderRadius.circular(10)
//                   ),
//                   child: Column(
//                     children: [
//                       Stack(
//                         alignment: Alignment.center,
//                         children: [
//                           Image.asset('assets/Image.png',fit: BoxFit.cover,),
//                           Icon(Icons.play_circle_fill,size: 30,color: Colors.white,),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       Text(
//                         "Aunty Lee’s\nDelights",textAlign: TextAlign.center,
//                         style: TextStyle(
//                             fontSize: 15, fontWeight: FontWeight.w500),
//                       ),
//
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Text(
//             "Recommended Videos",
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Container(
//             height: 180,
//             width: 130,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10)
//             ),
//             child: ListView.builder(
//               itemCount: 6,
//               shrinkWrap: true,
//               scrollDirection: Axis.horizontal,
//               itemBuilder: (context, index) {
//                 return Container(
//                   margin: EdgeInsets.only(right: 10),
//                   decoration: BoxDecoration(
//                       color: Colors.grey.shade200,
//                       borderRadius: BorderRadius.circular(10)
//                   ),
//                   child: Column(
//                     children: [
//                       Stack(
//                         alignment: Alignment.center,
//                         children: [
//                           Image.asset('assets/Image.png',fit: BoxFit.cover,),
//                           Icon(Icons.play_circle_fill,size: 30,color: Colors.white,),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       Text(
//                         "Aunty Lee’s\nDelights",textAlign: TextAlign.center,
//                         style: TextStyle(
//                             fontSize: 15, fontWeight: FontWeight.w500),
//                       ),
//
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//         ],
//       ),
//     );
//   }
// }

