import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proyecto_firebase_dap/domain/movie.dart';

final songProvider = StateNotifierProvider<SongsNotifier, List<Song>>(
  (ref) => SongsNotifier(FirebaseFirestore.instance),
);

class SongsNotifier extends StateNotifier<List<Song>> {
  final FirebaseFirestore db;

  SongsNotifier(this.db) : super([]);

  Future<void> addSong(Song song) async {
    final doc = db.collection('songs').doc(song.id);
    try {
      await doc.set(song.toFirestore());
      state = [...state, song];
    } catch (e) {
      print('Error al agregar la canción: $e');
    }
  }

  Future<void> getAllSongs() async {
    try {
      final docs = db.collection('songs').get();
      final fetchedSongs = (await docs).docs.map((d) {
        return Song.fromFirestore(d.data(), d.id);
      }).toList();

      state = fetchedSongs;
    } catch (e) {
      print('Error al obtener las canciones: $e');
    }
  }

  Future<void> updateSong(Song updatedSong) async {
    final doc = db.collection('songs').doc(updatedSong.id);
    try {
      await doc.update(updatedSong.toFirestore());
      state = [
        for (final song in state)
          if (song.id == updatedSong.id) updatedSong else song
      ];
    } catch (e) {
      print('Error al actualizar la canción: $e');
    }
  }

  Future<void> deleteSong(String songId) async {
    final doc = db.collection('songs').doc(songId);
    try {
      await doc.delete();
      state = state.where((song) => song.id != songId).toList();
    } catch (e) {
      print('Error al eliminar la canción: $e');
    }
  }
}
