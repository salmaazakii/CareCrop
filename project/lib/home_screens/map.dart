import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'home_menu.dart';


class HomePage extends StatefulWidget {
  final Pos pos;
  HomePage({this.pos});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  BitmapDescriptor pinLocationIcon;
  BitmapDescriptor pinHomeIcon;

  @override
  void initState() {
    super.initState();
    setCustomMapPin();
    setHomePin();
  }
  void setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/images/marker.png');
  }
  void setHomePin() async {
    pinHomeIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5,size: Size(3.0,3.0)),
        'assets/images/homemarker.jpg');
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: _googleMap(context),
      ),
    );
  }

  Widget _googleMap(BuildContext context) {

    Marker GamalHospital = new Marker(
        markerId: MarkerId("1"),
        position: LatLng(31.204258,29.926358),
        infoWindow: InfoWindow(title: "Gamal AbdElnasser Hospital"),
        icon:  pinLocationIcon );
    Marker ElGam3aHospital = new Marker(
        markerId: MarkerId("2"),
        position: LatLng(31.202799,29.919988),
        infoWindow: InfoWindow(title: "Alexandria University Hospital"),
        icon: pinLocationIcon );
    Marker AlMousaaHospital = new Marker(
        markerId: MarkerId("3"),
        position: LatLng(31.204414,29.928657),
        infoWindow: InfoWindow(title: "El Mowasah Hospital"),
        icon: pinLocationIcon );
    Marker ElbhoosHospital = new Marker(
        markerId: MarkerId("4"),
        position: LatLng(31.205300,29.927544),
        infoWindow: InfoWindow(title: "Medical Research Institute"),
        icon: pinLocationIcon );
    Marker ElshatbiHospital = new Marker(
        markerId: MarkerId("5"),
        position: LatLng(31.209126,29.911311),
        infoWindow: InfoWindow(title: "El Shatby Hospital"),
        icon: pinLocationIcon );
    Marker _HomeLoc (double lat,double lng){
      return Marker(
          markerId: MarkerId("0"),
          position: LatLng(lat,lng),
          infoWindow: InfoWindow(title: "Your Location"),
          icon: pinHomeIcon );
    }

    return Container(
      height: MediaQuery
          .of(context)
          .size
          .height,
      width: MediaQuery
          .of(context)
          .size
          .width,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
            target: LatLng(widget.pos.x, widget.pos.y), zoom: 15),
        onMapCreated: (GoogleMapController controller) { },
        markers: {
          _HomeLoc(widget.pos.x, widget.pos.y),
          GamalHospital,AlMousaaHospital,ElbhoosHospital,
          ElGam3aHospital,ElshatbiHospital
        },
      ),
    );
  }
}