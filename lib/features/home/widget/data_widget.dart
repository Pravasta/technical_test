import 'package:flutter/material.dart';

import '../../../constant/app_colors.dart';
import '../../../constant/app_text.dart';

class DataWidget extends StatelessWidget {
  const DataWidget({
    super.key,
    required this.name,
    required this.id,
    required this.email,
    required this.isVerified,
  });

  final String name;
  final String id;
  final String email;
  final String isVerified;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        elevation: 1,
        shadowColor: AppColors.blueColor,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.whiteSoftColor,
            borderRadius: BorderRadius.circular(10),
          ),
          width: double.infinity,
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name: $name',
                    style: AppText.text16.copyWith(
                      color: AppColors.blackColor,
                    ),
                  ),
                  Text(
                    'Email: $email',
                    style: AppText.text16.copyWith(
                      color: AppColors.blackColor,
                    ),
                  ),
                  Text(
                    'Uid: $id',
                    style: AppText.text16.copyWith(
                      color: AppColors.blackColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Text(
                  'IsVerified: $isVerified',
                  style: AppText.text16.copyWith(
                    color: AppColors.blackColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
