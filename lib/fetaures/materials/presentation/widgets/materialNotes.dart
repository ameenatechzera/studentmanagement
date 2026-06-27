import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class MaterialNotesScreen extends StatefulWidget {
  final String noteData;
  const MaterialNotesScreen({super.key,required this.noteData});

  @override
  State<MaterialNotesScreen> createState() => _MaterialNotesScreenState();
}

class _MaterialNotesScreenState extends State<MaterialNotesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF4F6FB),
        appBar: AppBar(
          backgroundColor: const Color(0xFFF4F6FB),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            "Notes",
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 28.0),
            child:  Html(
              data:widget.noteData.isEmpty
                  ? 'No Description'
                  : widget.noteData,
              style: {
                "body": Style(
                  margin: Margins.zero,
                  padding: HtmlPaddings.zero,
                  fontSize: FontSize(12),
                  lineHeight: const LineHeight(1.7),
                  color: Colors.black,
                ),
              },
            )
            //Text(widget.noteData),
          )
        ],
      )

    );
  }
}
