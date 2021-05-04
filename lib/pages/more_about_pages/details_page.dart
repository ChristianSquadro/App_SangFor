import 'package:app_sangfor/api/json_models/listVM/listVM.dart';
import 'package:app_sangfor/cache/Vm_Cache.dart';
import 'package:app_sangfor/models/details_model.dart';
import 'package:app_sangfor/widgets/widget_details/popup_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage();

  List<DetailsModel> loadDetailsModel(Servers detailsVM) {
    List<DetailsModel> details = [];
    var subnetMap = detailsVM.addresses as Map;
    var subnetNames = subnetMap.keys.toList();
    int indexNIC = 1;

    details.add(DetailsModel(
        title: "Hardware Configuration",
        id: "Hardware Configuration",
        showHero: false,
        items: []));

    details.add(DetailsModel(
        title: "Other Information",
        id: "Other Information",
        showHero: false,
        items: [
          DetailsItem(key: "Resource Pool", value: detailsVM.availability_zone),
          DetailsItem(key: "Created", value: detailsVM.created),
          DetailsItem(key: "Updated", value: detailsVM.updated),
          DetailsItem(key: "Status", value: detailsVM.status)
        ]));

    for (int i = 0; i < subnetNames.length; i++) {
      var subnetValues = subnetMap[subnetNames[i]].toList() as List<dynamic>;
      List<dynamic> values = [];

      for (int j = 0; j < subnetValues.length; j++) {
        values.addAll(subnetValues[j].values.toList() as List<dynamic>);
      }

      int j = 0;
      while (j < values.length) {
        List<DetailsItem> detailsItems = [];
        detailsItems.add(
            DetailsItem(key: "Subnet Name", value: subnetNames[i].toString()));
        detailsItems.add(
            DetailsItem(key: "Mac Addresss", value: values[j++].toString()));
        detailsItems
            .add(DetailsItem(key: "Ip Version", value: values[j++].toString()));
        detailsItems
            .add(DetailsItem(key: "Ip Address", value: values[j++].toString()));
        detailsItems
            .add(DetailsItem(key: "Ip Type", value: values[j++].toString()));
        details.add(DetailsModel(
            title: "NIC $indexNIC",
            id: "NIC$indexNIC",
            showHero: true,
            items: detailsItems));
        indexNIC++;
      }
    }

    if (indexNIC -1 % 2 != 0)
      details.add(DetailsModel(
          title: "---",
          id: "-",
          showHero: true,
          items: []));

    return details;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<VmCache>(builder: (_, value, __) {
      var details = loadDetailsModel(value.detailsVM);
      List<InfoCard> infoCard = [];

      for (int i = 2; i < details.length; i++)
        infoCard.add(InfoCard(model: details[i]));

      return
        Column(
          children: [
        InfoCard(model: details[0]),
        Flexible(
          child: GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 3.2,
            crossAxisSpacing: 14,
            children: infoCard,
          ),
        ),
        InfoCard(model: details[1]),
      ]);
    }));
  }
}
