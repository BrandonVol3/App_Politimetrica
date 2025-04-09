import 'package:flutter/material.dart';
import '../models/politician.dart';
import 'politician_detail_screen.dart';
import '../widgets/politician_card.dart';

class PoliticianListScreen extends StatelessWidget {
  const PoliticianListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Políticos Ecuatorianos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, semanticLabel: 'Buscar políticos'),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: EcuadorData.politicians.length,
        itemBuilder: (context, index) {
          final politician = EcuadorData.politicians[index];
          return PoliticianCard(
            politician: politician,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PoliticianDetailScreen(politician: politician),
              ),
            ),
          );
        },
      ),
    );
  }
}