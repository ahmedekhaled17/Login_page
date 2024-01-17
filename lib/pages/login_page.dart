import 'package:chat_app/constants.dart';
import 'package:chat_app/helpr/show_snak_bar.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../widgets/custom_button.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  static String id ='LoginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                const SizedBox(height: 75,),
                Image.asset('assets/images/scholar.png',
                  height: 100,
                ),
                const  Row(
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
                const SizedBox(height: 100,),
                const Row(
                  children: [
                      Text('LOGIN',
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
                  obscureText: true,
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
                        await LoginUser();
                        Navigator.pushNamed(context, ChatPage.id ,arguments: email);
                        //showSnackBar(context, 'success');

                      }on FirebaseAuthException catch(e){
                        if (e.code == 'user-not-found') {
                          showSnackBar(context,'user-not-found');
                        } else if (e.code == 'wrong-password') {
                          showSnackBar(context, 'wrong-password ');
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
                  title: 'Login',),
                const SizedBox(height:15 ,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("don't have an account ?",style: TextStyle(
                      color: Colors.white,
                    ),
                    ),
                    GestureDetector(
                      onTap: ()
                      {
                        Navigator.pushNamed(context, RegisterPage.id);
                      },
                      child:const Text("   Register",style: TextStyle(
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



  Future<void> LoginUser() async {
    UserCredential user =await  FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email!, password: password!);
  }
}
