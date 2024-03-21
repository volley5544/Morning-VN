import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'dart:ui' as ui;
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile_application_srisawad/main.dart';

import '../../bloc/map_bloc/map_bloc.dart';

class MapDetail extends StatefulWidget {
  final Set<Marker>? markers;
  final LatLng? latLng;
  late Function onMapCreate;
  // final Function(GoogleMapController) onMapCreated;
  MapDetail({Key? key, this.markers, this.latLng, required this.onMapCreate})
      : super(key: key);

  @override
  State<MapDetail> createState() => _MapDetailState();
}

class _MapDetailState extends State<MapDetail> {
  Set<Marker> markers = Set();
  late bool isIconLoaded = false;
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(13.7563, 100.5018);
  CameraPosition setNewCameraPosition(LatLng? latLng) {
    if (latLng == null) return CameraPosition(target: _center, zoom: 12);
    return CameraPosition(
      target: latLng,
      zoom: 12,
    );
  }

  // @override
  // void dispose() {
  //   widget.mapController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    // mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
    //     target: widget.latLng == null ? _center : widget.latLng!)));
    return Container(
      height: MediaQuery.of(context).size.height * 1,
      width: getActualWidth(context),
      child: GoogleMap(
          myLocationEnabled: true,
          mapType: MapType.normal,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          markers: widget.markers == null ? markers : widget.markers!,
          onMapCreated: (e) => widget.onMapCreate(e),
          initialCameraPosition: CameraPosition(
            target: widget.latLng == null ? _center : widget.latLng!,
            zoom: 12,
          )),
    );
  }
}


// position loading 
// go button on keyboard
// diable phone button
// sai กม