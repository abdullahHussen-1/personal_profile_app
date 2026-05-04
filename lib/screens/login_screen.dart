import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:personal_profile_app/core/routes/app_routes.dart';
import 'package:personal_profile_app/core/themes/app_media_query.dart';
import 'package:personal_profile_app/core/widgets/custom_text_form_field.dart';
import 'package:personal_profile_app/features/auth/services/auth_service.dart';
import 'package:personal_profile_app/utils/dialog_utils.dart';

import '../core/widgets/custom_elevated_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordVisible = false;
  TextEditingController emailController = TextEditingController(
    text: "abdullah@gmail.com",
  );
  TextEditingController passwordController = TextEditingController(
    text: "123456789",
  );
  final _formKey = GlobalKey<FormState>();
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login"), centerTitle: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: AppMediaQuery.sizeHeight(context) * 0.1),

              Center(
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Icon(
                    Icons.person,
                    size: 60,
                    color: Colors.white,
                  ),
                ).animate().scale(duration: 600.ms),
              ),

              SizedBox(height: AppMediaQuery.sizeHeight(context) * 0.05),

              Text(
                "Welcome Back!",
                style: Theme.of(context).textTheme.headlineMedium,
              ).animate().fadeIn(delay: 200.ms).slideX(),

              Text(
                "Login to continue using the app",
                style: Theme.of(context).textTheme.bodySmall,
              ).animate().fadeIn(delay: 400.ms),
              SizedBox(height: AppMediaQuery.sizeHeight(context) * 0.03),

              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      controller: emailController,
                      label: "Email Address",
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your email";
                        }
                        return null;
                      },
                    ).animate().fadeIn(delay: 400.ms),

                    CustomTextFormField(
                      controller: passwordController,
                      label: "Password",
                      obscureText: !_isPasswordVisible,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () => setState(
                          () => _isPasswordVisible = !_isPasswordVisible,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your password";
                        }
                        return null;
                      },
                    ).animate().fadeIn(delay: 400.ms),
                  ],
                ),
              ),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
              ),

              SizedBox(height: AppMediaQuery.sizeHeight(context) * 0.02),

              CustomElevatedButton(
                text: "Login",
                backGroundColor: Theme.of(context).primaryColor,
                widthContainer: double.infinity,
                heightContainer: 55,
                onPressed: () {
                  login();
                },
                child: Text(
                  "Login",
                  style: Theme.of(context).elevatedButtonTheme.style?.textStyle
                      ?.resolve({})
                      ?.copyWith(
                        color: Theme.of(context)
                            .elevatedButtonTheme
                            .style
                            ?.foregroundColor
                            ?.resolve({}),
                      ),
                ),
              ).animate().fadeIn(delay: 600.ms).scale(),
              SizedBox(height: AppMediaQuery.sizeHeight(context) * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.registerScreen);
                    },
                    child: Text(
                      "Register Now",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> login() async {
    if (_formKey.currentState!.validate()) {
      DialogUtils.showLoading(context: context, text: "Logging in...");
      try {
        final response = await authService.login(
          email: emailController.text,
          password: passwordController.text,
        );

        if (response.success) {
          if (mounted) {
            DialogUtils.hideLoading(context: context);
            Navigator.pushReplacementNamed(context, AppRoutes.homeBottomScreen);
          }
        } else {
          if (mounted) {
            DialogUtils.hideLoading(context: context);
            DialogUtils.showMessage(
              context: context,
              message: response.message ?? "Invalid email or password",
              title: "Login Failed",
            );
          }
        }
      } catch (error) {
        if (mounted) {
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMessage(
            context: context,
            message: error.toString(),
            title: "Error",
          );
        }
      }
    }
  }
}
