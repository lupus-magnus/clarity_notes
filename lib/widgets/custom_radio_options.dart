import 'package:flutter/material.dart';

class CustomRadioOptions extends StatelessWidget {
  final String labelField;
  final String valueField;
  final String groupValue;
  final List<dynamic> options;
  final Function onChange;

  const CustomRadioOptions(
      {super.key,
      required this.options,
      required this.labelField,
      required this.groupValue,
      required this.onChange,
      required this.valueField});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: 168,
        child: ListView(
            children: options
                .map(
                  (option) => (Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(4)),
                        child: RadioListTile(
                            value: option[valueField],
                            activeColor: Colors.black,
                            groupValue: groupValue,
                            onChanged: (value) {
                              onChange(value);
                            },
                            title: Text(option[labelField])),
                      ))),
                )
                .toList()));
  }
}
