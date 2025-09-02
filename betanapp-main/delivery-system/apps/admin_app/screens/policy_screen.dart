import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common/widgets/index.dart';
import '../../../common/utils/index.dart';

class PolicyScreen extends ConsumerWidget {
  const PolicyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chính sách hệ thống'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppTheme.spacingM),
        children: [
          _buildPolicyCard(
            'Chính sách hoa hồng',
            'Cấu hình tỷ lệ hoa hồng cho tài xế và leader',
            Icons.monetization_on,
            const Color(0xFF4CAF50),
            () => _showComingSoon(context, 'Chính sách hoa hồng'),
          ),
          _buildPolicyCard(
            'Chính sách giá cước',
            'Thiết lập giá cước theo khu vực và thời gian',
            Icons.local_atm,
            const Color(0xFF2196F3),
            () => _showComingSoon(context, 'Chính sách giá cước'),
          ),
          _buildPolicyCard(
            'Quy định tài xế',
            'Thiết lập quy định và yêu cầu cho tài xế',
            Icons.local_shipping,
            const Color(0xFFFF9800),
            () => _showComingSoon(context, 'Quy định tài xế'),
          ),
          _buildPolicyCard(
            'Chính sách quán ăn',
            'Quy định dành cho đối tác quán ăn',
            Icons.restaurant,
            const Color(0xFFE91E63),
            () => _showComingSoon(context, 'Chính sách quán ăn'),
          ),
        ],
      ),
    );
  }

  Widget _buildPolicyCard(String title, String description, IconData icon, Color color, VoidCallback onTap) {
    return AppCard(
      margin: const EdgeInsets.only(bottom: AppTheme.spacingM),
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppTheme.radiusM),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(width: AppTheme.spacingM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppTheme.spacingS),
                Text(
                  description,
                  style: const TextStyle(
                    color: AppTheme.textSecondaryColor,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right,
            color: AppTheme.textSecondaryColor,
          ),
        ],
      ),
    );
  }

  void _showComingSoon(BuildContext context, String feature) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.surfaceColor, // Dark theme background
        title: Text(feature),
        content: Text('Tính năng $feature đang được phát triển...'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Đóng'),
          ),
        ],
      ),
    );
  }
}
