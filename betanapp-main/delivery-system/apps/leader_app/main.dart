import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common/utils/index.dart';
import '../../common/services/index.dart';
import '../../common/models/index.dart';
import 'screens/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize mock data
  ApiService().initializeMockData();
  
  runApp(const ProviderScope(child: LeaderApp()));
}

class LeaderApp extends StatelessWidget {
  const LeaderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppThemes.getAppName(UserRole.leader),
      theme: AppThemes.leaderTheme,
      home: const LeaderMainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LeaderMainScreen extends ConsumerStatefulWidget {
  const LeaderMainScreen({super.key});

  @override
  ConsumerState<LeaderMainScreen> createState() => _LeaderMainScreenState();
}

class _LeaderMainScreenState extends ConsumerState<LeaderMainScreen> {
  int _currentIndex = 0;
  bool _isLoggedIn = false;

  final List<Widget> _screens = const [
    DonHangScreen(),
    TaiXeScreen(),
    PhiTaiXeScreen(),
    GiaKhuVucScreen(),
    BaoCaoScreen(),
    CaiDatScreen(),
  ];

  final List<BottomNavigationBarItem> _navItems = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.assignment),
      label: 'Đơn hàng',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.people),
      label: 'Tài xế',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.attach_money),
      label: 'Phí tài xế',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.location_on),
      label: 'Giá khu vực',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.bar_chart),
      label: 'Báo cáo',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Cài đặt',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final authService = AuthService();
    final isLoggedIn = await authService.isLoggedIn();
    
    if (!isLoggedIn) {
      // Auto login as leader for demo
      await authService.loginWithRole(UserRole.leader);
    }
    
    setState(() {
      _isLoggedIn = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isLoggedIn) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: _navItems,
        selectedItemColor: AppTheme.primaryColor,
        unselectedItemColor: AppTheme.textSecondaryColor,
        selectedFontSize: 10,
        unselectedFontSize: 10,
      ),
    );
  }
}
