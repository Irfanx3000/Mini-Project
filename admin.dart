import 'package:flutter/material.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  bool isPasswordObscured = true;
  bool isConfirmObscured = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushNamed(context, 'landing');
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 70,
              backgroundColor: Colors.green[100],
              backgroundImage: const AssetImage('assets/qurb.jpg'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Admin Registration',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelStyle: TextStyle(
                        color: Colors.green,
                      ),
                      labelText: 'First Name',
                      filled: true,
                      fillColor: Colors.green[50],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelStyle: TextStyle(
                        color: Colors.green,
                      ),
                      labelText: 'Last Name',
                      filled: true,
                      fillColor: Colors.green[50],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            TextFormField(
              decoration: InputDecoration(
                labelStyle: TextStyle(
                  color: Colors.green,
                ),
                labelText: 'Email',
                filled: true,
                fillColor: Colors.green[50],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextFormField(
              obscureText: isPasswordObscured,
              decoration: InputDecoration(
                labelStyle: TextStyle(
                  color: Colors.green,),
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      isPasswordObscured = !isPasswordObscured;
                    });
                  },
                  child: Icon(
                    isPasswordObscured ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
                labelText: 'Password',
                filled: true,
                fillColor: Colors.green[50],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextFormField(
              obscureText: isConfirmObscured,
              decoration: InputDecoration(
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      isConfirmObscured = !isConfirmObscured;
                    });
                  },
                  child: Icon(
                    isConfirmObscured ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
                labelStyle: TextStyle(
                  color: Colors.green,),
                labelText: 'Confirm Password',
                filled: true,
                fillColor: Colors.green[50],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding:
                const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, 'Custom');
              },
              child: const Text(
                'Login',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
