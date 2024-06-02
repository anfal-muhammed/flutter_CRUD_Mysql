import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'details.dart';
import 'login.dart';
import 'newdata.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drivers',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List> getData() async {
    // Updated URL for Android emulator
    final url =
        Uri.parse("http://192.168.0.101//dashboard/myfolder/getdata.php");
    print('Attempting to connect to: $url');

    try {
      final response = await http
          .get(url)
          .timeout(const Duration(seconds: 10)); // Set a timeout of 10 seconds
      print('Response received with status code: ${response.statusCode}');
      if (response.statusCode == 200) {
        print('Response body: ${response.body}');
        return json.decode(response.body);
      } else {
        print('Failed to load data. Status code: ${response.statusCode}');
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to connect to the server');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Drivers"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => NewData(),
        )),
        child: Icon(Icons.add),
      ),
      body: FutureBuilder<List>(
        future: getData(),
        builder: (ctx, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data found'));
          }
          return Items(list: snapshot.data);
        },
      ),
    );
  }
}

class Items extends StatelessWidget {
  final List? list;

  Items({required this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list?.length ?? 0,
      itemBuilder: (ctx, i) {
        return ListTile(
          leading: Icon(Icons.message),
          title: Text(list?[i]['id'] ?? ''),
          subtitle: Text(list?[i]['email'] ?? ''),
          onTap: () {
            if (list != null) {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        Details(list: list!, index: i)),
              );
            }
          },
        );
      },
    );
  }
}

// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// import 'details.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Drivers',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   Future<List> getData() async{
//     final response=await http.get("http://192.168.0.102/dashboard/myfolder/getdata.php");
//     return json.decode(response.body);
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//           title: Text("Drivers"),
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {},
//           child: Icon(Icons.add),
//         ),
//         body: FutureBuilder<List>(
//           future: getData(),
//           builder: (ctx, ss) {
//             if (ss.hasError) {
//               print("error");
//             }
//             if (ss.hasData) {
//               return Items(list:ss.data);
//             } else {
//               return CircularProgressIndicator();
//             }
//           },
//         ));
//   }
// }
// class Items extends StatelessWidget {
//   final List? list;
//
//   Items({required this.list});
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: list?.length ?? 0,
//       itemBuilder: (ctx, i) {
//         return ListTile(
//           leading: Icon(Icons.message),
//           title: Text(list?[i]['id'] ?? ''),
//           subtitle: Text(list?[i]['email'] ?? ''),
//           onTap: () {
//             if (list != null) {
//               Navigator.of(context).push(
//                 MaterialPageRoute(builder: (BuildContext context) => Details(list: list!, index: i)),
//               );
//             }
//           },
//         );
//       },
//     );
//   }
// }
//
//
// // class Items extends StatelessWidget {
// //   List list;
// //   Items({required this.list});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return ListView.builder(
// //       itemCount: list==null?0:list.length,
// //         itemBuilder: (ctx,i){
// //         return ListTile(
// //           leading: Icon(Icons.message),
// //           title: Text(list[i]['id']),
// //           subtitle: Text(list[i]['email']),
// //           onTap: ()=>Navigator.of(context).push(
// //             MaterialPageRoute(builder: (BuildContext context)=>Details(list:list,index:i),
// //           ),
// //           ),
// //         );
// //         });
// //   }
// // }
