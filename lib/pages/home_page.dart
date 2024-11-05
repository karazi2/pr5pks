import 'package:flutter/material.dart';
import '../models/note.dart';
import '../components/item_note.dart' as components;
import 'create_note_page.dart' as pages;

class HomePage extends StatelessWidget {
  final List<Note> notes;
  final Function(Note) onToggleFavorite;
  final Function(Note) onAddNote;
  final Function(Note) onDeleteNote; // Добавленный параметр для удаления

  const HomePage({
    Key? key,
    required this.notes,
    required this.onToggleFavorite,
    required this.onAddNote,
    required this.onDeleteNote,
  }) : super(key: key);

  void _openNote(BuildContext context, Note note) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => components.ItemNote(note: note),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Аренда Квартир'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => pages.CreateNotePage(onCreate: onAddNote),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];
          return GestureDetector(
            onTap: () => _openNote(context, note),
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (note.photo_id.isNotEmpty)
                        Image.network(
                          note.photo_id,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Text('Ошибка загрузки изображения');
                          },
                        ),
                      const SizedBox(height: 10),
                      Text(
                        note.title,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.black),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        note.description,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black87),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '₽${note.price}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(
                            note.isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: note.isFavorite ? Colors.red : Colors.grey,
                          ),
                          onPressed: () {
                            onToggleFavorite(note);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            onDeleteNote(note); // Вызов функции удаления
                          },
                        ),
                      ],
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
