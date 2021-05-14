
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'edit_page.dart';
import 'next_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: '簡単メモ'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class Data {
  String title;
  final String body;
  final Color color;

  Data({
    this.title,
    this.body,
    this.color,
  });
}

class _MyHomePageState extends State<MyHomePage> {
  List<Data> dataList = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: GridView.count(
          childAspectRatio: 3 / 4,
          crossAxisCount: 3,
          children: List.generate(dataList.length, (index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => NewPage(
                              data: dataList[index],
                              onEdited: (newData) {
                                dataList[index] = newData;
                              },
                            )));
              },
              onLongPress: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return SimpleDialog(
                      title: Text(dataList[index].title + '　を削除・編集'),
                      children: <Widget>[
                        TextButton(
                          child: Text('削除する'),
                          onPressed: () {
                            setState(() {
                              dataList.removeAt(index);
                              Navigator.pop(context);
                            });
                          },
                        ),
                        TextButton(
                          child: Text('編集する'),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return SimpleDialog(
                                  children: <Widget>[
                                    TextField(
                                      decoration: InputDecoration(
                                        hintText: 'タイトル',
                                      ),
                                      onChanged: (text) {
                                        setState(() {
                                          dataList[index].title = text;
                                        });
                                      },
                                    ),
                                    TextButton(
                                      child: Text('完了'),
                                      onPressed: () {
                                        Navigator.popUntil(
                                            context,
                                            (Route<dynamic> route) =>
                                                route.isFirst);
                                      },
                                    )
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: Container(
                margin: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    border: Border.all(color: dataList[index].color, width: 5),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                width: double.infinity,
                height: double.infinity,
                child: Text(
                  dataList[index].title,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return NextPage(onSaved: (text, color) {
                final data = Data(title: text, color: color);
                setState(() {
                  dataList.add(data);
                }); //関数が呼び出された時の処理
              });
            }),
          );
        },
        tooltip: 'add your note',
        child: Icon(Icons.add),
      ),
    );
  }
}
