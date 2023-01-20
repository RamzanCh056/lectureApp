import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lecture_app/admin/models/quotes_model.dart';

import '../../../common/reusable_textformfield.dart';
import '../../../res/static_info.dart';
class AddQuotes extends StatefulWidget {
  const AddQuotes({Key? key}) : super(key: key);

  @override
  State<AddQuotes> createState() => _AddQuotesState();
}

class _AddQuotesState extends State<AddQuotes> {
  TextEditingController quotesController =  TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Quotes"),
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
                  hintText: 'Write quotes here',
                  hintStyle: TextStyle(
                      color: Colors.grey
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter qoutes';
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

              ListView.builder(
                shrinkWrap: true,
                itemCount: quotes.length,
                  itemBuilder: (context, index){
                return Card(
                  elevation: 4,
                  child: ListTile(
                    title: Text(quotes[index].quotes.toString()),
                    trailing: GestureDetector(
                      onTap: (){
                        FirebaseFirestore.instance.collection(StaticInfo.dailyQuotes).doc(quotes[index].doc.toString()).delete().then(
                              (doc) => print("Document deleted"),
                          onError: (e) => print("Error updating document $e"),);

                      },
                      child: Icon(
                        Icons.delete, color: Colors.red,
                      ),
                    ),
                  ),
                );
              })


          ],),
        ),
      ),
    );
  }

  addQuotes() async {
    isLoading = true;
    setState(() {});
    int id = DateTime.now().millisecondsSinceEpoch;
    QuotesModel dataModel = QuotesModel(
    quotes:quotesController.text,
      doc: id.toString(),
    );
    try {
      await FirebaseFirestore.instance
          .collection(StaticInfo.dailyQuotes)
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
