// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderItem _$OrderItemFromJson(Map<String, dynamic> json) => OrderItem(
      id: json['id'] as String,
      name: json['name'] as String,
      quantity: json['quantity'] as int,
      price: (json['price'] as num).toDouble(),
      note: json['note'] as String?,
    );

Map<String, dynamic> _$OrderItemToJson(OrderItem instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'quantity': instance.quantity,
      'price': instance.price,
      'note': instance.note,
    };

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      address: json['address'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      note: json['note'] as String?,
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'address': instance.address,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'note': instance.note,
    };

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      id: json['id'] as String,
      customerId: json['customerId'] as String,
      customerName: json['customerName'] as String,
      customerPhone: json['customerPhone'] as String,
      restaurantId: json['restaurantId'] as String,
      restaurantName: json['restaurantName'] as String,
      driverId: json['driverId'] as String?,
      driverName: json['driverName'] as String?,
      items: (json['items'] as List<dynamic>)
          .map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      restaurantAddress: Address.fromJson(
          json['restaurantAddress'] as Map<String, dynamic>),
      deliveryAddress: Address.fromJson(
          json['deliveryAddress'] as Map<String, dynamic>),
      status: $enumDecode(_$OrderStatusEnumMap, json['status']),
      paymentMethod: $enumDecode(_$PaymentMethodEnumMap, json['paymentMethod']),
      paymentStatus: $enumDecode(_$PaymentStatusEnumMap, json['paymentStatus']),
      itemsTotal: (json['itemsTotal'] as num).toDouble(),
      deliveryFee: (json['deliveryFee'] as num).toDouble(),
      tax: (json['tax'] as num).toDouble(),
      discount: (json['discount'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
      note: json['note'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      confirmedAt: json['confirmedAt'] == null
          ? null
          : DateTime.parse(json['confirmedAt'] as String),
      assignedAt: json['assignedAt'] == null
          ? null
          : DateTime.parse(json['assignedAt'] as String),
      pickedUpAt: json['pickedUpAt'] == null
          ? null
          : DateTime.parse(json['pickedUpAt'] as String),
      deliveredAt: json['deliveredAt'] == null
          ? null
          : DateTime.parse(json['deliveredAt'] as String),
      cancelledAt: json['cancelledAt'] == null
          ? null
          : DateTime.parse(json['cancelledAt'] as String),
      cancelReason: json['cancelReason'] as String?,
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'id': instance.id,
      'customerId': instance.customerId,
      'customerName': instance.customerName,
      'customerPhone': instance.customerPhone,
      'restaurantId': instance.restaurantId,
      'restaurantName': instance.restaurantName,
      'driverId': instance.driverId,
      'driverName': instance.driverName,
      'items': instance.items.map((e) => e.toJson()).toList(),
      'restaurantAddress': instance.restaurantAddress.toJson(),
      'deliveryAddress': instance.deliveryAddress.toJson(),
      'status': _$OrderStatusEnumMap[instance.status]!,
      'paymentMethod': _$PaymentMethodEnumMap[instance.paymentMethod]!,
      'paymentStatus': _$PaymentStatusEnumMap[instance.paymentStatus]!,
      'itemsTotal': instance.itemsTotal,
      'deliveryFee': instance.deliveryFee,
      'tax': instance.tax,
      'discount': instance.discount,
      'total': instance.total,
      'note': instance.note,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'confirmedAt': instance.confirmedAt?.toIso8601String(),
      'assignedAt': instance.assignedAt?.toIso8601String(),
      'pickedUpAt': instance.pickedUpAt?.toIso8601String(),
      'deliveredAt': instance.deliveredAt?.toIso8601String(),
      'cancelledAt': instance.cancelledAt?.toIso8601String(),
      'cancelReason': instance.cancelReason,
    };

const _$OrderStatusEnumMap = {
  OrderStatus.created: 'created',
  OrderStatus.confirmed: 'confirmed',
  OrderStatus.pooled: 'pooled',
  OrderStatus.assigned: 'assigned',
  OrderStatus.pickedUp: 'pickedUp',
  OrderStatus.delivered: 'delivered',
  OrderStatus.cancelled: 'cancelled',
};

const _$PaymentMethodEnumMap = {
  PaymentMethod.cash: 'cash',
  PaymentMethod.card: 'card',
  PaymentMethod.wallet: 'wallet',
};

const _$PaymentStatusEnumMap = {
  PaymentStatus.pending: 'pending',
  PaymentStatus.paid: 'paid',
  PaymentStatus.failed: 'failed',
  PaymentStatus.refunded: 'refunded',
};
