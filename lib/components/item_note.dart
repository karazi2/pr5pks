
import 'package:flutter/material.dart';
import '../models/note.dart';

class ItemNote extends StatefulWidget {
  final Note note;

  const ItemNote({Key? key, required this.note}) : super(key: key);

  @override
  _ItemNoteState createState() => _ItemNoteState();
}

class _ItemNoteState extends State<ItemNote> {
  // Функция для переключения избранного состояния
  void _toggleFavorite() {
    setState(() {
      widget.note.isFavorite = !widget.note.isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note.title),
        actions: [
          IconButton(
            icon: Icon(
              widget.note.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: widget.note.isFavorite ? Colors.red : Colors.white,
            ),
            onPressed: _toggleFavorite,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.note.photo_id.isNotEmpty)
              Image.network(
                widget.note.photo_id,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Text('Ошибка загрузки изображения');
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                          : null,
                    ),
                  );
                },
              ),
            const SizedBox(height: 10),
            Text(widget.note.description),
          ],
        ),
      ),
    );
  }
}
