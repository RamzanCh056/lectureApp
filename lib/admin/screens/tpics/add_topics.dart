import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lecture_app/admin/models/quotes_model.dart';
import 'package:lecture_app/admin/screens/tpics/add_video_lecture.dart';

import '../../../res/static_info.dart';
import '../../models/add_topics_model.dart';
class AddTopics extends StatefulWidget {
  const AddTopics({Key? key}) : super(key: key);

  @override
  State<AddTopics> createState() => _AddTopicsState();
}

class _AddTopicsState extends State<AddTopics> {
  TextEditingController quotesController =  TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  List<AddTopic> topics = [];

  @override
  void initState() {
    getQuotes();
    super.initState();
  }

  getQuotes() {
    try {
      topics.clear();
      setState(() {});
      FirebaseFirestore.instance.collection("topics").snapshots().listen((event) {
        topics.clear();
        setState(() {});
        for (int i = 0; i < event.docs.length; i++) {
          AddTopic dataModel = AddTopic.fromJson(event.docs[i].data());
          topics.add(dataModel);
        }
        setState(() {});
      });
      setState(() {});
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Topics/Subject"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Form(
          key: formKey,
          child: Column(

            children: [
              SizedBox(height: 20,),
              TextFormField(
                controller: quotesController,
                minLines: 2,
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: 'Enter Topics/Subject',
                  hintStyle: TextStyle(
                      color: Colors.grey
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Topics/Subject';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20,),

              isLoading? CircularProgressIndicator():
              GestureDetector(
                onTap: (){
                  if(formKey.currentState!.validate()){
                    addQuotes();
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue,

                    ),

                    height: 50,
                    width: double.infinity,
                    child: Center(child: Text("Upload", style: TextStyle(
                        color: Colors.white

                    ),),),),
                ),
              ),

              SizedBox(height: 20,),

              Text("Click on topics to add videos "),
              SizedBox(height: 20,),
              GridView.builder(
                shrinkWrap: true,
                itemCount: topics.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,crossAxisSpacing: 10,mainAxisSpacing: 10),
                itemBuilder: (context, index){
                  return  InkWell(
                      onTap: (){
                        FocusScope.of(context).requestFocus(FocusNode());
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>  AddLecture(topics,index)
                          ),
                        );

                      },
                      child: Container(
                          height: 100,
                          width: double.infinity,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(topics[index].topics.toString(), style: TextStyle(fontSize: 18,color: Colors.white),)
                              ],
                            ),
                          )));
                },

              ),


            ],),
        ),
      ),
    );
  }

  addQuotes() async {
    isLoading = true;
    setState(() {});
    int id = DateTime.now().millisecondsSinceEpoch;
    AddTopic dataModel = AddTopic(
      topics:quotesController.text,
      doc: id.toString(),
    );
    try {
      await FirebaseFirestore.instance
          .collection("topics")
          .doc('$id')
          .set(dataModel.toJson());
      isLoading = false;
      setState(() {});
      Fluttertoast.showToast(msg: 'Added successfully');


    } catch (e) {
      isLoading = false;
      setState(() {});
      Fluttertoast.showToast(msg: 'Some error occurred');
    }
  }
}
