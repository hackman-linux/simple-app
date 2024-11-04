import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfilePage extends StatefulWidget {
  final String email;

  const ProfilePage({super.key, required this.email});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _image;
  final _bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Settings logic here
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                _showImageDialog();
              },
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _image != null
                    ? Image.file(_image!).image
                    : const NetworkImage('https://via.placeholder.com/150'),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Welcome, ${widget.email}',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Text('Email: ${widget.email}'),
            const SizedBox(height: 20),
            TextField(
              controller: _bioController,
              decoration: const InputDecoration(
                labelText: 'Bio',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Save bio logic here
                print('Bio: ${_bioController.text}');
              },
              child: const Text('Save Bio'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Logout logic here
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }

  void _showImageDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Image'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  _getImageFromCamera();
                },
                child: const Text('Take a photo'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  _getImageFromGallery();
                },
                child: const Text('Choose from gallery'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _getImageFromCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      if (image != null) {
  _image = File(image.path);
      } else {
        _image = null;
      }
    });
    Navigator.pop(context);
  }

  void _getImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        _image = null;
      }
    });
    Navigator.pop(context);
  }
}