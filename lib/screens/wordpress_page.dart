import 'package:flutter/material.dart';
import '../services/wordpress_api.dart';
class WordPressPage extends StatelessWidget {
  const WordPressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Politicos Ecuador'),
        actions: [
          Semantics(
            button: true,
            label: 'Botón para refrescar contenido',
            child: IconButton(
              icon: const Icon(Icons.refresh, semanticLabel: 'Refrescar'),
              onPressed: () {
                // Implementar refresh si es necesario
              },
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<dynamic>>(
        future: WordPressAPI.getPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Semantics(
                label: 'Cargando contenido',
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Semantics(
                liveRegion: true,
                child: Text('Error: ${snapshot.error}'),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Semantics(
                liveRegion: true,
                child: Text('No hay noticias disponibles.'),
              ),
            );
          } else {
            final posts = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                final title = post['title']['rendered'];
                final excerpt = post['excerpt']['rendered'];
                final content = post['content']['rendered'];
                final imageUrl = post['_embedded']?['wp:featuredmedia']?[0]?['source_url'];
                final date = DateTime.parse(post['date']).toLocal();

                return Semantics(
                  button: true,
                  label: 'Noticia: $title',
                  child: Card(
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        _showPostDetail(context, title, content, imageUrl);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (imageUrl != null)
                              Semantics(
                                image: true,
                                label: 'Imagen de la noticia',
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    imageUrl,
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        width: 80,
                                        height: 80,
                                        color: Colors.grey.shade200,
                                        child: const Icon(Icons.article, semanticLabel: 'Icono de artículo'),
                                      );
                                    },
                                  ),
                                ),
                              )
                            else
                              Semantics(
                                image: true,
                                label: 'Icono de artículo',
                                child: Container(
                                  width: 80,
                                  height: 80,
                                  color: Colors.grey.shade200,
                                  child: const Icon(Icons.article),
                                ),
                              ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    title,
                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${date.day}/${date.month}/${date.year}',
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    excerpt.replaceAll(RegExp(r'<[^>]*>'), ''),
                                    style: Theme.of(context).textTheme.bodyMedium,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  void _showPostDetail(BuildContext context, String title, String content, String? imageUrl) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Semantics(
            explicitChildNodes: true,
            label: 'Detalle de la noticia',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (imageUrl != null)
                  Semantics(
                    image: true,
                    label: 'Imagen destacada de la noticia',
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        imageUrl,
                        height: 200,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 200,
                            color: Colors.grey.shade200,
                            child: const Center(
                              child: Icon(Icons.article, size: 60, semanticLabel: 'Icono de artículo'),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                const SizedBox(height: 16),
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  content.replaceAll(RegExp(r'<[^>]*>'), ''),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 24),
                Semantics(
                  button: true,
                  label: 'Botón para cerrar el detalle',
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cerrar'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}