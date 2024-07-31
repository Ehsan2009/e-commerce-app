// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// class SplashScreen extends StatelessWidget {
//   const SplashScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: Supabase.instance.client.auth.currentSession,
//       builder: (ctx, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Scaffold(
//             appBar: AppBar(
//               title: const Text('Shop App'),
//             ),
//           );
//         }

//         if (snapshot.hasData) {
//           // Navigate to TabsScreen if user is authenticated
//           Future.microtask(() => context.go('/home_screen'));
//         } else {
//           // Navigate to IntroductionScreen if user is not authenticated
//           Future.microtask(() => context.go('/introduction_screen'));
//         }

//         // While navigating, show an empty container
//         return const Scaffold();
//       },
//     );
//   }
// }

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _redirect();
  }

  Future<void> _redirect() async {
    await Future.delayed(Duration.zero);
    final session = Supabase.instance.client.auth.currentSession;
    
    if (!mounted) return;

    if (session != null) {
      context.go('/home_screen');
    } else {
      context.go('/introduction_screen');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
