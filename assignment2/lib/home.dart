import 'dart:ui';

import 'package:assignment2/model/data.dart';
import 'package:assignment2/model/user_model.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  //const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<UserData> list = [];
  bool loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    get();
  }

  get() async {
    Users userClass = Users();

    await userClass.getData();
    list = userClass.userslist;
    setState(() {
      loading = false;
    });
    print(list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users"),
      ),
      body: loading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: ListView.builder(
                  itemCount: list.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return BlogTile(
                        imageUrl: list[index].avatar,
                        fname: list[index].firstName,
                        lname: list[index].lastName,
                        email: list[index].email);
                  }),
            ),
    );
  }
}

class BlogTile extends StatelessWidget {
  String imageUrl, fname, lname, email;
  BlogTile(
      {@required this.imageUrl,
      @required this.fname,
      @required this.lname,
      @required this.email});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
          padding: EdgeInsets.only(top: 16),
          child: Row(
            children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.network(imageUrl)),
              SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        fname,
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(width: 8),
                      Text(
                        lname,
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    email,
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                ],
              )
            ],
          )),
    );
  }
}
