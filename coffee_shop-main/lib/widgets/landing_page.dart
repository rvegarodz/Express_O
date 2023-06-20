import 'package:coffee_shop/screens/welcome_screen.dart';
import 'package:coffee_shop/widgets/member_card.dart';
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
        child: SingleChildScrollView(
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
                SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 16),
                      Container(
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
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
                          Flexible(
                            flex: 1,
                            child: buildMemberCard(
                              'Melissa Arroyo',
                              'Frontend Developer',
                              'images/Melissa.jpeg',
                              avatarRadius,
                              'https://github.com/MelissaAT',
                              'https://www.linkedin.com/in/melissa-arroyo-torres/',
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: buildMemberCard(
                              'Rafael Vega',
                              'Backend Developer',
                              'images/Rafael.jpeg',
                              avatarRadius,
                              'https://github.com/rvegarodz',
                              'https://www.linkedin.com/in/rvegarodz/',
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: buildMemberCard(
                              'Yahdiel Saldaña',
                              'Backend Developer',
                              'images/Yahdiel.jpeg',
                              avatarRadius,
                              'https://www.linkedin.com/in/yahdielsaldana',
                              'https://github.com/yahdielo',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 32),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WelcomeScreen(),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 50,
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xFFE57734),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'Get Started',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
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
}
