import 'package:flutter/material.dart';

class AboutWidget extends StatelessWidget {
  const AboutWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         
          Text(
            'ATS Tech',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Sale Safe: Version: 1.0.0',
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(height: 16.0),
          Text(
            'Contact Us',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Phone: +233542857029',
            style: TextStyle(fontSize: 16.0),
          ),
          Text(
            'Email: atarqiudeen@gmail.com',
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(height: 16.0),
          Text(
            'ATS Tech is a software development company specializing in creating innovative and user-friendly applications for businesses and individuals. With a team of experienced developers and designers, we strive to deliver high-quality solutions tailored to our clients\' needs.',
            style: TextStyle(fontSize: 16.0),
          ),
         
        ],
      ),
    );
  }
}