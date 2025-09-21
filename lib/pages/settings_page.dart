import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../widgets/custom_button.dart';
import '../widgets/settings_section.dart';
import '../widgets/profile_picture_modal.dart';
import 'edit_profile_page.dart';
import 'privacy_settings_page.dart';
import 'account_settings_page.dart';
import 'notifications_settings_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Settings',
          style: AppTextStyles.h2.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Section
            SettingsSection(
              title: 'Profile',
              items: [
                SettingsItem(
                  icon: Icons.person_outline,
                  title: 'Edit Profile',
                  subtitle: 'Update your personal information',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const EditProfilePage()),
                  ),
                ),
                SettingsItem(
                  icon: Icons.photo_camera_outlined,
                  title: 'Profile Picture',
                  subtitle: 'Change your profile photo',
                  onTap: () => _showProfilePictureOptions(context),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Account Section
            SettingsSection(
              title: 'Account',
              items: [
                SettingsItem(
                  icon: Icons.account_circle_outlined,
                  title: 'Account Settings',
                  subtitle: 'Manage your account preferences',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AccountSettingsPage(),
                    ),
                  ),
                ),
                SettingsItem(
                  icon: Icons.security_outlined,
                  title: 'Privacy & Security',
                  subtitle: 'Control your privacy settings',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const PrivacySettingsPage(),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Notifications Section
            SettingsSection(
              title: 'Notifications',
              items: [
                SettingsItem(
                  icon: Icons.notifications_outlined,
                  title: 'Notification Settings',
                  subtitle: 'Customize your notifications',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const NotificationsSettingsPage(),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // App Section
            SettingsSection(
              title: 'App',
              items: [
                SettingsItem(
                  icon: Icons.language_outlined,
                  title: 'Language',
                  subtitle: 'English',
                  onTap: () => _showLanguageOptions(context),
                ),
                SettingsItem(
                  icon: Icons.dark_mode_outlined,
                  title: 'Theme',
                  subtitle: 'System',
                  onTap: () => _showThemeOptions(context),
                ),
                SettingsItem(
                  icon: Icons.storage_outlined,
                  title: 'Storage',
                  subtitle: 'Clear cache and data',
                  onTap: () => _showStorageOptions(context),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Support Section
            SettingsSection(
              title: 'Support',
              items: [
                SettingsItem(
                  icon: Icons.help_outline,
                  title: 'Help & Support',
                  subtitle: 'Get help and contact support',
                  onTap: () => _showHelpOptions(context),
                ),
                SettingsItem(
                  icon: Icons.info_outline,
                  title: 'About',
                  subtitle: 'App version and information',
                  onTap: () => _showAboutDialog(context),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Logout Button
            Center(
              child: CustomButton(
                text: 'Logout',
                onPressed: () => _showLogoutDialog(context),
                backgroundColor: Colors.red,
                textColor: Colors.white,
                height: 48,
                borderradius: 24,
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showProfilePictureOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => ProfilePictureModal(
        onCameraTap: () {
          // Implement camera functionality
        },
        onGalleryTap: () {
          // Implement gallery functionality
        },
      ),
    );
  }

  void _showLanguageOptions(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Language selection coming soon!')),
    );
  }

  void _showThemeOptions(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Theme selection coming soon!')),
    );
  }

  void _showStorageOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Storage'),
        content: const Text('This will clear all cached data. Continue?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Storage cleared!')));
            },
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }

  void _showHelpOptions(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Help & Support coming soon!')),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'Recipe App',
      applicationVersion: '1.0.0',
      applicationIcon: const Icon(Icons.restaurant_menu, size: 48),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/login');
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
