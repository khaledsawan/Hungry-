import 'package:flutter/material.dart';


class InPutTextForm extends StatelessWidget {
  IconData icon;
  Color color;
  Color hintcolor;
  String hintText;
  bool isPassword;
  TextEditingController textEditingController;
  InPutTextForm(
      {Key? key,
        this.isPassword=false,
      required this.icon,
      required this.hintcolor,
      required this.hintText,
      required this.color,
      required this.textEditingController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      padding: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: const Border(left: BorderSide.none),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey[400]!,
                blurRadius: 8,
                spreadRadius: 1,
                offset: const Offset(0, 4),
                blurStyle: BlurStyle.normal)
          ]),
      child: TextFormField(
        obscureText: isPassword,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (v) {
          return null; // textEditingController.validateEmail(v!);
        },
        onSaved: (v) {
          //textEditingController.emailController != v;
        },
        controller: textEditingController,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(
                width: 1,
                color: Colors.white,
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(
                width: 1,
                color: Colors.white,
              )),
          hintText: hintText,
          hintStyle: TextStyle(color: hintcolor),
          prefixIcon: Icon(
            icon,
            color: color,
          ),
        ),
      ),
    );
  }
}
