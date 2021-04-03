// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flavorVM.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlavorVM _$FlavorVMFromJson(Map<String, dynamic> json) {
  return FlavorVM(
    (json['flavors'] as List<dynamic>)
        .map((e) => Flavors.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$FlavorVMToJson(FlavorVM instance) => <String, dynamic>{
      'flavors': instance.flavors.map((e) => e.toJson()).toList(),
    };

Flavors _$FlavorsFromJson(Map<String, dynamic> json) {
  return Flavors(
    json['name'] as String,
    json['ram'] as num,
    json['vcpus'] as num,
    json['disk'] as num,
    (json['links'] as List<dynamic>)
        .map((e) => Links.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$FlavorsToJson(Flavors instance) => <String, dynamic>{
      'name': instance.name,
      'ram': instance.ram,
      'vcpus': instance.vcpus,
      'disk': instance.disk,
      'links': instance.links.map((e) => e.toJson()).toList(),
    };

Links _$LinksFromJson(Map<String, dynamic> json) {
  return Links(
    json['href'] as String,
    json['rel'] as String,
  );
}

Map<String, dynamic> _$LinksToJson(Links instance) => <String, dynamic>{
      'href': instance.href,
      'rel': instance.rel,
    };
