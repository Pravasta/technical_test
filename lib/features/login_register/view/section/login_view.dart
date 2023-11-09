import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technical_test/common/routes/app_routes.dart';
import 'package:technical_test/constant/app_colors.dart';
import 'package:technical_test/constant/app_text.dart';
import 'package:technical_test/features/home/view/home_page.dart';
import 'package:technical_test/features/login_register/view/forget_password_page.dart';
import 'package:technical_test/features/login_register/view/register_page.dart';
import 'package:technical_test/widget/button/default_button.dart';
import 'package:technical_test/widget/field/default_text_field.dart';

import '../../../../common/validator/validator.dart';
import '../../cubit/auth_cubit.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final emailC = TextEditingController();
  final passC = TextEditingController();

  bool isShow = false;

  @override
  void dispose() {
    super.dispose();
    emailC.clear();
    passC.clear();
  }

  @override
  Widget build(BuildContext context) {
    header() {
      return Column(
        children: [
          Text(
            'Login here',
            style: AppText.text24.copyWith(
              color: AppColors.blueColor,
              fontWeight: FontWeight.w700,
              fontSize: 30,
            ),
          ),
          const SizedBox(height: 26),
          Text(
            'Welcome back you’ve\n been missed!',
            textAlign: TextAlign.center,
            style: AppText.text20.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 74),
        ],
      );
    }

    textField() {
      return Form(
        key: _formKey,
        child: Column(
          children: [
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
            DefaultTextField(
              controller: passC,
              hintText: 'Password',
              isObscure: isShow ? false : true,
              suffixWidget: IconButton(
                onPressed: () {
                  setState(() {
                    isShow = !isShow;
                  });
                },
                icon: Icon(
                  isShow ? Icons.remove_red_eye_outlined : Icons.remove_red_eye,
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Password tidak boleh kosong';
                }
                if (!Validator.isValidPassword(value)) {
                  return 'Password tidak valid';
                }
                return null;
              },
            ),
            const SizedBox(height: 30),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  AppRoutes.to(const ForgetPasswordPage());
                },
                child: Text(
                  'Forgot your password?',
                  style: AppText.text14.copyWith(
                    color: AppColors.blueColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            submmitButton(),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                AppRoutes.toAndRemove(const Registerpage());
              },
              child: Text(
                'Create new account',
                style: AppText.text14.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 31, vertical: 70),
      child: ListView(
        children: [
          header(),
          textField(),
        ],
      ),
    );
  }

  Widget submmitButton() {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSucces) {
          AppRoutes.toAndRemove(const HomePage());
        }
        if (state is AuthFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        return DefaultButtonWidget(
          title: 'Sign in',
          onTap: () {
            if (_formKey.currentState!.validate()) {
              context.read<AuthCubit>().singIn(
                    email: emailC.text,
                    password: passC.text,
                  );
            }
          },
          width: double.infinity,
          height: 50,
        );
      },
    );
  }
}
