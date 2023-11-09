import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technical_test/constant/app_colors.dart';
import 'package:technical_test/features/login_register/view/login_page.dart';

import '../../../../common/routes/app_routes.dart';
import '../../../../common/validator/validator.dart';
import '../../../../constant/app_text.dart';
import '../../../../widget/button/default_button.dart';
import '../../../../widget/field/default_text_field.dart';
import '../../cubit/auth_cubit.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final emailC = TextEditingController(text: 'fitrayanaf11@gmail.com');

  @override
  void dispose() {
    super.dispose();
    emailC.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Place your Email',
                textAlign: TextAlign.center,
                style: AppText.text20.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 30),
              DefaultTextField(
                controller: emailC,
                hintText: 'Email',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Email tidak boleh kosong';
                  }
                  if (!Validator.isValidEmail(value)) {
                    return 'Email tidak valid';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              submmitButton(),
              const SizedBox(height: 30),
              DefaultButtonWidget(
                title: 'Login Page',
                onTap: () async {
                  AppRoutes.toAndRemove(const LoginPage());
                },
                width: double.infinity,
                backgroundColor: AppColors.whiteSoftColor,
                textColor: AppColors.blackColor,
                elevation: 2,
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget submmitButton() {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSucces) {
          AppRoutes.toAndRemove(const LoginPage());
        }
        if (state is AuthFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        if (state is AuthLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return DefaultButtonWidget(
          title: 'Reset Password',
          onTap: () async {
            if (_formKey.currentState!.validate()) {
              context.read<AuthCubit>().resetPassword(emailC.text);
            }
          },
          width: double.infinity,
          height: 50,
        );
      },
    );
  }
}
