import 'package:flutter/material.dart';

class AppConstants {
  // App Information
  static const String appName = 'Delivery System';
  static const String appVersion = '1.0.0';
  
  // API Configuration
  static const String baseUrl = 'https://api.delivery.com';
  static const String apiVersion = '/api/v1';
  static const Duration apiTimeout = Duration(seconds: 30);
  
  // WebSocket Configuration
  static const String wsUrl = 'wss://ws.delivery.com';
  
  // Storage Keys
  static const String userTokenKey = 'user_token';
  static const String userDataKey = 'user_data';
  static const String settingsKey = 'app_settings';
  
  // Order Configuration
  static const double defaultDeliveryFee = 15000;
  static const double taxRate = 0.1; // 10%
  static const Duration orderTimeout = Duration(minutes: 30);
  
  // Driver Configuration
  static const double maxDeliveryDistance = 10.0; // km
  static const Duration locationUpdateInterval = Duration(seconds: 30);
  
  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;
}

class AppTheme {
  // Primary Colors - Đồng bộ với màu thương hiệu chính
  static const Color primaryColor = Color(0xFFE53E3E); // Màu đỏ thương hiệu chính
  static const Color primaryDarkColor = Color(0xFFC53030); // Màu đỏ tối
  static const Color primaryLightColor = Color(0xFFFC8181); // Màu đỏ nhạt
  
  // Accent Colors - Sử dụng màu thương hiệu làm accent
  static const Color accentColor = Color(0xFFE53E3E); // Màu đỏ thương hiệu
  static const Color accentDarkColor = Color(0xFFC53030); // Màu đỏ tối
  static const Color accentLightColor = Color(0xFFFC8181); // Màu đỏ nhạt
  
  // Status Colors - Màu trạng thái hệ thống
  static const Color successColor = Color(0xFF4CAF50); // Xanh lá - thành công
  static const Color warningColor = Color(0xFFFF9800); // Cam - cảnh báo
  static const Color errorColor = Color(0xFFF44336); // Đỏ - lỗi
  static const Color infoColor = Color(0xFFE53E3E); // Sử dụng màu thương hiệu cho info
  
  // Neutral Colors - Dark theme giống như trong ảnh
  static const Color backgroundColor = Color(0xFF1A1A1A); // Background tối chính
  static const Color surfaceColor = Color(0xFF2D2D2D); // Surface tối
  static const Color cardColor = Color(0xFF3A3A3A); // Card tối
  
  // Text Colors - Điều chỉnh cho dark theme
  static const Color textPrimaryColor = Color(0xFFFFFFFF); // Text trắng
  static const Color textSecondaryColor = Color(0xFFB0B0B0); // Text xám nhạt
  static const Color textDisabledColor = Color(0xFF666666); // Text xám đậm
  
  // Divider Color
  static const Color dividerColor = Color(0xFF4A4A4A); // Divider xám đậm
  
  // Order Status Colors - Sử dụng màu thương hiệu cho các trạng thái chính
  static const Map<String, Color> orderStatusColors = {
    'created': Color(0xFFE53E3E), // Màu thương hiệu cho đơn mới
    'confirmed': Color(0xFFE53E3E), // Màu thương hiệu cho đã xác nhận
    'pooled': Color(0xFFE53E3E), // Màu thương hiệu cho chờ tài xế
    'assigned': Color(0xFF3F51B5), // Xanh dương - đã gán
    'pickedUp': Color(0xFF9C27B0), // Tím - đã lấy hàng
    'delivered': Color(0xFF4CAF50), // Xanh lá - đã giao
    'cancelled': Color(0xFFF44336), // Đỏ - đã hủy
  };
  
  // Spacing
  static const double spacingXS = 4.0;
  static const double spacingS = 8.0;
  static const double spacingM = 16.0;
  static const double spacingL = 24.0;
  static const double spacingXL = 32.0;
  
  // Border Radius
  static const double radiusS = 4.0;
  static const double radiusM = 8.0;
  static const double radiusL = 16.0;
  static const double radiusXL = 24.0;
  
  // Elevation
  static const double elevation1 = 1.0;
  static const double elevation2 = 2.0;
  static const double elevation4 = 4.0;
  static const double elevation6 = 6.0;
  static const double elevation8 = 8.0;
}

class AppStrings {
  // Common
  static const String ok = 'OK';
  static const String cancel = 'Hủy';
  static const String save = 'Lưu';
  static const String delete = 'Xóa';
  static const String edit = 'Sửa';
  static const String add = 'Thêm';
  static const String loading = 'Đang tải...';
  static const String error = 'Lỗi';
  static const String success = 'Thành công';
  static const String noData = 'Không có dữ liệu';
  static const String retry = 'Thử lại';
  
  // Authentication
  static const String login = 'Đăng nhập';
  static const String logout = 'Đăng xuất';
  static const String email = 'Email';
  static const String password = 'Mật khẩu';
  static const String loginFailed = 'Đăng nhập thất bại';
  
  // Order Status
  static const String orderCreated = 'Đơn mới';
  static const String orderConfirmed = 'Đã xác nhận';
  static const String orderPooled = 'Chờ tài xế';
  static const String orderAssigned = 'Đã gán tài xế';
  static const String orderPickedUp = 'Đã lấy hàng';
  static const String orderDelivered = 'Đã giao';
  static const String orderCancelled = 'Đã hủy';
  
  // User Roles
  static const String admin = 'Quản trị viên';
  static const String leader = 'Trưởng nhóm';
  static const String driver = 'Tài xế';
  static const String restaurant = 'Quán ăn';
  
  // Navigation
  static const String dashboard = 'Tổng quan';
  static const String orders = 'Đơn hàng';
  static const String drivers = 'Tài xế';
  static const String restaurants = 'Quán ăn';
  static const String reports = 'Báo cáo';
  static const String settings = 'Cài đặt';
  static const String profile = 'Hồ sơ';
  static const String wallet = 'Ví tiền';
  
  // Error Messages
  static const String networkError = 'Lỗi kết nối mạng';
  static const String serverError = 'Lỗi máy chủ';
  static const String unknownError = 'Lỗi không xác định';
  static const String validationError = 'Dữ liệu không hợp lệ';
}
