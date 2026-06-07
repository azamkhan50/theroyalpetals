import 'package:get/get.dart';
import 'package:royalpetals/views/auth/login_screen.dart';
import 'package:royalpetals/views/auth/signup_screen.dart';
import 'package:royalpetals/views/home/favorites_screen.dart';
import 'package:royalpetals/views/home/home_screen.dart';
import 'package:royalpetals/views/home/main_navigation.dart';
import 'package:royalpetals/views/product/feature_product_screen.dart';
import 'package:royalpetals/views/product/my_cart_screen.dart';
import 'package:royalpetals/views/product/order_success_screen.dart';
import 'package:royalpetals/views/product/personal_information_screen.dart';
import 'package:royalpetals/views/profile/profile_screen.dart';
import 'package:royalpetals/views/splash_screen/onboarding_screen.dart';
import 'package:royalpetals/views/splash_screen/splash_view1.dart';

class AppRoutes {
  // Route Name Constants
  static const String initial = '/';
  static const String mainNav = '/main-nav';
  static const String home = '/home';
  static const String cart = '/cart';
  static const String profile = '/profile';
  static const String checkout = '/checkout';
  static const String success = '/success';
  static const String favorites = '/favorites';
  static const String featured = '/featured';
  static const String splash = '/splash';
  static const String signUp = '/sign-up';
  static const String login = '/login';
  static const String onboarding = '/onboarding';
  // GetPage List
  static List<GetPage> routes = [
    GetPage(
      name: mainNav,
      page: () => const MainNavigation(),
      transition: Transition.fadeIn,
    ),

    GetPage(
      name: signUp,
      page: () => const SignUpScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: login,
      page: () => const LoginScreen(),
      transition: Transition.fadeIn,
    ),

    GetPage(
      name: onboarding,
      page: () => const OnboardingScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(name: home, page: () => const HomeScreen()),
    GetPage(name: splash, page: () => const SplashView1()),
    GetPage(
      name: cart,
      page: () => const MyCartScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(name: profile, page: () => const ProfileScreen()),
    GetPage(name: featured, page: () => const FeatureProductScreen()),
    GetPage(name: checkout, page: () => const PersonalInformationScreen()),
    GetPage(name: success, page: () => const OrderSuccessScreen()),
    GetPage(name: favorites, page: () => const FavoritesScreen()),
  ];
}
