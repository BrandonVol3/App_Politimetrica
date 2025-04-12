import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../app/app_routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final user = FirebaseAuth.instance.currentUser;
    final userName = user?.displayName ?? "Usuario";
    final userPhoto = user?.photoURL;

    return Scaffold(
      body: Stack(
        children: [
          // Fondo degradado con curva
          Container(
            height: 200,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF4CAF50), // Verde claro
                  Color(0xFF388E3C), // Verde más oscuro
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(24),
              ),
            ),
          ),


          // Contenido principal
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Perfil y mensaje
                  Row(
                    children: [
                      AnimatedOpacity(
                        opacity: 1.0,
                        duration: const Duration(milliseconds: 600),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage:
                          userPhoto != null ? NetworkImage(userPhoto) : null,
                          backgroundColor: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Usted accedió con su cuenta de Google',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: Colors.white70,
                            ),
                          ),
                          Text(
                            userName,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () => _confirmLogout(context),
                        icon: const Icon(Icons.logout_rounded),
                        tooltip: 'Cerrar sesión',
                        color: Colors.white,
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  Text(
                    "Explora las opciones:",
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      children: [
                        _featureCard(
                          context,
                          icon: Icons.people,
                          title: 'Políticos',
                          color: Colors.green.shade700,
                          route: AppRoutes.politicianList,
                        ),
                        _featureCard(
                          context,
                          icon: Icons.map,
                          title: 'Provincias',
                          color: Colors.red.shade700,
                          route: AppRoutes.provincesList,
                        ),
                        _featureCard(
                          context,
                          icon: Icons.article,
                          title: 'Noticias',
                          color: Colors.blue.shade700,
                          route: AppRoutes.wordpressNews,
                        ),
                        _featureCard(
                          context,
                          icon: Icons.analytics,
                          title: 'Estadísticas',
                          color: Colors.purple.shade700,
                          route: null,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _featureCard(
      BuildContext context, {
        required IconData icon,
        required String title,
        required Color color,
        String? route,
      }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 5,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: route != null ? () => Navigator.pushNamed(context, route) : null,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color.withOpacity(0.12),
                color.withOpacity(0.05),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: color),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _confirmLogout(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cerrar sesión'),
        content: const Text('¿Estás seguro de que deseas cerrar sesión?'),
        actions: [
          TextButton(
            child: const Text('Cancelar'),
            onPressed: () => Navigator.pop(context, false),
          ),
          ElevatedButton(
            child: const Text('Salir'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
            ),
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await FirebaseAuth.instance.signOut();
      try {
        await GoogleSignIn().signOut();
      } catch (_) {}
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.login,
            (route) => false,
      );
    }
  }
}
