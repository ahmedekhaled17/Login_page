import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
   CustomButton({this.onTab,required this.title}) ;
   VoidCallback? onTab;
 String title;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTab ,
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Center(
          child: Text(title),
        ),
      ),
    );
  }
}