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

/// 🔹 CARD
Widget buildCard({required Widget child}) {
  return Container(
    height: 100,
    padding: const EdgeInsets.symmetric(horizontal: 14),
    decoration: BoxDecoration(
      color: const Color(0xFFF8F8F9),
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          blurRadius: 16,
          offset: const Offset(0, 10),
        ),
      ],
    ),
    child: child,
  );
}

// /// 🔹 FAVORITE ICON
// Widget _favIcon(ValueNotifier<bool> isFav) {
//   return ValueListenableBuilder<bool>(
//     valueListenable: isFav,
//     builder: (_, value, __) {
//       return IconButton(
//         onPressed: () => isFav.value = !value,
//         icon: Icon(Icons.star, color: value ? Colors.yellow : Colors.grey),
//       );
//     },
//   );
// }
Widget favIcon(bool isFav) {
  return Icon(Icons.star, color: isFav ? Colors.yellow : Colors.grey);
}

/// 🔹 DOWNLOAD ICON
Widget downloadIcon() {
  return Container(
    height: 20,
    width: 20,
    decoration: BoxDecoration(
      color: const Color(0xFFC4005F),
      borderRadius: BorderRadius.circular(30),
    ),
    child: const Icon(Icons.download, size: 10, color: Colors.white),
  );
}

/// 🔹 ARROW ICON
Widget arrowIcon({VoidCallback? onTap}) {
  return Container(
    height: 25,
    width: 25,
    decoration: BoxDecoration(
      color: const Color(0xFFC4005F),
      borderRadius: BorderRadius.circular(30),
    ),
    child: IconButton(
      onPressed: onTap,
      icon: const Icon(Icons.arrow_forward_ios, size: 10, color: Colors.white),
    ),
  );
}

Widget leadingIcon(item) {
  /// 📄 PDF
  if (item.material != null && item.material.toString().isNotEmpty) {
    return Image.asset(
      'assets/icons/Group (1).png', // your PDF icon
      height: 40,
      width: 40,
    );
  }

  /// 🔗 LINK
  if (item.link != null && item.link.toString().isNotEmpty) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Icon(Icons.link, color: Colors.white),
    );
  }

  /// 📝 NOTES
  if (item.notes != null && item.notes.toString().isNotEmpty) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: const Color(0xFFADDFFF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Icon(Icons.note, color: Colors.black),
    );
  }

  return const SizedBox();
}
