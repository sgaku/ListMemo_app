import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'main.dart';

class NewPage extends StatefulWidget {
  final Data data;
  final void Function(Data) onEdited;

  NewPage({
    @required this.data,
    @required this.onEdited,
  });

  @override
  _NewPageState createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  String editingBody;
  TextEditingController controller;

  @override
  void initState() {
    super.initState();
    editingBody = widget.data.body;
    controller = TextEditingController(text: widget.data.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.data.title),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_outlined),
            onPressed: () {
              final newData = Data(
                title: widget.data.title,
                color: widget.data.color,
                body: editingBody,
              );
              widget.onEdited(newData);
              Navigator.pop(context);
            },
          ),
        ),
        body: PageView.builder(
          itemCount: 100,

          itemBuilder: (context, index) {
            return TextField(controller: controller,
              autofocus: true,
              maxLines: null,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              keyboardType: TextInputType.multiline,
              onChanged: (text) {
                editingBody = text;
              },);
          },

        )

    );
  }
}
