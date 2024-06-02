import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'main.dart';

class Edit extends StatefulWidget {
  final List list;
  final int index;

  Edit({required this.index, required this.list});

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  late TextEditingController cemail;
  late TextEditingController cpassword;

  @override
  void initState() {
    super.initState();
    cemail = TextEditingController(text: widget.list[widget.index]['email']);
    cpassword = TextEditingController(text: widget.list[widget.index]['password']);
  }

  Future<void> editData() async {
    var url = "http://192.168.0.101/dashboard/myfolder/editdata.php";
    try {
      var response = await http.post(
        Uri.parse(url),
        body: {
          "id": widget.list[widget.index]['id'].toString(),
          "email": cemail.text,
          "password": cpassword.text,
        },
      );

      if (response.statusCode == 200) {
        // Successfully edited data
        var responseData = json.decode(response.body);
        // Handle the response data if needed

        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => MyHomePage(
              title: 'Drivers',
            )));
      } else {
        // Handle server errors
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to edit data. Server error.')),
        );
      }
    } catch (e) {
      // Handle network errors
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => MyHomePage(
            title: 'Drivers',
          )));
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('Failed to edit data. Network error.')),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Data ${widget.list[widget.index]['email']}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: cemail,
              decoration: InputDecoration(
                  hintText: "Enter email", labelText: "Enter email"),
            ),
            TextField(
              controller: cpassword,
              decoration: InputDecoration(
                  hintText: "Enter password", labelText: "Enter password"),
              obscureText: true,
            ),
            SizedBox(height: 20),
            MaterialButton(
              onPressed: () {
                editData();
              },
              child: Text("Edit Data"),
              color: Colors.redAccent,
            )
          ],
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'main.dart';
//
// class Edit extends StatefulWidget {
//   final List list;
//   final int index;
//
//   Edit(this.list, this.index);
//
//   @override
//   State<Edit> createState() => _EditState();
// }
//
// class _EditState extends State<Edit> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Edit Data ${widget.list[widget.index]['email']}"),
//       ),
//       body: ListView(
//         children: const [
//           TextField(
//             decoration: InputDecoration(
//                 hintText: "Enter email", labelText: "Enter email"),
//           ),
//           TextField(
//             decoration: InputDecoration(
//                 hintText: "Enter password", labelText: "Enter password"),
//           ),
//           MaterialButton(
//             onPressed: () {
//               editdata();
//               Navigator.of(context).push(
//                 MaterialPageRoute(
//                     builder: (BuildContext context) =>
//                         MyHomePage(title: 'Drivers')),
//               );
//             },
//             child: Text("Edit Data"),
//           )
//         ],
//       ),
//     );
//   }
// }
