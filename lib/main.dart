import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const AnimeDXAdminApp());
}

class AnimeDXAdminApp extends StatelessWidget {
  const AnimeDXAdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Anime DX Manager',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0D0D12),
        primaryColor: const Color(0xFFFF640A),
      ),
      home: const AdminHomeScreen(),
    );
  }
}

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  final _titleController = TextEditingController();
  final _episodesController = TextEditingController();
  final _streamUrlController = TextEditingController();
  String? _selectedImagePath;

  final List<Map<String, String>> _uploadedList = [];

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      setState(() {
        _selectedImagePath = file.path;
      });
    }
  }

  Widget _build3DCard(String title, String value, IconData icon, List<Color> colors) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: colors, begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: colors.last.withOpacity(0.4),
            offset: const Offset(4, 8),
            blurRadius: 14,
          ),
          const BoxShadow(
            color: Color(0x33FFFFFF),
            offset: Offset(-1, -1),
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, size: 30, color: Colors.white),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
              Text(title, style: const TextStyle(fontSize: 12, color: Colors.white70)),
            ],
          ),
        ],
      ),
    );
  }

  void _publishAnime() {
    if (_titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please provide an Anime Title!'), backgroundColor: Colors.red),
      );
      return;
    }

    setState(() {
      _uploadedList.insert(0, {
        'title': _titleController.text,
        'episodes': _episodesController.text.isEmpty ? '12' : _episodesController.text,
        'image': _selectedImagePath ?? '',
        'stream': _streamUrlController.text,
      });
    });

    _titleController.clear();
    _episodesController.clear();
    _streamUrlController.clear();
    setState(() {
      _selectedImagePath = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Anime Published Successfully! 🚀'), backgroundColor: Colors.green),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Row(
          children: [
            Icon(Icons.admin_panel_settings, color: Color(0xFFFF640A)),
            SizedBox(width: 8),
            Text('ANIME DX COMMAND HUB', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 3D Analytics Cards
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              childAspectRatio: 1.2,
              children: [
                _build3DCard('Managed Shows', '${_uploadedList.length + 4}', Icons.movie_creation, [const Color(0xFFFF640A), const Color(0xFFD83A00)]),
                _build3DCard('Active Server', 'Port 8080', Icons.dns, [const Color(0xFF00B4DB), const Color(0xFF0083B0)]),
                _build3DCard('Cloud Link', 'Connected', Icons.cloud_done, [const Color(0xFF11998E), const Color(0xFF38EF7D)]),
                _build3DCard('Bandwidth', '1.2 GB/s', Icons.speed, [const Color(0xFF8A2387), const Color(0xFFE94057)]),
              ],
            ),
            const SizedBox(height: 24),

            const Text('Upload New Series', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),

            // 3D Glass Form Box
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFF16161F),
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(color: Colors.black87, offset: Offset(0, 10), blurRadius: 20),
                  BoxShadow(color: Color(0x1AFFFFFF), offset: Offset(-1, -1), blurRadius: 4),
                ],
              ),
              child: Column(
                children: [
                  TextField(
                    controller: _titleController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'Anime Name',
                      labelStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.subtitles, color: Color(0xFFFF640A)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _episodesController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'Total Episodes',
                      labelStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.format_list_numbered, color: Color(0xFFFF640A)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _streamUrlController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'Video Stream URL (MP4 / Local Server Link)',
                      labelStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.link, color: Color(0xFFFF640A)),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Gallery Pick 3D Frame
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      height: 130,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFFF640A).withOpacity(0.5)),
                      ),
                      child: _selectedImagePath != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(File(_selectedImagePath!), fit: BoxFit.cover),
                            )
                          : const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add_photo_alternate, size: 40, color: Color(0xFFFF640A)),
                                SizedBox(height: 6),
                                Text('Choose Poster from Device Gallery', style: TextStyle(color: Colors.white70, fontSize: 12)),
                              ],
                            ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // 3D Push Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF640A),
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 8,
                      shadowColor: const Color(0xFFFF640A).withOpacity(0.6),
                    ),
                    onPressed: _publishAnime,
                    child: const Text('UPLOAD & SYNC', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

