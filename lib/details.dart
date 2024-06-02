import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'deletedata.dart';
import 'editdata.dart';

class Details extends StatefulWidget {
  List list;
  int index;
  Details({required this.list, required this.index});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  void confirm() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.list[widget.index]['email']}"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Text(
              widget.list[widget.index]['email'],
              style: TextStyle(fontSize: 20.0),
            ),
            Text(
              widget.list[widget.index]['password'],
            ),
            MaterialButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        Edit(list: widget.list, index: widget.index)),
              ),
              child: Text("Edit"),
              color: Colors.green,
            ),
            MaterialButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        Delete(list: widget.list, index: widget.index)),
              ),
              child: Text("Delete"),
              color: Colors.blue,
            )
          ],
        ),
      ),
    );
  }
}
