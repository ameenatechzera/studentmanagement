import 'package:flutter/material.dart';
import 'package:studentmanagement/fetaures/classdiary/presentation/screens/alldiary_screen.dart';

Widget radioItem(BuildContext context, String text, String groupValue) {
  return RadioListTile<String>(
    value: text,
    groupValue: groupValue,
    dense: true,
    title: Text(text),
    activeColor: const Color(0xFFC4005F),
    contentPadding: EdgeInsets.zero,
    onChanged: (val) {
      selectedSubject.value = val!;
      Navigator.pop(context);
    },
  );
}
