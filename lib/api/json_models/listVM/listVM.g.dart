// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listVM.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListVM _$ListVMFromJson(Map<String, dynamic> json) {
  return ListVM(
    (json['servers'] as List<dynamic>)
        .map((e) => Servers.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ListVMToJson(ListVM instance) => <String, dynamic>{
      'servers': instance.servers.map((e) => e.toJson()).toList(),
    };

Servers _$ServersFromJson(Map<String, dynamic> json) {
  return Servers(
    json['id'] as String,
    json['name'] as String,
    json['status'] as String,
    json['created'] as String,
    json['OS-EXT-AZ:availability_zone'] as String,
    json['updated'] as String,
    (json['links'] as List<dynamic>)
        .map((e) => Links.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['addresses'],
    Flavor.fromJson(json['flavor'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ServersToJson(Servers instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'status': instance.status,
      'created': instance.created,
      'OS-EXT-AZ:availability_zone': instance.availability_zone,
      'updated': instance.updated,
      'links': instance.links.map((e) => e.toJson()).toList(),
      'addresses': instance.addresses,
      'flavor': instance.flavor.toJson(),
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

Flavor _$FlavorFromJson(Map<String, dynamic> json) {
  return Flavor(
    json['id'] as String,
  );
}

Map<String, dynamic> _$FlavorToJson(Flavor instance) => <String, dynamic>{
      'id': instance.id,
    };
