import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class ManagerLoginPage extends StatefulWidget {
  const ManagerLoginPage({super.key});

  @override
  State<ManagerLoginPage> createState() => _ManagerLoginPageState();
}

class _ManagerLoginPageState extends State<ManagerLoginPage> {
  // Controllers to get text from input fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String errorMessage = '';
  bool _obscureText = true;

  void handleLogin() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();



    // Simple login logic for now
    if (email.isEmpty || password.isEmpty) {
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please complete all fields.")));
      setState(() {
        errorMessage = 'Invalid manager email or password';
      });
    } else {
      try {
        FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password:password).then((value){
          Navigator.pushReplacementNamed(context, '/manager-dashboard');
        });
      } catch(err){
        print(err);
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manager Login')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              obscureText: _obscureText, // hides password input
              decoration: InputDecoration(
                labelText: 'Password',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText; // toggle visibility
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: handleLogin,
              child: const Text('LOG IN'),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [
                const Text("Don't have an account yet?"),
                InkWell(
                    onTap: (){
                      Navigator.pushReplacementNamed(context, '/manager-signup');
                    },

                    child: const Text(
                        "Sign up here",
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        )
                    )
                ),
              ],
            ),
            Text(
              errorMessage,
              style: const TextStyle(color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}