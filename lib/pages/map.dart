//real time users geo locations
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kisan_sahay/widgets/titlebar.dart';
import 'package:location/location.dart';
import 'package:geoflutterfire/src/point.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

class NearbyMap extends StatefulWidget {
  const NearbyMap({Key? key}) : super(key: key);

  @override
  _NearbyMapState createState() => _NearbyMapState();
}

class _NearbyMapState extends State<NearbyMap> {

  User? user =FirebaseAuth.instance.currentUser;
  Set<Marker> _markers ={ };

  LatLng currentLatLng = LatLng(0, 0);

  late GoogleMapController mapController;
  Location location = new Location();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Geoflutterfire geo = Geoflutterfire();

  //Stateful data
    BehaviorSubject<double> radius =BehaviorSubject();
    late Stream<dynamic> query;

    //Subscription
  late StreamSubscription subscription;


  late double latitude,longitude;
  void _onMapCreated(GoogleMapController controller)
  {
    mapController = controller;
  }


 getlatitude() async {

   //CollectionReference users =FirebaseFirestore.instance.collection("Users");
   var docsnt = await FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid).get();
   var df= docsnt.data() as Map<String,dynamic>;
   latitude =  df['latitude'];
   longitude = df['longitude'];
   print(latitude);
   print(longitude);


   // String latitude = document["latitude"];S
 }


  @override
  void initState(){
    //getUsers();
    getlatitude();
    super.initState();
  }

  //final LatLng _center = LatLng(latitude,longitude);
   LatLng _center = LatLng(16.7594482,80.6393911);

  @override
  Widget build(BuildContext context) {
    user!.reload();
    return Scaffold(

      body: Stack(
        children: [
          GoogleMap(
            mapType:MapType.normal,
            markers: _markers,
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.5,
            ),
            compassEnabled: true,
            onCameraMove: (position) {
              print(position);
              currentLatLng = LatLng(position.target.latitude, position.target.longitude);
            },
          ),
          Positioned(
            bottom: 50,
            left: 70,
            child: ElevatedButton(
              onPressed:_addGeoPoint,
              child: Icon(Icons.pin_drop_rounded,color:Colors.white),
            ),

          ),
         /* Positioned(
            bottom: 50,
            left: 10,
            child: Slider(
              min: 100.0,
              max: 500.0,
              divisions: 4,
              value: radius.value,
              label: 'Radius ${radius.value}km',
              activeColor: Colors.green,
              inactiveColor: Colors.green.withOpacity(0.2),
              onChanged:(double) async {},

            ),
          )*/
        ],
      ),
    );

  }

  void _addMarker()
  {
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

  _animateToUser() async{
    LocationData pos = await location.getLocation();
    mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
          target: LatLng(pos.latitude!,pos.longitude!),
          zoom: 17.0
      )
    )
    );
    
  }

  Future<DocumentReference>  _addGeoPoint()
  async {
    LocationData pos = await location.getLocation();
    GeoFirePoint point = geo.point(latitude:pos.latitude!,longitude:pos.longitude!);

    return firestore.collection('locations').add(
      {
        'position':point.data,
        'name': 'User name-1'

      }
    );
  }

  void _updateMarkers(List<DocumentSnapshot> documentList) {
    print(documentList);
 /*   mapController.clearMarkers();
    documentList.forEach((DocumentSnapshot document) {
      GeoPoint pos = document.data['position']['geopoint'];
      double distance = document.data['distance'];
      var marker = Marker(
          position: LatLng(pos.latitude, pos.longitude),
          icon: BitmapDescriptor.defaultMarker,
          infoWindowText: InfoWindowText('Magic Marker', '$distance kilometers from query center')
      );


      mapController.addMarker(marker);
    });*/
  }

  _startQuery() async {
    // Get users location
    LocationData pos = await location.getLocation();
    double lat = pos.latitude!;
    double lng = pos.longitude!;


    // Make a referece to firestore
    var ref = firestore.collection('locations');
    GeoFirePoint center = geo.point(latitude: lat, longitude: lng);

    // subscribe to query
    subscription = radius.switchMap((rad) {
      return geo.collection(collectionRef: ref).within(
          center: center,
          radius: rad,
          field: 'position',
          strictMode: true
      );
    }).listen(_updateMarkers);
  }

  _updateQuery(value) {
    setState(() {
      radius.add(value);
    });
  }
  @override
  dispose() {
    subscription.cancel();
    super.dispose();
  }

}
