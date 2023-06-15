import 'package:coffee_shop/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isLargeScreen =
        screenSize.width > 600; // Adjust the threshold as needed

    final welcomeFontSize = isLargeScreen ? 40.0 : 25.0;
    final descriptionFontSize = isLargeScreen ? 16.0 : 12.0;
    final avatarRadius = isLargeScreen ? 60.0 : 40.0;

    return Scaffold(
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Welcome to Express O' ",
                  style: GoogleFonts.pacifico(
                    fontSize: welcomeFontSize,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  "Start Your Journey with Express O'",
                  style: TextStyle(
                    fontSize: descriptionFontSize,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Pacifico',
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildMemberCard(
                      'Melissa Aroryo',
                      'Frontend Developer',
                      'images/Melissa.jpg',
                      avatarRadius,
                    ),
                    buildMemberCard(
                      'Rafael Vega',
                      'Backend Developer',
                      'images/Rafael.jpeg',
                      avatarRadius,
                    ),
                    buildMemberCard(
                      'Yahdiel Saldaña',
                      'Backend Developer',
                      'images/Yahdiel.jpeg',
                      avatarRadius,
                    ),
                  ],
                ),
                SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WelcomeScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFE57734),
                    foregroundColor: Colors.white,
                    textStyle: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 50,
                    ),
                  ),
                  child: Text('Get Started'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildMemberCard(
    String name,
    String position,
    String imagePath,
    double avatarRadius,
  ) {
    return Column(
      children: [
        CircleAvatar(
          radius: avatarRadius,
          backgroundImage: Image.asset(
            imagePath,
            width: avatarRadius * 2,
            height: avatarRadius * 2,
            fit: BoxFit.cover,
          ).image,
        ),
        SizedBox(height: 8),
        Text(
          name,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Pacifico',
            color: Colors.white,
          ),
        ),
        Text(
          position,
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Pacifico',
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
