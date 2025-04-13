import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import 'package:pytrends/services/theme_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: Icon(
              Provider.of<ThemeProvider>(context).isDarkMode
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: () =>
                Provider.of<ThemeProvider>(context, listen: false).toggleTheme(),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'PyTrends Content Generator',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Dashboard'),
              onTap: () => Navigator.pushReplacementNamed(context, '/'),
            ),
            ListTile(
              leading: const Icon(Icons.trending_up),
              title: const Text('Tendencias'),
              onTap: () => Navigator.pushReplacementNamed(context, '/trends'),
            ),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('Me Interesa'),
              onTap: () => Navigator.pushReplacementNamed(context, '/interests'),
            ),
            ListTile(
              leading: const Icon(Icons.article),
              title: const Text('Artículos'),
              onTap: () => Navigator.pushReplacementNamed(context, '/articles'),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Configuración'),
              onTap: () => Navigator.pushReplacementNamed(context, '/settings'),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Resumen de Artículos',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            GridView.count(
              crossAxisCount: 4,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildStatCard(
                  'Total de Artículos',
                  '120',
                  Icons.article,
                  Colors.blue,
                ),
                _buildStatCard(
                  'Esta Semana',
                  '8',
                  Icons.calendar_today,
                  Colors.green,
                ),
                _buildStatCard(
                  'Este Mes',
                  '32',
                  Icons.date_range,
                  Colors.orange,
                ),
                _buildStatCard(
                  'Borradores',
                  '5',
                  Icons.edit_note,
                  Colors.purple,
                ),
              ],
            ),
            const SizedBox(height: 32),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: _buildCategoriesTable(),
                ),
                const SizedBox(width: 32),
                Expanded(
                  flex: 1,
                  child: _buildAIModelInfo(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: color),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoriesTable() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Categorías más utilizadas',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            DataTable(
              columns: const [
                DataColumn(label: Text('Categoría')),
                DataColumn(label: Text('Artículos')),
                DataColumn(label: Text('Tendencia')),
              ],
              rows: [
                _buildDataRow('Tecnología', '45', '+12%'),
                _buildDataRow('Negocios', '32', '+8%'),
                _buildDataRow('Salud', '28', '+15%'),
                _buildDataRow('Deportes', '15', '-3%'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  DataRow _buildDataRow(String category, String articles, String trend) {
    return DataRow(
      cells: [
        DataCell(Text(category)),
        DataCell(Text(articles)),
        DataCell(
          Text(
            trend,
            style: TextStyle(
              color: trend.startsWith('+') ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAIModelInfo() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Modelo de IA Actual',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.psychology, color: Colors.blue),
              title: const Text('GPT-4'),
              subtitle: const Text('OpenAI'),
            ),
            const Divider(),
            const ListTile(
              title: Text('Estadísticas del modelo'),
              subtitle: Text('Tokens utilizados: 1.2M\nPrecisión: 94%'),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.settings),
              label: const Text('Cambiar Modelo'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
              ),
            ),
          ],
        ),
      ),
    );
  }
}