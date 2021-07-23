import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kisan_sahay/widgets/titlebar.dart';
import 'package:kisan_sahay/pages/show_uploads.dart';
import 'package:location/location.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

class NearbyMap extends StatefulWidget {
  const NearbyMap({Key? key}) : super(key: key);

  @override
  _NearbyMapState createState() => _NearbyMapState();
}

class _NearbyMapState extends State<NearbyMap> {

  User? user = FirebaseAuth.instance.currentUser;
  Set<Marker> _markers = {};

  LatLng currentLatLng = LatLng(0, 0);

  late GoogleMapController mapController;
  Location location = new Location();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Geoflutterfire geo = Geoflutterfire();

  //Stateful data
  BehaviorSubject<double> radius = BehaviorSubject();
  late Stream<dynamic> query;


  late double latitude, longitude;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }


  getlatitude() async {
    //CollectionReference users =FirebaseFirestore.instance.collection("Users");
    var docsnt = await FirebaseFirestore.instance.collection("Users").doc(
        FirebaseAuth.instance.currentUser!.uid).get();
    var df = docsnt.data() as Map<String, dynamic>;
    latitude = df['latitude'];
    longitude = df['longitude'];
    print(latitude);
    print(longitude);

  }


  @override
  initState() {
    //getUsers();
    getlatitude();

    super.initState();
  }

  //final LatLng _center = LatLng(latitude,longitude);
  LatLng _center = LatLng(16.7594482, 80.6393911);

  @override
  Widget build(BuildContext context) {
    user!.reload();
    print(_markers.length);
    print("!@#");
    return Scaffold(
      appBar: TitleBar(),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            markers: _markers,
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.5,
            ),
            compassEnabled: true,
            onCameraMove: (position) {
              // print(position);
              currentLatLng =
                  LatLng(position.target.latitude, position.target.longitude);
            },
          ),
          Positioned(
            bottom: 50,
            left: 70,
            child: ElevatedButton(
              onPressed: _addGeoPoint,
              child: Icon(Icons.pin_drop_rounded, color: Colors.white),
            ),

          ),
        ],
      ),
    );
  }

  void _addMarker() {
    print("Add marker");
    setState(() {
      print(currentLatLng);
      _markers.add(
          Marker(markerId: MarkerId('1'),
            position: currentLatLng,
            //position: LatLng(17.7294,83.3093),
            infoWindow: InfoWindow(
              title: 'home',
              snippet: 'user home',
            ),
          )
      );
    });
  }

  _animateToUser() async {
    LocationData pos = await location.getLocation();
    mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(pos.latitude!, pos.longitude!),
            zoom: 17.0
        )
    )
    );
  }

  Future<void> _addGeoPoint() async {
    await FirebaseFirestore.instance.collection("Users").get()
        .then((QuerySnapshot querySnapshot) {
      print(querySnapshot.size);
      var j = 0;
      querySnapshot.docs.forEach((doc) {
        print(doc['latitude']);
        j = j + 1;
        _markers.add(Marker(
          markerId: MarkerId(j.toString()),
          position: LatLng(doc["latitude"], doc["longitude"]),
          infoWindow: InfoWindow(
            title: doc['name'],
            snippet: 'user home',
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueViolet),

          onTap: () {

            Navigator.push(context,
                new MaterialPageRoute(
                    builder: (BuildContext context) => new ShowUploads(
                      uid: doc.id, name: doc['name'],))
            );
          },
        ));
      });
    });
    setState(() {

    });

  }


}