import 'dart:async';
import '../core/base/base_view_model.dart';
import '../data/models/verify_email_model.dart';

class VerifyEmailViewModel extends BaseViewModel {
  VerifyEmailModel _model;
  final List<String> _otpDigits;
  int _resendCountdown;
  Timer? _timer;
  String? _successMessage;

  VerifyEmailViewModel({String? initialEmail})
      : _model = VerifyEmailModel(
          email: (initialEmail != null && initialEmail.trim().isNotEmpty)
              ? initialEmail.trim()
              : 'alex.verma@youngvip.io',
        ),
        _otpDigits = List<String>.filled(6, ''),
        _resendCountdown = 45 {
    _startCountdownTimer();
  }

  VerifyEmailModel get model => _model;
  List<String> get otpDigits => List.unmodifiable(_otpDigits);
  int get resendCountdown => _resendCountdown;
  String? get successMessage => _successMessage;
  bool get canResend => _resendCountdown == 0 && !isLoading;
  bool get isSuccess => status == ViewState.success;

  bool get isCodeComplete =>
      _otpDigits.every((d) => d.trim().isNotEmpty && d.length == 1);

  String get enteredCode => _otpDigits.join();

  void _startCountdownTimer() {
    _timer?.cancel();
    _resendCountdown = _model.resendTimeoutSeconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendCountdown > 0) {
        _resendCountdown--;
        notifyListeners();
      } else {
        timer.cancel();
      }
    });
  }

  void setDigit(int index, String value) {
    if (index >= 0 && index < _otpDigits.length) {
      _otpDigits[index] = value.trim().isNotEmpty ? value.trim().substring(0, 1) : '';
      if (hasError) {
        setIdle();
      } else {
        notifyListeners();
      }
    }
  }

  void pasteFullCode(String code) {
    final cleaned = code.replaceAll(RegExp(r'\D'), '');
    for (int i = 0; i < 6; i++) {
      if (i < cleaned.length) {
        _otpDigits[i] = cleaned[i];
      } else {
        _otpDigits[i] = '';
      }
    }
    setIdle();
  }

  void clearCode() {
    for (int i = 0; i < _otpDigits.length; i++) {
      _otpDigits[i] = '';
    }
    setIdle();
  }

  void updateEmail(String newEmail) {
    if (newEmail.trim().isEmpty || !newEmail.contains('@')) return;
    _model = _model.copyWith(email: newEmail.trim());
    clearCode();
    _startCountdownTimer();
  }

  Future<bool> verifyCode() async {
    if (!isCodeComplete) {
      setError('Please enter all 6 digits of your verification code.');
      return false;
    }

    setLoading();
    // Simulate brief network verification
    await Future.delayed(const Duration(milliseconds: 900));

    final code = enteredCode;
    // Accept valid 6-digit codes (reject test invalid like "000000")
    if (code == '000000') {
      setError('Invalid or expired code. Please request a new code.');
      return false;
    }

    _successMessage =
        'Email verified successfully! Your Young VIP account is fully active.';
    setSuccess();
    return true;
  }

  void resendCode() {
    if (!canResend) return;
    clearCode();
    _startCountdownTimer();
    setIdle();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
