import 'package:json_annotation/json_annotation.dart';

part 'flavorVM.g.dart';

@JsonSerializable(explicitToJson: true)
class FlavorVM {
  final List<Flavors> flavors;

  const FlavorVM(this.flavors);

  //the factory method is used to hide the constructor
  factory FlavorVM.fromJson(Map<String, dynamic> json) => _$FlavorVMFromJson(json);
  Map<String, dynamic> toJson() => _$FlavorVMToJson(this);
}


@JsonSerializable(explicitToJson: true)
class Flavors {
  final String name;
  final num ram;
  final num vcpus;
  final num disk;
  final List<Links> links;

  const Flavors(this.name,this.ram,this.vcpus,this.disk,this.links);

  //the factory method is used to hide the constructor
  factory Flavors.fromJson(Map<String, dynamic> json) => _$FlavorsFromJson(json);
  Map<String, dynamic> toJson() => _$FlavorsToJson(this);
}


@JsonSerializable()
class Links{
  final String href;
  final String rel;

  const Links(this.href,this.rel);

  factory Links.fromJson(Map<String, dynamic> json) => _$LinksFromJson(json);
  Map<String, dynamic> toJson() => _$LinksToJson(this);
}
