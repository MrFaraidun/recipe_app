import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class PrivacySettingsPage extends StatefulWidget {
  const PrivacySettingsPage({super.key});

  @override
  State<PrivacySettingsPage> createState() => _PrivacySettingsPageState();
}

class _PrivacySettingsPageState extends State<PrivacySettingsPage> {
  bool _profilePublic = true;
  bool _showEmail = false;
  bool _showFollowers = true;
  bool _allowMessages = true;
  bool _showActivity = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Privacy & Security',
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
            // Profile Visibility
            _buildSectionTitle('Profile Visibility'),
            _buildSettingsCard([
              _buildSwitchItem(
                title: 'Public Profile',
                subtitle: 'Make your profile visible to everyone',
                value: _profilePublic,
                onChanged: (value) => setState(() => _profilePublic = value),
              ),
              _buildSwitchItem(
                title: 'Show Email',
                subtitle: 'Display your email on your profile',
                value: _showEmail,
                onChanged: (value) => setState(() => _showEmail = value),
              ),
              _buildSwitchItem(
                title: 'Show Followers',
                subtitle: 'Display your follower count',
                value: _showFollowers,
                onChanged: (value) => setState(() => _showFollowers = value),
              ),
            ]),

            const SizedBox(height: 24),

            // Messages
            _buildSectionTitle('Messages'),
            _buildSettingsCard([
              _buildSwitchItem(
                title: 'Allow Messages',
                subtitle: 'Let other users send you messages',
                value: _allowMessages,
                onChanged: (value) => setState(() => _allowMessages = value),
              ),
            ]),

            const SizedBox(height: 24),

            // Activity
            _buildSectionTitle('Activity'),
            _buildSettingsCard([
              _buildSwitchItem(
                title: 'Show Activity',
                subtitle: 'Display your recent activity to followers',
                value: _showActivity,
                onChanged: (value) => setState(() => _showActivity = value),
              ),
            ]),

            const SizedBox(height: 24),

            // Security
            _buildSectionTitle('Security'),
            _buildSettingsCard([
              _buildActionItem(
                icon: Icons.lock_outline,
                title: 'Change Password',
                subtitle: 'Update your password',
                onTap: () => _changePassword(),
              ),
              _buildActionItem(
                icon: Icons.security_outlined,
                title: 'Two-Factor Authentication',
                subtitle: 'Add extra security to your account',
                onTap: () => _setupTwoFactor(),
              ),
              _buildActionItem(
                icon: Icons.block_outlined,
                title: 'Blocked Users',
                subtitle: 'Manage blocked users',
                onTap: () => _manageBlockedUsers(),
              ),
            ]),

            const SizedBox(height: 24),

            // Data & Privacy
            _buildSectionTitle('Data & Privacy'),
            _buildSettingsCard([
              _buildActionItem(
                icon: Icons.download_outlined,
                title: 'Download Data',
                subtitle: 'Get a copy of your data',
                onTap: () => _downloadData(),
              ),
              _buildActionItem(
                icon: Icons.delete_outline,
                title: 'Delete Account',
                subtitle: 'Permanently delete your account',
                onTap: () => _deleteAccount(),
                isDestructive: true,
              ),
            ]),

            const SizedBox(height: 32),
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
    bool isDestructive = false,
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
                color: isDestructive
                    ? Colors.red.withOpacity(0.1)
                    : AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: isDestructive ? Colors.red : AppColors.primary,
                size: 20,
              ),
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
                      color: isDestructive ? Colors.red : AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: AppTextStyles.bodySecondary.copyWith(
                      fontSize: 12,
                      color: isDestructive ? Colors.red.withOpacity(0.7) : null,
                    ),
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

  void _changePassword() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Change password feature coming soon!')),
    );
  }

  void _setupTwoFactor() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Two-factor authentication coming soon!')),
    );
  }

  void _manageBlockedUsers() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Blocked users management coming soon!')),
    );
  }

  void _downloadData() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Data download feature coming soon!')),
    );
  }

  void _deleteAccount() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Account'),
        content: const Text(
          'Are you sure you want to delete your account? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Implement account deletion
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Account deletion feature coming soon!'),
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
