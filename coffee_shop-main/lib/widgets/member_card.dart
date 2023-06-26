import 'package:flutter/material.dart';
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
                    style: TextStyle(color: Colors.white),
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
