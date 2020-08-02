

import 'dart:async';

import 'package:qacodereader/src/bloc/validator.dart';
import 'package:qacodereader/src/providers/db_provider.dart';

class ScansBloc with Validators {
  static final ScansBloc _singleton = new ScansBloc._internal();

  factory ScansBloc(){
    return _singleton;
  }

  ScansBloc._internal(){
    //obtener scans de la db
    obtenerScans();
  }

  final _scansStreamController = StreamController<List<ScanModel>>.broadcast();

  Stream<List<ScanModel>> get scansStream     => _scansStreamController.stream.transform(validarGeo);
  Stream<List<ScanModel>> get scansStreamHttp => _scansStreamController.stream.transform(validarHttp);

  dispose(){
    _scansStreamController?.close();
  }


  obtenerScans() async {
    _scansStreamController.sink.add(await DBProvider.db.getTodosScans());
  }

  agregarScan(ScanModel scan) async {
    await DBProvider.db.nuevoScan(scan);
    obtenerScans();
  }

  borrarScan(int id) async {
    await DBProvider.db.deleteScan(id);
    obtenerScans();
  }

  borrarTodosScans() async {
    await DBProvider.db.deleteAll();
    obtenerScans();
  }
}