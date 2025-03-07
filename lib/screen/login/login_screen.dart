import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:valbury_test/widget/input_field.dart';
import 'package:valbury_test/widget/universal_validator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Image.asset('assets/images/waves.jpg', fit: BoxFit.cover),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                padding: EdgeInsets.all(20),
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 6,
                      offset: Offset(1, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(color: Colors.grey, offset: Offset(0, 4), blurRadius: 3),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          'assets/images/valbury.jpg',
                          height: 50,
                          width: 50,
                        ),
                      ),
                    ),
                    Spacer(),
                    TextField(
                      controller: TextEditingController(),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        labelText: 'Username',
                        labelStyle: GoogleFonts.montserrat(),
                      ),
                      onChanged: (text) {
                        setState(() {});
                      },
                    ),
                    Container(height: 20),
                    TextField(
                      controller: TextEditingController(),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        labelText: 'Password',
                        labelStyle: GoogleFonts.montserrat(),
                      ),
                      onChanged: (text) {
                        setState(() {});
                      },
                    ),
                    Container(height: 15),
                    TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        padding: WidgetStateProperty.resolveWith((state) {
                          return EdgeInsets.symmetric(
                            horizontal: 60,
                            vertical: 10,
                          );
                        }),
                        backgroundColor: WidgetStateProperty.resolveWith((
                          state,
                        ) {
                          return Colors.blueAccent;
                        }),
                        foregroundColor: WidgetStateProperty.resolveWith((
                          state,
                        ) {
                          return Colors.white;
                        }),
                      ),
                      child: Text('Login', style: GoogleFonts.montserrat()),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset('assets/images/valbury_2.jpeg', height: 75),
            ),
          ],
        ),
      ),
    );
  }
}
