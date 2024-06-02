
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'main.dart';

class NewData extends StatefulWidget {
  const NewData({super.key});

  @override
  State<NewData> createState() => _NewDataState();
}

class _NewDataState extends State<NewData> {
  final TextEditingController cemail = TextEditingController();
  final TextEditingController cpassword = TextEditingController();
  bool isLoading = false;

  Future<void> addData() async {
    setState(() {
      isLoading = true;
    });

    var url = "http://192.168.0.101/dashboard/myfolder/adddata.php";
    try {
      var response = await http.post(
        Uri.parse(url),
        body: {
          "email": cemail.text,
          "password": cpassword.text,
        },
      );

      if (response.statusCode == 200) {
        // Successfully added data
        var responseData = json.decode(response.body);
        // Handle the response data if needed

        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => MyHomePage(
              title: 'Drivers',
            )));
      } else {
        // Handle server errors
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add data. Server error.')),
        );
      }
    } catch (e) {
      // Handle network errors
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => MyHomePage(
            title: 'Drivers',
          )));
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('Failed to add data. Network error.')),
      // );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Data"),
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
            isLoading
                ? CircularProgressIndicator()
                : MaterialButton(
              child: Text("Add Data"),
              color: Colors.redAccent,
              onPressed: addData,
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
//
// import 'main.dart';
//
// class NewData extends StatefulWidget {
//   const NewData({super.key});
//
//   @override
//   State<NewData> createState() => _NewDataState();
// }
// TextEditingController cemail = new TextEditingController();
// TextEditingController cpassword = new TextEditingController();
// class _NewDataState extends State<NewData> {
//   void addData() {
//
//
//     var url = "http://192.168.0.101//dashboard/myfolder/adddata.php";
//     http.post(url, body: {
//       "email": cemail.text,
//       "password": cpassword.text,
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Add New Data"),
//       ),
//       body: ListView(
//         children: <Widget>[
//           TextField(
//             controller: cemail,
//             decoration: InputDecoration(
//                 hintText: "Enter email", labelText: "Enter email"),
//           ),
//           TextField(
//             controller: cpassword,
//             decoration: InputDecoration(
//                 hintText: "Enter password", labelText: "Enter password"),
//           ),
//           MaterialButton(
//             child: Text("Add Data"),
//             color: Colors.redAccent,
//             onPressed: () {
//               addData();
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (BuildContext context) => MyHomePage(
//                         title: 'Drivers',
//                       )));
//             },
//           )
//         ],
//       ),
//     );
//   }
// }
