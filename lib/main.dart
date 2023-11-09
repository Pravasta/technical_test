import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technical_test/common/routes/app_routes.dart';
import 'package:technical_test/constant/theme_data.dart';
import 'package:technical_test/features/home/cubit/data_user_cubit.dart';
import 'package:technical_test/features/login_register/cubit/auth_cubit.dart';
import 'package:technical_test/features/splash/view/splash_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => DataUserCubit()),
      ],
      child: MaterialApp(
        navigatorKey: AppRoutes.navigatorKey,
        title: 'Technical Test',
        themeMode: ThemeMode.light,
        theme: ThemeDataColor.lightColor,
        darkTheme: ThemeDataColor.darkColor,
        debugShowCheckedModeBanner: false,
        home: const SplashPage(),
      ),
    );
  }
}
