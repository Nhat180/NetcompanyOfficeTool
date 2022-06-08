import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class LandScape extends StatelessWidget {
  const LandScape({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: FadeInDown(
                  delay: const Duration(microseconds: 500),
                  child: Text("Please return your phone to portrait mode",
                      style: GoogleFonts.oxygen(
                        fontWeight : FontWeight.w400,
                        fontSize: 33,
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.height / 3,
                  child: FadeInDown(
                    delay: const Duration(milliseconds: 1000),
                    child: Lottie.network(
                        "https://assets7.lottiefiles.com/packages/lf20_vkga8sgg.json", animate: true)
                  ),
                )
              )
            ],
          ),
        )
    );
  }
}
