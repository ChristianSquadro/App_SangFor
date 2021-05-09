// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flavorVM.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlavorVM _$FlavorVMFromJson(Map<String, dynamic> json) {
  return FlavorVM(
    Flavor.fromJson(json['flavor'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$FlavorVMToJson(FlavorVM instance) => <String, dynamic>{
      'flavor': instance.flavor.toJson(),
    };

Flavor _$FlavorFromJson(Map<String, dynamic> json) {
  return Flavor(
    json['name'] as String,
    json['ram'] as num,
    json['vcpus'] as num,
    json['disk'] as num,
  );
}

Map<String, dynamic> _$FlavorToJson(Flavor instance) => <String, dynamic>{
      'name': instance.name,
      'ram': instance.ram,
      'vcpus': instance.vcpus,
      'disk': instance.disk,
    };
