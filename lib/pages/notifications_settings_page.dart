import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class NotificationsSettingsPage extends StatefulWidget {
  const NotificationsSettingsPage({super.key});

  @override
  State<NotificationsSettingsPage> createState() => _NotificationsSettingsPageState();
}

class _NotificationsSettingsPageState extends State<NotificationsSettingsPage> {
  bool _pushNotifications = true;
  bool _emailNotifications = false;
  bool _recipeLikes = true;
  bool _newFollowers = true;
  bool _comments = true;
  bool _recipeShares = false;
  bool _weeklyDigest = true;
  bool _marketingEmails = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Notification Settings',
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
            // General Notifications
            _buildSectionTitle('General Notifications'),
            _buildSettingsCard([
              _buildSwitchItem(
                title: 'Push Notifications',
                subtitle: 'Receive notifications on your device',
                value: _pushNotifications,
                onChanged: (value) => setState(() => _pushNotifications = value),
              ),
              _buildSwitchItem(
                title: 'Email Notifications',
                subtitle: 'Receive notifications via email',
                value: _emailNotifications,
                onChanged: (value) => setState(() => _emailNotifications = value),
              ),
            ]),

            const SizedBox(height: 24),

            // Social Notifications
            _buildSectionTitle('Social Notifications'),
            _buildSettingsCard([
              _buildSwitchItem(
                title: 'Recipe Likes',
                subtitle: 'When someone likes your recipe',
                value: _recipeLikes,
                onChanged: (value) => setState(() => _recipeLikes = value),
              ),
              _buildSwitchItem(
                title: 'New Followers',
                subtitle: 'When someone follows you',
                value: _newFollowers,
                onChanged: (value) => setState(() => _newFollowers = value),
              ),
              _buildSwitchItem(
                title: 'Comments',
                subtitle: 'When someone comments on your recipe',
                value: _comments,
                onChanged: (value) => setState(() => _comments = value),
              ),
              _buildSwitchItem(
                title: 'Recipe Shares',
                subtitle: 'When someone shares your recipe',
                value: _recipeShares,
                onChanged: (value) => setState(() => _recipeShares = value),
              ),
            ]),

            const SizedBox(height: 24),

            // Email Preferences
            _buildSectionTitle('Email Preferences'),
            _buildSettingsCard([
              _buildSwitchItem(
                title: 'Weekly Digest',
                subtitle: 'Get a weekly summary of your activity',
                value: _weeklyDigest,
                onChanged: (value) => setState(() => _weeklyDigest = value),
              ),
              _buildSwitchItem(
                title: 'Marketing Emails',
                subtitle: 'Receive promotional content and updates',
                value: _marketingEmails,
                onChanged: (value) => setState(() => _marketingEmails = value),
              ),
            ]),

            const SizedBox(height: 24),

            // Notification Schedule
            _buildSectionTitle('Notification Schedule'),
            _buildSettingsCard([
              _buildActionItem(
                icon: Icons.schedule_outlined,
                title: 'Quiet Hours',
                subtitle: 'Set when you don\'t want to be disturbed',
                onTap: () => _setQuietHours(),
              ),
              _buildActionItem(
                icon: Icons.timer_outlined,
                title: 'Notification Frequency',
                subtitle: 'How often you receive notifications',
                onTap: () => _setNotificationFrequency(),
              ),
            ]),

            const SizedBox(height: 32),

            // Reset Button
            Center(
              child: TextButton(
                onPressed: _resetToDefaults,
                child: Text(
                  'Reset to Default Settings',
                  style: AppTextStyles.body.copyWith(
                    color: AppColors.textSecondary,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(
        title,
        style: AppTextStyles.h3.copyWith(
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildSettingsCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildSwitchItem({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.body.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: AppTextStyles.bodySecondary.copyWith(fontSize: 12),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildActionItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: AppColors.primary, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.body.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: AppTextStyles.bodySecondary.copyWith(fontSize: 12),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: AppColors.textSecondary,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  void _setQuietHours() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Set Quiet Hours'),
        content: const Text('Quiet hours feature coming soon!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _setNotificationFrequency() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Notification Frequency'),
        content: const Text('Notification frequency settings coming soon!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _resetToDefaults() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset Settings'),
        content: const Text('Reset all notification settings to default?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _pushNotifications = true;
                _emailNotifications = false;
                _recipeLikes = true;
                _newFollowers = true;
                _comments = true;
                _recipeShares = false;
                _weeklyDigest = true;
                _marketingEmails = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Settings reset to defaults!')),
              );
            },
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }
}
