import 'package:coffee_shop/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isLargeScreen = screenSize.width > 600;

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
                SizedBox(height: MediaQuery.of(context).padding.top),
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    "Welcome to Express O'",
                    style: GoogleFonts.pacifico(
                      fontSize: welcomeFontSize,
                      color: Colors.white,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'images/coffee2.png',
                    width: 200,
                    height: 200,
                    fit: BoxFit.contain,
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 16),
                      Container(
                        padding: EdgeInsets.all(10.0), // internal padding
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.white,
                              width: 2.0), // color and width
                          borderRadius:
                              BorderRadius.circular(10.0), // corner radious
                          color: Color(0xFFE57734),
                        ),
                        child: Text(
                          "Effortless coffee at your fingertips: Order ahead and pick up your perfectly crafted brew from our online coffee shop, making your mornings hassle-free.",
                          style: GoogleFonts.poppins(
                            fontSize: descriptionFontSize,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buildMemberCard(
                            'Melissa Arroyo',
                            'Frontend Developer',
                            'images/Melissa.jpeg',
                            avatarRadius,
                            'https://github.com/MelissaAT',
                            'https://www.linkedin.com/in/melissa-arroyo-torres/',
                          ),
                          buildMemberCard(
                            'Rafael Vega',
                            'Backend Developer',
                            'images/Rafael.jpeg',
                            avatarRadius,
                            'https://github.com/rvegarodz',
                            'https://www.linkedin.com/in/rvegarodz/',
                          ),
                          buildMemberCard(
                            'Yahdiel Saldaña',
                            'Backend Developer',
                            'images/Yahdiel.jpeg',
                            avatarRadius,
                            'https://www.linkedin.com/in/yahdielsaldana/',
                            'https://github.com/yahdielo',
                          ),
                        ],
                      ),
                      SizedBox(height: 32),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WelcomeScreen()),
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
    String linkedinUrl,
    String githubUrl,
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
        SizedBox(height: 8),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () async {
                final uri = Uri.parse(linkedinUrl);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri);
                } else {
                  throw 'Could not launch $linkedinUrl';
                }
              },
              child: Column(
                children: [
                  Icon(
                    Icons.link, // Linkedin
                    color: Colors.white,
                  ),
                  SizedBox(height: 4),
                  Text(
                    "LinkedIn",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8), // Space between icons
            GestureDetector(
              onTap: () async {
                final uri = Uri.parse(githubUrl);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri);
                } else {
                  throw 'Could not launch $githubUrl';
                }
              },
              child: Column(
                children: [
                  Icon(
                    Icons.link, // github
                    color: Colors.white,
                  ),
                  SizedBox(height: 4),
                  Text(
                    "GitHub",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
