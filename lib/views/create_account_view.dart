import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/young_vip_wordmark.dart';
import 'main_navigation_view.dart';
import 'verify_email_view.dart';

class CreateAccountView extends StatefulWidget {
  const CreateAccountView({super.key});

  @override
  State<CreateAccountView> createState() => _CreateAccountViewState();
}

class _CreateAccountViewState extends State<CreateAccountView> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController =
      TextEditingController(text: 'Alex Vance');
  final TextEditingController _emailController =
      TextEditingController(text: 'alex.vance@enterprise.io');
  final TextEditingController _passwordController =
      TextEditingController(text: 'Builder2026!');
  final TextEditingController _confirmPasswordController =
      TextEditingController(text: 'Builder2026!');

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _agreeToTerms = true;

  int _selectedRoleIndex = 0;
  final List<String> _roles = [
    'Legal Tech Architect',
    'AI Engineer / Builder',
    'Enterprise Leader',
    'Researcher / Student',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      if (!_agreeToTerms) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.deepInk,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.0),
            ),
            content: const Text(
              'Please accept the Terms of Service to continue.',
              style: TextStyle(color: AppColors.pureWhite),
            ),
          ),
        );
        return;
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => VerifyEmailView(
            email: _emailController.text.trim(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double horizontalPadding =
        screenWidth > 600 ? 28.0 : screenWidth * 0.055;

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
                      _buildHeading(),
                      const SizedBox(height: 18.0),
                      _buildFreeAccessBanner(),
                      const SizedBox(height: 22.0),
                      _buildFormCard(),
                      const SizedBox(height: 20.0),
                      _buildRoleSelectorCard(),
                      const SizedBox(height: 20.0),
                      _buildTermsAndSSO(),
                      const SizedBox(height: 24.0),
                      _buildSubmitButton(context),
                      const SizedBox(height: 18.0),
                      _buildSignInLink(context),
                      const SizedBox(height: 48.0),
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
            if (Navigator.canPop(context)) ...[
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
            ],
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
        const SizedBox(width: 40.0), // Balance spacing
      ],
    );
  }

  Widget _buildHeading() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Create Free Account',
          style: TextStyle(
            color: AppColors.deepInk,
            fontSize: 30.0,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.6,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'Join Young VIP and access live experiential AI sandboxes',
          style: TextStyle(
            color: Color(0xFF7A7972),
            fontSize: 13.5,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildFreeAccessBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 14.0),
      decoration: BoxDecoration(
        color: AppColors.pastelLilac.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: AppColors.pastelLilac.withValues(alpha: 0.7),
          width: 1.2,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 38.0,
            height: 38.0,
            decoration: BoxDecoration(
              color: AppColors.pureWhite,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: const Icon(
              Icons.bolt_rounded,
              color: AppColors.deepInk,
              size: 22.0,
            ),
          ),
          const SizedBox(width: 14.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'FREE MEMBER TIER INCLUDED',
                  style: TextStyle(
                    color: AppColors.deepInk,
                    fontSize: 11.5,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.8,
                  ),
                ),
                SizedBox(height: 2.0),
                Text(
                  'Instant access to interactive labs, peer rooms & tracks',
                  style: TextStyle(
                    color: Color(0xFF7A7972),
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22.0),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(26.0),
        boxShadow: AppColors.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFormField(
            label: 'FULL NAME',
            hint: 'e.g. Alex Verma',
            controller: _nameController,
            icon: Icons.person_outline_rounded,
            validator: (val) =>
                val == null || val.trim().isEmpty ? 'Please enter your name' : null,
          ),
          const SizedBox(height: 18.0),
          _buildFormField(
            label: 'WORK / PERSONAL EMAIL',
            hint: 'e.g. alex.verma@domain.com',
            controller: _emailController,
            icon: Icons.mail_outline_rounded,
            keyboardType: TextInputType.emailAddress,
            validator: (val) {
              if (val == null || val.trim().isEmpty) {
                return 'Please enter your email';
              }
              if (!val.contains('@') || !val.contains('.')) {
                return 'Please enter a valid email address';
              }
              return null;
            },
          ),
          const SizedBox(height: 18.0),
          _buildPasswordField(
            label: 'PASSWORD',
            hint: 'At least 8 characters',
            controller: _passwordController,
            isObscured: _obscurePassword,
            onToggleVisibility: () {
              setState(() => _obscurePassword = !_obscurePassword);
            },
            validator: (val) {
              if (val == null || val.length < 8) {
                return 'Password must be at least 8 characters';
              }
              return null;
            },
          ),
          const SizedBox(height: 18.0),
          _buildPasswordField(
            label: 'CONFIRM PASSWORD',
            hint: 'Re-enter your password',
            controller: _confirmPasswordController,
            isObscured: _obscureConfirmPassword,
            onToggleVisibility: () {
              setState(
                  () => _obscureConfirmPassword = !_obscureConfirmPassword);
            },
            validator: (val) {
              if (val != _passwordController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRoleSelectorCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22.0),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(26.0),
        boxShadow: AppColors.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'PRIMARY PROFESSION / ROLE',
            style: TextStyle(
              color: Color(0xFF7A7972),
              fontSize: 11.0,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.1,
            ),
          ),
          const SizedBox(height: 12.0),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: List.generate(_roles.length, (index) {
              final isSelected = _selectedRoleIndex == index;
              return GestureDetector(
                onTap: () {
                  setState(() => _selectedRoleIndex = index);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14.0, vertical: 9.0),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.pastelPeach
                        : AppColors.peachBackground.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(
                      color: isSelected ? AppColors.deepInk : Colors.transparent,
                      width: 1.2,
                    ),
                  ),
                  child: Text(
                    _roles[index],
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
        ],
      ),
    );
  }

  Widget _buildTermsAndSSO() {
    return Column(
      children: [
        Row(
          children: [
            Checkbox.adaptive(
              value: _agreeToTerms,
              onChanged: (val) => setState(() => _agreeToTerms = val ?? true),
              activeColor: AppColors.deepInk,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
              ),
            ),
            Expanded(
              child: Text.rich(
                TextSpan(
                  text: 'I agree to the ',
                  style: const TextStyle(
                    color: Color(0xFF7A7972),
                    fontSize: 12.5,
                  ),
                  children: const [
                    TextSpan(
                      text: 'Terms of Service',
                      style: TextStyle(
                        color: AppColors.deepInk,
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    TextSpan(text: ' and '),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: TextStyle(
                        color: AppColors.deepInk,
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20.0),
        Row(
          children: [
            const Expanded(child: Divider(color: Color(0x1AD59D88))),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Text(
                'OR SIGN UP WITH',
                style: TextStyle(
                  color: Color(0xFF8E8D88),
                  fontSize: 11.0,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.0,
                ),
              ),
            ),
            const Expanded(child: Divider(color: Color(0x1AD59D88))),
          ],
        ),
        const SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSSOButton('Google', Icons.g_mobiledata_rounded),
            const SizedBox(width: 14.0),
            _buildSSOButton('GitHub', Icons.code_rounded),
            const SizedBox(width: 14.0),
            _buildSSOButton('LinkedIn', Icons.work_outline_rounded),
          ],
        ),
      ],
    );
  }

  Widget _buildSSOButton(String provider, IconData icon) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.deepInk,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.0),
            ),
            content: Text(
              '$provider authentication initiated',
              style: const TextStyle(color: AppColors.pureWhite),
            ),
          ),
        );
      },
      child: Container(
        width: 52.0,
        height: 52.0,
        decoration: BoxDecoration(
          color: AppColors.pureWhite,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: AppColors.buttonShadow,
        ),
        child: Icon(icon, color: AppColors.deepInk, size: 26.0),
      ),
    );
  }

  Widget _buildFormField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
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
            color: AppColors.peachBackground.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            validator: validator,
            style: const TextStyle(
              color: AppColors.deepInk,
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(
                color: Color(0xFF9E9D96),
                fontSize: 13.5,
                fontWeight: FontWeight.w400,
              ),
              prefixIcon: Icon(icon, color: AppColors.deepInk, size: 20.0),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 14.0,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required bool isObscured,
    required VoidCallback onToggleVisibility,
    String? Function(String?)? validator,
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
            color: AppColors.peachBackground.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: TextFormField(
            controller: controller,
            obscureText: isObscured,
            validator: validator,
            style: const TextStyle(
              color: AppColors.deepInk,
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(
                color: Color(0xFF9E9D96),
                fontSize: 13.5,
                fontWeight: FontWeight.w400,
              ),
              prefixIcon: const Icon(
                Icons.lock_outline_rounded,
                color: AppColors.deepInk,
                size: 20.0,
              ),
              suffixIcon: GestureDetector(
                onTap: onToggleVisibility,
                child: Icon(
                  isObscured
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: AppColors.deepInk,
                  size: 20.0,
                ),
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 14.0,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return GestureDetector(
      onTap: _submitForm,
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
          'CREATE FREE ACCOUNT',
          style: TextStyle(
            color: AppColors.deepInk,
            fontSize: 15.0,
            fontWeight: FontWeight.w900,
            letterSpacing: 2.0,
          ),
        ),
      ),
    );
  }

  Widget _buildSignInLink(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const MainNavigationView()),
          );
        },
        child: Text.rich(
          TextSpan(
            text: 'Already have an account? ',
            style: const TextStyle(
              color: Color(0xFF7A7972),
              fontSize: 13.0,
              fontWeight: FontWeight.w500,
            ),
            children: const [
              TextSpan(
                text: 'Sign In',
                style: TextStyle(
                  color: AppColors.deepInk,
                  fontWeight: FontWeight.w800,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
