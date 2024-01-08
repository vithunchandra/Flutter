import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/firebase_service/authentication.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  Authentication auth = Authentication();
  var emailInputController = TextEditingController();
  var passwordInputController = TextEditingController();
  var errorText = '';

  Future<void> insertfavorite() async {
    print("start insrt fav");
    FirebaseFirestore refbaru = FirebaseFirestore.instance;
    String uid = FirebaseAuth.instance.currentUser!.uid.toString();
    print("2");
    print(uid);
    DocumentReference ref = await refbaru.collection("favorite").add({
      'uid': "kenneth@gmail.com",
      'track': 3,
    });
    print("end insrt fav");
    return;
  }

  Future<void> login() async {
    String email = emailInputController.text;
    String password = passwordInputController.text;
    debugPrint(email);
    debugPrint(password);

    if(email.isEmpty || password.isEmpty){
      setState(() {
        errorText = 'Semua field harus diisi';
      });
      return;
    }

    User? user = await auth.signInWithEmailAndPassword(email, password);
    if(user == null){
      setState(() {
        errorText = 'Email atau password salah';
      });
      return;
    }

    setState(() {
      errorText = '';
    });

    if(!mounted) return;
    Navigator.pushReplacementNamed(context, '/homepage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("MyMusic"),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Center(
                child: Text(
                  "Signin",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 32,),
              TextField(
                controller: emailInputController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter your email"
                ),
              ),
              const SizedBox(height: 8,),
              TextField(
                controller: passwordInputController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter your password"
                ),
              ),
              const SizedBox(height: 24,),
              if(errorText != '') Center(
                child: Text(
                  errorText,
                  style: const TextStyle(
                    color: Colors.red
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.07,
                child: FilledButton(
                  onPressed: login,
                  style: FilledButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(4)
                          )
                      )
                  ),
                  child: const Text("Login"),
                ),
              ),

              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Tidak punya akun?"),
                    TextButton(
                      onPressed: (){
                        Navigator.pushReplacementNamed(context, '/signup');
                      },
                      child: const Text(
                        "Daftar Sekarang!",
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
