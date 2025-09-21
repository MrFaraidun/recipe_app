import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../widgets/CustomTextField.dart';
import '../widgets/custom_button.dart';

class AccountSettingsPage extends StatefulWidget {
  const AccountSettingsPage({super.key});

  @override
  State<AccountSettingsPage> createState() => _AccountSettingsPageState();
}

class _AccountSettingsPageState extends State<AccountSettingsPage> {
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Account Settings',
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
            // Change Password Section
            _buildSectionTitle('Change Password'),
            _buildPasswordCard(),
            const SizedBox(height: 24),

            // Account Information
            _buildSectionTitle('Account Information'),
            _buildAccountInfoCard(),
            const SizedBox(height: 24),

            // Account Actions
            _buildSectionTitle('Account Actions'),
            _buildAccountActionsCard(),
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

  Widget _buildPasswordCard() {
    return Container(
      padding: const EdgeInsets.all(20),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Update Password',
            style: AppTextStyles.h3.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 20),

          CustomTextField(
            label: 'Current Password',
            controller: _currentPasswordController,
            icon: Icons.lock_outline,
            obscureText: _obscureCurrentPassword,
            suffixIcon: GestureDetector(
              onTap: () => setState(
                () => _obscureCurrentPassword = !_obscureCurrentPassword,
              ),
              child: Icon(
                _obscureCurrentPassword
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: AppColors.textSecondary,
              ),
            ),
            borderColor: AppColors.border,
            focusedBorderColor: AppColors.primary,
            borderradius: 12,
          ),
          const SizedBox(height: 16),

          CustomTextField(
            label: 'New Password',
            controller: _newPasswordController,
            icon: Icons.lock_outline,
            obscureText: _obscureNewPassword,
            suffixIcon: GestureDetector(
              onTap: () =>
                  setState(() => _obscureNewPassword = !_obscureNewPassword),
              child: Icon(
                _obscureNewPassword ? Icons.visibility_off : Icons.visibility,
                color: AppColors.textSecondary,
              ),
            ),
            borderColor: AppColors.border,
            focusedBorderColor: AppColors.primary,
            borderradius: 12,
          ),
          const SizedBox(height: 16),

          CustomTextField(
            label: 'Confirm New Password',
            controller: _confirmPasswordController,
            icon: Icons.lock_outline,
            obscureText: _obscureConfirmPassword,
            suffixIcon: GestureDetector(
              onTap: () => setState(
                () => _obscureConfirmPassword = !_obscureConfirmPassword,
              ),
              child: Icon(
                _obscureConfirmPassword
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: AppColors.textSecondary,
              ),
            ),
            borderColor: AppColors.border,
            focusedBorderColor: AppColors.primary,
            borderradius: 12,
          ),
          const SizedBox(height: 20),

          CustomButton(
            text: 'Update Password',
            onPressed: _updatePassword,
            backgroundColor: AppColors.primary,
            textColor: Colors.white,
            height: 48,
            borderradius: 24,
          ),
        ],
      ),
    );
  }

  Widget _buildAccountInfoCard() {
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
      child: Column(
        children: [
          _buildInfoItem(
            icon: Icons.email_outlined,
            title: 'Email',
            value: 'choirul@example.com',
            onTap: () => _changeEmail(),
          ),
          _buildDivider(),
          _buildInfoItem(
            icon: Icons.phone_outlined,
            title: 'Phone',
            value: '+1 234 567 8900',
            onTap: () => _changePhone(),
          ),
          _buildDivider(),
          _buildInfoItem(
            icon: Icons.calendar_today_outlined,
            title: 'Member Since',
            value: 'January 2024',
            onTap: null,
          ),
        ],
      ),
    );
  }

  Widget _buildAccountActionsCard() {
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
      child: Column(
        children: [
          _buildActionItem(
            icon: Icons.download_outlined,
            title: 'Download Data',
            subtitle: 'Get a copy of your data',
            onTap: () => _downloadData(),
          ),
          _buildDivider(),
          _buildActionItem(
            icon: Icons.logout_outlined,
            title: 'Sign Out',
            subtitle: 'Sign out of your account',
            onTap: () => _signOut(),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String title,
    required String value,
    VoidCallback? onTap,
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
                    value,
                    style: AppTextStyles.bodySecondary.copyWith(fontSize: 12),
                  ),
                ],
              ),
            ),
            if (onTap != null)
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

  Widget _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 1,
      color: AppColors.border,
    );
  }

  void _updatePassword() {
    if (_newPasswordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Passwords do not match!')));
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Password updated successfully!')),
    );
  }

  void _changeEmail() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Change email feature coming soon!')),
    );
  }

  void _changePhone() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Change phone feature coming soon!')),
    );
  }

  void _downloadData() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Data download feature coming soon!')),
    );
  }

  void _signOut() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
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
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }
}
