import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/components/profile_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? _userImageUrl;
  String? _userName;
  String? _userEmail;

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
  }

  Future<void> _loadProfileImage() async {
    final user = FirebaseAuth.instance.currentUser;

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();

    setState(() {
      _userImageUrl = doc['imageUrl'];
      _userName = doc['userName'];
      _userEmail = doc['email'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Profile',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 20),
              // GestureDetector(
              //   onTap: () {},
              //   child: CircleAvatar(
              //     radius: 60,
              //     backgroundColor: Colors.grey,
              //     foregroundImage: FileImage(_profileImageUrl),
              //     child: Image.network(_profileImageUrl!),
              //   ),
              // ),
              Container(
                width: 160,
                height: 160,
                clipBehavior: Clip.antiAlias,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: _userImageUrl != null
                    ? Image.network(
                        _userImageUrl!,
                        width: 160,
                        height: 160,
                        fit: BoxFit.cover,
                      )
                    : const CircularProgressIndicator(),
              ),
              // Container(
              //   width: 110,
              //   clipBehavior: Clip.antiAlias,
              //   decoration: const BoxDecoration(
              //     shape: BoxShape.circle,
              //   ),
              //   child: FadeInImage(
              //     placeholder: MemoryImage(kTransparentImage),
              //     image: NetworkImage(_userImageUrl!),
              //     fit: BoxFit.cover,
              //     height: 200,
              //     width: double.infinity,
              //   ),
              // ),
              const SizedBox(height: 10),
              ProfileCard(
                title: 'Name',
                text: _userName ?? 'Loading user name...',
                icon: Icons.person_outline,
                padding: const EdgeInsets.all(16),
                enableIcon: false,
              ),
              const SizedBox(height: 10),
              ProfileCard(
                title: 'Email',
                text: _userEmail ?? 'Loading user email...',
                icon: Icons.email_outlined,
                padding: const EdgeInsets.all(16),
                enableIcon: false,
              ),
              if (_userEmail == 'napem98@gmail.com') const SizedBox(height: 10),
              if (_userEmail == 'napem98@gmail.com')
                ProfileCard(
                  onPressed: () {
                    context.go('/admin_panel_screen');
                  },
                  text: 'Admin Panel',
                  icon: Icons.admin_panel_settings_outlined,
                  padding: const EdgeInsets.all(8),
                  enableIcon: true,
                ),
              const SizedBox(height: 10),
              ProfileCard(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  context.go('/');
                },
                text: 'LogOut',
                icon: Icons.logout,
                padding: const EdgeInsets.all(8),
                enableIcon: true,
              ),
              const SizedBox(height: 10),
              ProfileCard(
                onPressed: () async {
                  await FirebaseAuth.instance.currentUser!.delete();
                  context.go('/');
                },
                text: 'Delete Account',
                icon: Icons.delete_outline_outlined,
                padding: const EdgeInsets.all(8),
                enableIcon: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
