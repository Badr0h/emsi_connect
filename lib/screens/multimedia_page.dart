// Import pour lire un fichier image local
import 'dart:io';

// Import du lecteur audio
import 'package:audioplayers/audioplayers.dart';
// Import pour détecter le web (kIsWeb)
import 'package:flutter/foundation.dart';
// Import de Flutter Material
import 'package:flutter/material.dart';
// Import pour choisir une image
import 'package:image_picker/image_picker.dart';
// Import pour obtenir un dossier temporaire
import 'package:path_provider/path_provider.dart';
// Import pour demander des permissions
import 'package:permission_handler/permission_handler.dart';
// Import pour enregistrer de l'audio
import 'package:record/record.dart';

// Page multimédia avec état
class MultimediaPage extends StatefulWidget {
  // Constructeur constant
  const MultimediaPage({super.key});

  // Crée l'état de la page
  @override
  State<MultimediaPage> createState() => _MultimediaPageState();
}

// État privé de la page multimédia
class _MultimediaPageState extends State<MultimediaPage> {
  // Outil pour sélectionner une image
  final ImagePicker _imagePicker = ImagePicker();
  // Enregistreur audio
  final AudioRecorder _recorder = AudioRecorder();
  // Lecteur audio
  final AudioPlayer _audioPlayer = AudioPlayer();

  // Image actuellement sélectionnée
  XFile? _selectedImage;
  // Chemin du fichier audio enregistré
  String? _audioPath;
  // Indique si on enregistre
  bool _isRecording = false;
  // Indique si on lit l'audio
  bool _isPlaying = false;

  // Libère les ressources audio
  @override
  void dispose() {
    // Libère le lecteur
    _audioPlayer.dispose();
    // Libère l'enregistreur
    _recorder.dispose();
    // Appelle dispose du parent
    super.dispose();
  }

  // Demande une permission et gère le refus
  Future<bool> _requestPermission(Permission permission) async {
    // Demande la permission
    final status = await permission.request();
    // Si refusée
    if (!status.isGranted) {
      // Affiche un message si le widget est encore monté
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Permission refusée')));
      }
      // Permission non accordée
      return false;
    }
    // Permission accordée
    return true;
  }

  // Choisit une image depuis la caméra ou la galerie
  Future<void> _pickImage(ImageSource source) async {
    // Choisit la permission selon la source
    final permission = source == ImageSource.camera
        ? Permission.camera
        : Permission.photos;
    // Arrête si la permission est refusée
    if (!await _requestPermission(permission)) return;

    try {
      // Ouvre le sélecteur d'image
      final image = await _imagePicker.pickImage(source: source);
      // Vérifie que la page est encore active
      if (!mounted) return;
      // Met à jour l'image affichée
      setState(() => _selectedImage = image);
    } catch (_) {
      // En cas d'erreur, vérifie le montage
      if (!mounted) return;
      // Affiche un message d'erreur
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Impossible de sélectionner une image')),
      );
    }
  }

  // Démarre l'enregistrement audio
  Future<void> _startRecording() async {
    // Sur le web, l'enregistrement n'est pas disponible
    if (kIsWeb) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Enregistrement audio disponible sur Android/iOS'),
        ),
      );
      return;
    }
    // Demande le micro
    if (!await _requestPermission(Permission.microphone)) return;

    try {
      // Récupère un dossier temporaire
      final directory = await getTemporaryDirectory();
      // Crée un chemin unique pour le fichier audio
      final path =
          '${directory.path}/emsi_audio_${DateTime.now().millisecondsSinceEpoch}.m4a';
      // Démarre l'enregistrement
      await _recorder.start(const RecordConfig(), path: path);
      // Vérifie le montage
      if (!mounted) return;
      // Met à jour l'état
      setState(() {
        _isRecording = true;
        _audioPath = null;
      });
    } catch (_) {
      // En cas d'erreur
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Impossible de démarrer l’enregistrement'),
        ),
      );
    }
  }

  // Arrête l'enregistrement audio
  Future<void> _stopRecording() async {
    try {
      // Stoppe et récupère le chemin
      final path = await _recorder.stop();
      // Vérifie le montage
      if (!mounted) return;
      // Sauvegarde le chemin et arrête l'indicateur
      setState(() {
        _isRecording = false;
        _audioPath = path;
      });
    } catch (_) {
      // En cas d'erreur
      if (!mounted) return;
      setState(() => _isRecording = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Impossible d’arrêter l’enregistrement')),
      );
    }
  }

  // Lit ou arrête la lecture de l'audio
  Future<void> _playRecording() async {
    // Rien à lire si pas de fichier
    if (_audioPath == null) return;
    try {
      // Si déjà en lecture, on arrête
      if (_isPlaying) {
        await _audioPlayer.stop();
        if (mounted) setState(() => _isPlaying = false);
        return;
      }
      // Lance la lecture du fichier
      await _audioPlayer.play(DeviceFileSource(_audioPath!));
      // Met à jour l'état
      if (mounted) setState(() => _isPlaying = true);
    } catch (_) {
      // En cas d'erreur
      if (!mounted) return;
      setState(() => _isPlaying = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Impossible de lire l’enregistrement')),
      );
    }
  }

  // Construit l'interface
  @override
  Widget build(BuildContext context) {
    // Structure de page
    return Scaffold(
      // Titre de la page
      appBar: AppBar(title: const Text('Espace multimédia')),
      // Contenu défilant
      body: SingleChildScrollView(
        // Marge intérieure
        padding: const EdgeInsets.all(16),
        // Colonne principale
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Boutons caméra et galerie
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                // Bouton caméra
                FilledButton.icon(
                  onPressed: () => _pickImage(ImageSource.camera),
                  icon: const Icon(Icons.photo_camera),
                  label: const Text('Caméra'),
                ),
                // Bouton galerie
                FilledButton.tonalIcon(
                  onPressed: () => _pickImage(ImageSource.gallery),
                  icon: const Icon(Icons.photo_library),
                  label: const Text('Galerie'),
                ),
              ],
            ),
            // Espace
            const SizedBox(height: 16),
            // Affiche l'image si elle existe
            if (_selectedImage != null)
              // Image avec coins arrondis
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                // Sur le web on utilise Image.network
                child: kIsWeb
                    ? Image.network(
                        _selectedImage!.path,
                        height: 220,
                        fit: BoxFit.cover,
                      )
                    // Sur mobile/desktop on lit le fichier
                    : Image.file(
                        File(_selectedImage!.path),
                        height: 220,
                        fit: BoxFit.cover,
                      ),
              )
            else
              // Placeholder si aucune image
              const Card(
                child: SizedBox(
                  height: 220,
                  child: Center(child: Text('Aucune image sélectionnée')),
                ),
              ),
            // Espace
            const SizedBox(height: 24),
            // Titre de la section audio
            Text('Audio', style: Theme.of(context).textTheme.titleMedium),
            // Espace
            const SizedBox(height: 8),
            // Ligne des boutons enregistrement / arrêt
            Row(
              children: [
                // Bouton enregistrer
                Expanded(
                  child: FilledButton.icon(
                    onPressed: _isRecording ? null : _startRecording,
                    icon: const Icon(Icons.mic),
                    label: const Text('Enregistrer'),
                  ),
                ),
                // Petit espace
                const SizedBox(width: 8),
                // Bouton arrêter
                Expanded(
                  child: FilledButton.tonalIcon(
                    onPressed: _isRecording ? _stopRecording : null,
                    icon: const Icon(Icons.stop),
                    label: const Text('Arrêter'),
                  ),
                ),
              ],
            ),
            // Espace
            const SizedBox(height: 8),
            // Bouton lecture / stop
            FilledButton.icon(
              onPressed: _audioPath == null ? null : _playRecording,
              icon: Icon(_isPlaying ? Icons.stop : Icons.play_arrow),
              label: Text(_isPlaying ? 'Stopper lecture' : 'Lire'),
            ),
            // Message pendant l'enregistrement
            if (_isRecording)
              const Padding(
                padding: EdgeInsets.only(top: 12),
                child: Text(
                  'Enregistrement en cours…',
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
