import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:qurban/Custom.dart';

class ClientPage extends StatefulWidget {
  const ClientPage({super.key});
  @override
  State<ClientPage> createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  final List<String> states = [
    'Andhra Pradesh',
    'Arunachal Pradesh',
    'Assam',
    'Bihar',
    'Chhattisgarh',
    'Goa',
    'Gujarat',
    'Haryana',
    'Himachal Pradesh',
    'Jharkhand',
    'Karnataka',
    'Kerala',
    'Madhya Pradesh',
    'Maharashtra',
    'Manipur',
    'Meghalaya',
    'Mizoram',
    'Nagaland',
    'Odisha',
    'Punjab',
    'Rajasthan',
    'Sikkim',
    'Tamil Nadu',
    'Telangana',
    'Tripura',
    'Uttarakhand',
    'Uttar Pradesh',
    'West Bengal',
  ];

  String? selectedState;
  bool isPasswordObscured = true;
  bool isConfirmObscured = true;
  bool isChecked = false;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController membersController = TextEditingController();
  final TextEditingController qurbaniNameController = TextEditingController();
  final TextEditingController registerController = TextEditingController();
  @override
  void initState(){
    super.initState();
    setupFCM();
  }
  void setupFCM() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("User granted permission for notifications");
    } else {
      print("User declined or has not accepted notifications");
    }
  }
  // Function to save data to Firestore
  Future<void> saveClientData() async {
    print('Pressed');
    if (!isChecked) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please accept the terms and conditions'),
        ),
      );
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Passwords do not match'),
        ),
      );
      return;
    }

    try {
      // Reference Firestore
      final FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Save data
      await firestore.collection('clients').add({
        'first_name': firstNameController.text,
        'last_name': lastNameController.text,
        'email': emailController.text,
        'state': selectedState,
        'amount': amountController.text,
        'members': membersController.text,
        'qurbani_name': qurbaniNameController.text,
        'register':registerController.text,
        'timestamp': FieldValue.serverTimestamp(),
      });
      await FirebaseMessaging.instance.subscribeToTopic('registrations');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registration successful!'),
        ),
      );
      // Navigate to the next page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CustomPage()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_sharp, color: Colors.black),
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
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 70,
              backgroundColor: Colors.green[100],
              backgroundImage: const AssetImage('assets/qurb.jpg'),
            ),
            const Text(
              'Client Registration',
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
                    controller: firstNameController,
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
                    controller: lastNameController,
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
              controller: emailController,
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
              controller: passwordController,
              obscureText: isPasswordObscured,
              decoration: InputDecoration(
                labelStyle: TextStyle(
                  color: Colors.green,
                ),
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      isPasswordObscured = !isPasswordObscured;
                    });
                  },
                  child: Icon(
                    isPasswordObscured
                        ? Icons.visibility
                        : Icons.visibility_off,
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
              controller: confirmPasswordController,
              obscureText: isConfirmObscured,
              decoration: InputDecoration(
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      isConfirmObscured = !isConfirmObscured;
                    });
                  },
                  child: Icon(
                    isConfirmObscured
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                ),
                labelStyle: TextStyle(
                  color: Colors.green,
                ),
                labelText: 'Confirm Password',
                filled: true,
                fillColor: Colors.green[50],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 15),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelStyle: TextStyle(
                  color: Colors.green,
                ),
                labelText: 'State',
                filled: true,
                fillColor: Colors.green[50],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
              value: selectedState,
              onChanged: (String? newValue) {
                setState(() {
                  selectedState = newValue;
                });
              },
              items: states.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: amountController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.currency_rupee),
                labelStyle: TextStyle(
                  color: Colors.green,
                ),
                labelText: 'Amount',
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
              controller: membersController,
              decoration: InputDecoration(
                labelStyle: TextStyle(
                  color: Colors.green,
                ),
                labelText: 'Calculations for Members',
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
              controller: qurbaniNameController,
              decoration: InputDecoration(
                labelStyle: TextStyle(
                  color: Colors.green,
                ),
                labelText: 'Qurbani Name',
                filled: true,
                fillColor: Colors.green[50],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Payment Option',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
                children: [
                  TextSpan(
                    text: 'Note: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                      text:
                      'You will receive an update via email or message regarding payment confirmation and status.'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Checkbox(
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value ?? false;
                    });
                  },
                  activeColor: Colors.green,
                ),
                const Expanded(
                  child: Text(
                    'I accept all terms and condition and also payment conditions. ',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[400],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 10,
                ),
              ),
              onPressed: saveClientData,
              child: const Text(
                'Register',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}