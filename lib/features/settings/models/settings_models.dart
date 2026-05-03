
class SettingsModel {
  final bool darkMode;
  final bool notificationsEnabled;

  const SettingsModel({
    required this.darkMode,
    required this.notificationsEnabled,
  });

  factory SettingsModel.fromJson(Map<String, dynamic> json) => SettingsModel(
        darkMode:             json['darkMode'] as bool? ?? false,
        notificationsEnabled: json['notificationsEnabled'] as bool? ?? true,
      );
}
