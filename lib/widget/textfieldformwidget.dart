import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../const/const.dart';
import '../const/gobalcolor.dart';

class TextFieldFormWidget extends StatefulWidget {
  TextFieldFormWidget(
      {super.key,
        required this.hintText,
        required this.controller,
        this.autofocus = false,
        this.obscureText = false,
        this.isShowPassword = false,
        this.enable = true,
        this.textInputAction = TextInputAction.next,
        this.maxLines = 1,
        this.textInputType = TextInputType.text,
        required this.validator});
  final String hintText;
  final TextEditingController controller;
  final bool? autofocus;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final int? maxLines;
  final bool enable;
  bool? obscureText;
  final bool? isShowPassword;
  final String? Function(String?)? validator;

  @override
  State<TextFieldFormWidget> createState() => _TextFieldFormWidgetState();
}

class _TextFieldFormWidgetState extends State<TextFieldFormWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: mq.height * .012),
        child: TextFormField(
            controller: widget.controller,
            autofocus: widget.autofocus!,
            maxLines: widget.maxLines,
            validator: widget.validator,
            enabled: widget.enable,
            obscureText: widget.obscureText!,
            textInputAction: widget.textInputAction,
            keyboardType: widget.textInputType,
            style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: widget.enable
                    ? Theme
                    .of(context)
                    .primaryColor
                    : Colors.black54),
            decoration: InputDecoration(
              labelStyle: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              fillColor: searchColor,
              filled: true,
              hintText: widget.hintText,
              border: OutlineInputBorder(

                borderRadius: BorderRadius.circular(15),
              ),
              enabledBorder: OutlineInputBorder(

                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(

                borderRadius: BorderRadius.circular(15),
              ),
              suffixIcon: widget.isShowPassword!
                  ? IconButton(
                  onPressed: () {
                    widget.obscureText = !widget.obscureText!;
                    setState(() {});
                  },
                  icon: Icon(
                    Icons.password,
                    color: widget.obscureText! ? hintLightColor : red,
                  ))
                  : null,
              contentPadding: EdgeInsets.symmetric(
                  horizontal: mq.width * .033, vertical: mq.height * .025),
              hintStyle: const TextStyle(
                color: Color(0xffc8c8d5),
              ),
            )
        )
    );
  }
}