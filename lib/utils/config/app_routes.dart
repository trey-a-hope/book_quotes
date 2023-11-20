import 'package:quote_keeper/presentation/pages/dashboard/dashboard_view.dart';
import 'package:quote_keeper/presentation/pages/edit_book/edit_book_view.dart';
import 'package:quote_keeper/presentation/pages/main/main_view.dart';
import 'package:quote_keeper/presentation/pages/search_books/search_books_view.dart';
import 'package:quote_keeper/presentation/pages/splash/splash_view.dart';
import 'package:quote_keeper/presentation/screens/books_screen.dart';
import 'package:quote_keeper/presentation/screens/create_book_screen.dart';
import 'package:quote_keeper/presentation/screens/settings_screen.dart';
import 'package:quote_keeper/utils/constants/globals.dart';

import 'package:get/get_navigation/src/routes/get_route.dart';

import '../../presentation/pages/login/login_view.dart';

class AppRoutes {
  AppRoutes._();

  static final List<GetPage> routes = [
    GetPage(
      name: Globals.routeSplash,
      page: () => const SplashView(),
    ),
    GetPage(
      name: Globals.routeCreateQuote,
      page: () => CreateBookScreen(),
    ),
    GetPage(
      name: Globals.routeDashboard,
      page: () => DashboardView(),
    ),
    GetPage(
      name: Globals.routeBooks,
      page: () => BooksScreen(),
    ),
    GetPage(
      name: Globals.routeEditQuote,
      page: () => EditBookView(),
    ),
    GetPage(
      name: Globals.routeMain,
      page: () => const MainView(),
    ),
    GetPage(
      name: Globals.routeLogin,
      page: () => const LoginView(),
    ),
    GetPage(
      name: Globals.routeSearchBooks,
      page: () => SearchBooksView(),
    ),
    GetPage(
      name: Globals.routeSettings,
      page: () => SettingsScreen(),
    ),
  ];
}
