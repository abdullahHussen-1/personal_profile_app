import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:personal_profile_app/core/routes/app_routes.dart';
import 'package:personal_profile_app/core/themes/app_media_query.dart';
import 'package:personal_profile_app/core/widgets/custom_elevated_button.dart';
import 'package:personal_profile_app/features/auth/services/auth_service.dart';
import 'package:personal_profile_app/utils/dialog_utils.dart';

class LogoutScreen extends StatefulWidget {
  LogoutScreen({super.key});

  @override
  State<LogoutScreen> createState() => _LogoutScreenState();
}

class _LogoutScreenState extends State<LogoutScreen> {
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Logout"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppMediaQuery.sizeWidth(context) * 0.05,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              /* height: 180,
              width: 180,*/
              padding: EdgeInsets.symmetric(
                horizontal: AppMediaQuery.sizeWidth(context) * 0.2,
                vertical: AppMediaQuery.sizeHeight(context) * 0.1,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.error.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  Icons.logout_rounded,
                  size: 80,
                  color: Theme.of(
                    context,
                  ).colorScheme.error, // سيستخدم AppColors.errorRed
                ),
              ),
            ),

            SizedBox(height: AppMediaQuery.sizeHeight(context) * 0.04),

            Text(
              "Are you sure?",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: AppMediaQuery.sizeHeight(context) * 0.012),
            Text(
              "Do you really want to logout from your account?",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),

            SizedBox(height: AppMediaQuery.sizeHeight(context) * 0.08),

            CustomElevatedButton(
              text: "",
              backGroundColor: Theme.of(context).colorScheme.error,
              onPressed: () {
                //todo=>logout
                logout();
              },
              widthContainer: AppMediaQuery.sizeWidth(context),
              heightContainer: AppMediaQuery.sizeHeight(context) * 0.08,
              checkIcon: true,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.logout,
                    color: Theme.of(
                      context,
                    ).elevatedButtonTheme.style?.foregroundColor?.resolve({}),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "Logout",
                    style: Theme.of(context)
                        .elevatedButtonTheme
                        .style
                        ?.textStyle
                        ?.resolve({})
                        ?.copyWith(
                          color: Theme.of(context)
                              .elevatedButtonTheme
                              .style
                              ?.foregroundColor
                              ?.resolve({}),
                        ),
                  ),
                ],
              ),
            ),
          ],
        ).animate().fadeIn(duration: 900.ms).slideY(begin: -0.2, end: 0),
      ),
    );
  }

  Future<void> logout() async {
    DialogUtils.showLoading(context: context, text: "Logging out...");
    await authService.logout();
    if (context.mounted) {
      DialogUtils.hideLoading(context: context);
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.loginScreen,
        (route) => false,
      );
    }
  }
}
