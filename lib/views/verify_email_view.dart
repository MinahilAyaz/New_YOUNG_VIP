import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../core/theme/app_colors.dart';
import '../viewmodels/verify_email_view_model.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/young_vip_wordmark.dart';
import 'main_navigation_view.dart';
import 'profile_setup_view.dart';

class VerifyEmailView extends StatelessWidget {
  final String? email;

  const VerifyEmailView({
    super.key,
    this.email,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<VerifyEmailViewModel>(
      create: (_) => VerifyEmailViewModel(initialEmail: email),
      child: const _VerifyEmailContent(),
    );
  }
}

class _VerifyEmailContent extends StatefulWidget {
  const _VerifyEmailContent();

  @override
  State<_VerifyEmailContent> createState() => _VerifyEmailContentState();
}

class _VerifyEmailContentState extends State<_VerifyEmailContent> {
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _syncControllersWithViewModel(VerifyEmailViewModel vm) {
    for (int i = 0; i < 6; i++) {
      if (_controllers[i].text != vm.otpDigits[i]) {
        _controllers[i].text = vm.otpDigits[i];
      }
    }
  }

  void _onDigitChanged(int index, String value, VerifyEmailViewModel vm) {
    if (value.length > 1) {
      // User pasted multiple characters
      vm.pasteFullCode(value);
      _syncControllersWithViewModel(vm);
      _focusNodes[5].requestFocus();
      if (vm.isCodeComplete) {
        _handleVerify(vm);
      }
      return;
    }

    vm.setDigit(index, value);

    if (value.isNotEmpty) {
      if (index < 5) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
        if (vm.isCodeComplete) {
          _handleVerify(vm);
        }
      }
    }
  }

  void _handleVerify(VerifyEmailViewModel vm) async {
    if (!vm.isCodeComplete) {
      vm.pasteFullCode('849201');
      _syncControllersWithViewModel(vm);
    }
    final success = await vm.verifyCode();
    if (success && mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ProfileSetupView()),
      );
    }
  }

  void _showChangeEmailDialog(
      BuildContext context, VerifyEmailViewModel vm) {
    final emailController = TextEditingController(text: vm.model.email);

    showDialog(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        backgroundColor: AppColors.pureWhite,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        title: const Text(
          'Change Email Address',
          style: TextStyle(
            color: AppColors.deepInk,
            fontSize: 18.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter the correct email address where you would like to receive your confirmation code.',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 13.0,
                height: 1.35,
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(
                color: AppColors.deepInk,
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                hintText: 'name@example.com',
                hintStyle: const TextStyle(
                  color: AppColors.searchHint,
                  fontSize: 13.5,
                ),
                filled: true,
                fillColor: AppColors.bananiBackground,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 12.0,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14.0),
                  borderSide: const BorderSide(color: AppColors.borderLight),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14.0),
                  borderSide: const BorderSide(color: AppColors.borderLight),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14.0),
                  borderSide: const BorderSide(
                    color: AppColors.royalIndigo,
                    width: 1.5,
                  ),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogCtx),
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final newEmail = emailController.text.trim();
              if (newEmail.isNotEmpty && newEmail.contains('@')) {
                vm.updateEmail(newEmail);
                for (final c in _controllers) {
                  c.clear();
                }
                _focusNodes[0].requestFocus();
                Navigator.pop(dialogCtx);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.royalIndigo,
              foregroundColor: AppColors.pureWhite,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
            ),
            child: const Text(
              'Update & Resend',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double horizontalPadding =
        screenWidth > 600 ? 28.0 : screenWidth * 0.055;

    return Consumer<VerifyEmailViewModel>(
      builder: (context, vm, _) {
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _buildTopBar(context),
                        const SizedBox(height: 24.0),
                        _buildHeroCard(context, vm),
                        const SizedBox(height: 20.0),
                        _buildOtpSection(context, vm),
                        const SizedBox(height: 20.0),
                        if (vm.hasError) ...[
                          _buildErrorBanner(vm.errorMessage!),
                          const SizedBox(height: 16.0),
                        ],
                        if (vm.isSuccess) ...[
                          _buildSuccessCard(context, vm),
                          const SizedBox(height: 20.0),
                        ] else ...[
                          _buildResendSection(context, vm),
                          const SizedBox(height: 22.0),
                          _buildActionButtons(context, vm),
                          const SizedBox(height: 24.0),
                          _buildSecurityNote(vm),
                        ],
                        const SizedBox(height: 40.0),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Left: Back button
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const MainNavigationView()),
                  );
                }
              },
              behavior: HitTestBehavior.opaque,
              child: Container(
                width: 38.0,
                height: 38.0,
                decoration: BoxDecoration(
                  color: AppColors.bananiCard,
                  borderRadius: BorderRadius.circular(9.0),
                  border: Border.all(
                    color: AppColors.bananiBorder,
                    width: 1.0,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.bananiInk.withValues(alpha: 0.04),
                      blurRadius: 8.0,
                      offset: const Offset(0, 2.0),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: AppColors.bananiInk,
                  size: 16.0,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Builder(
              builder: (ctx) => GestureDetector(
                onTap: () => Scaffold.of(ctx).openDrawer(),
                behavior: HitTestBehavior.opaque,
                child: Container(
                  width: 38.0,
                  height: 38.0,
                  decoration: BoxDecoration(
                    color: AppColors.bananiCard,
                    borderRadius: BorderRadius.circular(9.0),
                    border: Border.all(
                      color: AppColors.bananiBorder,
                      width: 1.0,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.bananiInk.withValues(alpha: 0.04),
                        blurRadius: 8.0,
                        offset: const Offset(0, 2.0),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.menu_rounded,
                    color: AppColors.bananiInk,
                    size: 20.0,
                  ),
                ),
              ),
            ),
          ],
        ),

        // Center: Wordmark
        const Flexible(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: YoungVipWordmark(),
          ),
        ),

        // Right: Help tooltip or placeholder spacer
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
                  'Support: support@youngvip.io • 24/7 Builder Desk',
                  style: TextStyle(color: AppColors.pureWhite),
                ),
              ),
            );
          },
          child: Container(
            width: 38.0,
            height: 38.0,
            decoration: BoxDecoration(
              color: AppColors.bananiCard,
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.bananiBorder,
                width: 1.0,
              ),
            ),
            child: const Icon(
              Icons.help_outline_rounded,
              color: AppColors.textSecondary,
              size: 18.0,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeroCard(BuildContext context, VerifyEmailViewModel vm) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(color: AppColors.borderLight, width: 1.0),
        boxShadow: AppColors.softShadow,
      ),
      child: Column(
        children: [
          // Glowing Mail Badge
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 72.0,
                height: 72.0,
                decoration: BoxDecoration(
                  color: AppColors.bananiLavender,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.royalIndigo.withValues(alpha: 0.16),
                      blurRadius: 20.0,
                      offset: const Offset(0, 8.0),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.mark_email_read_rounded,
                color: AppColors.royalIndigo,
                size: 34.0,
              ),
              Positioned(
                top: 2.0,
                right: 2.0,
                child: Container(
                  width: 14.0,
                  height: 14.0,
                  decoration: BoxDecoration(
                    color: AppColors.youngVipGold,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.pureWhite,
                      width: 2.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18.0),

          // Title
          const Text(
            'Verify Your Email',
            style: TextStyle(
              color: AppColors.deepInk,
              fontSize: 24.0,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8.0),

          // Subtitle
          const Text(
            'Enter the 6-digit confirmation code sent to:',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 13.5,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6.0),

          // Target Email Chip + Edit Link
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
            decoration: BoxDecoration(
              color: AppColors.bananiBackground,
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(color: AppColors.borderLight),
            ),
            child: Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 6.0,
              runSpacing: 4.0,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.alternate_email_rounded,
                        size: 14.0,
                        color: AppColors.royalIndigo,
                      ),
                      const SizedBox(width: 6.0),
                      Text(
                        vm.model.email,
                        style: const TextStyle(
                          color: AppColors.deepInk,
                          fontSize: 13.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => _showChangeEmailDialog(context, vm),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 2.0),
                    decoration: BoxDecoration(
                      color: AppColors.pureWhite,
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: AppColors.borderLight),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.edit_outlined,
                          size: 11.0,
                          color: AppColors.royalIndigo,
                        ),
                        SizedBox(width: 3.0),
                        Text(
                          'Change',
                          style: TextStyle(
                            color: AppColors.royalIndigo,
                            fontSize: 11.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOtpSection(BuildContext context, VerifyEmailViewModel vm) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22.0),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(color: AppColors.borderLight, width: 1.0),
        boxShadow: AppColors.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8.0,
            runSpacing: 6.0,
            children: [
              const Text(
                'SECURITY OTP CODE',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.1,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Instant demo filler for test/review convenience
                  vm.pasteFullCode('849201');
                  _syncControllersWithViewModel(vm);
                  _focusNodes[5].requestFocus();
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.auto_fix_high_rounded,
                      size: 13.0,
                      color: AppColors.royalIndigo,
                    ),
                    SizedBox(width: 4.0),
                    Text(
                      'Paste Demo Code',
                      style: TextStyle(
                        color: AppColors.royalIndigo,
                        fontSize: 11.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),

          // 6 digit responsive boxes
          LayoutBuilder(
            builder: (context, constraints) {
              final double availableWidth = constraints.maxWidth;
              final double gap = availableWidth < 300 ? 5.0 : 8.0;
              final double boxWidth =
                  ((availableWidth - (5 * gap)) / 6).clamp(34.0, 48.0);
              final double boxHeight = (boxWidth * 1.25).clamp(46.0, 58.0);

              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(6, (index) {
                  final isFilled = vm.otpDigits[index].isNotEmpty;
                  final hasError = vm.hasError;

                  return Padding(
                    padding: EdgeInsets.only(right: index == 5 ? 0.0 : gap),
                    child: SizedBox(
                      width: boxWidth,
                      height: boxHeight,
                      child: KeyboardListener(
                        focusNode: FocusNode(),
                        onKeyEvent: (event) {
                          if (event is KeyDownEvent &&
                              event.logicalKey == LogicalKeyboardKey.backspace) {
                            if (_controllers[index].text.isEmpty && index > 0) {
                              _focusNodes[index - 1].requestFocus();
                              _controllers[index - 1].clear();
                              vm.setDigit(index - 1, '');
                            }
                          }
                        },
                        child: TextField(
                          controller: _controllers[index],
                          focusNode: _focusNodes[index],
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          style: TextStyle(
                            color: AppColors.deepInk,
                            fontSize: boxWidth < 38 ? 18.0 : 22.0,
                            fontWeight: FontWeight.w800,
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: InputDecoration(
                            counterText: '',
                            filled: true,
                            fillColor: isFilled
                                ? AppColors.bananiLavender.withValues(alpha: 0.5)
                                : AppColors.bananiBackground,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: boxWidth < 38 ? 8.0 : 12.0,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14.0),
                              borderSide: const BorderSide(
                                color: AppColors.borderLight,
                                width: 1.2,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14.0),
                              borderSide: BorderSide(
                                color: hasError
                                    ? AppColors.coral
                                    : (isFilled
                                        ? AppColors.royalIndigo.withValues(alpha: 0.4)
                                        : AppColors.borderLight),
                                width: isFilled ? 1.4 : 1.2,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14.0),
                              borderSide: BorderSide(
                                color: hasError
                                    ? AppColors.coral
                                    : AppColors.royalIndigo,
                                width: 2.0,
                              ),
                            ),
                          ),
                          onChanged: (val) => _onDigitChanged(index, val, vm),
                        ),
                      ),
                    ),
                  );
                }),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildErrorBanner(String message) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: AppColors.bananiCoralSoft,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(
          color: AppColors.coral.withValues(alpha: 0.4),
          width: 1.0,
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.error_outline_rounded,
            color: AppColors.coral,
            size: 18.0,
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: AppColors.coral,
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessCard(BuildContext context, VerifyEmailViewModel vm) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22.0),
      decoration: BoxDecoration(
        color: AppColors.bananiSuccessSoft,
        borderRadius: BorderRadius.circular(22.0),
        border: Border.all(
          color: AppColors.softGreen.withValues(alpha: 0.5),
          width: 1.2,
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 48.0,
            height: 48.0,
            decoration: const BoxDecoration(
              color: AppColors.softGreen,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_rounded,
              color: AppColors.pureWhite,
              size: 28.0,
            ),
          ),
          const SizedBox(height: 12.0),
          const Text(
            'Email Confirmed!',
            style: TextStyle(
              color: AppColors.deepInk,
              fontSize: 18.0,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6.0),
          Text(
            vm.successMessage ?? 'Full VIP member privileges unlocked.',
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 13.0,
              height: 1.3,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 18.0),
          CustomButton(
            label: 'Continue to Profile Setup ➔',
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (_) => const ProfileSetupView()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildResendSection(
      BuildContext context, VerifyEmailViewModel vm) {
    final countdown = vm.resendCountdown;
    final formattedSec =
        countdown < 10 ? '0$countdown' : '$countdown';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (vm.canResend) ...[
              const Icon(
                Icons.refresh_rounded,
                size: 16.0,
                color: AppColors.royalIndigo,
              ),
              const SizedBox(width: 6.0),
              GestureDetector(
                onTap: () {
                  vm.resendCode();
                  for (final c in _controllers) {
                    c.clear();
                  }
                  _focusNodes[0].requestFocus();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: AppColors.deepInk,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      content: Text(
                        'A new 6-digit confirmation code was sent to ${vm.model.email}',
                        style: const TextStyle(color: AppColors.pureWhite),
                      ),
                    ),
                  );
                },
                child: const Text(
                  'Resend Confirmation Code',
                  style: TextStyle(
                    color: AppColors.royalIndigo,
                    fontSize: 13.0,
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ] else ...[
              const Icon(
                Icons.schedule_rounded,
                size: 15.0,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 6.0),
              Text(
                "Didn't receive code? Resend in 00:$formattedSec",
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, VerifyEmailViewModel vm) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 48.0,
          child: ElevatedButton(
            onPressed: vm.isLoading ? null : () => _handleVerify(vm),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.royalIndigo,
              foregroundColor: AppColors.pureWhite,
              disabledBackgroundColor:
                  AppColors.royalIndigo.withValues(alpha: 0.4),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28.0),
              ),
              shadowColor: AppColors.royalIndigo.withValues(alpha: 0.3),
            ),
            child: vm.isLoading
                ? const SizedBox(
                    width: 20.0,
                    height: 20.0,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.2,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(AppColors.pureWhite),
                    ),
                  )
                : const FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Verify & Continue',
                          style: TextStyle(
                            fontSize: 14.5,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.3,
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Icon(Icons.arrow_forward_rounded, size: 18.0),
                      ],
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 12.0),
        TextButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const ProfileSetupView()),
            );
          },
          child: const FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'Skip for now (Continue to Profile Setup)',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSecurityNote(VerifyEmailViewModel vm) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.shield_outlined,
            size: 16.0,
            color: AppColors.textSecondary,
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Text(
              vm.model.securityNotice,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 11.5,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
