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
  final dynamic addresses;
  final Flavor flavor;

  const Servers(this.id,this.name,this.status,this.created,this.availability_zone,this.updated,this.links,this.addresses,this.flavor);

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

@JsonSerializable()
class Flavor {
  final String id;

  const Flavor(this.id);

  //the factory method is used to hide the constructor
  factory Flavor.fromJson(Map<String, dynamic> json) => _$FlavorFromJson(json);
  Map<String, dynamic> toJson() => _$FlavorToJson(this);
}
