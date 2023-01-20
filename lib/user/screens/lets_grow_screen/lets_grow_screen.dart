import 'package:flutter/material.dart';
import '../contact_us_form/contact_us_form.dart';
import '../promocode_screen/promocode_screen.dart';

class LetsGrowScreen extends StatelessWidget {
  const LetsGrowScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF292b2e),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Text("Lets Grow",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.white),),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: (){

                  },
                  child: Card(
                    color: Colors.grey.shade500,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey.shade300,
                        child: Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                      ),
                      title: Text(
                        "Profile",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios_outlined,color: Colors.black,),
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_){
                      return ContactUsForm();
                    },),);
                  },
                  child: Card(
                    color: Colors.grey.shade500,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey.shade300,
                        child: Icon(
                          Icons.contact_page,
                          color: Colors.black,
                        ),
                      ),
                      title: Text(
                        "Contact Us Form",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios_outlined,color: Colors.black,),
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_){
                      return PromoCode();
                    },),);
                  },
                  child: Card(
                    color: Colors.grey.shade500,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey.shade300,
                        child: Icon(
                          Icons.code,
                          color: Colors.black,
                        ),
                      ),
                      title: Text(
                        "Generate Promo Code",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios_outlined,color: Colors.black,),
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){

                  },
                  child: Card(
                    color: Colors.grey.shade500,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey.shade300,
                        child: Icon(
                          Icons.perm_identity,
                          color: Colors.black,
                        ),
                      ),
                      title: Text(
                        "Who are we?",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios_outlined,color: Colors.black,),
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){

                  },
                  child: Card(
                    color: Colors.grey.shade500,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey.shade300,
                        child: Icon(
                          Icons.settings,
                          color: Colors.black,
                        ),
                      ),
                      title: Text(
                        "Settings",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios_outlined,color: Colors.black,),
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){

                  },
                  child: Card(
                    color: Colors.grey.shade500,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey.shade300,
                        child: Icon(
                          Icons.logout,
                          color: Colors.black,
                        ),
                      ),
                      title: Text(
                        "Log Out",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios_outlined,color: Colors.black,),
                    ),
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
