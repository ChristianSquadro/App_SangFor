import 'package:json_annotation/json_annotation.dart';

part 'flavorVM.g.dart';


@JsonSerializable(explicitToJson: true)
class FlavorVM{
  final Flavor flavor;

  const FlavorVM(this.flavor);

  //the factory method is used to hide the constructor
  factory FlavorVM.fromJson(Map<String, dynamic> json) => _$FlavorVMFromJson(json);
  Map<String, dynamic> toJson() => _$FlavorVMToJson(this);
}


@JsonSerializable()
class Flavor{
  final String name;
  final num ram;
  final num vcpus;
  final num disk;

  const Flavor(this.name,this.ram,this.vcpus,this.disk);

  //the factory method is used to hide the constructor
  factory Flavor.fromJson(Map<String, dynamic> json) => _$FlavorFromJson(json);
  Map<String, dynamic> toJson() => _$FlavorToJson(this);
}
