import 'package:flutter/material.dart';
import '../models/politician.dart';

class ProvinceDetailsScreen extends StatelessWidget {
  final String provinceName;

  const ProvinceDetailsScreen({super.key, required this.provinceName});

  @override
  Widget build(BuildContext context) {
    final politicians = EcuadorData.getPoliticiansByProvince(provinceName);

    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de $provinceName'),
      ),
      body: politicians.isEmpty
          ? Center(child: Text('No hay políticos registrados para $provinceName'))
          : ListView.builder(
        itemCount: politicians.length,
        itemBuilder: (context, index) {
          final p = politicians[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(p.imageUrl),
            ),
            title: Text(p.name),
            subtitle: Text('${p.position}\n${p.party}'),
            isThreeLine: true,
          );
        },
      ),
    );
  }
}
