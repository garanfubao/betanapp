import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common/models/index.dart';
import '../../../common/services/index.dart';
import '../../../common/widgets/index.dart';
import '../../../common/utils/index.dart';

final dashboardStatsProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final apiService = ApiService();
  
  // Get all data
  final orders = await apiService.getOrders();
  final drivers = await apiService.getUsers(role: UserRole.driver);
  final leaders = await apiService.getUsers(role: UserRole.leader);
  final restaurants = await apiService.getUsers(role: UserRole.restaurant);
  
  // Calculate stats
  final today = DateTime.now();
  final todayOrders = orders.where((order) =>
    order.createdAt.day == today.day &&
    order.createdAt.month == today.month &&
    order.createdAt.year == today.year
  ).toList();
  
  final completedOrders = orders.where((order) => order.status == OrderStatus.delivered).length;
  final totalRevenue = orders
    .where((order) => order.status == OrderStatus.delivered)
    .fold<double>(0, (sum, order) => sum + order.total);
  
  final activeDrivers = drivers.where((driver) => driver.status == UserStatus.active).length;
  
  return {
    'totalOrders': orders.length,
    'todayOrders': todayOrders.length,
    'completedOrders': completedOrders,
    'totalRevenue': totalRevenue,
    'totalDrivers': drivers.length,
    'activeDrivers': activeDrivers,
    'totalLeaders': leaders.length,
    'totalRestaurants': restaurants.length,
    'avgOrderValue': totalRevenue / (completedOrders > 0 ? completedOrders : 1),
    'completionRate': (completedOrders / (orders.isNotEmpty ? orders.length : 1)) * 100,
  };
});

final recentOrdersProvider = FutureProvider<List<Order>>((ref) async {
  final apiService = ApiService();
  final orders = await apiService.getOrders();
  
  // Sort by created date and take latest 10
  orders.sort((a, b) => b.createdAt.compareTo(a.createdAt));
  return orders.take(10).toList();
});

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(dashboardStatsProvider);
    final recentOrdersAsync = ref.watch(recentOrdersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Admin'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.refresh(dashboardStatsProvider);
              ref.refresh(recentOrdersProvider);
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.refresh(dashboardStatsProvider);
          ref.refresh(recentOrdersProvider);
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppTheme.spacingM),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome section
              _buildWelcomeSection(),
              const SizedBox(height: AppTheme.spacingL),
              
              // Stats grid
              statsAsync.when(
                data: (stats) => _buildStatsGrid(stats),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Text('Lỗi: $error'),
              ),
              const SizedBox(height: AppTheme.spacingL),
              
              // Charts section
              statsAsync.when(
                data: (stats) => _buildChartsSection(stats),
                loading: () => const SizedBox.shrink(),
                error: (error, stack) => const SizedBox.shrink(),
              ),
              const SizedBox(height: AppTheme.spacingL),
              
              // Recent orders
              const Text(
                'Đơn hàng gần đây',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppTheme.spacingM),
              recentOrdersAsync.when(
                data: (orders) => _buildRecentOrders(orders),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Text('Lỗi: $error'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return AppCard(
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: const Color(0xFFE53E3E).withOpacity(0.1), // Màu thương hiệu chính
              borderRadius: BorderRadius.circular(AppTheme.radiusL),
            ),
            child: const Icon(
              Icons.admin_panel_settings,
              size: 32,
              color: const Color(0xFFE53E3E), // Màu thương hiệu chính
            ),
          ),
          const SizedBox(width: AppTheme.spacingM),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Chào mừng Admin!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: AppTheme.spacingS),
                Text(
                  'Hệ thống giao hàng đang hoạt động tốt',
                  style: TextStyle(
                    color: AppTheme.textSecondaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid(Map<String, dynamic> stats) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: AppTheme.spacingM,
      mainAxisSpacing: AppTheme.spacingM,
      childAspectRatio: 1.2,
      children: [
        _buildStatCard(
          'Tổng đơn hàng',
          stats['totalOrders'].toString(),
          'Đơn hôm nay: ${stats['todayOrders']}',
          Icons.receipt_long,
          const Color(0xFF4CAF50),
        ),
        _buildStatCard(
          'Doanh thu',
          AppFormatters.formatMoney(stats['totalRevenue']),
          'TB/đơn: ${AppFormatters.formatMoney(stats['avgOrderValue'])}',
          Icons.monetization_on,
          const Color(0xFFFF9800),
        ),
        _buildStatCard(
          'Tài xế',
          '${stats['activeDrivers']}/${stats['totalDrivers']}',
          'Đang hoạt động',
          Icons.local_shipping,
          const Color(0xFF2196F3),
        ),
        _buildStatCard(
          'Tỷ lệ thành công',
          '${stats['completionRate'].toStringAsFixed(1)}%',
          '${stats['completedOrders']} đơn hoàn tất',
          Icons.check_circle,
          const Color(0xFF9C27B0),
        ),
        _buildStatCard(
          'Leader',
          stats['totalLeaders'].toString(),
          'Quản lý khu vực',
          Icons.supervisor_account,
          const Color(0xFF607D8B),
        ),
        _buildStatCard(
          'Quán ăn',
          stats['totalRestaurants'].toString(),
          'Đối tác hoạt động',
          Icons.restaurant,
          const Color(0xFFE91E63),
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, String subtitle, IconData icon, Color color) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppTheme.spacingS),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppTheme.radiusS),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const Spacer(),
              Icon(Icons.trending_up, color: color, size: 16),
            ],
          ),
          const SizedBox(height: AppTheme.spacingM),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: AppTheme.spacingXS),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppTheme.spacingXS),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 10,
              color: AppTheme.textSecondaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChartsSection(Map<String, dynamic> stats) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Thống kê tổng quan',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppTheme.spacingM),
        Row(
          children: [
            Expanded(
              child: AppCard(
                child: Column(
                  children: [
                    const Text(
                      'Tỷ lệ hoàn thành',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingM),
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: Stack(
                        children: [
                          Center(
                            child: SizedBox(
                              width: 100,
                              height: 100,
                              child: CircularProgressIndicator(
                                value: stats['completionRate'] / 100,
                                strokeWidth: 8,
                                backgroundColor: AppTheme.textDisabledColor.withOpacity(0.3),
                                valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF4CAF50)),
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              '${stats['completionRate'].toStringAsFixed(1)}%',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF4CAF50),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: AppTheme.spacingM),
            Expanded(
              child: AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Phân bố đơn hàng',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingM),
                    _buildOrderDistribution(stats),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildOrderDistribution(Map<String, dynamic> stats) {
    final total = stats['totalOrders'] as int;
    final completed = stats['completedOrders'] as int;
    final pending = total - completed;
    
    return Column(
      children: [
        _buildProgressBar('Hoàn thành', completed, total, const Color(0xFF4CAF50)),
        const SizedBox(height: AppTheme.spacingS),
        _buildProgressBar('Đang xử lý', pending, total, const Color(0xFFFF9800)),
      ],
    );
  }

  Widget _buildProgressBar(String label, int value, int total, Color color) {
    final percentage = total > 0 ? (value / total) : 0.0;
    
    return Column(
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 12),
            ),
            const Spacer(),
            Text(
              value.toString(),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppTheme.spacingXS),
        LinearProgressIndicator(
          value: percentage,
          backgroundColor: AppTheme.textDisabledColor.withOpacity(0.3),
          valueColor: AlwaysStoppedAnimation<Color>(color),
        ),
      ],
    );
  }

  Widget _buildRecentOrders(List<Order> orders) {
    if (orders.isEmpty) {
      // Chỉ hiển thị background tối, không có thông báo
      return Container(
        color: AppTheme.backgroundColor,
      );
    }

    return Column(
      children: orders.take(5).map((order) => OrderCard(
        order: order,
        showDriver: true,
        showCustomer: true,
        onTap: () => {}, // TODO: Navigate to order details
      )).toList(),
    );
  }
}
