import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

Widget buildMemberCard(
  String name,
  String position,
  String imagePath,
  double avatarRadius,
  String linkedinUrl,
  String githubUrl,
) {
  return Container(
    decoration: BoxDecoration(
      color: Color(0xFF212325).withOpacity(0.8),
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
      ],
    ),
    padding: EdgeInsets.all(16),
    child: Column(
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
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          position,
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8),
        Row(
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
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 16), // Space between icons
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
    ),
  );
}
