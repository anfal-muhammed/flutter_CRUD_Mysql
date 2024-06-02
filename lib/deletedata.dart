import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'main.dart';

class Delete extends StatefulWidget {
  final List list;
  final int index;

  Delete({required this.index, required this.list});

  @override
  State<Delete> createState() => _DeleteState();
}

class _DeleteState extends State<Delete> {
  Future<void> deleteData() async {
    var url = "http://192.168.0.101/dashboard/myfolder/deletedata.php";
    try {
      var response = await http.post(
        Uri.parse(url),
        body: {
          "id": widget.list[widget.index]['id'].toString(),
        },
      );

      if (response.statusCode == 200) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => MyHomePage(
              title: 'Drivers',
            )));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete data. Server error.')),
        );
      }
    } catch (e) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => MyHomePage(
            title: 'Drivers',
          )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Delete Data ${widget.list[widget.index]['email']}"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Are you sure you want to delete ${widget.list[widget.index]['email']}?",
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MaterialButton(
                  onPressed: () {
                    deleteData();
                  },
                  child: Text("Delete"),
                  color: Colors.redAccent,
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Cancel"),
                  color: Colors.grey,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
