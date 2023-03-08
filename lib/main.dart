import 'dart:convert';

import 'package:fhir/r4.dart' as r4;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder<r4.ValueSet>(
          future: loadAndParse(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Text("Waiting");
              case ConnectionState.active:
                return const Text("Active");
              case ConnectionState.done:
                if (snapshot.hasData) {
                  final vs = snapshot.data!;
                  return Text("${vs.title} by ${vs.publisher}");
                } else {
                  return const Text("Snapshot.data loading failed");
                }
              default:
                return const Text("Nothing to see here");
            }
          },
        ),
      ),
    );
  }

  Future<r4.ValueSet> loadAndParse() async {
    final jsonString = await rootBundle.loadString("assets/IHE.XDS.merged.json");
    final jsonMap = jsonDecode(jsonString);
    final valueSet = r4.ValueSet.fromJson(jsonMap);
    return valueSet;
  }
}
