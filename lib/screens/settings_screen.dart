import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pytrends/services/theme_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _openAIController = TextEditingController();
  final _claudeController = TextEditingController();
  final _mistralController = TextEditingController();
  String _selectedModel = 'gpt-4';
  String _selectedLength = 'media';
  String _selectedTone = 'profesional';
  String _selectedLanguage = 'es';
  String _selectedRegion = 'ES';
  bool _autoSave = true;
  bool _notifications = true;
  String _selectedFrequency = 'diaria';
  TimeOfDay _selectedTime = const TimeOfDay(hour: 9, minute: 0);

  @override
  void dispose() {
    _openAIController.dispose();
    _claudeController.dispose();
    _mistralController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAPIKeysSection(),
              const Divider(height: 32),
              _buildAIModelSection(),
              const Divider(height: 32),
              _buildContentPreferencesSection(),
              const Divider(height: 32),
              _buildUIPreferencesSection(),
              const Divider(height: 32),
              _buildAutomationSection(),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveSettings,
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('Guardar Configuración'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAPIKeysSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'API Keys',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _openAIController,
          decoration: const InputDecoration(
            labelText: 'OpenAI API Key',
            border: OutlineInputBorder(),
          ),
          obscureText: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor ingresa tu API key de OpenAI';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _claudeController,
          decoration: const InputDecoration(
            labelText: 'Claude API Key',
            border: OutlineInputBorder(),
          ),
          obscureText: true,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _mistralController,
          decoration: const InputDecoration(
            labelText: 'Mistral API Key',
            border: OutlineInputBorder(),
          ),
          obscureText: true,
        ),
      ],
    );
  }

  Widget _buildAIModelSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Modelo de IA',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<String>(
          value: _selectedModel,
          decoration: const InputDecoration(
            labelText: 'Modelo Activo',
            border: OutlineInputBorder(),
          ),
          items: const [
            DropdownMenuItem(value: 'gpt-4', child: Text('GPT-4')),
            DropdownMenuItem(value: 'gpt-3.5', child: Text('GPT-3.5')),
            DropdownMenuItem(value: 'claude', child: Text('Claude')),
            DropdownMenuItem(value: 'mistral', child: Text('Mistral')),
          ],
          onChanged: (value) {
            setState(() {
              _selectedModel = value!;
            });
          },
        ),
      ],
    );
  }

  Widget _buildContentPreferencesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Preferencias de Contenido',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<String>(
          value: _selectedLength,
          decoration: const InputDecoration(
            labelText: 'Longitud del contenido',
            border: OutlineInputBorder(),
          ),
          items: const [
            DropdownMenuItem(value: 'corta', child: Text('Corta')),
            DropdownMenuItem(value: 'media', child: Text('Media')),
            DropdownMenuItem(value: 'larga', child: Text('Larga')),
          ],
          onChanged: (value) {
            setState(() {
              _selectedLength = value!;
            });
          },
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<String>(
          value: _selectedTone,
          decoration: const InputDecoration(
            labelText: 'Tono de escritura',
            border: OutlineInputBorder(),
          ),
          items: const [
            DropdownMenuItem(value: 'profesional', child: Text('Profesional')),
            DropdownMenuItem(value: 'casual', child: Text('Casual')),
            DropdownMenuItem(value: 'formal', child: Text('Formal')),
          ],
          onChanged: (value) {
            setState(() {
              _selectedTone = value!;
            });
          },
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<String>(
                value: _selectedLanguage,
                decoration: const InputDecoration(
                  labelText: 'Idioma principal',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'es', child: Text('Español')),
                  DropdownMenuItem(value: 'en', child: Text('Inglés')),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedLanguage = value!;
                  });
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: DropdownButtonFormField<String>(
                value: _selectedRegion,
                decoration: const InputDecoration(
                  labelText: 'Región',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'ES', child: Text('España')),
                  DropdownMenuItem(value: 'MX', child: Text('México')),
                  DropdownMenuItem(value: 'AR', child: Text('Argentina')),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedRegion = value!;
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildUIPreferencesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Preferencias de Interfaz',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        SwitchListTile(
          title: const Text('Modo Oscuro'),
          value: Provider.of<ThemeProvider>(context).isDarkMode,
          onChanged: (value) {
            Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
          },
        ),
        SwitchListTile(
          title: const Text('Guardado Automático'),
          value: _autoSave,
          onChanged: (value) {
            setState(() {
              _autoSave = value;
            });
          },
        ),
        SwitchListTile(
          title: const Text('Notificaciones'),
          value: _notifications,
          onChanged: (value) {
            setState(() {
              _notifications = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildAutomationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Automatización',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<String>(
          value: _selectedFrequency,
          decoration: const InputDecoration(
            labelText: 'Frecuencia de generación',
            border: OutlineInputBorder(),
          ),
          items: const [
            DropdownMenuItem(value: 'diaria', child: Text('Diaria')),
            DropdownMenuItem(value: 'semanal', child: Text('Semanal')),
            DropdownMenuItem(value: 'mensual', child: Text('Mensual')),
          ],
          onChanged: (value) {
            setState(() {
              _selectedFrequency = value!;
            });
          },
        ),
        const SizedBox(height: 16),
        ListTile(
          title: const Text('Hora de generación'),
          subtitle: Text(_selectedTime.format(context)),
          trailing: const Icon(Icons.access_time),
          onTap: () async {
            final TimeOfDay? time = await showTimePicker(
              context: context,
              initialTime: _selectedTime,
            );
            if (time != null) {
              setState(() {
                _selectedTime = time;
              });
            }
          },
        ),
      ],
    );
  }

  void _saveSettings() {
    if (_formKey.currentState!.validate()) {
      // Implementar guardado de configuración
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Configuración guardada')),
      );
    }
  }
}