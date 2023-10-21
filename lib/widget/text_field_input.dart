import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType type;
  final String hintText;
  final bool isPassword;
  const TextFieldInput(
      {Key? key,
      required this.controller,
      required this.type,
      this.isPassword=false,
      required this.hintText}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:25),
      child: Container(   
        padding: EdgeInsets.all(8),     
        decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xFFD5BDAF)
          )
        ),
        child: TextFormField(
          controller: controller,
          keyboardType: type,
          decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none
          ),
          obscureText: isPassword,
        ),
      ),
    );
  }
}
