import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common/models/index.dart';
import '../../../common/services/index.dart';
import '../../../common/widgets/index.dart';
import '../../../common/utils/index.dart';

class BaoCaoScreen extends ConsumerWidget {
  const BaoCaoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Báo cáo'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Quick stats
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Thống kê nhanh',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacingM),
                  Row(
                    children: [
                      Expanded(
                        child: AppButton(
                          text: 'Hôm nay',
                          type: AppButtonType.outline,
                          onPressed: () {},
                        ),
                      ),
                      const SizedBox(width: AppTheme.spacingS),
                      Expanded(
                        child: AppButton(
                          text: 'Tuần này',
                          type: AppButtonType.outline,
                          onPressed: () {},
                        ),
                      ),
                      const SizedBox(width: AppTheme.spacingS),
                      Expanded(
                        child: AppButton(
                          text: 'Tháng này',
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: AppTheme.spacingL),
            
            // Report categories
            const Text(
              'Loại báo cáo',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppTheme.spacingM),
            
            _buildReportCard(
              'Báo cáo doanh thu',
              'Thống kê doanh thu theo thời gian',
              Icons.bar_chart,
              const Color(0xFFE53E3E), // Màu thương hiệu chính
              () => _showComingSoon(context, 'Báo cáo doanh thu'),
            ),
            _buildReportCard(
              'Báo cáo đơn hàng',
              'Phân tích chi tiết các đơn hàng',
              Icons.receipt_long,
              const Color(0xFF2196F3),
              () => _showComingSoon(context, 'Báo cáo đơn hàng'),
            ),
            _buildReportCard(
              'Báo cáo tài xế',
              'Hiệu suất và hoạt động của tài xế',
              Icons.local_shipping,
              const Color(0xFFFF9800),
              () => _showComingSoon(context, 'Báo cáo tài xế'),
            ),
            _buildReportCard(
              'Báo cáo khu vực',
              'Thống kê theo từng khu vực',
              Icons.map,
              const Color(0xFF9C27B0),
              () => _showComingSoon(context, 'Báo cáo khu vực'),
            ),
            _buildReportCard(
              'Báo cáo quán ăn',
              'Thống kê đối tác quán ăn',
              Icons.restaurant,
              const Color(0xFFE91E63),
              () => _showComingSoon(context, 'Báo cáo quán ăn'),
            ),
            _buildReportCard(
              'Báo cáo tài chính',
              'Chi tiết thu chi và lợi nhuận',
              Icons.account_balance,
              const Color(0xFF607D8B),
              () => _showComingSoon(context, 'Báo cáo tài chính'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportCard(String title, String description, IconData icon, Color color, VoidCallback onTap) {
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
