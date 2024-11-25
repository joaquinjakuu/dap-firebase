import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_firebase_dap/domain/movie.dart';
import 'package:proyecto_firebase_dap/presentation/providers/movie_provider.dart';

class SongDetailScreen extends ConsumerWidget {
  static const String name = 'song_detail_screen';

  final String songId;

  const SongDetailScreen({super.key, required this.songId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final songList = ref.watch(songProvider);
    final song = songList.firstWhere((s) => s.id == songId);

    final TextEditingController cancionController =
        TextEditingController(text: song.cancion);
    final TextEditingController bandaController =
        TextEditingController(text: song.banda);
    final TextEditingController discoController =
        TextEditingController(text: song.disco);
    final TextEditingController yearController =
        TextEditingController(text: song.year.toString());
    final TextEditingController imagenController =
        TextEditingController(text: song.imagen);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles de la Canción'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () async {
              final updatedSong = song.copyWith(
                cancion: cancionController.text.trim(),
                banda: bandaController.text.trim(),
                disco: discoController.text.trim(),
                year: int.tryParse(yearController.text) ?? song.year,
                imagen: imagenController.text.trim(),
              );
              await ref.read(songProvider.notifier).updateSong(updatedSong);
              Navigator.of(context).pop();
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              await ref.read(songProvider.notifier).deleteSong(song.id);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  imagenController.text.trim(),
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.image_not_supported, size: 100),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: cancionController,
                decoration: const InputDecoration(labelText: 'Canción'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: bandaController,
                decoration: const InputDecoration(labelText: 'Banda'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: discoController,
                decoration: const InputDecoration(labelText: 'Disco'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: yearController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Año'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: imagenController,
                decoration: const InputDecoration(labelText: 'URL de la Imagen'),
                onChanged: (value) {
                  // Actualiza la imagen al cambiar el texto
                  // Puedes usar setState en un StatefulWidget si necesitas interacción instantánea
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
