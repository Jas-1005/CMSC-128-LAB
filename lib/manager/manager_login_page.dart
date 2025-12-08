import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ManagerLoginPage extends StatefulWidget {
  const ManagerLoginPage({super.key});

  @override
  State<ManagerLoginPage> createState() => _ManagerLoginPageState();
}

class _ManagerLoginPageState extends State<ManagerLoginPage> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String errorMessage = '';
  bool _obscureText = true;
  bool _isLoading = false;

  Future <void> handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();
    setState(() => _isLoading = true);

    try {
      final user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: email.trim(),
        password:password,
      );

      if(!mounted) return;
      if(await isManager(user)) Navigator.pushReplacementNamed(context, '/manager-dashboard');
      if(await isTenant(user)) Navigator.pushReplacementNamed(context, '/tenant-dashboard');

    } on FirebaseAuthException catch (e){
      String displayMessage;
      if (e.code == 'network-request-failed'){
        displayMessage = 'Network error: Please check your internet connection.';
      } else if (e.code == 'user-not-found'){
        displayMessage = 'Your account does not e exist. Please create an account first.';
      } else if (e.code == 'wrong-password'){
        displayMessage = 'Please double check your password.';
      } else if (e.code == 'too-many-requests'){
        displayMessage = 'Too many failed login attempts. Please try again later.';
      } else {
        displayMessage = 'Login failed: ${e.message}'; // Generic message for other errors
      }

      if (!mounted) return;
      setState(() {
        errorMessage = displayMessage;
      });

      setState(() {
        errorMessage = displayMessage;
      });

    } catch(err) {
      if (!mounted) return;
      setState(() {
        errorMessage = 'An unexpected error occurred. Please try again.';
      });
    } finally {
      if (!mounted) return;
      setState(() => _isLoading = false);
    }
  }

  Future <bool> isTenant(user) async{
     final userIsTenantQuery = await FirebaseFirestore.instance
         .collection('users')
         .where(FieldPath.documentId, isEqualTo: user.uid)
         .where('role', isEqualTo: 'tenant')
         .get();
     return userIsTenantQuery.docs.isNotEmpty;
  }

  Future <bool> isManager(user) async{
    final userIsManagerQuery = await FirebaseFirestore.instance
        .collection('users')
        .where(FieldPath.documentId, isEqualTo: user.uid)
        .where('role', isEqualTo: 'manager')
        .get();
    return userIsManagerQuery.docs.isNotEmpty;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manager Login')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form (
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Enter email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Enter your email';
                  if (!value.contains('@') || !value.contains('.')) return 'Invalid email';
                  return null;
                },
                onSaved: (value) => email = value!,
              ),
              const SizedBox(height: 20),
              TextFormField(
                obscureText: _obscureText,
                decoration: InputDecoration(
                  labelText: 'Enter password',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
                    onPressed: () => setState(() => _obscureText = !_obscureText),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Enter your password';
                  return null;
                },
                onSaved: (value) => password = value!,
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _isLoading ? null : handleLogin,
                child: _isLoading
                    ? SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                )
                    : Text('LOG IN'),
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
              const SizedBox(height: 12),
              Text(
                  errorMessage,
                  style: const TextStyle(color: Colors.red)),
            ],
          ),
        ),
      ),
    );
  }
}