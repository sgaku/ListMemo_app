import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class EditPage extends StatefulWidget {
  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('EditPage'),
        ),
        body: PageView.builder(
          itemBuilder: (context, index) {
            return NewPage(
              newpageindex: index,
            );
          },
          itemCount: 100,
        ));
  }
}

class NewPage extends StatefulWidget {
  const NewPage({
    Key key,
    this.newpageindex,
  }) : super(key: key);
  final int newpageindex;

  @override
  _NewPageState createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text('${widget.newpageindex}'),
            TextField(
              autofocus: true,
              maxLines: null,
              keyboardType: TextInputType.multiline,
            )
          ],
        ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
