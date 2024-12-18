import 'package:go_router/go_router.dart';
import 'package:proyecto_firebase_dap/presentation/screens/login_screen.dart';
import 'package:proyecto_firebase_dap/presentation/screens/movie_detail_screen.dart';
import 'package:proyecto_firebase_dap/presentation/screens/movies_screen.dart';
import 'package:proyecto_firebase_dap/presentation/screens/register_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
     GoRoute(
      path: '/register',
      name: RegisterScreen.name,
      builder: (context, state) => RegisterScreen(),
    ),
     GoRoute(
      path: '/login',
      name: LoginScreen.name,
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: '/movies',
      name: SongsScreen.name,
      builder: (context, state) => const SongsScreen(),
    ),
    GoRoute(
      path: '/movie_detail/:songId',
      name: SongDetailScreen.name,
      builder: (context, state) => SongDetailScreen(
        songId: state.pathParameters['songId']!,
      ),
    )
  ],
);