import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common/models/index.dart';
import '../../../common/services/index.dart';
import '../../../common/widgets/index.dart';
import '../../../common/utils/index.dart';

final availableOrdersProvider = FutureProvider<List<Order>>((ref) async {
  final apiService = ApiService();
  return await apiService.getOrders(status: OrderStatus.pooled);
});

class DonMoiScreen extends ConsumerWidget {
  const DonMoiScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ordersAsync = ref.watch(availableOrdersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Đơn hàng mới'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.refresh(availableOrdersProvider),
          ),
        ],
      ),
      body: ordersAsync.when(
        data: (orders) => _buildOrdersList(context, ref, orders),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error, size: 64, color: AppTheme.errorColor),
              const SizedBox(height: AppTheme.spacingM),
              Text('Lỗi: $error'),
              const SizedBox(height: AppTheme.spacingM),
              AppButton(
                text: 'Thử lại',
                onPressed: () => ref.refresh(availableOrdersProvider),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrdersList(BuildContext context, WidgetRef ref, List<Order> orders) {
    if (orders.isEmpty) {
      // Chỉ hiển thị background tối, không có thông báo
      return Container(
        color: AppTheme.backgroundColor,
      );
    }

    return RefreshIndicator(
      onRefresh: () async => ref.refresh(availableOrdersProvider),
      child: ListView.builder(
        padding: const EdgeInsets.all(AppTheme.spacingM),
        itemCount: orders.length,
        itemBuilder: (context, index) => _buildOrderCard(context, ref, orders[index]),
      ),
    );
  }

  Widget _buildOrderCard(BuildContext context, WidgetRef ref, Order order) {
    return OrderCard(
      order: order,
      buttonText: 'Nhận đơn',
      onButtonPressed: () => _acceptOrder(context, ref, order),
      onTap: () => _showOrderDetails(context, ref, order),
      showEarnings: true,
    );
  }

  void _showOrderDetails(BuildContext context, WidgetRef ref, Order order) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppTheme.radiusL)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        expand: false,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(AppTheme.spacingL),
          color: AppTheme.backgroundColor, // Dark theme background
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppTheme.textDisabledColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: AppTheme.spacingL),
              
              const Text(
                'Chi tiết đơn hàng',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppTheme.spacingM),
              
              Expanded(
                child: ListView(
                  controller: scrollController,
                  children: [
                    // Order info
                    _buildDetailSection(
                      'Thông tin đơn hàng',
                      [
                        _buildDetailRow('Mã đơn', AppFormatters.formatOrderId(order.id)),
                        _buildDetailRow('Khách hàng', order.customerName),
                        _buildDetailRow('Số điện thoại', AppFormatters.formatPhoneNumber(order.customerPhone)),
                        _buildDetailRow('Thời gian đặt', AppFormatters.formatDateTime(order.createdAt)),
                      ],
                    ),
                    
                    // Restaurant info
                    _buildDetailSection(
                      'Quán ăn',
                      [
                        _buildDetailRow('Tên quán', order.restaurantName),
                        _buildDetailRow('Địa chỉ', order.restaurantAddress.address),
                      ],
                    ),
                    
                    // Items
                    _buildDetailSection(
                      'Món ăn',
                      order.items.map((item) => _buildDetailRow(
                        '${item.name} x${item.quantity}',
                        AppFormatters.formatMoney(item.totalPrice),
                      )).toList(),
                    ),
                    
                    // Payment info
                    _buildDetailSection(
                      'Thanh toán',
                      [
                        _buildDetailRow('Tiền món ăn', AppFormatters.formatMoney(order.itemsTotal)),
                        _buildDetailRow('Phí giao hàng', AppFormatters.formatMoney(order.deliveryFee)),
                        _buildDetailRow('Thuế', AppFormatters.formatMoney(order.tax)),
                        const Divider(),
                        _buildDetailRow(
                          'Tổng cộng',
                          AppFormatters.formatMoney(order.total),
                          isBold: true,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: AppTheme.spacingL),
              AppButton(
                text: 'Nhận đơn hàng',
                onPressed: () {
                  Navigator.pop(context);
                  _acceptOrder(context, ref, order);
                },
                isFullWidth: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppTheme.spacingM),
        ...children,
        const SizedBox(height: AppTheme.spacingL),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.spacingS),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(color: AppTheme.textSecondaryColor),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                color: isBold ? AppTheme.primaryColor : AppTheme.textPrimaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _acceptOrder(BuildContext context, WidgetRef ref, Order order) async {
    try {
      final apiService = ApiService();
      final authService = AuthService();
      final currentUser = authService.currentUser;
      
      if (currentUser == null) {
        throw Exception('Không tìm thấy thông tin tài xế');
      }

      await apiService.assignDriverToOrder(order.id, currentUser.id);
      
      // Refresh the orders list
      ref.refresh(availableOrdersProvider);
      
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Đã nhận đơn hàng thành công!'),
            backgroundColor: AppTheme.successColor,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Lỗi: $e'),
            backgroundColor: AppTheme.errorColor,
          ),
        );
      }
    }
  }
}
