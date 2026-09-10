import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../widgets/custom_button.dart';
import '../widgets/young_vip_wordmark.dart';
import 'interests_view.dart';

class ProfileSetupView extends StatefulWidget {
  final String? initialName;
  final String? initialEmail;

  const ProfileSetupView({
    super.key,
    this.initialName,
    this.initialEmail,
  });

  @override
  State<ProfileSetupView> createState() => _ProfileSetupViewState();
}

class _ProfileSetupViewState extends State<ProfileSetupView> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _roleController;
  late final TextEditingController _orgController;

  int _selectedDomainIndex = 0;
  int _selectedExperienceIndex = 1; // 0: Foundational, 1: Practitioner, 2: Architect

  final List<String> _domains = const [
    'AI Agents & Reasoning',
    'RAG & Knowledge Pipelines',
    'Autonomous Automation',
    'Security & Model Sandboxes',
  ];

  final List<String> _experienceLevels = const [
    'Foundational (0-1 yrs)',
    'Practitioner (1-3 yrs)',
    'Architect (3+ yrs)',
  ];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName ?? 'Alex Vance');
    _roleController = TextEditingController(text: 'Senior Legal Tech Counsel');
    _orgController = TextEditingController(text: 'Vance & Partners Global');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _roleController.dispose();
    _orgController.dispose();
    super.dispose();
  }

  void _handleContinue() {
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const InterestsView()),
      );
    }
  }

  void _handleSkip() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const InterestsView()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double horizontalPadding =
        screenWidth > 600 ? 28.0 : screenWidth * 0.055;

    return Scaffold(
      backgroundColor: AppColors.peachBackground,
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 540.0),
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: 14.0,
              ),
              child: SizedBox(
                width: double.infinity,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTopBar(context),
                      const SizedBox(height: 20.0),
                      _buildHeader(),
                      const SizedBox(height: 22.0),
                      _buildAvatarCard(),
                      const SizedBox(height: 20.0),
                      _buildSectionHeader('Personal Identity'),
                      const SizedBox(height: 12.0),
                      _buildFormFields(),
                      const SizedBox(height: 20.0),
                      _buildSectionHeader('Primary AI Track'),
                      const SizedBox(height: 12.0),
                      _buildDomainSelector(),
                      const SizedBox(height: 20.0),
                      _buildSectionHeader('Experience Level'),
                      const SizedBox(height: 12.0),
                      _buildExperienceSelector(),
                      const SizedBox(height: 26.0),
                      CustomButton(
                        label: 'Continue to Topic Interests ➔',
                        onPressed: _handleContinue,
                      ),
                      const SizedBox(height: 14.0),
                      Center(
                        child: TextButton(
                          onPressed: _handleSkip,
                          child: const Text(
                            'Skip this step for now',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 13.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32.0),
                    ],
                  ),
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
            const SizedBox(width: 10.0),
            const Flexible(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: YoungVipWordmark(),
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: _handleSkip,
          behavior: HitTestBehavior.opaque,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 7.0),
            decoration: BoxDecoration(
              color: AppColors.pureWhite,
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: AppColors.buttonShadow,
            ),
            child: const Text(
              'Skip',
              style: TextStyle(
                color: AppColors.deepInk,
                fontSize: 12.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: AppColors.pastelLilac,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: const Text(
            'ONBOARDING · STEP 3 OF 5',
            style: TextStyle(
              color: AppColors.deepInk,
              fontSize: 10.0,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.8,
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        const Text(
          'Profile Setup',
          style: TextStyle(
            color: AppColors.deepInk,
            fontSize: 26.0,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 6.0),
        const Text(
          'Personalize your builder credential card and lab difficulty to match your role.',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 13.0,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildAvatarCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(22.0),
        boxShadow: AppColors.softShadow,
      ),
      child: Row(
        children: [
          Container(
            width: 58.0,
            height: 58.0,
            decoration: BoxDecoration(
              color: AppColors.avatarBg,
              borderRadius: BorderRadius.circular(18.0),
            ),
            alignment: Alignment.center,
            child: const Text(
              'AV',
              style: TextStyle(
                color: AppColors.avatarText,
                fontSize: 19.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Builder Identity Card',
                  style: TextStyle(
                    color: AppColors.deepInk,
                    fontSize: 14.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 3.0),
                Text(
                  'Your verified credentials will display on completed labs & peer rooms.',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 11.5,
                    height: 1.35,
                  ),
                ),
              ],
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
        fontSize: 15.0,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.2,
      ),
    );
  }

  Widget _buildFormFields() {
    return Container(
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(22.0),
        boxShadow: AppColors.softShadow,
      ),
      child: Column(
        children: [
          _buildInput(
            controller: _nameController,
            label: 'Full Name',
            icon: Icons.person_outline_rounded,
            validator: (v) => (v == null || v.trim().isEmpty) ? 'Please enter your name' : null,
          ),
          const SizedBox(height: 14.0),
          _buildInput(
            controller: _roleController,
            label: 'Current Role / Specialization',
            icon: Icons.badge_outlined,
            validator: (v) => (v == null || v.trim().isEmpty) ? 'Please enter your role' : null,
          ),
          const SizedBox(height: 14.0),
          _buildInput(
            controller: _orgController,
            label: 'Organization / Firm (Optional)',
            icon: Icons.business_outlined,
          ),
        ],
      ),
    );
  }

  Widget _buildInput({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      style: const TextStyle(
        color: AppColors.deepInk,
        fontSize: 13.5,
        fontWeight: FontWeight.w600,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          color: AppColors.textSecondary,
          fontSize: 12.5,
        ),
        prefixIcon: Icon(icon, color: AppColors.deepInk, size: 18.0),
        filled: true,
        fillColor: AppColors.peachBackground.withValues(alpha: 0.35),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.0),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
      ),
    );
  }

  Widget _buildDomainSelector() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(22.0),
        boxShadow: AppColors.softShadow,
      ),
      child: Column(
        children: List.generate(_domains.length, (index) {
          final isSelected = _selectedDomainIndex == index;
          return Padding(
            padding: EdgeInsets.only(bottom: index == _domains.length - 1 ? 0 : 8.0),
            child: GestureDetector(
              onTap: () => setState(() => _selectedDomainIndex = index),
              behavior: HitTestBehavior.opaque,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.pastelPeach.withValues(alpha: 0.6)
                      : AppColors.peachBackground.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(14.0),
                  border: Border.all(
                    color: isSelected ? AppColors.youngVipGold : Colors.transparent,
                    width: 1.2,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      isSelected ? Icons.radio_button_checked_rounded : Icons.radio_button_off_rounded,
                      color: isSelected ? AppColors.deepInk : AppColors.textSecondary,
                      size: 18.0,
                    ),
                    const SizedBox(width: 12.0),
                    Expanded(
                      child: Text(
                        _domains[index],
                        style: TextStyle(
                          color: AppColors.deepInk,
                          fontSize: 13.0,
                          fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildExperienceSelector() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(22.0),
        boxShadow: AppColors.softShadow,
      ),
      child: Column(
        children: List.generate(_experienceLevels.length, (index) {
          final isSelected = _selectedExperienceIndex == index;
          return Padding(
            padding: EdgeInsets.only(bottom: index == _experienceLevels.length - 1 ? 0 : 8.0),
            child: GestureDetector(
              onTap: () => setState(() => _selectedExperienceIndex = index),
              behavior: HitTestBehavior.opaque,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.pastelLilac.withValues(alpha: 0.6)
                      : AppColors.peachBackground.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(14.0),
                  border: Border.all(
                    color: isSelected ? AppColors.royalIndigo : Colors.transparent,
                    width: 1.2,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      isSelected ? Icons.check_circle_rounded : Icons.circle_outlined,
                      color: isSelected ? AppColors.royalIndigo : AppColors.textSecondary,
                      size: 18.0,
                    ),
                    const SizedBox(width: 12.0),
                    Expanded(
                      child: Text(
                        _experienceLevels[index],
                        style: TextStyle(
                          color: AppColors.deepInk,
                          fontSize: 13.0,
                          fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
