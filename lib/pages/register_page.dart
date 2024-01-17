import 'package:chat_app/constants.dart';
import 'package:chat_app/helpr/show_snak_bar.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../widgets/custom_button.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

 static String id ='RegisterPage';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
 String? email;

 String? password;

 bool isLoading =false;

 GlobalKey<FormState>formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor:kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Form(
            key:formKey,
            child: ListView(
              children: [
                SizedBox(height: 75,),
                Image.asset('assets/images/scholar.png',
                height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Scholar Chat',
                      style:TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontFamily: 'Pacifico',
                      ) ,
                    ),
                  ],
                ),
                SizedBox(height: 100,),
                Row(
                  children:const [
                    Text('Register',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomFormTextField(
                  onChange: (data)
                  {
                    email =data;
                  },

                  hintText: 'Email',
                ),
                const SizedBox(height:10 ,),
                CustomFormTextField(
                  onChange: (data)
                  {
                    password =data;
                  },
                  hintText: 'Password',
                ),
                const SizedBox(height:20 ,),
                 CustomButton(
                   onTab: ()async
                   {
                     if (formKey.currentState!.validate()) {
                       isLoading = true;
                       setState(() {

                       });
                       try{
                         await registerUser();
                         Navigator.pushNamed(context, ChatPage.id);
                       //  showSnackBar(context, 'success');

                       }on FirebaseAuthException catch(e){
                         if (e.code == 'weak-password') {
                           showSnackBar(context,'weak password');
                         } else if (e.code == 'email-already-in-use') {
                          showSnackBar(context, 'email already exists ');
                         }
                       }catch(e){
                         showSnackBar(context, 'there was an error ');
                       }
                       isLoading = false;
                       setState(() {

                       });

                     }else
                       {

                       }
                   },
                   title: 'Register',),
                const SizedBox(height:15 ,),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("already have an account ?",style: TextStyle(
                      color: Colors.white,
                    ),
                    ),
                    GestureDetector(
                      onTap: ()
                      {
                        Navigator.pop(context);
                      },
                      child: Text("   LOGIN",style: TextStyle(
                        color: Color(0XFFC7EDE6),
                      ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Future<void> registerUser() async {
    UserCredential user =await  FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email!, password: password!);
  }
}
