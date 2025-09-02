import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common/models/index.dart';
import '../../../common/services/index.dart';
import '../../../common/widgets/index.dart';
import '../../../common/utils/index.dart';


class DonMoiScreen extends ConsumerStatefulWidget {
  const DonMoiScreen({super.key});

  @override
  ConsumerState<DonMoiScreen> createState() => _DonMoiScreenState();
}

class _DonMoiScreenState extends ConsumerState<DonMoiScreen> {
  final _formKey = GlobalKey<FormState>();
  final _customerNameController = TextEditingController();
  final _customerPhoneController = TextEditingController();
  final _deliveryAddressController = TextEditingController();
  final _noteController = TextEditingController();
  final _totalAmountController = TextEditingController();
  
  // Danh sách khu vực và phí giao hàng (mock data - sau này sẽ lấy từ API)
  final Map<String, double> _areaDeliveryFees = {
    'Thanh Xuân': 10000,
    'Cầu Giấy': 12000,
    'Đống Đa': 15000,
    'Hai Bà Trưng': 18000,
    'Hoàn Kiếm': 20000,
    'Tây Hồ': 22000,
    'Long Biên': 25000,
    'Gia Lâm': 30000,
    'Đông Anh': 35000,
    'Sóc Sơn': 40000,
  };

  double _deliveryFee = 15000; // Phí giao hàng mặc định
  double _tax = 0;
  double _total = 0;

  @override
  void initState() {
    super.initState();
    _totalAmountController.addListener(_calculateTotal);
  }

  @override
  void dispose() {
    _customerNameController.dispose();
    _customerPhoneController.dispose();
    _deliveryAddressController.dispose();
    _noteController.dispose();
    _totalAmountController.dispose();
    super.dispose();
  }

  void _calculateTotal() {
    final amount = double.tryParse(_totalAmountController.text) ?? 0;
    _tax = amount * 0.1; // Thuế 10%
    _total = amount + _deliveryFee + _tax;
    setState(() {});
  }

  void _updateDeliveryFee(String address) {
    // Tìm khu vực trong địa chỉ
    String? foundArea;
    for (String area in _areaDeliveryFees.keys) {
      if (address.toLowerCase().contains(area.toLowerCase())) {
        foundArea = area;
        break;
      }
    }
    
    if (foundArea != null) {
      setState(() {
        _deliveryFee = _areaDeliveryFees[foundArea]!;
      });
      _calculateTotal();
      
      // Hiển thị thông báo
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Đã cập nhật phí giao hàng: ${foundArea} = ${AppFormatters.formatMoney(_deliveryFee)}'),
          backgroundColor: AppTheme.primaryColor,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor, // Sử dụng dark theme
      body: Column(
        children: [
          // Header
          _buildHeader(),
          
          // Nội dung chính
          Expanded(
            child: _buildContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: AppTheme.primaryColor, // Sử dụng màu thương hiệu chính
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Text(
            '12:53',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                'Đơn hàng mới',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              // Refresh logic
            },
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Form tạo đơn hàng
          _buildOrderForm(),
        ],
      ),
    );
  }



  Widget _buildOrderForm() {
    return AppCard(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Thông tin khách hàng',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryColor,
              ),
            ),
            const SizedBox(height: 16),
            
            // Tên khách hàng
            TextFormField(
              controller: _customerNameController,
              decoration: const InputDecoration(
                labelText: 'Tên khách hàng *',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Vui lòng nhập tên khách hàng';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            
            // Số điện thoại
            TextFormField(
              controller: _customerPhoneController,
              decoration: const InputDecoration(
                labelText: 'Số điện thoại *',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.phone),
              ),
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Vui lòng nhập số điện thoại';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            
            // Địa chỉ giao hàng với auto-detect khu vực
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _deliveryAddressController,
                  decoration: InputDecoration(
                    labelText: 'Địa chỉ giao hàng *',
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.location_on),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        if (_deliveryAddressController.text.isNotEmpty) {
                          _updateDeliveryFee(_deliveryAddressController.text);
                        }
                      },
                      tooltip: 'Tự động cập nhật phí giao hàng',
                    ),
                  ),
                  maxLines: 2,
                  onChanged: (value) {
                    // Tự động cập nhật phí giao hàng khi nhập địa chỉ
                    if (value.length > 10) { // Chỉ cập nhật khi đủ ký tự
                      _updateDeliveryFee(value);
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập địa chỉ giao hàng';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                // Hiển thị thông tin khu vực được detect
                _buildAreaInfo(),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Ghi chú
            TextFormField(
              controller: _noteController,
              decoration: const InputDecoration(
                labelText: 'Ghi chú',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.note),
              ),
              maxLines: 2,
            ),
            
            const SizedBox(height: 24),
            
            // Số tiền cần thanh toán
            _buildTotalAmountSection(),
            
            const SizedBox(height: 24),
            
            // Tổng tiền
            _buildTotalSection(),
            
            const SizedBox(height: 24),
            
            // Nút tạo đơn
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildAreaInfo() {
    // Tìm khu vực trong địa chỉ
    String? foundArea;
    for (String area in _areaDeliveryFees.keys) {
      if (_deliveryAddressController.text.toLowerCase().contains(area.toLowerCase())) {
        foundArea = area;
        break;
      }
    }

    if (foundArea != null) {
      return Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppTheme.primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppTheme.primaryColor.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Icon(Icons.check_circle, color: AppTheme.primaryColor, size: 16),
            const SizedBox(width: 8),
            Text(
              'Khu vực: $foundArea - Phí giao hàng: ${AppFormatters.formatMoney(_areaDeliveryFees[foundArea]!)}',
              style: TextStyle(
                color: AppTheme.primaryColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppTheme.warningColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.warningColor.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.info, color: AppTheme.warningColor, size: 16),
          const SizedBox(width: 8),
          Text(
            'Nhập địa chỉ để tự động cập nhật phí giao hàng',
            style: TextStyle(
              color: AppTheme.warningColor,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalAmountSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Số tiền cần thanh toán',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryColor,
          ),
        ),
        const SizedBox(height: 12),
        
        TextFormField(
          controller: _totalAmountController,
          decoration: const InputDecoration(
            labelText: 'Số tiền (VNĐ) *',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.payment),
            hintText: 'Nhập số tiền món ăn',
          ),
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Vui lòng nhập số tiền';
            }
            final amount = double.tryParse(value);
            if (amount == null || amount <= 0) {
              return 'Số tiền phải là số dương';
            }
            return null;
          },
        ),
        
        const SizedBox(height: 8),
        
        // Hiển thị danh sách khu vực và phí giao hàng
        _buildAreaDeliveryFeesList(),
      ],
    );
  }

  Widget _buildAreaDeliveryFeesList() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info, color: AppTheme.primaryColor, size: 16),
              const SizedBox(width: 8),
              Text(
                'Bảng phí giao hàng theo khu vực:',
                style: TextStyle(
                  color: AppTheme.primaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: _areaDeliveryFees.entries.map((entry) {
              final isSelected = _deliveryAddressController.text.toLowerCase().contains(entry.key.toLowerCase());
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isSelected ? AppTheme.primaryColor.withOpacity(0.1) : AppTheme.cardColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected ? AppTheme.primaryColor : AppTheme.dividerColor,
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Text(
                  '${entry.key}: ${AppFormatters.formatMoney(entry.value)}',
                  style: TextStyle(
                    fontSize: 10,
                    color: isSelected ? AppTheme.primaryColor : AppTheme.textSecondaryColor,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.primaryColor.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          _buildTotalRow('Tiền món ăn', double.tryParse(_totalAmountController.text) ?? 0),
          _buildTotalRow('Phí giao hàng', _deliveryFee),
          _buildTotalRow('Thuế (10%)', _tax),
          const Divider(),
          _buildTotalRow('Tổng cộng', _total, isBold: true),
        ],
      ),
    );
  }

  Widget _buildTotalRow(String label, double amount, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: isBold ? 16 : 14,
              color: AppTheme.textPrimaryColor, // Màu trắng cho label
            ),
          ),
          Text(
            AppFormatters.formatMoney(amount),
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: isBold ? 16 : 14,
              color: isBold ? AppTheme.primaryColor : AppTheme.textPrimaryColor, // Màu thương hiệu cho tổng, trắng cho các mục khác
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child:       AppButton(
        text: 'Tạo đơn hàng',
        onPressed: _totalAmountController.text.isEmpty ? null : _createOrder,
        type: AppButtonType.primary,
        isFullWidth: true,
        height: 56,
        fontSize: 18,
      ),
    );
  }

  void _createOrder() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final amount = double.tryParse(_totalAmountController.text);
    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng nhập số tiền hợp lệ'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Tạo đơn hàng mới
    final newOrder = Order(
      id: 'ORDER-${DateTime.now().millisecondsSinceEpoch}',
      customerId: 'CUST-${DateTime.now().millisecondsSinceEpoch}',
      customerName: _customerNameController.text.trim(),
      customerPhone: _customerPhoneController.text.trim(),
      restaurantId: 'REST-001', // ID quán hiện tại
      restaurantName: 'Quán của bạn', // Tên quán hiện tại
      driverId: null,
      driverName: null,
      items: [
        OrderItem(
          id: 'ITEM-${DateTime.now().millisecondsSinceEpoch}',
          name: 'Đơn hàng tổng hợp',
          price: amount,
          quantity: 1,
        ),
      ],
      restaurantAddress: Address(
        address: 'Địa chỉ quán của bạn',
        latitude: 10.7769,
        longitude: 106.7009,
      ),
      deliveryAddress: Address(
        address: _deliveryAddressController.text.trim(),
        latitude: 10.7770,
        longitude: 106.7010,
      ),
      status: OrderStatus.confirmed, // Chuyển sang trạng thái đang chuẩn bị
      paymentMethod: PaymentMethod.cash,
      paymentStatus: PaymentStatus.pending,
      itemsTotal: amount,
      deliveryFee: _deliveryFee,
      tax: _tax,
      discount: 0,
      total: _total,
      note: _noteController.text.trim(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      confirmedAt: DateTime.now(), // Xác nhận ngay lập tức
    );

    // TODO: Gửi đơn hàng lên server
    // await apiService.createOrder(newOrder);

    // Reset form
    _formKey.currentState!.reset();
    _customerNameController.clear();
    _customerPhoneController.clear();
    _deliveryAddressController.clear();
    _noteController.clear();
    _totalAmountController.clear();
    setState(() {
      _deliveryFee = 15000;
      _tax = 0;
      _total = 0;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Đã tạo đơn hàng thành công! Đơn hàng đã chuyển sang tab "Đang chuẩn bị"'),
        backgroundColor: AppTheme.primaryColor,
      ),
    );
  }
}
