import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lecture_app/admin/models/add_contact_form_model.dart';
import 'package:lecture_app/common/custom_textfield.dart';
import 'package:lecture_app/res/static_info.dart';

import '../../../common/reusable_textformfield.dart';

class ContactUsForm extends StatefulWidget {
  const ContactUsForm({Key? key}) : super(key: key);

  @override
  State<ContactUsForm> createState() => _ContactUsFormState();
}

class _ContactUsFormState extends State<ContactUsForm> {
  TextEditingController name = TextEditingController();
  TextEditingController phoneno = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController message = TextEditingController();
  bool isLoadFile = false;
  bool isLoad = false;
  bool isLoading = false;
  DateTime? fDate;
  final formKey = GlobalKey<FormState>();

  uploadLecture() async {
    isLoading = true;
    setState(() {});
    int id = DateTime.now().millisecondsSinceEpoch;
    AddFormData dataModel = AddFormData(
      name: name.text,
      phoneno: phoneno.text,
      email: email.text,
      message: message.text,
      uploadTime:     DateTime.now().millisecondsSinceEpoch
,
      doc: id.toString(),
    );
    try {
      await FirebaseFirestore.instance
          .collection(StaticInfo.addFormData)
          .doc('$id')
          .set(dataModel.toJson());
      isLoading = false;
      setState(() {});
      Fluttertoast.showToast(msg: 'Lecture added successfully');
      //showDialogForSuccess();

    } catch (e) {
      isLoading = false;
      setState(() {});
      Fluttertoast.showToast(msg: 'Some error occurred');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF292b2e),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Name",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ReusableTextForm(
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'This is required field';
                    }
                  },
                  hintText: 'Name',
                  prefixIcon: Icons.person,
                  controller: name,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Phone",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ReusableTextForm(
                  keyboardType: TextInputType.number,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'This is required field';
                    }
                  },
                  hintText: 'Phone No',
                  prefixIcon: Icons.phone,
                  controller: phoneno,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Email",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ReusableTextForm(
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'This is required field';
                    }
                  },
                  hintText: 'Email',
                  controller: email,
                  prefixIcon: Icons.email,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Message",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ReusableTextForm(
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'This is required field';
                    }
                  },
                  controller: message,
                  hintText: 'Message',
                  prefixIcon: Icons.message,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.black),
                    onPressed: ()async {
                      if (formKey.currentState!.validate()) {
                       await uploadLecture();
                      }
                       Navigator.pop(context);
                    },
                    child: Text("Send"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

