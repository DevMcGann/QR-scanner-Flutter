import "package:latlong/latlong.dart" as latLng;

class ScanModel {
    ScanModel({
        this.id,
        this.tipo,
        this.valor,
    }){
      if (valor.contains("http")){
        tipo = 'http';
      }else {
        tipo = 'geo';
      }
    }

    int id;
    String tipo;
    String valor;

    factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
        id: json["id"],
        tipo: json["tipo"],
        valor: json["valor"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo,
        "valor": valor,
    };

    latLng.LatLng getLatLng(){
      final latlong = valor.substring(4).split(',');
      final lat = double.parse(latlong[0]);
      final lng = double.parse(latlong[1]);

      return latLng.LatLng(lat,lng);
    }
}