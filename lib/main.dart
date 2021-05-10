import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'edit_page.dart';
import 'next_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Flutter List Demo'),
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
  final String title;
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
                    builder: (context) => EditPage(
                      data: dataList[index],
                      onEdited: (newData) {
                        dataList[index] = newData;
                      },
                    ),
                  ),
                );
              },
              child: Center(
                child: Container(
                  margin: EdgeInsets.all(16),
                  color: dataList[index].color,
                  width: double.infinity,
                  height: double.infinity,
                  child: Text(
                    dataList[index].title,
                    style: Theme.of(context).textTheme.headline5,
                    textAlign: TextAlign.center,
                  ),
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
