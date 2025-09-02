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
  
  runApp(const ProviderScope(child: RestaurantApp()));
}

class RestaurantApp extends StatelessWidget {
  const RestaurantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppThemes.getAppName(UserRole.restaurant),
      theme: AppThemes.restaurantTheme,
      home: const RestaurantMainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RestaurantMainScreen extends ConsumerStatefulWidget {
  const RestaurantMainScreen({super.key});

  @override
  ConsumerState<RestaurantMainScreen> createState() => _RestaurantMainScreenState();
}

class _RestaurantMainScreenState extends ConsumerState<RestaurantMainScreen> {
  int _currentIndex = 0;
  bool _isLoggedIn = false;

  final List<Widget> _screens = const [
    DonMoiScreen(),
    DangChuanBiScreen(),
    DaBanGiaoScreen(),
    HoanTatScreen(),
    MenuMonScreen(),
  ];

  final List<BottomNavigationBarItem> _navItems = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.assignment_turned_in),
      label: 'Đơn mới',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.restaurant_menu),
      label: 'Đang chuẩn bị',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.delivery_dining),
      label: 'Đã bàn giao',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.check_circle),
      label: 'Hoàn tất',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.menu),
      label: 'Menu',
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
      // Auto login as restaurant for demo
      await authService.loginWithRole(UserRole.restaurant);
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
