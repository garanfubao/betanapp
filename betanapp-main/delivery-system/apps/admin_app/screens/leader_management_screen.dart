import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common/models/index.dart';
import '../../../common/services/index.dart';
import '../../../common/widgets/index.dart';
import '../../../common/utils/index.dart';

final leadersProvider = FutureProvider<List<User>>((ref) async {
  final apiService = ApiService();
  return await apiService.getUsers(role: UserRole.leader);
});

class LeaderManagementScreen extends ConsumerWidget {
  const LeaderManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final leadersAsync = ref.watch(leadersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý Leader'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddLeaderDialog(context),
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.refresh(leadersProvider),
          ),
        ],
      ),
      body: leadersAsync.when(
        data: (leaders) => _buildLeadersList(context, leaders),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Lỗi: $error')),
      ),
    );
  }

  Widget _buildLeadersList(BuildContext context, List<User> leaders) {
    if (leaders.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.supervisor_account, size: 64, color: AppTheme.textSecondaryColor),
            SizedBox(height: AppTheme.spacingM),
            Text('Chưa có leader nào'),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppTheme.spacingM),
      itemCount: leaders.length,
      itemBuilder: (context, index) => _buildLeaderCard(context, leaders[index]),
    );
  }

  Widget _buildLeaderCard(BuildContext context, User leader) {
    return AppCard(
      margin: const EdgeInsets.only(bottom: AppTheme.spacingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: const Color(0xFF6C63FF).withOpacity(0.1),
                child: Text(
                  leader.name.substring(0, 1).toUpperCase(),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF6C63FF),
                  ),
                ),
              ),
              const SizedBox(width: AppTheme.spacingM),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      leader.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingS),
                    Text(
                      'Khu vực: ${leader.areaCode ?? "Chưa xác định"}',
                      style: const TextStyle(color: AppTheme.textSecondaryColor),
                    ),
                  ],
                ),
              ),
              StatusBadge.userStatus(leader.status),
            ],
          ),
          const SizedBox(height: AppTheme.spacingM),
          Row(
            children: [
              const Icon(Icons.phone, size: 16, color: AppTheme.textSecondaryColor),
              const SizedBox(width: AppTheme.spacingS),
              Text(AppFormatters.formatPhoneNumber(leader.phone)),
              const SizedBox(width: AppTheme.spacingL),
              const Icon(Icons.people, size: 16, color: AppTheme.textSecondaryColor),
              const SizedBox(width: AppTheme.spacingS),
              Text('${leader.managedDrivers?.length ?? 0} tài xế'),
            ],
          ),
        ],
      ),
    );
  }

  void _showAddLeaderDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.surfaceColor, // Dark theme background
        title: const Text('Thêm Leader mới'),
        content: const Text('Tính năng thêm leader đang được phát triển...'),
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
