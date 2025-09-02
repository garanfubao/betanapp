import 'package:flutter/material.dart';
import 'constants.dart';
import '../models/index.dart';

class AppThemes {
  // Brand colors - Đồng bộ màu thương hiệu chính
  static const Color primaryBrand = Color(0xFFE53E3E); // Màu đỏ chính - thương hiệu
  static const Color primaryDark = Color(0xFFC53030); // Màu đỏ tối
  static const Color primaryLight = Color(0xFFFC8181); // Màu đỏ nhạt
  
  // Secondary colors - Màu phụ hỗ trợ
  static const Color secondaryBlue = Color(0xFF2196F3);
  static const Color secondaryGreen = Color(0xFF4CAF50);
  static const Color secondaryOrange = Color(0xFFFF9800);
  static const Color secondaryPurple = Color(0xFF6C63FF);
  
  // Delivery app specific colors - Tất cả đều dùng màu thương hiệu chính
  static const Color driverColor = primaryBrand;
  static const Color leaderColor = primaryBrand;
  static const Color restaurantColor = primaryBrand;
  static const Color adminColor = primaryBrand;

  // Base theme data
  static ThemeData _baseTheme(Color primaryColor) {
    return ThemeData(
      primarySwatch: _createMaterialColor(primaryColor),
      primaryColor: primaryColor,
      scaffoldBackgroundColor: AppTheme.backgroundColor, // Background tối
      fontFamily: 'Roboto',
      appBarTheme: AppBarTheme(
        backgroundColor: AppTheme.surfaceColor, // AppBar tối
        foregroundColor: Colors.white,
        elevation: AppTheme.elevation4,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: AppTheme.elevation2,
          padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.spacingL,
            vertical: AppTheme.spacingM,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusM),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryColor,
          side: BorderSide(color: primaryColor),
          padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.spacingL,
            vertical: AppTheme.spacingM,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusM),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      cardTheme: CardThemeData(
        color: AppTheme.cardColor, // Card tối
        elevation: AppTheme.elevation2,
        margin: const EdgeInsets.symmetric(
          horizontal: AppTheme.spacingM,
          vertical: AppTheme.spacingS,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusM),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppTheme.surfaceColor, // Bottom nav tối
        elevation: AppTheme.elevation8,
        selectedItemColor: primaryColor,
        unselectedItemColor: AppTheme.textSecondaryColor,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w400,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: AppTheme.elevation6,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: primaryColor.withOpacity(0.1),
        labelStyle: TextStyle(color: primaryColor),
        side: BorderSide.none,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusM),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusM),
          borderSide: const BorderSide(color: AppTheme.textDisabledColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusM),
          borderSide: const BorderSide(color: AppTheme.textDisabledColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusM),
          borderSide: BorderSide(color: primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusM),
          borderSide: const BorderSide(color: AppTheme.errorColor, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spacingM,
          vertical: AppTheme.spacingM,
        ),
        filled: true,
        fillColor: AppTheme.cardColor, // Input background tối
      ),
      tabBarTheme: TabBarThemeData(
        labelColor: primaryColor,
        unselectedLabelColor: AppTheme.textSecondaryColor,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: primaryColor, width: 3),
        ),
        labelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: AppTheme.dividerColor,
        thickness: 1,
        space: 1,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: AppTheme.textPrimaryColor,
        ),
        displayMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: AppTheme.textPrimaryColor,
        ),
        displaySmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppTheme.textPrimaryColor,
        ),
        headlineLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppTheme.textPrimaryColor,
        ),
        headlineMedium: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppTheme.textPrimaryColor,
        ),
        headlineSmall: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppTheme.textPrimaryColor,
        ),
        titleLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppTheme.textPrimaryColor,
        ),
        titleMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppTheme.textPrimaryColor,
        ),
        titleSmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppTheme.textPrimaryColor,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: AppTheme.textPrimaryColor,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: AppTheme.textPrimaryColor,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: AppTheme.textSecondaryColor,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppTheme.textPrimaryColor,
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppTheme.textPrimaryColor,
        ),
        labelSmall: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: AppTheme.textSecondaryColor,
        ),
      ),
    );
  }

  // App-specific themes - Tất cả đều dùng màu thương hiệu chính
  static ThemeData get driverTheme => _baseTheme(driverColor);
  static ThemeData get leaderTheme => _baseTheme(leaderColor);
  static ThemeData get restaurantTheme => _baseTheme(restaurantColor);
  static ThemeData get adminTheme => _baseTheme(adminColor);

  // Helper to create MaterialColor from Color
  static MaterialColor _createMaterialColor(Color color) {
    final List<double> strengths = <double>[.05];
    final Map<int, Color> swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    
    for (final strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    
    return MaterialColor(color.value, swatch);
  }

  // Status colors for different states - Sử dụng màu thương hiệu cho các trạng thái chính
  static Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
      case 'delivered':
      case 'completed':
      case 'success':
        return AppTheme.successColor;
      case 'pending':
      case 'assigned':
      case 'processing':
        return AppTheme.warningColor;
      case 'inactive':
      case 'cancelled':
      case 'failed':
        return AppTheme.errorColor;
      case 'created':
      case 'confirmed':
        return primaryBrand; // Sử dụng màu thương hiệu cho trạng thái mới
      case 'picked_up':
        return primaryBrand; // Sử dụng màu thương hiệu
      case 'pooled':
        return primaryBrand; // Sử dụng màu thương hiệu
      default:
        return AppTheme.textSecondaryColor;
    }
  }

  // App name with color mapping
  static String getAppName(UserRole role) {
    switch (role) {
      case UserRole.driver:
        return 'App Tài xế';
      case UserRole.leader:
        return 'App Leader';
      case UserRole.restaurant:
        return 'App Quán ăn';
      case UserRole.admin:
        return 'App Admin';
      default:
        return 'Delivery System';
    }
  }

  static Color getAppColor(UserRole role) {
    // Tất cả app đều dùng màu thương hiệu chính
    return primaryBrand;
  }

  // Gradient helpers - Sử dụng màu thương hiệu
  static LinearGradient getAppGradient(UserRole role) {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        primaryBrand,
        primaryBrand.withOpacity(0.8),
      ],
    );
  }
}

// Extension to easily access theme colors
extension ThemeExtension on BuildContext {
  Color get primaryColor => Theme.of(this).primaryColor;
  Color get cardColor => Theme.of(this).cardColor;
  TextTheme get textTheme => Theme.of(this).textTheme;
}
