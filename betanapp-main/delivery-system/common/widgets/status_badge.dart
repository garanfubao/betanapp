import 'package:flutter/material.dart';
import '../models/index.dart';
import '../utils/index.dart';

class StatusBadge extends StatelessWidget {
  final String status;
  final Color? color;
  final double? fontSize;
  final EdgeInsets? padding;

  const StatusBadge({
    super.key,
    required this.status,
    this.color,
    this.fontSize,
    this.padding,
  });

  StatusBadge.orderStatus(OrderStatus status, {super.key})
      : status = status.name,
        color = null,
        fontSize = null,
        padding = null;

  StatusBadge.userStatus(UserStatus status, {super.key})
      : status = status.name,
        color = null,
        fontSize = null,
        padding = null;

  StatusBadge.transactionStatus(TransactionStatus status, {super.key})
      : status = status.name,
        color = null,
        fontSize = null,
        padding = null;

  @override
  Widget build(BuildContext context) {
    final badgeColor = color ?? _getOrderStatusColor(status);
    final textColor = _getTextColor(badgeColor);

    return Container(
      padding: padding ?? const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingS,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: badgeColor,
        borderRadius: BorderRadius.circular(AppTheme.radiusS),
        border: Border.all(
          color: badgeColor,
          width: 1,
        ),
      ),
      child: Text(
        _getStatusText(status),
        style: TextStyle(
          color: textColor,
          fontSize: fontSize ?? 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Color _getOrderStatusColor(String status) {
    // Sử dụng màu thương hiệu cho các trạng thái chính
    const Color primaryBrand = Color(0xFFE53E3E);
    
    switch (status.toLowerCase()) {
      case 'created':
      case 'confirmed':
      case 'pooled':
        return primaryBrand; // Màu thương hiệu chính
      case 'assigned':
        return const Color(0xFF3F51B5); // Xanh dương
      case 'picked_up':
        return const Color(0xFF9C27B0); // Tím
      case 'delivered':
        return const Color(0xFF4CAF50); // Xanh lá
      case 'cancelled':
        return const Color(0xFFF44336); // Đỏ
      default:
        return AppTheme.textSecondaryColor;
    }
  }

  Color _getTextColor(Color backgroundColor) {
    // Tính toán màu text dựa trên độ sáng của background
    final luminance = backgroundColor.computeLuminance();
    return luminance > 0.5 ? Colors.black : Colors.white;
  }

  String _getStatusText(String status) {
    switch (status.toLowerCase()) {
      case 'created':
        return 'Đơn mới';
      case 'confirmed':
        return 'Đã xác nhận';
      case 'pooled':
        return 'Chờ tài xế';
      case 'assigned':
        return 'Đã gán';
      case 'picked_up':
        return 'Đã lấy hàng';
      case 'delivered':
        return 'Đã giao';
      case 'cancelled':
        return 'Đã hủy';
      case 'active':
        return 'Hoạt động';
      case 'inactive':
        return 'Không hoạt động';
      case 'banned':
        return 'Bị cấm';
      case 'pending':
        return 'Chờ xử lý';
      case 'completed':
        return 'Hoàn tất';
      case 'failed':
        return 'Thất bại';
      case 'refunded':
        return 'Đã hoàn tiền';
      default:
        return status;
    }
  }
}
