import 'package:ecoomerce_dbestech/controllers/locationController.dart';
import 'package:ecoomerce_dbestech/utils/constants.dart';
import 'package:ecoomerce_dbestech/utils/dimentions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_maps_webservice/src/places.dart';

class LoactionDialogue extends StatelessWidget {
  final GoogleMapController mapController;

  const LoactionDialogue({super.key, required this.mapController});

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();
    return Container(
      padding: EdgeInsets.all(Dimentions.width10),
      alignment: Alignment.topCenter,
      child: Material(
        // color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimentions.radius20 / 2),
        ),
        child: SingleChildScrollView(
          child: TypeAheadField(
            textFieldConfiguration: TextFieldConfiguration(
              controller: _controller,
              textInputAction: TextInputAction.search,
              autofocus: true,
              textCapitalization: TextCapitalization.words,
              keyboardType: TextInputType.streetAddress,
              decoration: InputDecoration(
                hintText: 'search location',
                hintStyle: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Theme.of(context).disabledColor,
                    fontSize: Dimentions.font16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    style: BorderStyle.none,
                    width: 0,
                  ),
                ),
              ),
            ),

            /* * suggestions as u type from the server
           */
            suggestionsCallback: (String pattern) async {
              return await Get.find<LocationController>()
                  .searchLocation(context, pattern);
            },
            itemBuilder: (BuildContext context, Prediction suggestion) {
              return Padding(
                padding: EdgeInsets.all(Dimentions.width10),
                child: Row(
                  children: [
                    Icon(Icons.location_on),
                    Expanded(
                        child: Text(
                      suggestion.description!,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(
                              color: Colors.black, fontSize: Dimentions.font16),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ))
                  ],
                ),
              );
            },
            onSuggestionSelected: (suggestion) {
              Get.find<LocationController>().setLocation(
                  suggestion.placeId!, suggestion.description!, mapController);
              Get.back();
            },
          ),
        ),
      ),
    );
  }
}
