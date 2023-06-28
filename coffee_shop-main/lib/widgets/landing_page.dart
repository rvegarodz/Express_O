import 'package:coffee_shop/screens/welcome_screen.dart';
import 'package:coffee_shop/widgets/member_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';

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
                SizedBox(height: 16),
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
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 32),
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
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Our project, Express O\', was inspired by our own experiences and a small coffee shop that we used to visit. We noticed that the coffee shop had a lot of potential, but the ordering and payment process could be made more efficient. That\'s when we decided to design a solution that would automate the ordering and payment process, while also providing the convenience of ordering ahead.\n\nThis project is a Portfolio Project for Holberton School, where we are honing our skills in software development. It allowed us to apply our knowledge and creativity to create a seamless coffee shop experience. We are proud to present Express O\', a platform that brings together the love for coffee and the power of technology.',
                        style: TextStyle(
                            fontSize: descriptionFontSize,
                            fontWeight: FontWeight.bold,
                            color: Colors.white.withOpacity(0.8)),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () async {
                          final url = Uri.parse(
                              'https://holbertonschoolpr.com/?utm_source=google&utm_medium=conversions&utm_campaign=google_search&utm_id=google_search&gad=1&gclid=EAIaIQobChMI5qCrzqPh_wIVEHmGCh3daQ1WEAAYASAAEgJNLfD_BwE');
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFE57734),
                          padding: EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 50,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Holberton School',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: descriptionFontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
                              'https://www.linkedin.com/in/melissa-arroyo-torres/',
                              'https://github.com/MelissaAT',
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: buildMemberCard(
                              'Rafael Vega',
                              'Backend Developer',
                              'images/Rafael.jpeg',
                              avatarRadius,
                              'https://www.linkedin.com/in/rvegarodz/',
                              'https://github.com/rvegarodz',
                            ),
                          ),
                        ],
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
