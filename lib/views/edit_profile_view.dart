import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/young_vip_wordmark.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  late final TextEditingController _nameController;
  late final TextEditingController _titleController;
  late final TextEditingController _emailController;
  late final TextEditingController _locationController;
  late final TextEditingController _bioController;
  int _selectedDomainIndex = 0; // 0 = AI Agents, 1 = RAG, 2 = Security, 3 = Automation

  final List<String> _domains = [
    'AI Agents & Reasoning',
    'RAG & Knowledge Retrieval',
    'Security & Sandboxes',
    'Autonomous Automation',
  ];

  bool _peerRoomInvites = true;
  bool _sprintDigest = true;
  bool _publicFluencyBadge = true;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: 'Alex Vance');
    _titleController = TextEditingController(text: 'Senior Legal Tech Counsel');
    _emailController = TextEditingController(text: 'alex.vance@youngvip.io');
    _locationController = TextEditingController(text: 'San Francisco, CA');
    _bioController = TextEditingController(
      text: 'Building verifiable agent architectures and automated legal workflows.',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _titleController.dispose();
    _emailController.dispose();
    _locationController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profile changes saved successfully!'),
        backgroundColor: AppColors.softGreen,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double horizontalPadding =
        screenWidth > 600 ? 24.0 : screenWidth * 0.055;

    return Scaffold(
      backgroundColor: AppColors.peachBackground,
      drawer: const CustomDrawer(),
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 540.0),
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: 12.0,
              ),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTopBar(context),
                    const SizedBox(height: 20.0),
                    _buildHeading(),
                    const SizedBox(height: 22.0),
                    _buildAvatarCard(),
                    const SizedBox(height: 20.0),
                    _buildSectionHeader('Personal Information'),
                    const SizedBox(height: 12.0),
                    _buildPersonalInfoCard(),
                    const SizedBox(height: 20.0),
                    _buildSectionHeader('Builder Track & Domain'),
                    const SizedBox(height: 12.0),
                    _buildSpecializationCard(),
                    const SizedBox(height: 20.0),
                    _buildSectionHeader('Preferences & Security'),
                    const SizedBox(height: 12.0),
                    _buildPreferencesCard(),
                    const SizedBox(height: 24.0),
                    _buildSaveButton(context),
                    const SizedBox(height: 88.0),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () => Navigator.maybePop(context),
              behavior: HitTestBehavior.opaque,
              child: Container(
                width: 38.0,
                height: 38.0,
                decoration: BoxDecoration(
                  color: AppColors.pureWhite,
                  borderRadius: BorderRadius.circular(14.0),
                  boxShadow: AppColors.buttonShadow,
                ),
                child: const Icon(
                  Icons.arrow_back_rounded,
                  color: AppColors.deepInk,
                  size: 18.0,
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            Builder(
              builder: (ctx) => GestureDetector(
                onTap: () => Scaffold.of(ctx).openDrawer(),
                behavior: HitTestBehavior.opaque,
                child: Container(
                  width: 38.0,
                  height: 38.0,
                  decoration: BoxDecoration(
                    color: AppColors.pureWhite,
                    borderRadius: BorderRadius.circular(14.0),
                    boxShadow: AppColors.buttonShadow,
                  ),
                  child: const Icon(
                    Icons.menu_rounded,
                    color: AppColors.deepInk,
                    size: 18.0,
                  ),
                ),
              ),
            ),
          ],
        ),
        const YoungVipWordmark(),
        GestureDetector(
          onTap: _saveProfile,
          behavior: HitTestBehavior.opaque,
          child: Container(
            width: 40.0,
            height: 40.0,
            decoration: BoxDecoration(
              color: AppColors.pureWhite,
              borderRadius: BorderRadius.circular(14.0),
              boxShadow: AppColors.buttonShadow,
            ),
            child: const Icon(
              Icons.check_rounded,
              color: AppColors.deepInk,
              size: 22.0,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeading() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Edit Profile',
          style: TextStyle(
            color: AppColors.deepInk,
            fontSize: 30.0,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Customize your builder identity, tracks & preferences',
          style: TextStyle(
            color: Color(0xFF8E8D88),
            fontSize: 13.5,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildAvatarCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 22.0),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(26.0),
        boxShadow: AppColors.softShadow,
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                width: 86.0,
                height: 86.0,
                decoration: BoxDecoration(
                  color: AppColors.pastelLilac,
                  borderRadius: BorderRadius.circular(28.0),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'AV',
                  style: TextStyle(
                    color: AppColors.deepInk,
                    fontSize: 28.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: AppColors.deepInk,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      content: const Text(
                        'Photo upload option triggered',
                        style: TextStyle(color: AppColors.pureWhite),
                      ),
                    ),
                  );
                },
                child: Container(
                  width: 32.0,
                  height: 32.0,
                  decoration: BoxDecoration(
                    color: AppColors.pastelPeach,
                    shape: BoxShape.circle,
                    boxShadow: AppColors.buttonShadow,
                    border: Border.all(color: AppColors.pureWhite, width: 2.0),
                  ),
                  child: const Icon(
                    Icons.camera_alt_outlined,
                    color: AppColors.deepInk,
                    size: 16.0,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14.0),
          const Text(
            'Alex Verma',
            style: TextStyle(
              color: AppColors.deepInk,
              fontSize: 18.0,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4.0),
          const Text(
            'Builder ID: •••• ••• 003',
            style: TextStyle(
              color: Color(0xFF8E8D88),
              fontSize: 12.0,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 10.0),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.5),
            decoration: BoxDecoration(
              color: AppColors.pastelPeach.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: const Text(
              'Fluency: Builder · Level 14',
              style: TextStyle(
                color: AppColors.deepInk,
                fontSize: 11.5,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: AppColors.deepInk,
        fontSize: 14.5,
        fontWeight: FontWeight.w800,
      ),
    );
  }

  Widget _buildPersonalInfoCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: AppColors.softShadow,
      ),
      child: Column(
        children: [
          _buildInputField(
            label: 'FULL NAME',
            controller: _nameController,
            icon: Icons.person_outline_rounded,
          ),
          const SizedBox(height: 16.0),
          _buildInputField(
            label: 'PROFESSIONAL TITLE',
            controller: _titleController,
            icon: Icons.badge_outlined,
          ),
          const SizedBox(height: 16.0),
          _buildInputField(
            label: 'EMAIL ADDRESS',
            controller: _emailController,
            icon: Icons.mail_outline_rounded,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16.0),
          _buildInputField(
            label: 'LOCATION / ORGANIZATION',
            controller: _locationController,
            icon: Icons.location_on_outlined,
          ),
        ],
      ),
    );
  }

  Widget _buildSpecializationCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: AppColors.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'PRIMARY DOMAIN',
            style: TextStyle(
              color: Color(0xFF7A7972),
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 12.0),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: List.generate(_domains.length, (index) {
              final isSelected = _selectedDomainIndex == index;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedDomainIndex = index;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.pastelPeach
                        : AppColors.peachBackground.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(
                      color: isSelected ? AppColors.deepInk : Colors.transparent,
                      width: 1.2,
                    ),
                  ),
                  child: Text(
                    _domains[index],
                    style: TextStyle(
                      color: AppColors.deepInk,
                      fontSize: 12.5,
                      fontWeight:
                          isSelected ? FontWeight.w800 : FontWeight.w600,
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 18.0),
          _buildInputField(
            label: 'BIO & LEARNING OBJECTIVES',
            controller: _bioController,
            icon: Icons.edit_note_rounded,
            maxLines: 3,
          ),
        ],
      ),
    );
  }

  Widget _buildPreferencesCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: AppColors.softShadow,
      ),
      child: Column(
        children: [
          _buildSwitchItem(
            title: 'Peer Room Invites',
            subtitle: 'Receive live sprint collaboration requests',
            value: _peerRoomInvites,
            onChanged: (val) => setState(() => _peerRoomInvites = val),
          ),
          const Divider(color: Color(0x1AD59D88), height: 16.0),
          _buildSwitchItem(
            title: 'Weekly Sprint Digest',
            subtitle: 'Summary of completed labs & fluency gains',
            value: _sprintDigest,
            onChanged: (val) => setState(() => _sprintDigest = val),
          ),
          const Divider(color: Color(0x1AD59D88), height: 16.0),
          _buildSwitchItem(
            title: 'Public Fluency Badge',
            subtitle: 'Showcase verified credentials to community',
            value: _publicFluencyBadge,
            onChanged: (val) => setState(() => _publicFluencyBadge = val),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF7A7972),
            fontSize: 11.0,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.1,
          ),
        ),
        const SizedBox(height: 6.0),
        Container(
          decoration: BoxDecoration(
            color: AppColors.peachBackground.withValues(alpha: 0.45),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            maxLines: maxLines,
            style: const TextStyle(
              color: AppColors.deepInk,
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
            ),
            decoration: InputDecoration(
              prefixIcon: Icon(icon, color: AppColors.deepInk, size: 20.0),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12.0,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSwitchItem({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.deepInk,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2.0),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Color(0xFF8E8D88),
                  fontSize: 11.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        Switch.adaptive(
          value: value,
          onChanged: onChanged,
          thumbColor: const WidgetStatePropertyAll(AppColors.deepInk),
          activeTrackColor: AppColors.pastelPeach,
        ),
      ],
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return GestureDetector(
      onTap: _saveProfile,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        decoration: BoxDecoration(
          color: AppColors.pureWhite,
          borderRadius: BorderRadius.circular(28.0),
          boxShadow: AppColors.softShadow,
        ),
        alignment: Alignment.center,
        child: const Text(
          'SAVE CHANGES',
          style: TextStyle(
            color: AppColors.deepInk,
            fontSize: 15.0,
            fontWeight: FontWeight.w800,
            letterSpacing: 2.0,
          ),
        ),
      ),
    );
  }
}
