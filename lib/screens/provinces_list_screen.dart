import 'package:flutter/material.dart';
import '../models/politician.dart';
import 'politician_detail_screen.dart';

class ProvincesListScreen extends StatelessWidget {
  const ProvincesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provincias del Ecuador'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: EcuadorData.provinces.length,
        itemBuilder: (context, index) {
          final province = EcuadorData.provinces[index];
          final politicians = EcuadorData.politicians
              .where((p) => p.province == province)
              .toList();

          return Semantics(
            button: true,
            label: 'Provincia $province con ${politicians.length} políticos',
            child: Card(
              child: ListTile(
                title: Text(province),
                trailing: Text(
                  politicians.isEmpty ? '0' : politicians.length.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  if (politicians.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('No hay políticos registrados en $province'),
                        action: SnackBarAction(
                          label: 'OK',
                          onPressed: () {},
                        ),
                      ),
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Políticos de $province'),
                          content: SizedBox(
                            width: double.maxFinite,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: politicians.length,
                              itemBuilder: (context, index) {
                                final politician = politicians[index];
                                return Semantics(
                                  button: true,
                                  label: 'Político ${politician.name} del partido ${politician.party}',
                                  child: ListTile(
                                    title: Text(politician.name),
                                    subtitle: Text(politician.party),
                                    onTap: () {
                                      Navigator.pop(context);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PoliticianDetailScreen(politician: politician),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                          actions: [
                            Semantics(
                              button: true,
                              label: 'Botón para cerrar el diálogo',
                              child: TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Cerrar'),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}