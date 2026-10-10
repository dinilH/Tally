import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/config/supabase_config.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'domain/repositories/auth_repository.dart';

late final AuthRepository authRepository;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: SupabaseConfig.url,
    anonKey: SupabaseConfig.anonKey,
  );
  authRepository = AuthRepositoryImpl(Supabase.instance.client);

  runApp(const TallyApp());
}

class TallyApp extends StatelessWidget {
  const TallyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tally',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Inter',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF88EF1B),
        ),
        scaffoldBackgroundColor: const Color(0xFFF4F1EA),
        useMaterial3: true,
      ),
      // Temporary: switch back to TallyHomePage after auth is tested
      home: const AuthTestScreen(),
    );
  }
}

class TallyHomePage extends StatelessWidget {
  const TallyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Tally'),
      ),
    );
  }
}

/// Temporary screen to test auth. Replace later with the real login UI.
class AuthTestScreen extends StatefulWidget {
  const AuthTestScreen({super.key});

  @override
  State<AuthTestScreen> createState() => _AuthTestScreenState();
}

class _AuthTestScreenState extends State<AuthTestScreen> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  String _status = 'Not signed in';

  @override
  void initState() {
    super.initState();
    final user = authRepository.currentUser;
    if (user != null) _status = 'Signed in as ${user.name} (${user.email})';
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _run(Future<void> Function() action) async {
    try {
      await action();
    } catch (e) {
      setState(() => _status = 'Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tally - Auth test')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(
              controller: _name,
              decoration:
              const InputDecoration(labelText: 'Name (sign up only)'),
            ),
            TextField(
              controller: _email,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _password,
              obscureText: true,
              decoration:
              const InputDecoration(labelText: 'Password (min 6)'),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              children: [
                ElevatedButton(
                  onPressed: () => _run(() async {
                    final u = await authRepository.signUp(
                      name: _name.text.trim(),
                      email: _email.text.trim(),
                      password: _password.text,
                    );
                    setState(
                            () => _status = 'Signed up: ${u.name} (${u.email})');
                  }),
                  child: const Text('Sign up'),
                ),
                ElevatedButton(
                  onPressed: () => _run(() async {
                    final u = await authRepository.signIn(
                      email: _email.text.trim(),
                      password: _password.text,
                    );
                    setState(
                            () => _status = 'Signed in: ${u.name} (${u.email})');
                  }),
                  child: const Text('Log in'),
                ),
                OutlinedButton(
                  onPressed: () => _run(() async {
                    await authRepository.signOut();
                    setState(() => _status = 'Signed out');
                  }),
                  child: const Text('Log out'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(_status),
          ],
        ),
      ),
    );
  }
}