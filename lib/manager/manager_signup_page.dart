import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ManagerSignupPage extends StatefulWidget {
  const ManagerSignupPage({super.key});

  @override
  State<ManagerSignupPage> createState() => _ManagerSignupPageState();
}

class _ManagerSignupPageState extends State<ManagerSignupPage> {
  // Controllers to get text from input fields
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController boardingHouseNameController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();


  String errorMessage = '';
  bool _obscureText = true;

  void handleSignup() {
    final fullName = fullNameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final boardingHouseName = boardingHouseNameController.text.trim();
    final contactNumber = contactNumberController.text.trim();

    // Simple signup logic for now
    if (fullName.isEmpty || email.isEmpty || password.isEmpty || boardingHouseName.isEmpty || contactNumber.isEmpty) {
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please complete all fields.")));
      setState(() {
        errorMessage = 'Please complete all fields';
      });
    } else {
      try {
        FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password:password).then((value){
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
      appBar: AppBar(title: const Text('Create Manager Account')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: fullNameController,
              decoration: const InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
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
            TextField(
              controller: boardingHouseNameController,
              decoration: const InputDecoration(
                labelText: 'Boarding House Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: contactNumberController,
              decoration: const InputDecoration(
                labelText: 'Contact Number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: handleSignup,
              child: const Text('SIGN UP'),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [
                const Text("Already have an account?"),
                InkWell(
                    onTap: (){
                      Navigator.pushReplacementNamed(context, '/manager-login');
                    },

                    child: const Text(
                        "Log in here",
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