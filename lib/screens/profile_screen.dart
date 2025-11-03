import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF6a5acd), Color(0xFFff7f50)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.person, size: 100, color: Colors.grey), // Replaced image with icon
              SizedBox(height: 20),
              Text(
                'User Name',
                style: Theme.of(context).textTheme.headlineSmall, // Updated to headlineSmall
              ),
              SizedBox(height: 8),
              Text(
                'email@example.com',
                style: Theme.of(context).textTheme.bodyMedium, // Optional: update style for consistency
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Add logout or edit profile logic here
                },
                child: Text('Edit Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
