import 'package:flutter/material.dart';

import '../utility/constant.dart';

class TextFormWidget extends StatelessWidget {
  final String? initialValue;
  final Function(String)? onchanged;
  final int? minLines;
  final int? maxLines;
  final String? hintText;
  
  const TextFormWidget({
    Key? key,
    this.onchanged,
    this.initialValue,
    this.maxLines,
    this.minLines,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: maxLines ?? 1,
      maxLines: minLines ?? 1,
      onChanged: onchanged,
      initialValue: initialValue,
      decoration: InputDecoration(
        hintText: hintText,
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
          borderSide: BorderSide(
            color: kBlueColor,
            style: BorderStyle.solid,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
          borderSide: BorderSide(
            color: Colors.black,
            style: BorderStyle.solid,
          ),
        ),
      ),
    );
  }
}
