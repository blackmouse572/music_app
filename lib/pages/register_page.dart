import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:music_app/providers/auth.provider.dart';
import 'package:music_app/routes.dart';
import 'package:music_app/theme.dart';
import 'package:music_app/widgets/ScreenContainer.dart';

class RegisterPage extends ConsumerWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _formKey = GlobalKey<FormState>();
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();
    final _confirmPasswordController = TextEditingController();
    final isLoading = ref.watch(authControllerProvider).isLoading;
    final signUp = ref.watch(authControllerProvider.notifier).signUp;

    Future<void> onSubmitted() async {
      if (_formKey.currentState!.validate()) {
        final email = _emailController.value.text;
        final password = _passwordController.value.text;
        final confirmPassword = _confirmPasswordController.value.text;
        debugPrint(
            "Register with email: $email and password: $password and confirm password: $confirmPassword");
        bool rs =
            await signUp(email: email, password: password, context: context);
        if (rs) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(Routes.home, (route) => false);
        }
      }
    }

    return ScreenContainer(
      withBackButton: true,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SvgPicture.asset('assets/svg/music.svg'),
              Text(
                'Đăng ký',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 20),
              //Login from
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Email không được để trống';
                        }

                        if (!value.contains('@')) {
                          return 'Email không hợp lệ';
                        }
                      },
                      style: Theme.of(context).textTheme.bodyLarge,
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: Theme.of(context).textTheme.bodyMedium,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                            color: Gray.gray600,
                            width: 1,
                          ),
                        ),
                        prefixIcon: Icon(Icons.email,
                            color: Colors.white.withAlpha(70)),
                        filled: true,
                        fillColor: Gray.gray700,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      obscureText: true,
                      controller: _passwordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Mật khẩu không được để trống';
                        }
                        if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$')
                            .hasMatch(value)) {
                          return 'Mật khẩu cần có ít nhất 8 ký tự, chứa ít nhất 1 chữ cái và 1 số';
                        }
                      },
                      style: Theme.of(context).textTheme.bodyLarge,
                      decoration: InputDecoration(
                        labelText: "Mật khẩu",
                        labelStyle: Theme.of(context).textTheme.bodyMedium,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                            color: Gray.gray600,
                            width: 1,
                          ),
                        ),
                        prefixIcon:
                            Icon(Icons.lock, color: Colors.white.withAlpha(70)),
                        filled: true,
                        fillColor: Gray.gray700,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      obscureText: true,
                      style: Theme.of(context).textTheme.bodyLarge,
                      controller: _confirmPasswordController,
                      validator: (value) {
                        if (value != _passwordController.value.text) {
                          return 'Mật khẩu không khớp';
                        }
                      },
                      decoration: InputDecoration(
                        labelText: "Nhập lại mật khẩu",
                        labelStyle: Theme.of(context).textTheme.bodyMedium,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(
                            color: Gray.gray600,
                            width: 1,
                          ),
                        ),
                        prefixIcon:
                            Icon(Icons.lock, color: Colors.white.withAlpha(70)),
                        filled: true,
                        fillColor: Gray.gray700,
                      ),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        onSubmitted();
                      },
                      child: isLoading
                          ? const Text("...")
                          : Text('Đăng ký',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  )),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 15),
                        maximumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                    ),
                    //register
                    TextButton(
                      onPressed: () {
                        if (isLoading) return;
                        Navigator.popAndPushNamed(context, Routes.login);
                      },
                      child: Text('Đăng nhập',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.onPrimary,
                              )),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 15),
                        maximumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
