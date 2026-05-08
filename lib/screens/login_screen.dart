import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../providers/auth_provider.dart';
import '../providers/user_provider.dart';
import '../routes/app_routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLogin = true;
  bool isLoading = false;
  bool obscurePassword = true;
  String? _emailError;
  String? _passwordError;

  bool _validate() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    String? emailError;
    String? passwordError;

    if (email.isEmpty) {
      emailError = 'Informe seu e-mail';
    } else if (!email.contains('@') || !email.contains('.')) {
      emailError = 'E-mail inválido';
    }

    if (password.isEmpty) {
      passwordError = 'Informe sua senha';
    } else if (password.length < 6) {
      passwordError = 'Senha muito curta (mín. 6)';
    }

    setState(() {
      _emailError = emailError;
      _passwordError = passwordError;
    });

    return emailError == null && passwordError == null;
  }

  Future<void> submit() async {
    if (isLoading) return;
    if (!_validate()) return;

    try {
      setState(() {
        isLoading = true;
      });

      await context.read<AuthProvider>().authenticate(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        isLogin: isLogin,
      );

      final authUser =
          Supabase.instance.client.auth.currentUser;

      if (authUser == null) return;

      await context.read<UserProvider>().loadUser(
        authUser.id,
      );

      final hasUser =
          context.read<UserProvider>().hasUser;

      if (!mounted) return;

      if (hasUser) {
        Navigator.pushReplacementNamed(
          context,
          AppRoutes.home,
        );
      } else {
        Navigator.pushReplacementNamed(
          context,
          AppRoutes.completeProfile,
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isLogin
                ? 'Não foi possível entrar. Verifique seus dados.'
                : 'Não foi possível criar a conta. Tente novamente.',
          ),
        ),
      );
    } finally {
      if (!mounted) return;
      setState(() => isLoading = false);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 420,
              ),
              child: Container(
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A1A),
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(
                    color: Colors.white10,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.12),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.checkroom_rounded,
                          color: Colors.green,
                          size: 52,
                        ),
                      ),
                    ),

                    const SizedBox(height: 28),

                    const Center(
                      child: Text(
                        'LookLink',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    Center(
                      child: Text(
                        isLogin
                            ? 'Seu guarda-roupa inteligente'
                            : 'Crie sua conta',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    Text(
                      'E-mail',
                      style: TextStyle(
                        color: Colors.grey.shade300,
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(height: 10),

                    TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      enabled: !isLoading,
                      decoration: InputDecoration(
                        hintText: 'Digite seu e-mail',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        filled: true,
                        fillColor: const Color(0xFF262626),
                        errorText: _emailError,
                        prefixIcon: const Icon(
                          Icons.email_outlined,
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 22),

                    Text(
                      'Senha',
                      style: TextStyle(
                        color: Colors.grey.shade300,
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(height: 10),

                    TextField(
                      controller: passwordController,
                      obscureText: obscurePassword,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      enabled: !isLoading,
                      decoration: InputDecoration(
                        hintText: 'Digite sua senha',
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                        ),
                        filled: true,
                        fillColor: const Color(0xFF262626),
                        errorText: _passwordError,
                        prefixIcon: const Icon(
                          Icons.lock_outline,
                          color: Colors.grey,
                        ),
                        suffixIcon: IconButton(
                          onPressed: isLoading
                              ? null
                              : () {
                            setState(() {
                              obscurePassword =
                              !obscurePassword;
                            });
                          },
                          icon: Icon(
                            obscurePassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: Colors.grey,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 34),

                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed:
                        isLoading ? null : submit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.black,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(18),
                          ),
                        ),
                        child: isLoading
                            ? const SizedBox(
                          height: 22,
                          width: 22,
                          child:
                          CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: Colors.black,
                          ),
                        )
                            : Text(
                          isLogin
                              ? 'Entrar'
                              : 'Criar conta',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight:
                            FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 22),

                    Center(
                      child: TextButton(
                        onPressed: isLoading
                            ? null
                            : () {
                          setState(() {
                            isLogin = !isLogin;
                            _emailError = null;
                            _passwordError = null;
                          });
                        },
                        child: RichText(
                          text: TextSpan(
                            text: isLogin
                                ? 'Não possui conta? '
                                : 'Já possui conta? ',
                            style: TextStyle(
                              color: Colors.grey.shade400,
                              fontSize: 14,
                            ),
                            children: [
                              TextSpan(
                                text: isLogin
                                    ? 'Criar conta'
                                    : 'Entrar',
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontWeight:
                                  FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}