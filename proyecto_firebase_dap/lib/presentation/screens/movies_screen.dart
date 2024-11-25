import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:proyecto_firebase_dap/domain/movie.dart';
import 'package:proyecto_firebase_dap/presentation/providers/movie_provider.dart';

class SongsScreen extends ConsumerStatefulWidget {
  static const String name = 'songs_screen';
  const SongsScreen({super.key});

  @override
  ConsumerState<SongsScreen> createState() => _SongsScreenState();
}

class _SongsScreenState extends ConsumerState<SongsScreen> {
  @override
  void initState() {
    super.initState();
    // Cargar las canciones desde Firebase al iniciar
    ref.read(songProvider.notifier).getAllSongs();
  }

  @override
  Widget build(BuildContext context) {
    List<Song> songs = ref.watch(songProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Songs'),
      ),
      body: songs.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : _SongsView(songs: songs),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Obtener la nueva ID basada en la cantidad actual de canciones
          final newId = (songs.isNotEmpty
                  ? songs.map((song) => int.tryParse(song.id) ?? 0).reduce((a, b) => a > b ? a : b)
                  : 0) +
              1;

          // Crear una nueva canción con un ID único
          final newSong = Song(
            id: newId.toString(),
            cancion: 'New Song $newId',
            banda: 'Unknown Band',
            disco: 'Unknown Album',
            year: DateTime.now().year,
            imagen: 'URL',
          );

          // Agregar la nueva canción a Firebase
          await ref.read(songProvider.notifier).addSong(newSong);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _SongsView extends StatelessWidget {
  final List<Song> songs;

  const _SongsView({
    required this.songs,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: songs.length,
      itemBuilder: (context, index) {
        final song = songs[index];
        return _SongItemView(song: song);
      },
    );
  }
}

class _SongItemView extends StatelessWidget {
  final Song song;

  const _SongItemView({required this.song});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(song.cancion),
        subtitle: Text(song.banda),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          context.push('/movie_detail/${song.id}');
        },
      ),
    );
  }
}
