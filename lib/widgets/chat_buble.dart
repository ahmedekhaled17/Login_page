import 'package:chat_app/constants.dart';
import 'package:chat_app/models/messages.dart';
import 'package:flutter/material.dart';

class ChatBuble extends StatelessWidget {
 const ChatBuble({Key? key,required this.message}) : super(key: key);

final Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin:const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
        padding:const EdgeInsets.only(left: 16,bottom: 32,top: 32,right: 32),
        decoration:const BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.only(topRight: Radius.circular(32),
            topLeft: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
        ),
        child: Text(message.message,style: TextStyle(
          color:Colors.white,
        ),
        ),
      ),
    );
  }
}

class ChatBubleForFriend extends StatelessWidget {
  const ChatBubleForFriend({Key? key,required this.message}) : super(key: key);

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin:const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
        padding:const EdgeInsets.only(left: 16,bottom: 32,top: 32,right: 32),
        decoration:const BoxDecoration(
          color: Color(0Xff006D84),
          borderRadius: BorderRadius.only(topRight: Radius.circular(32),
            topLeft: Radius.circular(32),
            bottomLeft: Radius.circular(32),
          ),
        ),
        child: Text(message.message,style: TextStyle(
          color:Colors.white,
        ),
        ),
      ),
    );
  }
}