import 'package:app_sangfor/api/json_models/listVM/listVM.dart';
import 'package:app_sangfor/cache/Vm_Cache.dart';
import 'package:app_sangfor/models/details_model.dart';
import 'package:app_sangfor/widgets/widget_details/popup_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage();
  
  List<DetailsModel> loadDetailsModel (Servers detailsVM)
  {
    List<DetailsModel> details=[];
    
    details.add(DetailsModel(title: "Hardware Configuration",id:"Hardware Configuration", showHero: false, items: []));
    details.add(DetailsModel(title: "NIC1" ,id: "NIC1",showHero: true, items: [
      DetailsItem(key: "Resource Pool", value: detailsVM.availability_zone),
      DetailsItem(key: "Created", value: detailsVM.created),
      DetailsItem(key: "Updated", value: detailsVM.updated),
      DetailsItem(key: "Status", value: detailsVM.status)
    ]));
    details.add(DetailsModel(title: "NIC2" ,id:"NIC 2" ,showHero: true, items: [
      DetailsItem(key: "Resource Pool", value: detailsVM.availability_zone),
      DetailsItem(key: "Created", value: detailsVM.created),
      DetailsItem(key: "Updated", value: detailsVM.updated),
      DetailsItem(key: "Status", value: detailsVM.status)
    ]));
    details.add(DetailsModel(title: "Other Information",id: "Other Information",showHero: false, items: [
      DetailsItem(key: "Resource Pool", value: detailsVM.availability_zone),
      DetailsItem(key: "Created", value: detailsVM.created),
      DetailsItem(key: "Updated", value: detailsVM.updated),
      DetailsItem(key: "Status", value: detailsVM.status)
    ]));
    
    return details;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<VmCache>(
            builder: (_, value, __) {
              var details = loadDetailsModel(value.detailsVM);

              return SafeArea(
                  child:ListView(
                children: [
                  InfoCard(model: details[0]),
                  InfoCard(model: details[1]),
                  InfoCard(model: details[2]),
                  InfoCard(model: details[3]),
                ],
              ));
            }));
  }
}