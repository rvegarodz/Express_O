import 'package:coffee_shop/screens/welcome_screen.dart';
import 'package:coffee_shop/widgets/member_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';

class LandingPage extends StatelessWidget {
  final List<String> imageUrls = [
    'images/welcome.jpeg',
    'images/SingUp.jpeg',
    'images/LogIn.jpeg',
    'images/Item.jpeg',
    'images/Snackbar.jpeg',
    'images/Orders.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isLargeScreen = screenSize.width > 600;

    final welcomeFontSize = isLargeScreen ? 40.0 : 30.0;
    final descriptionFontSize = isLargeScreen ? 16.0 : 12.0;
    final avatarRadius = isLargeScreen ? 60.0 : 40.0;

    return Scaffold(
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 100, bottom: 40),
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
                SizedBox(height: 50), // Increased from 16 to 50
                Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Color(0xFF212325),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.6),
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                      "Effortless coffee at your fingertips: Order ahead and pick up your perfectly crafted brew from our online coffee shop, making your mornings hassle-free.",
                      style: GoogleFonts.poppins(
                          fontSize: descriptionFontSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.white.withOpacity(0.8)),
                      textAlign: TextAlign.center),
                ),
                SizedBox(
                    height:
                        100), // Increased the height from 32 to 48 for more space
                Text(
                  "Preview Of Our Coffee Shop",
                  style: GoogleFonts.pacifico(
                      fontSize: 25, // Set a suitable font size for the heading
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                    height:
                        80), // Added another SizedBox for space between the heading and the slideshow
                Container(
                  height: 540, // Set the desired height for the image slideshow
                  width: 600, // Set the desired width for the image slideshow
                  child: CarouselSlider(
                    options: CarouselOptions(
                      height:
                          540, // Set the height to match the container height
                      autoPlay: true,
                      enlargeCenterPage: true,
                      aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      viewportFraction: 0.8,
                    ),
                    items: imageUrls.map((url) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image: AssetImage(url),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 100), // Add a SizedBox for space
                Container(
                  margin: EdgeInsets.symmetric(vertical: 16),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color(0xFF212325),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.6),
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        'About',
                        style: GoogleFonts.pacifico(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(
                        'Our project, Express O\', was inspired by our own experiences and a small coffee shop that we used to visit. We noticed that the coffee shop had a lot of potential, but the ordering and payment process could be made more efficient. That\'s when we decided to design a solution that would automate the ordering and payment process, while also providing the convenience of ordering ahead.',
                        style: TextStyle(
                            fontSize: descriptionFontSize,
                            fontWeight: FontWeight.bold,
                            color: Colors.white.withOpacity(0.8)),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 32),
                      Text(
                        'Our Team',
                        style: GoogleFonts.pacifico(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 100),
                      LayoutBuilder(
                        builder:
                            (BuildContext context, BoxConstraints constraints) {
                          if (constraints.maxWidth > 600) {
                            // If screen width is greater than 600, show in a row
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                buildMemberCard(
                                  'Melissa Arroyo',
                                  'Frontend Developer',
                                  'images/Melissa.jpeg',
                                  avatarRadius,
                                  'https://www.linkedin.com/in/melissa-arroyo-torres/',
                                  'https://github.com/MelissaAT',
                                ),
                                buildMemberCard(
                                  'Rafael Vega',
                                  'Backend Developer',
                                  'images/Rafael.jpeg',
                                  avatarRadius,
                                  'https://www.linkedin.com/in/rvegarodz/',
                                  'https://github.com/rvegarodz',
                                ),
                                buildMemberCard(
                                  'Yahdiel Saldaña',
                                  'Backend Developer',
                                  'images/Yahdiel.jpeg',
                                  avatarRadius,
                                  'https://www.linkedin.com/in/yahdielsaldana',
                                  'https://github.com/yahdielo',
                                ),
                              ],
                            );
                          } else {
                            // If screen width is less than or equal to 600, show in a column
                            return Column(
                              children: [
                                buildMemberCard(
                                  'Melissa Arroyo',
                                  'Frontend Developer',
                                  'images/Melissa.jpeg',
                                  avatarRadius,
                                  'https://www.linkedin.com/in/melissa-arroyo-torres/',
                                  'https://github.com/MelissaAT',
                                ),
                                SizedBox(height: 16),
                                buildMemberCard(
                                  'Rafael Vega',
                                  'Backend Developer',
                                  'images/Rafael.jpeg',
                                  avatarRadius,
                                  'https://www.linkedin.com/in/rvegarodz/',
                                  'https://github.com/rvegarodz',
                                ),
                                SizedBox(height: 16),
                                buildMemberCard(
                                  'Yahdiel Saldaña',
                                  'Backend Developer',
                                  'images/Yahdiel.jpeg',
                                  avatarRadius,
                                  'https://www.linkedin.com/in/yahdielsaldana',
                                  'https://github.com/yahdielo',
                                ),
                              ],
                            );
                          }
                        },
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
