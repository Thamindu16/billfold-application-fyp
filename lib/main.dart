import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'view_models/theme_view_model.dart';
import 'views/auth/splash_view.dart';
import 'views/auth/login_view.dart';
import 'views/auth/register_view.dart';
import 'views/auth/otp_view.dart';
import 'views/auth/biometric_view.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeViewModel(),
      child: const BillfoldApp(),
    ),
  );
}

class BillfoldApp extends StatelessWidget {
  const BillfoldApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeViewModel = Provider.of<ThemeViewModel>(context);

    return MaterialApp(
      title: 'BILLFOLD',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeViewModel.themeMode,
      home: const SplashView(),
      routes: {
        '/login': (context) => const LoginView(),
        '/register': (context) => const RegisterView(),
        '/otp': (context) => const OtpView(),
        '/biometric': (context) => const BiometricView(),
      },
    );
  }
}
