import 'package:flutter/material.dart';

Widget dot({required bool isActive}) {
  return Container(
    width: isActive ? 10 : 8,
    height: isActive ? 10 : 8,
    decoration: BoxDecoration(
      color: isActive ? const Color(0xFFC4005F) : Colors.grey.shade400,
      shape: BoxShape.circle,
    ),
  );
}
