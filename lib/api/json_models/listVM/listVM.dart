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


@JsonSerializable()
class Servers {
  final String name;
  final String status;

  const Servers(this.name,this.status);

  //the factory method is used to hide the constructor
  factory Servers.fromJson(Map<String, dynamic> json) => _$ServersFromJson(json);
  Map<String, dynamic> toJson() => _$ServersToJson(this);
}