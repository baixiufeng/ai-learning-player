import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'presentation/pages/main_navigation_page.dart';
import 'presentation/pages/onboarding_page.dart';
import 'core/services/storage_service.dart';

class AiLearningPlayerApp extends StatelessWidget {
  const AiLearningPlayerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI兩衞甩料棕',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const AppEntryPoint(),
    );
  }
}

class AppEntryPoint extends StatefulWidget {
  const AppEntryPoint({super.key});

  @override
  State<AppEntryPoint> createState() => _AppEntryPointState();
}

class _AppEntryPointState extends State<AppEntryPoint> {
  bool _isFirstLaunch = true;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkFirstLaunch();
  }

  Future<void> _checkFirstLaunch() async {
    final hasLaunched = StorageService.getBool('has_launched') ?? false;
    setState(() {
      _isFirstLaunch = !hasLaunched;
      _isLoading = false;
    });
  }

  void _onOnboardingComplete() {
    StorageService.setBool('has_launched', true);
    setState(() {
      _isFirstLaunch = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_isFirstLaunch) {
      return OnboardingPage(
        onComplete: _onOnboardingComplete,
      );
    }

    return const MainNavigationPage();
  }
}
