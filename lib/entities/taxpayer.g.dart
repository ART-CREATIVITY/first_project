// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'taxpayer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Taxpayer _$TaxpayerFromJson(Map<String, dynamic> json) => Taxpayer(
      id: json['id'] as int?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      gender: _$enumDecodeNullable(_$GenderEnumMap, json['gender']),
      birthDay: json['birthDay'] == null
          ? null
          : DateTime.parse(json['birthDay'] as String),
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      address: json['address'] as String?,
      identifyPicture: json['identifyPicture'] as String?,
      bornAround: json['bornAround'] as bool?,
      serverId: json['serverId'] as String?,
    );

Map<String, dynamic> _$TaxpayerToJson(Taxpayer instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'gender': _$GenderEnumMap[instance.gender],
      'birthDay': instance.birthDay?.toIso8601String(),
      'phone': instance.phone,
      'email': instance.email,
      'address': instance.address,
      'identifyPicture': instance.identifyPicture,
      'bornAround': instance.bornAround,
      'serverId': instance.serverId,
    };

Map<String, dynamic> _$TaxpayerToRestJson(Taxpayer instance) => <String, dynamic>{
  'id': "${instance.id}",
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'gender': _$GenderEnumMap[instance.gender],
  'birthDay': instance.birthDay?.toIso8601String(),
  'phone': instance.phone,
  'email': instance.email,
  'address': instance.address,
  // 'identifyPicture': instance.identifyPicture,
  // 'bornAround': instance.bornAround,
  'serverId': instance.serverId,
};

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

K? _$enumDecodeNullable<K, V>(
  Map<K, V> enumValues,
  dynamic source, {
  K? unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<K, V>(enumValues, source, unknownValue: unknownValue);
}

const _$GenderEnumMap = {
  Gender.MALE: 'MALE',
  Gender.FEMALE: 'FEMALE',
  Gender.OTHER: 'OTHER',
};
