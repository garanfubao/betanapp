import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common/widgets/index.dart';
import '../../../common/utils/index.dart';

class ViAdminScreen extends ConsumerWidget {
  const ViAdminScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ví Admin'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppTheme.spacingM),
        children: [
          // Balance card
          AppCard(
            child: Column(
              children: [
                const Text(
                  'Số dư hệ thống',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppTheme.textSecondaryColor,
                  ),
                ),
                const SizedBox(height: AppTheme.spacingM),
                Text(
                  AppFormatters.formatMoney(15750000),
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF6C63FF),
                  ),
                ),
                const SizedBox(height: AppTheme.spacingM),
                Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        text: 'Nạp tiền',
                        type: AppButtonType.outline,
                        onPressed: () => _showComingSoon(context, 'Nạp tiền'),
                      ),
                    ),
                    const SizedBox(width: AppTheme.spacingM),
                    Expanded(
                      child: AppButton(
                        text: 'Rút tiền',
                        onPressed: () => _showComingSoon(context, 'Rút tiền'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          const SizedBox(height: AppTheme.spacingL),
          
          // Statistics
          const Text(
            'Thống kê tài chính',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppTheme.spacingM),
          
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Doanh thu hôm nay',
                  AppFormatters.formatMoney(2450000),
                  Icons.trending_up,
                  const Color(0xFF4CAF50),
                ),
              ),
              const SizedBox(width: AppTheme.spacingM),
              Expanded(
                child: _buildStatCard(
                  'Chi phí hôm nay',
                  AppFormatters.formatMoney(1960000),
                  Icons.trending_down,
                  const Color(0xFFFF5722),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: AppTheme.spacingM),
          
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Lợi nhuận tháng',
                  AppFormatters.formatMoney(45200000),
                  Icons.account_balance_wallet,
                  const Color(0xFF2196F3),
                ),
              ),
              const SizedBox(width: AppTheme.spacingM),
              Expanded(
                child: _buildStatCard(
                  'Tăng trưởng',
                  '+12.5%',
                  Icons.show_chart,
                  const Color(0xFF9C27B0),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: AppTheme.spacingL),
          
          // Recent transactions
          const Text(
            'Giao dịch gần đây',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppTheme.spacingM),
          
          ...List.generate(5, (index) => _buildTransactionItem(
            'Hoa hồng đơn hàng #${1000 + index}',
            '-${AppFormatters.formatMoney(25000 + (index * 5000))}',
            DateTime.now().subtract(Duration(hours: index)),
          )),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return AppCard(
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: AppTheme.spacingM),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: AppTheme.spacingS),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: AppTheme.textSecondaryColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(String description, String amount, DateTime time) {
    return AppCard(
      margin: const EdgeInsets.only(bottom: AppTheme.spacingS),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: amount.startsWith('-') 
                ? const Color(0xFFFF5722).withOpacity(0.1)
                : const Color(0xFF4CAF50).withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppTheme.radiusM),
            ),
            child: Icon(
              amount.startsWith('-') ? Icons.arrow_downward : Icons.arrow_upward,
              color: amount.startsWith('-') 
                ? const Color(0xFFFF5722)
                : const Color(0xFF4CAF50),
              size: 20,
            ),
          ),
          const SizedBox(width: AppTheme.spacingM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  description,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: AppTheme.spacingXS),
                Text(
                  AppFormatters.formatRelativeTime(time),
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.textSecondaryColor,
                  ),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: amount.startsWith('-') 
                ? const Color(0xFFFF5722)
                : const Color(0xFF4CAF50),
            ),
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
