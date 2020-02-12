import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

String url = "https://reqres.in/api/users?page=2";

void main() => runApp(HomePage()); //Main Function

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map data;
  List userData;

  Future getData() async {
    http.Response response = await http.get(url);
//    debugPrint(response.body);
    data = json.decode(response.body);
    setState(() {
      userData = data["data"];
    });
    debugPrint(userData.toString());
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Json Data Test"),
          elevation: 5,
        ),
        body: ListView.builder(
          itemCount: userData.length == null ? 0 : userData.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: CircleAvatar( backgroundImage: NetworkImage(userData[index]["avatar"]), ),
              title: Text(userData[index]["first_name"]+ " " + userData[index]["last_name"]),
              trailing: Text(userData[index]["email"]),
              subtitle: Text("ID: "+ userData[index]["id"].toString()),
            );
          },
        ),
      ),
    );
  }
}
