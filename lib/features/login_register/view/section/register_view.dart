import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technical_test/common/routes/app_routes.dart';
import 'package:technical_test/common/validator/validator.dart';
import 'package:technical_test/constant/app_colors.dart';
import 'package:technical_test/constant/app_text.dart';
import 'package:technical_test/features/login_register/cubit/auth_cubit.dart';
import 'package:technical_test/features/verifikasi/view/verifikasi_page.dart';
import 'package:technical_test/widget/button/default_button.dart';
import 'package:technical_test/widget/field/default_text_field.dart';

import '../login_page.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final nameC = TextEditingController();
  final emailC = TextEditingController();
  final passC = TextEditingController();
  final passConfirmC = TextEditingController();

  bool isShow = false;

  @override
  void dispose() {
    super.dispose();
    emailC.clear();
    nameC.clear();
    passC.clear();
    passConfirmC.clear();
  }

  @override
  Widget build(BuildContext context) {
    header() {
      return Column(
        children: [
          Text(
            'Create Account',
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
              controller: nameC,
              hintText: 'Name',
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Nama tidak boleh kosong';
                }
                if (!Validator.isValidName(value)) {
                  return 'Nama tidak valid';
                }
                return null;
              },
            ),
            const SizedBox(height: 25),
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
            const SizedBox(height: 25),
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
            const SizedBox(height: 25),
            DefaultTextField(
              controller: passConfirmC,
              hintText: 'Confirm Password',
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
                  return 'Konfirmasi Password tidak boleh kosong';
                }
                if (!Validator.arePasswordsMatching(passC.text, value)) {
                  return 'Password tidak sesuai';
                }
                return null;
              },
            ),
            const SizedBox(height: 25),
            submmitButton(),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                AppRoutes.toAndRemove(const LoginPage());
              },
              child: Text(
                'Already have an account',
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
          AppRoutes.toAndRemove(const VerificationPage());
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
          title: 'Sign up',
          onTap: () async {
            if (_formKey.currentState!.validate()) {
              context.read<AuthCubit>().signUp(
                    name: nameC.text,
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
