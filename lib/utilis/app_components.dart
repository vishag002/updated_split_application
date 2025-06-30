import 'package:flutter/material.dart';
import 'package:updated_split_application/utilis/color_const.dart';

class AppComponents {
  // App Bar Theme
  static AppBar appBarStyleWithTitle(
    String title,
    BuildContext context, {
    bool showBackButton = true,
  }) {
    return AppBar(
      automaticallyImplyLeading: false, // We control 'leading' manually
      title: Text(
        title,
        style: const TextStyle(
          color: AppColors.primaryTextColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: AppColors.primaryColor,
      elevation: 4,
      leading: showBackButton
          ? IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: AppColors.primaryTextColor,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          : null, // No leading icon shown
    );
  }

  static AppBar appBarStyleWithIconButton({
    required String title,
    required Icon icon,
    required VoidCallback onTapFunction,
  }) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          color: AppColors.primaryTextColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: AppColors.primaryColor,
      elevation: 4,
      actions: [IconButton(icon: icon, onPressed: onTapFunction)],
    );
  }

  static AppBar appBarStyle() {
    return AppBar(
      backgroundColor: AppColors.secondaryColor,
      elevation: 4,
      automaticallyImplyLeading: false,
    );
  }

  // Elevated Button Style
  static ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: AppColors.primaryColor,
    foregroundColor: AppColors.buttonTextColor,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    elevation: 4,
  );

  // Text Button Style
  static ButtonStyle textButtonStyle = TextButton.styleFrom(
    foregroundColor: AppColors.primaryColor,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
  );

  // Outlined Button Style
  static ButtonStyle outlinedButtonStyle = OutlinedButton.styleFrom(
    foregroundColor: AppColors.primaryColor,
    side: const BorderSide(color: AppColors.primaryColor),
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  );

  // Container Style
  static BoxDecoration containerStyle = BoxDecoration(
    color: AppColors.cardColor,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.2),
        spreadRadius: 1,
        blurRadius: 5,
        offset: const Offset(0, 3),
      ),
    ],
  );

  // Card Style
  static BoxDecoration cardStyle = BoxDecoration(
    color: AppColors.backgroundColor,
    borderRadius: BorderRadius.circular(10),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.1),
        spreadRadius: 1,
        blurRadius: 4,
        offset: const Offset(0, 2),
      ),
    ],
  );

  // Divider Style
  static Divider dividerStyle = const Divider(
    color: AppColors.borderColor,
    thickness: 1,
    height: 1,
  );

  // Input Field Decoration
  static InputDecoration inputFieldDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(
        color: AppColors.secondaryTextColor,
        fontSize: 14,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.borderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.primaryColor),
      ),
    );
  }
}
