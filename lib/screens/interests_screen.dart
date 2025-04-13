import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InterestsScreen extends StatelessWidget {
  const InterestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Me Interesa'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _mockInterests.length,
        itemBuilder: (context, index) {
          final interest = _mockInterests[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              interest['title'],
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              interest['category'],
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.favorite, color: Colors.red),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(interest['description']),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    children: (interest['keywords'] as List).map((keyword) {
                      return Chip(
                        label: Text(keyword),
                        backgroundColor:
                            Theme.of(context).primaryColor.withOpacity(0.1),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Región: ${interest['region']}'),
                      Text('Volumen: ${interest['searchVolume']}'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Guardado: ${DateFormat('dd/MM/yyyy').format(interest['savedDate'])}',
                      ),
                      Text('Ranking: #${interest['ranking']}'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, '/editor');
                      },
                      icon: const Icon(Icons.article),
                      label: const Text('Generar artículo con IA'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

final List<Map<String, dynamic>> _mockInterests = [
  {
    'title': 'Tendencia Guardada de Ejemplo',
    'category': 'Tecnología',
    'description':
        'Esta es una descripción de ejemplo para una tendencia guardada.',
    'keywords': ['keyword1', 'keyword2', 'keyword3', 'keyword4', 'keyword5'],
    'region': 'España',
    'searchVolume': '50K',
    'savedDate': DateTime.now(),
    'ranking': 1,
  },
  {
    'title': 'Otra Tendencia Interesante',
    'category': 'Negocios',
    'description':
        'Una segunda tendencia guardada para mostrar múltiples elementos.',
    'keywords': ['business', 'startup', 'innovation', 'tech', 'future'],
    'region': 'México',
    'searchVolume': '35K',
    'savedDate': DateTime.now().subtract(const Duration(days: 1)),
    'ranking': 2,
  },
];