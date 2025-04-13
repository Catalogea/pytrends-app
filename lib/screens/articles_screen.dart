import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ArticlesScreen extends StatefulWidget {
  const ArticlesScreen({super.key});

  @override
  State<ArticlesScreen> createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen> {
  String _selectedCategory = 'Todas';
  String _searchQuery = '';

  final List<Map<String, dynamic>> _articles = [
    {
      'title': 'Artículo de Ejemplo',
      'category': 'Tecnología',
      'keywords': ['tech', 'ai', 'future'],
      'createdAt': DateTime.now(),
      'status': 'Publicado',
    },
    {
      'title': 'Otro Artículo',
      'category': 'Negocios',
      'keywords': ['business', 'startup'],
      'createdAt': DateTime.now().subtract(const Duration(days: 1)),
      'status': 'Borrador',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Artículos Generados'),
      ),
      body: Column(
        children: [
          _buildFilters(),
          Expanded(
            child: _buildArticlesList(),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Buscar artículos',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          const SizedBox(width: 16),
          DropdownButton<String>(
            value: _selectedCategory,
            items: const [
              DropdownMenuItem(value: 'Todas', child: Text('Todas')),
              DropdownMenuItem(value: 'Tecnología', child: Text('Tecnología')),
              DropdownMenuItem(value: 'Negocios', child: Text('Negocios')),
              DropdownMenuItem(value: 'Salud', child: Text('Salud')),
            ],
            onChanged: (value) {
              setState(() {
                _selectedCategory = value!;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildArticlesList() {
    final filteredArticles = _articles.where((article) {
      final matchesCategory = _selectedCategory == 'Todas' ||
          article['category'] == _selectedCategory;
      final matchesSearch = article['title']
          .toString()
          .toLowerCase()
          .contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: filteredArticles.length,
      itemBuilder: (context, index) {
        final article = filteredArticles[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16.0),
          child: ListTile(
            title: Text(
              article['title'],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Row(
                  children: [
                    Chip(
                      label: Text(article['category']),
                      backgroundColor:
                          Theme.of(context).primaryColor.withOpacity(0.1),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      DateFormat('dd/MM/yyyy')
                          .format(article['createdAt'] as DateTime),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: article['status'] == 'Publicado'
                            ? Colors.green
                            : Colors.orange,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        article['status'],
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: (article['keywords'] as List).map((keyword) {
                    return Chip(
                      label: Text(keyword),
                      backgroundColor:
                          Theme.of(context).primaryColor.withOpacity(0.1),
                    );
                  }).toList(),
                ),
              ],
            ),
            trailing: PopupMenuButton<String>(
              onSelected: (value) => _handleArticleAction(value, article),
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'view',
                  child: Text('Ver'),
                ),
                const PopupMenuItem(
                  value: 'edit',
                  child: Text('Editar'),
                ),
                const PopupMenuItem(
                  value: 'download',
                  child: Text('Descargar'),
                ),
                const PopupMenuItem(
                  value: 'delete',
                  child: Text('Eliminar'),
                ),
                const PopupMenuItem(
                  value: 'publish',
                  child: Text('Publicar'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _handleArticleAction(String action, Map<String, dynamic> article) {
    switch (action) {
      case 'view':
        // Implementar vista del artículo
        break;
      case 'edit':
        Navigator.pushNamed(context, '/editor');
        break;
      case 'download':
        // Implementar descarga del artículo
        break;
      case 'delete':
        // Implementar eliminación del artículo
        break;
      case 'publish':
        // Implementar publicación del artículo
        break;
    }
  }
}