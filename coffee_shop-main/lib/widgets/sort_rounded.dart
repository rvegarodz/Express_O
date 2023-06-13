import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color(0xFF212325),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 80, // Set this to whatever height you want.
              decoration: BoxDecoration(
                color: Color(0xFFE57734),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'User Options',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.account_circle,
                  color: Colors.white), // Set icon color
              title: Text('Profile',
                  style: TextStyle(color: Colors.white)), // Set text color
              onTap: () {
                // Handle profile tap
              },
            ),
            ListTile(
              leading:
                  Icon(Icons.settings, color: Colors.white), // Set icon color
              title: Text('Settings',
                  style: TextStyle(color: Colors.white)), // Set text color
              onTap: () {
                // Handle settings tap
              },
            ),
            ListTile(
              leading:
                  Icon(Icons.logout, color: Colors.white), // Set icon color
              title: Text('Sign Out',
                  style: TextStyle(color: Colors.white)), // Set text color
              onTap: () {
                // Handle sign out tap
              },
            ),
          ],
        ),
      ),
    );
  }
}
