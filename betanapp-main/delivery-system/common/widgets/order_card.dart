import 'package:flutter/material.dart';
import '../models/index.dart';
import '../utils/index.dart';
import 'index.dart';

class OrderCard extends StatelessWidget {
  final Order order;
  final String? buttonText;
  final VoidCallback? onButtonPressed;
  final VoidCallback? onTap;
  final bool showDriver;
  final bool showCustomer;
  final bool showEarnings;

  const OrderCard({
    super.key,
    required this.order,
    this.buttonText,
    this.onButtonPressed,
    this.onTap,
    this.showDriver = false,
    this.showCustomer = true,
    this.showEarnings = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      margin: const EdgeInsets.only(bottom: AppTheme.spacingM),
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header với order ID và status
          Row(
            children: [
              Expanded(
                child: Text(
                  AppFormatters.formatOrderId(order.id),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimaryColor,
                  ),
                ),
              ),
              StatusBadge.orderStatus(order.status),
            ],
          ),
          const SizedBox(height: AppTheme.spacingM),
          
          // Customer info (nếu showCustomer = true)
          if (showCustomer) ...[
            _buildInfoRow(
              Icons.person_outline,
              '${order.customerName} • ${AppFormatters.formatPhoneNumber(order.customerPhone)}',
              AppTheme.textPrimaryColor,
            ),
            const SizedBox(height: AppTheme.spacingS),
          ],
          
          // Driver info (nếu showDriver = true và có driver)
          if (showDriver && order.driverName != null) ...[
            _buildInfoRow(
              Icons.local_shipping_outlined,
              order.driverName!,
              const Color(0xFFE53E3E), // Màu thương hiệu chính
            ),
            const SizedBox(height: AppTheme.spacingS),
          ],
          
          // Restaurant info
          _buildInfoRow(
            Icons.restaurant_outlined,
            order.restaurantName,
            AppTheme.textSecondaryColor,
          ),
          const SizedBox(height: AppTheme.spacingS),
          
          // Delivery address
          _buildInfoRow(
            Icons.location_on_outlined,
            order.deliveryAddress.address,
            AppTheme.textSecondaryColor,
          ),
          const SizedBox(height: AppTheme.spacingS),
          
          // Time info
          _buildInfoRow(
            Icons.access_time_outlined,
            _getTimeInfo(),
            AppTheme.textSecondaryColor,
          ),
          const SizedBox(height: AppTheme.spacingM),
          
          // Bottom section với price và button
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${order.items.length} món',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppTheme.textSecondaryColor,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingXS),
                    Text(
                      AppFormatters.formatMoney(order.total),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFE53E3E), // Màu đỏ
                      ),
                    ),
                    if (showEarnings) ...[
                      const SizedBox(height: AppTheme.spacingXS),
                      Text(
                        'Hoa hồng: ${AppFormatters.formatMoney(order.deliveryFee * 0.8)}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppTheme.successColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (buttonText != null && onButtonPressed != null) ...[
                const SizedBox(width: AppTheme.spacingM),
                AppButton(
                  text: buttonText!,
                  onPressed: onButtonPressed,
                  type: AppButtonType.primary,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor, // Background xám đậm cho mỗi row
        borderRadius: BorderRadius.circular(AppTheme.radiusS),
        border: Border.all(
          color: AppTheme.dividerColor, // Border xám đậm
          width: 0.5,
        ),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: AppTheme.spacingS),
            child: Icon(
              icon,
              size: 16,
              color: AppTheme.textSecondaryColor,
            ),
          ),
          const SizedBox(width: AppTheme.spacingS),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: textColor,
                fontWeight: textColor == AppTheme.textPrimaryColor 
                  ? FontWeight.w600 
                  : FontWeight.normal,
              ),
            ),
          ),
          const SizedBox(width: AppTheme.spacingS),
        ],
      ),
    );
  }

  String _getTimeInfo() {
    switch (order.status) {
      case OrderStatus.created:
        return 'Đặt lúc: ${AppFormatters.formatDateTime(order.createdAt)}';
      case OrderStatus.confirmed:
        return 'Xác nhận: ${AppFormatters.formatRelativeTime(order.confirmedAt!)}';
      case OrderStatus.pooled:
        return 'Chờ tài xế: ${AppFormatters.formatRelativeTime(order.updatedAt)}';
      case OrderStatus.assigned:
        return 'Nhận đơn: ${AppFormatters.formatRelativeTime(order.assignedAt!)}';
      case OrderStatus.pickedUp:
        return 'Đã lấy hàng: ${AppFormatters.formatRelativeTime(order.pickedUpAt!)}';
      case OrderStatus.delivered:
        return 'Hoàn tất: ${AppFormatters.formatRelativeTime(order.deliveredAt!)}';
      case OrderStatus.cancelled:
        return 'Đã hủy: ${AppFormatters.formatRelativeTime(order.cancelledAt!)}';
    }
  }
}

// Widget riêng cho việc hiển thị thống kê đơn hàng
class OrderStatsCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  const OrderStatsCard({
    super.key,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppTheme.spacingS),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppTheme.radiusM),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              const SizedBox(width: AppTheme.spacingM),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppTheme.textSecondaryColor,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingXS),
                    Text(
                      value,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                    if (subtitle.isNotEmpty) ...[
                      const SizedBox(height: AppTheme.spacingXS),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 10,
                          color: AppTheme.textSecondaryColor,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
