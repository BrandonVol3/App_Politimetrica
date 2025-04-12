import '../screens/login_screen.dart';
import '../screens/home_screen.dart';
import '../screens/politician_list_screen.dart';
import '../screens/provinces_list_screen.dart';
import '../screens/register_screen.dart';  // Agrega esta importación

class AppRoutes {
  static const String login = '/';
  static const String home = '/home';
  static const String politicianList = '/politicians';
  static const String politicianDetail = '/politicians/detail';
  static const String provincesList = '/provinces';
  static const String wordpressNews = '/wordpress-news';

  static final routes = {
    login: (context) => const LoginScreen(),
    home: (context) => const HomeScreen(),
    politicianList: (context) => const PoliticianListScreen(),
    provincesList: (context) => const ProvincesListScreen(),
    '/register': (context) => const RegisterScreen(), // Agrega la ruta para el registro
  };
}
