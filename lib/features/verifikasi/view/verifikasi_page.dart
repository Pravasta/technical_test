import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:technical_test/common/routes/app_routes.dart';
import 'package:technical_test/constant/app_colors.dart';
import 'package:technical_test/constant/app_text.dart';
import 'package:technical_test/features/login_register/view/login_page.dart';
import 'package:technical_test/widget/button/default_button.dart';

class VerificationPage extends StatelessWidget {
  const VerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Kami sudah mengirimkan email Verifikasi ke email anda',
              textAlign: TextAlign.center,
              style: AppText.text18.copyWith(
                color: AppColors.blackColor,
              ),
            ),
            const SizedBox(height: 20),
            DefaultButtonWidget(
              height: 50,
              width: double.infinity,
              title: 'Login Page',
              onTap: () {
                AppRoutes.toAndRemove(const LoginPage());
              },
            ),
            const SizedBox(height: 20),
            DefaultButtonWidget(
              height: 50,
              width: double.infinity,
              title: 'Send New Email Verification',
              backgroundColor: AppColors.whiteSoftColor,
              textColor: AppColors.blackColor,
              elevation: 1,
              onTap: () async {
                await FirebaseAuth.instance.currentUser!
                    .sendEmailVerification();
              },
            )
          ],
        )),
      ),
    );
  }
}
