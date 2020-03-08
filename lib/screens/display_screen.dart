import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'dart:convert';

class displayScreen extends StatefulWidget {
  @override
  _displayScreenState createState() => _displayScreenState();
}

class _displayScreenState extends State<displayScreen> {
  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  String _text = "";
  double seen0 = 1.0; //text field
  double seen1 = 0.0; //container

  void _settext() {
    setState(() {
      _text = myController.text;
      seen0 = 0.0;
      seen1 = 1.0;
    });
  }

  void _settext2() {
    setState(() {
      _text = myController.text;
      seen0 = 1.0;
      seen1 = 0.0;
    });
  }

  String username = "";
  int id = 0; // Time in that location
  String type = ''; //url asset flag icon
  String urls = ''; // location getting api end point
  String siteadmin = "";
  String name = '';
  String company = '';
  int public_repos = 0;
  String created_at = '';
  String updated_at = '';
  int followers = 0;
  int following = 0;
  String bio = "";
  String location = '';
  String email = "";
  String hirerable = "";

  void getData() async {
    Response response = await get("https://api.github.com/users/$_text");
    Map data = jsonDecode(response.body);
    print(data);

    void setter() {

        setState(() {
          name = data["name"];
          username = data["login"];
          id = data["id"];
          type = data["type"];
          siteadmin = data["siteadmin"];
          company = data["company"];
          public_repos = data["public_repos"];
          created_at = data["created_at"];
          updated_at = data["updates_at"];
          urls = data["avatar_url"];
          followers = data["followers"];
          following = data["following"];
          bio = data["bio"];
          location = data["location"];
          email = data["email"];
          hirerable = data["hirerable"];
        });
      }

      setter();
      print("got here6");

      void _settext3() {
        setState(() {
          _text = myController.text;
          seen0 = 0.0;
          seen1 = 1.0;
        });
      }

      _settext3();
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Center(child: Text("Github User")),
        actions: <Widget>[
          FlatButton.icon(
              onPressed: _settext2,
              icon: Icon(Icons.keyboard_arrow_left),
              label: Text("back"))
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
//          color: Color(0xff9fdfbf),
          child: Column(
            children: <Widget>[
              Opacity(
                opacity: seen0,
                child: Container(
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.white30,

                    borderRadius: BorderRadius.all(Radius.circular(10)),

                  ),
                  child: Center(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: "Enter a git username"
                      ),

                      controller: myController,

                      onEditingComplete: _settext,
                    ),
                  ),
                ),
              ),
              AnimatedOpacity(
                duration: Duration(seconds: 5),
                opacity: seen1,
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Center(
                        child: Container(
                            height: 150,
                            width: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10)),
                            ),
                            child: FadeInImage.assetNetwork(
                                placeholder: "assets/images/waiting.png",
                                image: urls)),
                      ),
                      Container(
                        height: 400,
                        width: 250,
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 5),
                            Text(
                              name.toString(),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 15),
                            Text("Username : $username"),
                            SizedBox(height: 10),
                            Text("email : $email".toString()),
                            SizedBox(height: 10),
                            Text("bio : $bio".toString()),
                            SizedBox(height: 10),
                            Text("User ID : $id".toString()),
                            SizedBox(height: 10),
                            Text("Usertype : $type"),
                            SizedBox(height: 10),
                            Text("Company : $company".toString()),
                            SizedBox(height: 10),
                            Text("Total public repos : $public_repos"
                                .toString()),
                            SizedBox(height: 10),
                            Text("Joined on : $created_at".toString()),
                            SizedBox(height: 10),
                            Text("Last updated at : $updated_at".toString()),
                            SizedBox(height: 10),
                            Text("location : $location".toString()),
                            SizedBox(height: 10),
                            Text("hirerable : $hirerable".toString()),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.update,
        ),
        tooltip: "Click to update",
        onPressed: getData,
      ),
    );
  }
}
