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
    Address.fromJson(json['addresses'] as Map<String, dynamic>),
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
      'addresses': instance.addresses.toJson(),
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

Address _$AddressFromJson(Map<String, dynamic> json) {
  return Address(
    (json['subnet1'] as List<dynamic>)
        .map((e) => Subnet.fromJson(e as Map<String, dynamic>))
        .toList(),
    (json['subnet2'] as List<dynamic>)
        .map((e) => Subnet.fromJson(e as Map<String, dynamic>))
        .toList(),
    (json['subnet3'] as List<dynamic>)
        .map((e) => Subnet.fromJson(e as Map<String, dynamic>))
        .toList(),
    (json['subnet4'] as List<dynamic>)
        .map((e) => Subnet.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'subnet1': instance.subnet1.map((e) => e.toJson()).toList(),
      'subnet2': instance.subnet2.map((e) => e.toJson()).toList(),
      'subnet3': instance.subnet3.map((e) => e.toJson()).toList(),
      'subnet4': instance.subnet4.map((e) => e.toJson()).toList(),
    };

Subnet _$SubnetFromJson(Map<String, dynamic> json) {
  return Subnet(
    json['OS-EXT-IPS-MAC:mac_addr'] as String,
    json['version'] as String,
    json['addr'] as String,
    json['OS-EXT-IPS:type'] as String,
  );
}

Map<String, dynamic> _$SubnetToJson(Subnet instance) => <String, dynamic>{
      'OS-EXT-IPS-MAC:mac_addr': instance.mac,
      'version': instance.version,
      'addr': instance.addr,
      'OS-EXT-IPS:type': instance.type,
    };
