import 'package:flutter/material.dart';
import 'package:lecture_app/landing_page.dart';

import '../../../common/custom_tiles.dart';
import '../../youtube_viewer/youtbe_landing.dart';
import '../../youtube_viewer/youtube.dart';
import '../lectures/pdf_lectures/pfd_view.dart';
import '../lectures/pdf_lectures/view_landing_pdf.dart';
import '../lectures/video_lectures/view_lecture_topic.dart';
import '../qoutes/add_qoutes.dart';
import '../recommended_lecture/view_recomended_lecture.dart';
import '../tpics/add_video_lecture.dart';


class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  // SharedPreferences? preferences;
  // @override
  // void initState() {
  //   SharedPreferences.getInstance().then((value) {
  //     preferences = value;
  //     setState(() {});
  //   });
  //   super.initState();
  //
  // }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              accountName: Text(
               " preferences?.getString('Email') ?? 'User'",
                style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              accountEmail: const Text(
                '',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )),
          const SizedBox(
            height: 10,
          ),
          CustomTile(
            icon: const Icon(Icons.format_quote_sharp),
            title: "Quotes",
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 18,
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> AddQuotes()));
            },
          ),
          CustomTile(
            icon: const Icon(Icons.video_call_outlined),
            title: "Recommended Lecture",
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 18,
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const ViewRecommendedLecture()));
            },
          ),

          CustomTile(
            icon: const Icon(Icons.picture_as_pdf),
            title: "Pdf",
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 18,
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));
            },
          ),
          CustomTile(
            icon: const Icon(Icons.logout),
            title: "Logout",
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 18,
            ),
            onTap: () {
              logoutDialog();
            },
          ),
          const SizedBox(
            height: 15,
          )
        ],
      ),
    );
  }

  logoutDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Log Out"),
            content: const Text("Are you sure to Logout?"),
            actions: [
              TextButton(
                onPressed: () async {
                  Navigator.pushAndRemoveUntil(
                      context, MaterialPageRoute(builder: (_) => LandingPage()), (route) => false);
                },
                child: const Text("Log Out"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Cancel"),
              ),
            ],
          );
        });
  }
}
