import 'package:flutter/material.dart';
import 'package:qacodereader/src/bloc/scans_bloc.dart';
import 'package:qacodereader/src/models/scan_model.dart';
import 'package:qacodereader/src/utils/utils.dart' as utils;

class MapasPage extends StatelessWidget {

  final scansBloc = new ScansBloc();

  @override
  Widget build(BuildContext context) {

    scansBloc.obtenerScans();

    return StreamBuilder<List<ScanModel>>(
      stream: scansBloc.scansStream,
      builder: (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshtop ){
        if(!snapshtop.hasData){
          return Center(child: CircularProgressIndicator(),);
        }
        final scans = snapshtop.data;

        if (scans.length == 0 ){
          return Center(child: Text("No hay datos"),);
        }

        return ListView.builder(
          itemCount: scans.length,
          itemBuilder: (context, i) =>
           Dismissible(
              key: UniqueKey(),
              background: Container(color: Colors.red),
              onDismissed: (direction) => scansBloc.borrarScan(scans[i].id),
              child: ListTile(
              leading: Icon(Icons.map, color: Theme.of(context).primaryColor ),
              title: Text(scans[i].valor),
              trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey),
              onTap: () => utils.abrirScan(context,scans[i]),
            ),
          ), 
          );
      }
      );
  }
}