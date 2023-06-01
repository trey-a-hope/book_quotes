import 'package:book_quotes/presentation/pages/books/books_view.dart';
import 'package:book_quotes/presentation/pages/create_book/create_book_view.dart';
import 'package:book_quotes/presentation/pages/dashboard/dashboard_view.dart';
import 'package:book_quotes/presentation/pages/edit_book/edit_book_view.dart';
import 'package:book_quotes/presentation/pages/main/main_view.dart';
import 'package:book_quotes/presentation/pages/splash/splash_view.dart';
import 'package:book_quotes/utils/constants/globals.dart';

import 'package:get/get_navigation/src/routes/get_route.dart';

import '../presentation/pages/login/login_view.dart';

class AppRoutes {
  AppRoutes._();

  static final List<GetPage> routes = [
    GetPage(
      name: Globals.routeSplash,
      page: () => const SplashView(),
    ),
    GetPage(
      name: Globals.routeCreateQuote,
      page: () => CreateBookView(),
    ),
    GetPage(
      name: Globals.routeDashboard,
      page: () => const DashboardView(),
    ),
    GetPage(
      name: Globals.routeBooks,
      page: () => const BooksView(),
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
  ];
}