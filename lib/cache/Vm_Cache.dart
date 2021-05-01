import 'package:app_sangfor/api/json_models/listVM/listVM.dart';

class VmCache
{
  late Servers _detailsVM;

  Servers get detailsVM => _detailsVM;
  set detailsVM(Servers detailsVM) {_detailsVM=detailsVM;}

}