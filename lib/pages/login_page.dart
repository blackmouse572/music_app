import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:music_app/providers/auth.provider.dart';
import 'package:music_app/routes.dart';
import 'package:music_app/theme.dart';
import 'package:music_app/widgets/ScreenContainer.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _formKey = GlobalKey<FormState>();
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();
    final signIn = ref.watch(authControllerProvider.notifier).signIn;
    final isLoading = ref.watch(authControllerProvider).isLoading;
    Future<void> onSubmitted() async {
      if (_formKey.currentState!.validate()) {
        final email = _emailController.value.text;
        final password = _passwordController.value.text;
        debugPrint("Login with email: $email and password: $password");
        //If sign in successfully, navigate to the home page
        final rs = await signIn(
          email: email,
          password: password,
          context: context,
        );
        if (rs) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(Routes.home, (route) => false);
        } else {
          return;
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
                'Đăng nhập',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 20),
              //Login from
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      validator: (value) {
                        if (!value!.contains('@')) {
                          return 'Email không hợp lệ';
                        } else if (value.isEmpty) {
                          return 'Email không được để trống';
                        }
                      },
                      style: Theme.of(context).textTheme.bodyLarge,
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(r"\s")),
                      ],
                      autocorrect: true,
                      textInputAction: TextInputAction.next,
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
                      validator: (v) {
                        if (v!.isEmpty) {
                          return 'Mật khẩu không được để trống';
                        }
                        //Password must be at least 8 characters, contain at least one number and one letter
                        //Using regex
                        if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$')
                            .hasMatch(v)) {
                          return 'Mật khẩu cần có ít nhất 8 ký tự, chứa ít nhất 1 chữ cái và 1 số';
                        }
                      },
                      textInputAction: TextInputAction.go,
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
                    const SizedBox(height: 30),
                    ElevatedButton(
                      //disable on loading
                      onPressed: isLoading
                          ? null
                          : () {
                              onSubmitted();
                            },
                      child: isLoading
                          ? const Text("...")
                          : Text('Đăng nhập',
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
                        Navigator.popAndPushNamed(context, Routes.register);
                      },
                      child: Text('Đăng ký',
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
