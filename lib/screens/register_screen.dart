import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:personal_profile_app/core/routes/app_routes.dart';
import 'package:personal_profile_app/core/themes/app_media_query.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    if (value == null || !value.contains('@'))
                      return "Enter a valid email";
                    return null;
                  },
                ).animate().fadeIn(delay: 400.ms),

                CustomTextFormField(
                  controller: phoneController,
                  label: "Phone Number",
                  keyboardType: TextInputType.phone,
                  validator: (value) =>
                      value!.length < 10 ? "Enter a valid phone number" : null,
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
                  validator: (value) =>
                      value!.length < 6 ? "Password is too short" : null,
                ).animate().fadeIn(delay: 600.ms),
                CustomTextFormField(
                  controller: confirmPasswordController,
                  label: "Confirm Password",
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
                      return "Please confirm your password";
                    }
                    if (value != passwordController.text) {
                      return "Passwords do not match";
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

  void register() {
    //if (_formKey.currentState!.validate()) {}
    Navigator.pushNamed(context, AppRoutes.homeBottomScreen);
  }
}
