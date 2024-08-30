// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../core/theme/base_color.dart';

class text_box extends StatefulWidget {
  text_box(
      {super.key,
      required this.value,
      required this.title,
      required this.hint,
      this.height,
      this.obsureText,
      this.validator,
      this.keyboard,
      this.onChanged});

  final TextEditingController value;
  final String title;
  final String hint;
  final double? height;
  bool? obsureText;
  final String? Function(String?)? validator;
  final TextInputType? keyboard;
  final Function(String)? onChanged;

  @override
  State<text_box> createState() => _text_boxState();
}

class _text_boxState extends State<text_box> {
  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: widget.height,
          // decoration: BoxDecoration(
          //     border: Border.all(color: AppColors.primarycolor2, width: 1),
          //     borderRadius: BorderRadius.circular(8),
          //     color: Colors.white),
          child: TextFormField(
            maxLines: 1,
            onChanged: widget.onChanged,
            keyboardType: widget.keyboard,
            style:
                TextStyle(fontFamily: 'Roboto', color: AppColors.primarycolor2),
            controller: widget.value,
            validator: widget.validator,
            obscureText: widget.obsureText == true ? _obscureText : false,
            obscuringCharacter: '*',
            decoration: InputDecoration(
              suffixIcon: widget.obsureText == true
                  ? IconButton(
                      icon: Icon(
                        _obscureText == true
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: _toggle,
                    )
                  : null,
              // hintText: widget.hint,
              labelText: widget.hint,
              labelStyle: TextStyle(color: AppColors.primarycolor2),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primarycolor2)),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.primarycolor2),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
