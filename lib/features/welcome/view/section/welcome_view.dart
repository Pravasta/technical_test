import 'package:flutter/material.dart';
import 'package:technical_test/common/routes/app_routes.dart';
import 'package:technical_test/constant/app_colors.dart';
import 'package:technical_test/constant/app_text.dart';
import 'package:technical_test/constant/url_assets.dart';

import '../../../../widget/button/default_button.dart';
import '../../../login_register/view/login_page.dart';
import '../../../login_register/view/register_page.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 30),
        child: ListView(
          children: [
            Image.asset(
              UrlAsset.welcome,
              width: 300,
            ),
            const SizedBox(height: 53),
            Text(
              'Discover Your Dream Job here',
              textAlign: TextAlign.center,
              style: AppText.text24.copyWith(
                color: AppColors.blueColor,
                fontSize: 35,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 23),
            Text(
              'Explore all the existing job roles based on your\ninterest and study major',
              style: AppText.text16,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 88),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DefaultButtonWidget(
                  title: 'Login',
                  onTap: () {
                    AppRoutes.toAndRemove(const LoginPage());
                  },
                ),
                DefaultButtonWidget(
                  title: 'Register',
                  textColor: AppColors.blackColor,
                  backgroundColor: AppColors.whiteColor,
                  elevation: 0,
                  onTap: () {
                    AppRoutes.toAndRemove(const Registerpage());
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
