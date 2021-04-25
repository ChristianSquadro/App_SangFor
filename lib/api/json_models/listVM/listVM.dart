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
  final List<Links> links;

  const Servers(this.id,this.name,this.status,this.links);

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