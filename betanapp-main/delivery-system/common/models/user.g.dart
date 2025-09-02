// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      role: $enumDecode(_$UserRoleEnumMap, json['role']),
      status: $enumDecode(_$UserStatusEnumMap, json['status']),
      avatar: json['avatar'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      vehicleType: json['vehicleType'] as String?,
      vehicleNumber: json['vehicleNumber'] as String?,
      driverLicense: json['driverLicense'] as String?,
      restaurantName: json['restaurantName'] as String?,
      restaurantAddress: json['restaurantAddress'] as String?,
      businessLicense: json['businessLicense'] as String?,
      areaCode: json['areaCode'] as String?,
      managedDrivers: (json['managedDrivers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'role': _$UserRoleEnumMap[instance.role]!,
      'status': _$UserStatusEnumMap[instance.status]!,
      'avatar': instance.avatar,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'vehicleType': instance.vehicleType,
      'vehicleNumber': instance.vehicleNumber,
      'driverLicense': instance.driverLicense,
      'restaurantName': instance.restaurantName,
      'restaurantAddress': instance.restaurantAddress,
      'businessLicense': instance.businessLicense,
      'areaCode': instance.areaCode,
      'managedDrivers': instance.managedDrivers,
    };

const _$UserRoleEnumMap = {
  UserRole.admin: 'admin',
  UserRole.leader: 'leader',
  UserRole.driver: 'driver',
  UserRole.restaurant: 'restaurant',
};

const _$UserStatusEnumMap = {
  UserStatus.active: 'active',
  UserStatus.inactive: 'inactive',
  UserStatus.banned: 'banned',
};
