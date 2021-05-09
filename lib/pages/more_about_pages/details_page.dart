import 'package:app_sangfor/api/api_call/flavorVM_apicall.dart';
import 'package:app_sangfor/api/json_models/flavorVM/flavorVM.dart';
import 'package:app_sangfor/api/json_models/listVM/listVM.dart';
import 'package:app_sangfor/cache/Vm_Cache.dart';
import 'package:app_sangfor/models/details_model.dart';
import 'package:app_sangfor/widgets/widget_details/details_card.dart';
import 'package:app_sangfor/widgets/widget_details/images_card.dart';
import 'package:app_sangfor/widgets/widget_details/popup_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage();

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<DetailsPage> {
  FlavorVM_ApiCall flavorVM_ApiCall = FlavorVM_ApiCall();
  late Future<FlavorVM> flavorVM;

  @override
  void initState() {
    super.initState();
    flavorVM = flavorVM_ApiCall.loadFlavorVM(
        Provider.of<VmCache>(context, listen: false).detailsVM.flavor.id,
        context);
  }

  List<DetailsModel> loadDetailsModel(Servers detailsVM,FlavorVM data) {
    List<DetailsModel> details = [];
    var subnetMap = detailsVM.addresses as Map;
    var subnetNames = subnetMap.keys.toList();
    int indexNIC = 1;

  //defining static details model
    details.add(DetailsModel(
        title: "Hardware Configuration",
        images: [
          DetailsImage(pathImage: "assets/cpu.png", value: data.flavor.vcpus.toString()+" Core(s)"),
          DetailsImage(pathImage: "assets/ram.png", value: data.flavor.ram.toString()+" MB"),
          DetailsImage(pathImage: "assets/disk.png", value: data.flavor.disk.toString()+" GB"),
        ]));

    details.add(DetailsModel(
        title: "Other Information",
        items: [
          DetailsItem(key: "Resource Pool", value: detailsVM.availability_zone),
          DetailsItem(key: "Created", value: detailsVM.created.replaceAll(RegExp(".000000"), "").replaceAll("T", " ")),
          DetailsItem(key: "Updated", value: detailsVM.updated.replaceAll(RegExp(".000000"), "").replaceAll("T", " ")),
          DetailsItem(key: "Status", value: detailsVM.status.toLowerCase())
        ]));


    //Defining variable details model (you could install more NICS)
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
            items: detailsItems));
        indexNIC++;
      }
    }

    //add a bonus model to have pair number of InfoCard
    if (indexNIC - 1 % 2 != 0)
      details.add(DetailsModel(title: "---", id: "-",items: []));

    return details;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<VmCache>(builder: (_, value, __) {
      return FutureBuilder<FlavorVM>(
          future: flavorVM,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
              var data = snapshot.data;
              var details = loadDetailsModel(value.detailsVM,data!);

              return Column(
                  children: [
                ImagesCard(model: details[0]),
                (details.length > 2) ? Flexible(
                  child: GridView.count(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    childAspectRatio: 3.2,
                    crossAxisSpacing: 14,
                    children:[  for (int i = 2; i < details.length; i++) InfoCard(model: details[i])],
                  )) : Container(),
                DetailsCard(model: details[1]),
              ]);
            }

            if (snapshot.hasError &&
                snapshot.connectionState == ConnectionState.done) {
              return Center(child: Text("No Data!"));
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          });
    }));
  }
}
