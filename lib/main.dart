import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

class _MyHomePageState extends State<MyHomePage> {
  List<String> data = [];

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
          children: List.generate(data.length, (index) {
            return Center(
              child: Container(
                margin: EdgeInsets.all(16),
                color: Colors.green,
                width: double.infinity,
                height: double.infinity,
                child: Text(
                  data[index],
                  style: Theme.of(context).textTheme.headline5,
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newListText = await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return NextPage();
            }),
          );
          setState(() {
            data.add(newListText);
          });
        },
        tooltip: 'add your note',
        child: Icon(Icons.add),
      ),
    );
  }
}

class NextPage extends StatefulWidget {
  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  String note = '';

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Note'),
      ),
      body: Container(
        child: Column(
          children: [
            Text(note),
            TextField(
              autofocus: true,
              onChanged: (String value) {
                setState(() {
                  value = note;
                });
              },
            ),
            Container(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(note);
                },
                child: Text('完了'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
