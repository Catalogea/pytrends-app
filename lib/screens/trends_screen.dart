import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TrendsScreen extends StatefulWidget {
  const TrendsScreen({super.key});

  @override
  State<TrendsScreen> createState() => _TrendsScreenState();
}

class _TrendsScreenState extends State<TrendsScreen> {
  String selectedCountry = 'ES';
  String selectedCategory = 'all';
  String selectedTimeRange = 'today';

  final List<Map<String, dynamic>> trends = [
    {
      'title': 'Ejemplo de Tendencia',
      'category': 'Tecnología',
      'relevance': 95,
      'description': 'Esta es una descripción de ejemplo para mostrar el diseño.',
      'keywords': ['keyword1', 'keyword2', 'keyword3', 'keyword4', 'keyword5'],
      'region': 'España',
      'searchVolume': '50K',
      'date': DateTime.now(),
      'ranking': 1,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tendencias'),
      ),
      body: Column(
        children: [
          _buildFilters(),
          Expanded(
            child: _buildTrendsList(),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: selectedCountry,
                  decoration: const InputDecoration(
                    labelText: 'País',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'ES', child: Text('España')),
                    DropdownMenuItem(value: 'MX', child: Text('México')),
                    DropdownMenuItem(value: 'AR', child: Text('Argentina')),
                  ],
                  onChanged: (value) {
                    setState(() => selectedCountry = value!);
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: selectedCategory,
                  decoration: const InputDecoration(
                    labelText: 'Categoría',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'all', child: Text('Todas')),
                    DropdownMenuItem(value: 'tech', child: Text('Tecnología')),
                    DropdownMenuItem(value: 'business', child: Text('Negocios')),
                  ],
                  onChanged: (value) {
                    setState(() => selectedCategory = value!);
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: selectedTimeRange,
                  decoration: const InputDecoration(
                    labelText: 'Periodo',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'today', child: Text('Hoy')),
                    DropdownMenuItem(value: 'week', child: Text('Esta semana')),
                    DropdownMenuItem(value: 'month', child: Text('Este mes')),
                  ],
                  onChanged: (value) {
                    setState(() => selectedTimeRange = value!);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTrendsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: trends.length,
      itemBuilder: (context, index) {
        final trend = trends[index];
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
                            trend['title'],
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            trend['category'],
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '${trend['relevance']}%',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(trend['description']),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  children: (trend['keywords'] as List).map((keyword) {
                    return Chip(
                      label: Text(keyword),
                      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Región: ${trend['region']}'),
                    Text('Volumen: ${trend['searchVolume']}'),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Fecha: ${DateFormat('dd/MM/yyyy').format(trend['date'])}',
                    ),
                    Text('Ranking: #${trend['ranking']}'),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.preview),
                      label: const Text('Vista previa'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, '/interests');
                      },
                      icon: const Icon(Icons.favorite_border),
                      label: const Text('Me interesa'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}