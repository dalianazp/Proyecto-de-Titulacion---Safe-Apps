import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Accordion extends StatefulWidget {
  final String title;
  final String content;

  const Accordion({Key? key, required this.title, required this.content})
      : super(key: key);
  @override
  _AccordionState createState() => _AccordionState();
}

class _AccordionState extends State<Accordion> {
  bool _showContent = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(
          left: 30.0,
          right: 30.0,
          top: 15.0
      ),
      shape: RoundedRectangleBorder(side: BorderSide(color: Colors.white70, width: 1), borderRadius: BorderRadius.circular(20)),
      child: Column(children: [
        ListTile(
          title: Text(widget.title, style: TextStyle(fontSize: 16.0, fontFamily: "medium"),),
          trailing: IconButton(
            icon: Icon(
                _showContent ? CupertinoIcons.chevron_compact_up : CupertinoIcons.chevron_compact_down),
            onPressed: () {
              setState(() {
                _showContent = !_showContent;
              });
            },
          ),
        ),
        _showContent
            ? Container(
          padding:
          const EdgeInsets.symmetric(vertical: 15, horizontal: 14),
          child: Text(widget.content, style: TextStyle(fontSize: 16.0),),
        )
            : Container()
      ]),
    );
  }
}