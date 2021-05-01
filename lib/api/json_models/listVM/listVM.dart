import 'package:json_annotation/json_annotation.dart';

part 'listVM.g.dart';

@JsonSerializable(explicitToJson: true)
class ListVM {
  final List<Servers> servers;

  const ListVM(this.servers);

  //the factory method is used to hide the constructor
  factory ListVM.fromJson(Map<String, dynamic> json) => _$ListVMFromJson(json);
  Map<String, dynamic> toJson() => _$ListVMToJson(this);
}


@JsonSerializable(explicitToJson: true)
class Servers {
  final String id;
  final String name;
  final String status;
  final String created;
  @JsonKey(name:"OS-EXT-AZ:availability_zone")
  final String availability_zone;
  final String updated;
  final List<Links> links;
  final Address addresses;

  const Servers(this.id,this.name,this.status,this.created,this.availability_zone,this.updated,this.links,this.addresses);

  //the factory method is used to hide the constructor
  factory Servers.fromJson(Map<String, dynamic> json) => _$ServersFromJson(json);
  Map<String, dynamic> toJson() => _$ServersToJson(this);
}

@JsonSerializable()
class Links {
  final String href;
  final String rel;

  const Links(this.href,this.rel);

  //the factory method is used to hide the constructor
  factory Links.fromJson(Map<String, dynamic> json) => _$LinksFromJson(json);
  Map<String, dynamic> toJson() => _$LinksToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Address {
 final List<Subnet> subnet1;
 final List<Subnet> subnet2;
 final List<Subnet> subnet3;
 final List<Subnet> subnet4;

  const Address(this.subnet1,this.subnet2,this.subnet3,this.subnet4);

  //the factory method is used to hide the constructor
  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);
  Map<String, dynamic> toJson() => _$AddressToJson(this);
}

@JsonSerializable()
class Subnet {
  @JsonKey(name:"OS-EXT-IPS-MAC:mac_addr")
  final String mac;
  final String version;
  final String addr;
  @JsonKey(name:"OS-EXT-IPS:type")
  final String type;

  const Subnet(this.mac,this.version,this.addr,this.type);

  //the factory method is used to hide the constructor
  factory Subnet.fromJson(Map<String, dynamic> json) => _$SubnetFromJson(json);
  Map<String, dynamic> toJson() => _$SubnetToJson(this);
}