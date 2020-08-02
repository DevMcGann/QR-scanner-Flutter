import 'package:flutter/material.dart';
import 'package:qacodereader/src/models/scan_model.dart';
import 'package:flutter_map/flutter_map.dart';


class MapaPage extends StatefulWidget {


  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  final MapController mapController = new MapController();
  String tipoMapa = 'streets';

  @override
  Widget build(BuildContext context) {

    final ScanModel scan = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Coordenadas QR'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.my_location), 
          onPressed: (){
            mapController.move(scan.getLatLng(), 15);
          }),
        ],),
        body:_crearFlutterMap(scan),
        //floatingActionButton: _crearBotonFlotante(context) ,  //momentaneamente desactivado, porque hay un problema cn el string
    );
  }

  Widget _crearFlutterMap(ScanModel scan){
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        center: scan.getLatLng(),
        zoom: 15
      ),
      layers: [
        _crearMapa(),
        _crearMarcadores(scan)
      ],
      );
  }

_crearMapa() {
    return TileLayerOptions(
      urlTemplate: 'https://api.mapbox.com/styles/v1/{id}/tiles/'
                    '{z}/{x}/{y}?access_token={accessToken}',
      additionalOptions: {
        'accessToken':'insert yout MapBox ApiKey Here',
        'id': 'mapbox/$tipoMapa-v11'
      }
    );
  }

_crearMarcadores(ScanModel scan){
  return MarkerLayerOptions(
    markers: <Marker>[
      Marker(
        width: 100.0,
        height: 100.0,
        point: scan.getLatLng(),
        builder: (context) => 
        Container(
          child:Icon(
            Icons.location_on,
            size:65.0,
            color:Colors.red,
          ),
        ),
      ),
    ]
  );
}


Widget _crearBotonFlotante(BuildContext context){
  return FloatingActionButton(
    child: Icon(Icons.repeat),
    backgroundColor: Theme.of(context).primaryColor,
    onPressed: (){
        if (tipoMapa == 'streets'){
          tipoMapa = 'dark';
        }else if (tipoMapa == 'dark'){
          tipoMapa = 'light';
        }else if (tipoMapa == 'light'){
          tipoMapa = 'outdoors';
        }else if (tipoMapa == 'outdoors'){
          tipoMapa = 'satellite';
        }else{ tipoMapa = 'streets';}

        setState(() {});
    }
    );
}

}