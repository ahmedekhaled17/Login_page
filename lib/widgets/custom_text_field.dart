import 'package:flutter/material.dart';

class CustomFormTextField extends StatelessWidget {
   CustomFormTextField({this.onChange,this.hintText,this.obscureText=false});
 Function(String)? onChange;
  String? hintText;

  bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText!,
      validator: (data)
      {
        if (data!.isEmpty){
          return ' field is required';
        }
      },
      onChanged:onChange ,
      decoration: InputDecoration(
        hintText: hintText ,
        hintStyle:const TextStyle(
          color: Colors.white,
        ),
        enabledBorder:const OutlineInputBorder(
            borderSide:BorderSide(
              color: Colors.white,
            )
        ),
        border:const OutlineInputBorder(
            borderSide:BorderSide(
              color: Colors.white,
            )
        ),
      ),
    );
  }
}
