import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  const PostCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/nerv.jpg'),
          ),
          title: Text(
            "Ramazan Ch",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,),
          ),
          subtitle: Text(
            "5 minutes ago",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey,),
          ),
          trailing: Icon(Icons.more_vert,color: Colors.white,),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 180,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/7.jpg"),
              )),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Look up at the stars and not down at your feet. Try to make sense of what you see,",
                    style: TextStyle(
                        fontWeight: FontWeight.w500, color: Colors.white),
                  ),
                  Spacer(),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Color(0xFF5a5c64),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                    ),
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      width: 100,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(80, 80, 81, 0.4),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.access_time_outlined,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "duration",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}