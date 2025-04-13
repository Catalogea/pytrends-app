import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:flutter_markdown/flutter_markdown.dart';

class EditorScreen extends StatefulWidget {
  const EditorScreen({super.key});

  @override
  State<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> {
  final QuillController _controller = QuillController.basic();
  final TextEditingController _keywordsController = TextEditingController();
  final TextEditingController _metaDescriptionController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  String _previewContent = '';

  @override
  void initState() {
    super.initState();
    _controller.document.changes.listen((event) {
      setState(() {
        _previewContent = _controller.document.toPlainText();
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _keywordsController.dispose();
    _metaDescriptionController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editor de Artículos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveArticle,
          ),
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: _downloadArticle,
          ),
        ],
      ),
      body: Row(
        children: [
          Expanded(
            flex: 3,
            child: _buildEditor(),
          ),
          const VerticalDivider(width: 1),
          Expanded(
            flex: 2,
            child: _buildPreview(),
          ),
        ],
      ),
    );
  }

  Widget _buildEditor() {
    return Column(
      children: [
        QuillToolbar.basic(
          controller: _controller,
          showAlignmentButtons: true,
          showBackgroundColorButton: false,
          showCenterAlignment: true,
          showColorButton: true,
          showCodeBlock: true,
          showDirection: false,
          showFontFamily: true,
          showDividers: true,
          showIndent: true,
          showHeaderStyle: true,
          showLink: true,
          showSearchButton: true,
          showInlineCode: true,
          showQuote: true,
          showListBullets: true,
          showListNumbers: true,
          showClearFormat: true,
          showBoldButton: true,
          showItalicButton: true,
          showUnderLineButton: true,
          showStrikeThrough: true,
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: QuillEditor.basic(
              controller: _controller,
              readOnly: false,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPreview() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Vista Previa',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Markdown(data: _previewContent, shrinkWrap: true),
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            border: Border(
              top: BorderSide(color: Theme.of(context).dividerColor),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Configuración SEO',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _keywordsController,
                decoration: const InputDecoration(
                  labelText: 'Palabras clave (máx. 5)',
                  border: OutlineInputBorder(),
                  helperText: 'Separa las palabras clave con comas',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _metaDescriptionController,
                decoration: const InputDecoration(
                  labelText: 'Meta descripción',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _categoryController,
                decoration: const InputDecoration(
                  labelText: 'Categoría',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _regenerateArticle,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Regenerar artículo'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _saveArticle() {
    // Implementar guardado del artículo
  }

  void _downloadArticle() {
    // Implementar descarga del artículo
  }

  void _regenerateArticle() {
    // Implementar regeneración del artículo con IA
  }
}