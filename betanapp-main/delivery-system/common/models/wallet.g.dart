// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
      id: json['id'] as String,
      userId: json['userId'] as String,
      orderId: json['orderId'] as String?,
      type: $enumDecode(_$TransactionTypeEnumMap, json['type']),
      amount: (json['amount'] as num).toDouble(),
      balanceBefore: (json['balanceBefore'] as num).toDouble(),
      balanceAfter: (json['balanceAfter'] as num).toDouble(),
      status: $enumDecode(_$TransactionStatusEnumMap, json['status']),
      description: json['description'] as String,
      note: json['note'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$TransactionToJson(Transaction instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'orderId': instance.orderId,
      'type': _$TransactionTypeEnumMap[instance.type]!,
      'amount': instance.amount,
      'balanceBefore': instance.balanceBefore,
      'balanceAfter': instance.balanceAfter,
      'status': _$TransactionStatusEnumMap[instance.status]!,
      'description': instance.description,
      'note': instance.note,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

Wallet _$WalletFromJson(Map<String, dynamic> json) => Wallet(
      id: json['id'] as String,
      userId: json['userId'] as String,
      balance: (json['balance'] as num).toDouble(),
      totalEarnings: (json['totalEarnings'] as num).toDouble(),
      totalWithdrawals: (json['totalWithdrawals'] as num).toDouble(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$WalletToJson(Wallet instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'balance': instance.balance,
      'totalEarnings': instance.totalEarnings,
      'totalWithdrawals': instance.totalWithdrawals,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$TransactionTypeEnumMap = {
  TransactionType.deposit: 'deposit',
  TransactionType.withdraw: 'withdraw',
  TransactionType.payment: 'payment',
  TransactionType.refund: 'refund',
  TransactionType.commission: 'commission',
  TransactionType.fee: 'fee',
  TransactionType.bonus: 'bonus',
  TransactionType.penalty: 'penalty',
};

const _$TransactionStatusEnumMap = {
  TransactionStatus.pending: 'pending',
  TransactionStatus.completed: 'completed',
  TransactionStatus.failed: 'failed',
  TransactionStatus.cancelled: 'cancelled',
};
