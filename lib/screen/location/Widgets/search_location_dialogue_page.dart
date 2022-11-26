import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shop_delivery_system/controller/address_controller.dart';
import 'package:google_maps_webservice/places.dart';
import '../../../utils/colors.dart';

class SearchLocationDialoguePage extends StatelessWidget {
  final GoogleMapController mapController;
  const SearchLocationDialoguePage({required this.mapController, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final TextEditingController _textEditingController =
        TextEditingController();
    return Container(
      padding: const EdgeInsets.all(10),
      alignment: Alignment.topCenter,
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: SizedBox(
            width: width,
            child: TypeAheadField(
              textFieldConfiguration: TextFieldConfiguration(
                controller: _textEditingController,
                textInputAction: TextInputAction.search,
                autofocus: true,
                decoration: InputDecoration(
                    hintText: 'search location',
                    hintStyle: Theme.of(context).textTheme.headline2?.copyWith(
                        color: Theme.of(context).disabledColor, fontSize: 16),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            style: BorderStyle.none, width: 0))),
                textCapitalization: TextCapitalization.words,
                keyboardType: TextInputType.streetAddress,
              ),
              suggestionsCallback: (pattern) async {
                return await Get.find<AddressController>()
                    .searchLocation(context, _textEditingController.text);
              },
              onSuggestionSelected: (Prediction suggestion) async {
                return await Get.find<AddressController>().setLocation(
                    suggestion.placeId!, suggestion.description!, mapController);
              },
              itemBuilder: (BuildContext context, Prediction suggestion) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      const Icon(Icons.location_on),
                      Expanded(
                          child: Text(
                        suggestion.description!.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headline2?.copyWith(
                            color: Theme.of(context).textTheme.bodyText1?.color,
                            fontSize: 16),
                      ))
                    ],
                  ),
                );
              },
            )),
      ),
    );
  }
}
