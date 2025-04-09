import 'package:flutter/material.dart';
import '../models/politician.dart';

class PoliticianDetailScreen extends StatelessWidget {
  final Politician politician;

  const PoliticianDetailScreen({
    super.key,
    required this.politician,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(politician.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Semantics(
          liveRegion: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Semantics(
                image: true,
                label: 'Foto de ${politician.name}',
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      politician.imageUrl,
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 150,
                          height: 150,
                          color: Colors.grey.shade200,
                          child: const Icon(Icons.person, size: 60, semanticLabel: 'Icono de persona'),
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                politician.name,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                politician.position,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: Color(int.parse('0xFF${politician.partyColor}')),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    politician.party,
                    style: TextStyle(
                      color: Color(int.parse('0xFF${politician.partyColor}')),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildDetailCard(
                context,
                title: 'Provincia',
                content: politician.province,
                icon: Icons.location_on,
              ),
              const SizedBox(height: 16),
              _buildDetailCard(
                context,
                title: 'Índice de Aprobación',
                content: '${politician.approvalRating.toStringAsFixed(1)}%',
                icon: Icons.trending_up,
              ),
              const SizedBox(height: 16),
              _buildDetailCard(
                context,
                title: 'Biografía',
                content: politician.biography,
                icon: Icons.info,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailCard(
      BuildContext context, {
        required String title,
        required String content,
        required IconData icon,
      }) {
    return Semantics(
      container: true,
      label: '$title: $content',
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, color: Theme.of(context).primaryColor, semanticLabel: 'Icono de $title'),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(content),
            ],
          ),
        ),
      ),
    );
  }
}