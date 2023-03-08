import 'dart:convert';

import 'package:fhir/r4.dart' as r4;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'value_set_data.dart';

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
          future: loadAndParseAll(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Text("Waiting");
              case ConnectionState.active:
                return const Text("Active");
              case ConnectionState.done:
                if (snapshot.hasData) {
                  final vs = snapshot.data!;
                  // return const Text("Snapshot.data loading succeeded");
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

  Future<r4.ValueSet> loadAndParseAll() async {
    final allAssets = [
      // "assets/IHE.XDS.classCode.json",
      // "assets/IHE.XDS.typeCode.json",
      // "assets/IHE.XDS.practiceSettingCode.json",
      // "assets/IHE.XDS.healthcareFacilityTypeCode.json",
      // "assets/IHE.XDS.confidentialityCode.json",
      // "assets/IHE.XDS.eventCodeList.json",
      // "assets/IHE.XDS.formatCode.json",
      // "assets/IHE.XDS.contentTypeCode.json",
      "assets/IHE.XDS.merged.json",
      "assets/IHE.XDS.merged.json",
      "assets/IHE.XDS.merged.json",
    ];

    List<r4.ValueSet> valueSets = [];

    for (var asset in allAssets) {
      final jsonString = await rootBundle.loadString(asset);
      final jsonMap = jsonDecode(jsonString);
      final valueSet = r4.ValueSet.fromJson(jsonMap);
      valueSets.add(valueSet);
    }
    return valueSets.first;
  }

  Future<ValueSetData> loadAllData() async {
    return ValueSetData.loadFromAssets(
      documentClassPath: "assets/IHE.XDS.classCode.json",
      documentTypePath: "assets/IHE.XDS.typeCode.json",
      practiceSettingPath: "assets/IHE.XDS.practiceSettingCode.json",
      facilityTypePath: "assets/IHE.XDS.healthcareFacilityTypeCode.json",
      securityLabelPath: "assets/IHE.XDS.confidentialityCode.json",
      eventCodePath: "assets/IHE.XDS.eventCodeList.json",
      attachmentFormatPath: "assets/IHE.XDS.formatCode.json",
      attachmentContentTypePath: "assets/IHE.XDS.contentTypeCode.json",
    );
  }

  Future<ValueSetData> loadSubSetOfData() async {
    return ValueSetData.loadFromAssets(
      documentClassPath: "assets/IHE.XDS.classCode.json",
      documentTypePath: "assets/IHE.XDS.typeCode.json",
    );
  }
}
