import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CustomPage extends StatelessWidget {
  const CustomPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the 'clients' collection in Firestore
    final CollectionReference clientsCollection =
    FirebaseFirestore.instance.collection('clients');

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Registered Client Information',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: clientsCollection.orderBy('timestamp', descending: true).get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          // Show a loading indicator while fetching data
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Handle errors
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          // If no data is found
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('No registered clients found.'),
            );
          }

          // Data retrieved successfully, display it in a list
          final List<QueryDocumentSnapshot> clients = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(10.0),
            itemCount: clients.length,
            itemBuilder: (BuildContext context, int index) {
              final Map<String, dynamic> client =
              clients[index].data()! as Map<String, dynamic>;

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${client['first_name']} ${client['last_name']}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text('Email: ${client['email']}'),
                      Text('State: ${client['state'] ?? 'Not provided'}'),
                      Text('Amount: ${client['amount']}'),
                      Text('Members: ${client['members']}'),
                      Text(
                          'Qurbani Name: ${client['qurbani_name'] ?? 'Not provided'}'),
                      const SizedBox(height: 10),
                      Text(
                        'Registered on: ${client['timestamp'] != null ? (client['timestamp'] as Timestamp).toDate().toString() : 'Unknown'}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

