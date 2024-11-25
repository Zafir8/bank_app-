import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false;
  bool _isNotificationsEnabled = true;
  bool _isBiometricEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF2E5CB8), Color(0xFFFFFFFF)],
            stops: [0.0, 0.3],
          ),
        ),
        child: ListView(
          children: [
            _buildProfileSection(),
            const SizedBox(height: 20),
            _buildSettingsCard(
              'Account Settings',
              [
                _buildSettingsTile(
                  'Profile Information',
                  'Update your personal details',
                  Icons.person_outline,
                  onTap: () {},
                ),
                _buildSettingsTile(
                  'Bank Accounts',
                  'Manage linked accounts',
                  Icons.account_balance_outlined,
                  onTap: () {},
                ),
                _buildSettingsTile(
                  'Cards',
                  'Manage your cards',
                  Icons.credit_card_outlined,
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSettingsCard(
              'App Preferences',
              [
                _buildSwitchTile(
                  'Dark Mode',
                  'Change app theme',
                  Icons.dark_mode_outlined,
                  _isDarkMode,
                  (value) => setState(() => _isDarkMode = value),
                ),
                _buildSettingsTile(
                  'Language',
                  'Change app language',
                  Icons.language_outlined,
                  onTap: () {},
                ),
                _buildSettingsTile(
                  'Currency',
                  'Set preferred currency',
                  Icons.attach_money_outlined,
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSettingsCard(
              'Security',
              [
                _buildSwitchTile(
                  'Biometric Authentication',
                  'Enable fingerprint/face login',
                  Icons.fingerprint,
                  _isBiometricEnabled,
                  (value) => setState(() => _isBiometricEnabled = value),
                ),
                _buildSettingsTile(
                  'Change PIN',
                  'Update your security PIN',
                  Icons.lock_outline,
                  onTap: () {},
                ),
                _buildSettingsTile(
                  'Privacy Policy',
                  'Read our privacy policy',
                  Icons.privacy_tip_outlined,
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSettingsCard(
              'Notifications',
              [
                _buildSwitchTile(
                  'Push Notifications',
                  'Enable/disable notifications',
                  Icons.notifications_outlined,
                  _isNotificationsEnabled,
                  (value) => setState(() => _isNotificationsEnabled = value),
                ),
                _buildSettingsTile(
                  'Email Notifications',
                  'Manage email preferences',
                  Icons.email_outlined,
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildLogoutButton(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundColor: Colors.white,
            child: Icon(Icons.person, size: 50, color: Color(0xFF2E5CB8)),
          ),
          const SizedBox(height: 16),
          const Text(
            'John Doe',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'john.doe@example.com',
            style: TextStyle(
              fontSize: 16,
              color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsCard(String title, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E5CB8),
              ),
            ),
          ),
          const Divider(height: 1),
          ...children,
        ],
      ),
    );
  }

  Widget _buildSettingsTile(
    String title,
    String subtitle,
    IconData icon, {
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF2E5CB8)),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  Widget _buildSwitchTile(
    String title,
    String subtitle,
    IconData icon,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF2E5CB8)),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: const Color(0xFF2E5CB8),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Logout',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}