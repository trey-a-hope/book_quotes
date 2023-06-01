import 'package:flutter_animate/flutter_animate.dart';

class Globals {
  Globals._();

  /// Routes

  static const String routeBooks = '/books';
  static const String routeCreateQuote = '/createQuote';
  static const String routeDashboard = '/dashboard';
  static const String routeEditQuote = '/editQuote';
  static const String routeLogin = '/login';
  static const String routeMain = '/main';
  static const String routeSplash = '/splash';

  static const String cloudMessagingServerKey =
      'AAAAzo15CQU:APA91bH040ySf7LL4P-m68WqWqY3uVPeQspn93KZq3335E-K4e3UhkD9jX6m27xKB1P9IG7XIfVwL5evi59TJOyLioIilO3G0ea5NEELUEe0VciUGV-pRg3phNHGPntVnx_DszYPnzmP';

  /// Dummy Variables
  static const String dummyProfilePhotoUrl =
      'https://firebasestorage.googleapis.com/v0/b/critic-a9e44.appspot.com/o/Images%2FProfile.jpeg?alt=media&token=f8d67c2f-9b1c-4cbe-aca5-6da014c504a0';

  static const String darkModeEnabled = 'dark_mode_enabled';

  static String? version;
  static String? buildNumber;

  static List<Effect<dynamic>> fadeEffect = <Effect>[
    FadeEffect(duration: 300.ms),
  ];

  static String splashMessage = 'Books are essential.';

  /// Package info
  static const String appVersion = 'app_version';
  static const String appBuildNumber = 'build_number';
}