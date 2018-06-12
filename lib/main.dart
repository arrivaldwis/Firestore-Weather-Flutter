import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Dashboard',
      theme: new ThemeData(primarySwatch: Colors.blue),
      home: new MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => new _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<double> chartTemp = [2.2];
  List<double> chartLight = [2.3];
  List<double> chartHumidity = [3.2];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          elevation: 2.0,
          backgroundColor: Colors.white,
          title: new Text('Project 1 (Client)',
              style: new TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 30.0)),
        ),
        body: new ListView(
          scrollDirection: Axis.vertical,
          padding: new EdgeInsets.symmetric(horizontal: 16.0),
            children: <Widget>[
              new Padding(padding: new EdgeInsets.only(top: 16.0)),
              new Container(
                  margin: new EdgeInsets.only(bottom: 16.0),
                  child: new Material(
                      elevation: 14.0,
                      borderRadius: new BorderRadius.circular(12.0),
                      shadowColor: new Color(0x802196F3),
                      child: new InkWell(
                        onTap: () {},
                        child: new Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: new Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    new Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        new Text('Temperature',
                                            style: new TextStyle(
                                                color: Colors.blueAccent)),
                                        new StreamBuilder(
                                            stream: Firestore.instance
                                                .collection('temp')
                                                .orderBy('timestamp', descending: true)
                                                .snapshots(),
                                            builder: (context, snapshot) {
                                              if (!snapshot.hasData)
                                                return const Text('Loading...');
                                              DocumentSnapshot ds =
                                              snapshot.data.documents[0];
                                              return new Text("${ds['value']}°C",
                                                  style: new TextStyle(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: 34.0));
                                            }),
                                      ],
                                    ),
                                    new Material(
                                        color: Colors.blue,
                                        borderRadius: new BorderRadius.circular(24.0),
                                        child: new Center(
                                            child: new Padding(
                                              padding: const EdgeInsets.all(16.0),
                                              child: new Icon(Icons.cloud,
                                                  color: Colors.white, size: 30.0),
                                            ))),
                                  ],
                                ),
                                new Padding(
                                    padding: new EdgeInsets.only(bottom: 4.0)),

                                new StreamBuilder(
                                    stream: Firestore.instance
                                        .collection('temp')
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData)
                                        return const Text('Loading...');

                                      chartTemp.clear();
                                      for(int i=0; i<snapshot.data.documents.length; i++) {
                                        DocumentSnapshot ds = snapshot.data.documents[i];
                                        chartTemp.add(double.parse(ds['value'].toString()));
                                        print(ds['value'].toString());
                                      }

                                      return new Sparkline(
                                        data: chartTemp,
                                        lineWidth: 5.0,
                                        lineColor: Colors.blueAccent,
                                      );
                                    }),
                              ],
                            )),
                      ))),
              new Container(
                  margin: new EdgeInsets.only(bottom: 16.0),
                  child: new Material(
                      elevation: 14.0,
                      borderRadius: new BorderRadius.circular(12.0),
                      shadowColor: new Color(0x802196F3),
                      child: new InkWell(
                        onTap: () {},
                        child: new Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: new Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    new Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        new Text('Light',
                                            style: new TextStyle(
                                                color: Colors.orangeAccent)),
                                        new StreamBuilder(
                                            stream: Firestore.instance
                                                .collection('light')
                                                .orderBy('timestamp', descending: true)
                                                .snapshots(),
                                            builder: (context, snapshot) {
                                              if (!snapshot.hasData)
                                                return const Text('Loading...');
                                              DocumentSnapshot ds =
                                              snapshot.data.documents[0];
                                              return new Text("${ds['value']}",
                                                  style: new TextStyle(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: 34.0));
                                            }),
                                      ],
                                    ),
                                    new Material(
                                        color: Colors.orangeAccent,
                                        borderRadius: new BorderRadius.circular(24.0),
                                        child: new Center(
                                            child: new Padding(
                                              padding: const EdgeInsets.all(16.0),
                                              child: new Icon(Icons.lightbulb_outline,
                                                  color: Colors.white, size: 30.0),
                                            ))),
                                  ],
                                ),
                                new Padding(
                                    padding: new EdgeInsets.only(bottom: 4.0)),

                                new StreamBuilder(
                                    stream: Firestore.instance
                                        .collection('light')
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData)
                                        return const Text('Loading...');

                                      chartLight.clear();
                                      for(int i=0; i<snapshot.data.documents.length; i++) {
                                        DocumentSnapshot ds = snapshot.data.documents[i];
                                        chartLight.add(double.parse(ds['value'].toString()));
                                        print(ds['value'].toString());
                                      }

                                      return new Sparkline(
                                        data: chartLight,
                                        lineWidth: 5.0,
                                        lineColor: Colors.orangeAccent,
                                      );
                                    }),
                              ],
                            )),
                      ))),
              new Container(
                  margin: new EdgeInsets.only(bottom: 16.0),
                  child: new Material(
                      elevation: 14.0,
                      borderRadius: new BorderRadius.circular(12.0),
                      shadowColor: new Color(0x802196F3),
                      child: new InkWell(
                        onTap: () {},
                        child: new Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: new Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    new Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        new Text('Humidity',
                                            style: new TextStyle(
                                                color: Colors.teal)),
                                        new StreamBuilder(
                                            stream: Firestore.instance
                                                .collection('humidity')
                                                .orderBy('timestamp', descending: true)
                                                .snapshots(),
                                            builder: (context, snapshot) {
                                              if (!snapshot.hasData)
                                                return const Text('Loading...');
                                              DocumentSnapshot ds =
                                              snapshot.data.documents[0];
                                              return new Text("${ds['value']}",
                                                  style: new TextStyle(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: 34.0));
                                            }),
                                      ],
                                    ),
                                    new Material(
                                        color: Colors.teal,
                                        borderRadius: new BorderRadius.circular(24.0),
                                        child: new Center(
                                            child: new Padding(
                                              padding: const EdgeInsets.all(16.0),
                                              child: new Icon(Icons.person,
                                                  color: Colors.white, size: 30.0),
                                            ))),
                                  ],
                                ),
                                new Padding(
                                    padding: new EdgeInsets.only(bottom: 4.0)),

                                new StreamBuilder(
                                    stream: Firestore.instance
                                        .collection('humidity')
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData)
                                        return const Text('Loading...');

                                      chartHumidity.clear();
                                      for(int i=0; i<snapshot.data.documents.length; i++) {
                                        DocumentSnapshot ds = snapshot.data.documents[i];
                                        chartHumidity.add(double.parse(ds['value'].toString()));
                                        print(ds['value'].toString());
                                      }

                                      return new Sparkline(
                                        data: chartHumidity,
                                        lineWidth: 5.0,
                                        lineColor: Colors.teal,
                                      );
                                    }),
                              ],
                            )),
                      ))),
              new Container(
                  margin: new EdgeInsets.only(bottom: 16.0),
                  child: new Text('Last update: 5 min ago',
                      style: new TextStyle(color: Colors.grey)))
              /*new Container
          (
            margin: new EdgeInsets.only(bottom: 16.0),
            child: new Material
            (
              elevation: 14.0,
              borderRadius: new BorderRadius.circular(12.0),
              shadowColor: new Color(0x802196F3),
              child: new InkWell
              (
                onTap: () => Navigator.of(context).push(new MaterialPageRoute(builder: (_) => new ShopItemsPage())),
                child: new Padding
                (
                  padding: const EdgeInsets.all(24.0),
                  child: new Row
                  (
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>
                    [
                      new Column
                      (
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>
                        [
                          new Text('Shop Items', style: new TextStyle(color: Colors.redAccent)),
                          new Text('173', style: new TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 34.0))
                        ],
                      ),
                      new Material
                      (
                        color: Colors.red,
                        borderRadius: new BorderRadius.circular(24.0),
                        child: new Center
                        (
                          child: new Padding
                          (
                            padding: new EdgeInsets.all(16.0),
                            child: new Icon(Icons.store, color: Colors.white, size: 30.0),
                          )
                        )
                      )
                    ]
                  ),
                ),
              )
            )
          ),*/
            ],
        ));
  }
}
