import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class NextPage extends StatefulWidget {
  final void Function(String, Color) onSaved; //関数を定義する

  NextPage({this.onSaved});

  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  String note = '';

  // create some values
  Color choosingColor = Color(0xff443a49);
  Color chosenColor = Color(0xff443a49);

// ValueChanged<Color> callback
  void changeColor(Color color) {
    setState(() => choosingColor = color);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Note'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              autofocus: true,
              onChanged: (String value) {
                note = value;
              },
            ),
            TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('好きな色を選んでね'),
                    content: SingleChildScrollView(
                      child: ColorPicker(
                        pickerColor: choosingColor,
                        onColorChanged: changeColor,
                        showLabel: true,
                        pickerAreaHeightPercent: 0.8,
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('完了'),
                        onPressed: () {
                          setState(() => chosenColor = choosingColor);
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                );
              },
              child: Text('色を選択する', style: TextStyle(color: chosenColor)),
            ),
            Container(
              child: ElevatedButton(
                onPressed: () {
                  widget.onSaved(note, chosenColor);
                  Navigator.of(context).pop();
                },
                child: Text("完了"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
