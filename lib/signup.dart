import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/firebase_service/authentication.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  Authentication auth = Authentication();

  var emailInputController = TextEditingController();
  var passwordInputController = TextEditingController();
  var confirmPasswordInputController = TextEditingController();
  var nameInputController = TextEditingController();
  var errorText = '';

  void register() async {
    String email = emailInputController.text;
    String name = nameInputController.text;
    String password = passwordInputController.text;
    String confirmPassword = confirmPasswordInputController.text;

    if(email == '' || password == '' || confirmPassword == '' || name == ''){
      setState(() {
        errorText = 'Semua field wajib diisi';
      });
    }else{
      User? user = await auth.signUpWithEmailAndPassword(email, password);
      if(user == null){
        setState(() {
          errorText = 'Input invalid';
        });
      }else{
        setState(() {
          errorText = '';
        });
        if(!mounted) return;
        Navigator.pushReplacementNamed(context, '/homepage');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MyMusic"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(
              child: Text(
                "Signup",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
            ),
            SizedBox(height: 32,),
            TextField(
              controller: emailInputController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter your email"
              ),
            ),
            SizedBox(height: 8,),
            TextField(
              controller: nameInputController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter your name"
              ),
            ),
            SizedBox(height: 8,),
            TextField(
              controller: passwordInputController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter your password"
              ),
            ),
            SizedBox(height: 8,),
            TextField(
              controller: confirmPasswordInputController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter confirm password"
              ),
            ),
            SizedBox(height: 24,),
            if(errorText != '') Center(
              child: Text(
                errorText,
                style: TextStyle(
                    color: Colors.red
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.07,
              child: FilledButton(
                onPressed: register,
                style: FilledButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                        Radius.circular(4)
                    )
                  )
                ),
                child: const Text("Register"),
              ),
            ),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Tidak punya akun?"),
                  TextButton(
                    onPressed: (){
                      Navigator.pushReplacementNamed(context, '/signin');
                    },
                    child: const Text(
                      "Signin",
                      style: TextStyle(
                          color: Colors.blueAccent
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}
