import 'package:chat_app/models/messages.dart';
import 'package:chat_app/widgets/chat_buble.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatPage extends StatelessWidget {
   ChatPage({Key? key}) : super(key: key);
static String id ='ChatApp';

   final _controller = ScrollController();


   CollectionReference messages = FirebaseFirestore.instance.collection(kMessagesCollection);
   TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
   var email =  ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(kCreatedAt,descending: true).snapshots(),
      builder: (context,snapshot){
        if(snapshot.hasData){
         List<Message> messageList =[];
          for(int i =0 ;i < snapshot.data!.docs.length; i++)
            {
              messageList.add(Message.fromJson(snapshot.data!.docs[i]));
            }
          return Scaffold(
            appBar: AppBar(
              backgroundColor:kPrimaryColor,
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/scholar.png',height: 60,),
                  const Text('Chat'),],
              ),
            ),
            body:Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: _controller,
                    itemCount: messageList.length,
                    itemBuilder: (context, index) {
                    return messageList[index].id ==email ? ChatBuble(
                      message: messageList[index],
                    ):ChatBubleForFriend(message: messageList[index]);
                  },),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (data)
                    {
                      messages.add({
                         kMessage:data,
                         kCreatedAt:DateTime.now(),
                        'id': email,
                      });
                      controller.clear();
                      _controller.animateTo(
                        0,
                        duration: const Duration(seconds: 1),
                        curve: Curves.fastOutSlowIn,
                      );
                    },
                    decoration: InputDecoration(
                      hintText: 'Send message',
                      suffixIcon:const Icon(
                        Icons.send,
                        color: kPrimaryColor,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16)
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide:const BorderSide(color: kPrimaryColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }else
        {
          return Scaffold(
            body: Center(child: Text('Loading ...',style: TextStyle(
              fontSize: 32,
            ),)),
          );
        }
      },

    );
  }
}


