import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccYearDropdown extends StatefulWidget {
  final List<String> accYears;
  final String? initialValue;
  final ValueChanged<String?>? onChanged;

  const AccYearDropdown({
    super.key,
    required this.accYears,
    this.initialValue,
    this.onChanged,
  });

  @override
  State<AccYearDropdown> createState() => _AccYearDropdownState();
}

class _AccYearDropdownState extends State<AccYearDropdown> {
  String? _selectedYear;

  @override
  void initState() {
    super.initState();
    _selectedYear = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Theme(
        data: Theme.of(context).copyWith(
          focusColor: Colors.white,
          canvasColor: Colors.white,
        ),
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButtonFormField<String>(
            value: _selectedYear,
            hint: const Text('Select Account Year'),
            dropdownColor: Colors.white,
            focusColor: Colors.white,
            isExpanded: true,
            decoration: InputDecoration(
              labelText: 'Account Year',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
            items: widget.accYears.map((year) {
              return DropdownMenuItem(
                value: year,
                child: Text(year),
              );
            }).toList(),
            selectedItemBuilder: (context) {
              return widget.accYears.map((year) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    year,
                    style: const TextStyle(color: Colors.black),
                  ),
                );
              }).toList();
            },
            onChanged: (value) {
              setState(() => _selectedYear = value);
              widget.onChanged?.call(value);
            },
          ),
        ),
      ),
    );
  }
}