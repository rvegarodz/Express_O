import 'package:coffee_shop/screens/welcome_screen.dart';
import 'package:coffee_shop/widgets/member_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';

class LandingPage extends StatelessWidget {
  final List<String> imageUrls = [
    'images/Welcome.png',
    'images/Signup.png',
    'images/Login.png',
    'images/Item.png',
    'images/Snackbar.png',
    'images/Orders.png',
  ];

  final Color primaryColor = Color(0xFFE57734);
  final Color secondaryColor = Color(0xFF212325);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isLargeScreen = screenSize.width > 600;

    final welcomeFontSize = isLargeScreen ? 70.0 : 40.0;
    final descriptionFontSize = isLargeScreen ? 40.0 : 30.0;
    final avatarRadius = isLargeScreen ? 60.0 : 40.0;
    final containersize = isLargeScreen ? 300.0 : 600.0;

    return Scaffold(
      body: Container(
        color: secondaryColor,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 100, horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start, // Aligns column
              crossAxisAlignment: CrossAxisAlignment.start, // Aligns children
              children: [
                Text(
                  "Welcome to Express O'",
                  style: GoogleFonts.pacifico(
                    fontSize: welcomeFontSize,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 100),
                Container(
                  height: containersize,
                  child: ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                        colors: [
                          Color(0xffffa014),
                          Color.fromARGB(255, 240, 238, 234)
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ).createShader(bounds);
                    },
                    child: Text(
                      "Effortless coffee at your fingertips: Order ahead and pick up your perfectly crafted brew from our online coffee shop, making your mornings hassle-free.",
                      style: GoogleFonts.poppins(
                        fontSize: descriptionFontSize,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                SizedBox(height: 100),
                LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    if (constraints.maxWidth > 600) {
                      // large screen: display in a row
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Preview Of Our Coffee Shop",
                                style: GoogleFonts.pacifico(
                                    fontSize: 80, color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 540,
                              child: CarouselSlider(
                                options: CarouselOptions(
                                  height: 540,
                                  autoPlay: true,
                                  enlargeCenterPage: true,
                                  aspectRatio: 16 / 9,
                                  autoPlayCurve: Curves.fastOutSlowIn,
                                  enableInfiniteScroll: true,
                                  autoPlayAnimationDuration:
                                      Duration(milliseconds: 800),
                                  viewportFraction: 0.8,
                                ),
                                items: imageUrls.map((url) {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          image: DecorationImage(
                                            image: AssetImage(url),
                                            fit: BoxFit.scaleDown,
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      // small screen: display in a column
                      return Column(
                        children: [
                          Text(
                            "Preview Of Our Coffee Shop",
                            style: GoogleFonts.pacifico(
                                fontSize: 24, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 50),
                          Container(
                            height: 540,
                            child: CarouselSlider(
                              options: CarouselOptions(
                                height: 540,
                                autoPlay: true,
                                enlargeCenterPage: true,
                                aspectRatio: 16 / 9,
                                autoPlayCurve: Curves.fastOutSlowIn,
                                enableInfiniteScroll: true,
                                autoPlayAnimationDuration:
                                    Duration(milliseconds: 800),
                                viewportFraction: 0.8,
                              ),
                              items: imageUrls.map((url) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        image: DecorationImage(
                                          image: AssetImage(url),
                                          fit: BoxFit.scaleDown,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
                SizedBox(height: 100),
                Column(
                  crossAxisAlignment: CrossAxisAlignment
                      .start, // This aligns children to the start (or left side)
                  children: [
                    Text(
                      'About',
                      style: GoogleFonts.pacifico(
                        fontSize: descriptionFontSize,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      height: containersize,
                      child: ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return LinearGradient(
                            colors: [
                              Color(0xffffa014),
                              Color.fromARGB(255, 240, 238, 234)
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ).createShader(bounds);
                        },
                        child: Text(
                          'Our project, Express O\', was inspired by our own experiences and a small coffee shop that we used to visit. We noticed that the coffee shop had a lot of potential, but the ordering and payment process could be made more efficient. That\'s when we decided to design a solution that would automate the ordering and payment process, while also providing the convenience of ordering ahead.',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            height: 1.5,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 1),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Our Team',
                    style: GoogleFonts.pacifico(
                      fontSize: descriptionFontSize,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 100),
                LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    if (constraints.maxWidth > 600) {
                      return Container(
                        child: Row(
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
                              'Yahdiel Saldaña',
                              'Backend Developer',
                              'images/Yahdiel.jpeg',
                              avatarRadius,
                              'https://www.linkedin.com/in/yahdielsaldana',
                              'https://github.com/yahdielo',
                            ),
                            buildMemberCard(
                              'Rafael Vega',
                              'Full Stack Developer',
                              'images/Rafael.jpeg',
                              avatarRadius,
                              'https://www.linkedin.com/in/rvegarodz/',
                              'https://github.com/rvegarodz',
                            ),
                          ],
                        ),
                      );
                    } else {
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
                            'Yahdiel Saldaña',
                            'Backend Developer',
                            'images/Yahdiel.jpeg',
                            avatarRadius,
                            'https://www.com/in/yahdielsaldana',
                            'https://github.com/yahdielo',
                          ),
                          SizedBox(height: 16),
                          buildMemberCard(
                            'Rafael Vega',
                            'Full Stack Developer',
                            'images/Rafael.jpeg',
                            avatarRadius,
                            'https://www.linkedin.com/in/rvegarodz/',
                            'https://github.com/rvegarodz',
                          ),
                        ],
                      );
                    }
                  },
                ),
                SizedBox(height: 100),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WelcomeScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Get Started',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(primaryColor),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
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
