import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:personal_profile_app/core/routes/app_routes.dart';
import 'package:personal_profile_app/core/themes/app_media_query.dart';
import 'package:personal_profile_app/features/auth/services/auth_service.dart';
import 'package:personal_profile_app/utils/dialog_utils.dart';

import '../core/widgets/custom_elevated_button.dart';
import '../core/widgets/custom_text_form_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;
  bool confirmPasswordVisible = false;
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppMediaQuery.sizeHeight(context) * 0.03,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: AppMediaQuery.sizeHeight(context) * 0.05),
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
                SizedBox(height: AppMediaQuery.sizeHeight(context) * 0.04),
                Text(
                  "Create Account",
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ).animate().fadeIn().slideX(begin: -0.2),

                SizedBox(height: AppMediaQuery.sizeHeight(context) * 0.01),

                Text(
                  "Join us to manage your personal profile and memories",
                  style: Theme.of(context).textTheme.bodySmall,
                ).animate().fadeIn(delay: 200.ms),

                const SizedBox(height: 40),

                CustomTextFormField(
                  controller: nameController,
                  label: "Full Name",
                  keyboardType: TextInputType.name,
                  validator: (value) =>
                      value!.isEmpty ? "Please enter your name" : null,
                ).animate().fadeIn(delay: 300.ms),

                CustomTextFormField(
                  controller: emailController,
                  label: "Email Address",
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter your email.";
                    }
                    if (!value.contains('@') || !value.endsWith("gmail.com")) {
                      return "Enter a valid email.";
                    }

                    return null;
                  },
                ).animate().fadeIn(delay: 400.ms),

                CustomTextFormField(
                  controller: phoneController,
                  label: "Phone Number",
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter your Phone.";
                    }
                    if (value.length < 11) {
                      return "Enter valid phone number.";
                    }
                    return null;
                  },
                ).animate().fadeIn(delay: 500.ms),

                CustomTextFormField(
                  controller: passwordController,
                  label: "Password",
                  obscureText: !isPasswordVisible,
                  suffixIcon: IconButton(
                    icon: Icon(
                      isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () =>
                        setState(() => isPasswordVisible = !isPasswordVisible),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your password.";
                    }
                    if (value.length < 8) {
                      return "Password must be at least 8 characters.";
                    }
                    final passwordRegex = RegExp(
                      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[\W_]).+$',
                    );
                    if (!passwordRegex.hasMatch(value)) {
                      return "Password must contain uppercase lowercase and special characte.r";
                    }

                    return null;
                  },
                ).animate().fadeIn(delay: 600.ms),
                CustomTextFormField(
                  controller: confirmPasswordController,
                  label: "Confirm Password",
                  obscureText: !confirmPasswordVisible,
                  suffixIcon: IconButton(
                    icon: Icon(
                      confirmPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () => setState(
                      () => confirmPasswordVisible = !confirmPasswordVisible,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please confirm your password.";
                    }
                    if (value != passwordController.text) {
                      return "Passwords do not match.";
                    }
                    if (value == null || value.isEmpty) {
                      return "Please enter your password.";
                    }
                    if (value.length < 8) {
                      return "Password must be at least 8 characters.";
                    }
                    final passwordRegex = RegExp(
                      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[\W_]).+$',
                    );
                    if (!passwordRegex.hasMatch(value)) {
                      return "Password must contain uppercase lowercase and special character.";
                    }
                    return null;
                  },
                ).animate().fadeIn(delay: 650.ms),

                SizedBox(height: AppMediaQuery.sizeHeight(context) * 0.04),
                CustomElevatedButton(
                  text: "Create Account",
                  backGroundColor: Theme.of(context).primaryColor,
                  widthContainer: double.infinity,
                  heightContainer: 55,
                  onPressed: () {
                    register();
                  },
                ).animate().scale(delay: 700.ms),

                SizedBox(height: AppMediaQuery.sizeHeight(context) * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> register() async {
    if (_formKey.currentState!.validate()) {
      //todo=> showLoading
      DialogUtils.showLoading(
        context: context,
        text: "Creating your account...",
      );
      try {
        final response = await authService.register(
          fullName: nameController.text,
          email: emailController.text,
          password: passwordController.text,
          phone: phoneController.text,
        );
        //todo=> hed Loading
        if (mounted) DialogUtils.hideLoading(context: context);
        if (response.success) {
          if (mounted) {
            DialogUtils.showMessage(
              context: context,
              message: response.message,
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(
                      context,
                      AppRoutes.homeBottomScreen,
                    );
                  },
                  child: const Text("Go to Home"),
                ),
              ],
            );
          }
        } else {
          //todo=>show message error come from server
          if (mounted) {
            DialogUtils.hideLoading(context: context);
            DialogUtils.showMessage(
              context: context,
              message: response.message ?? "Registration Failed",
              title: "Error",
            );
          }
        }
      } catch (error) {
        if (mounted) {
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMessage(
            context: context,
            message: "Connection Error: ${error.toString()}",
            title: "Error",
          );
        }
      }
    }
  }
}
