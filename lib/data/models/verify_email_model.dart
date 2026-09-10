class VerifyEmailModel {
  final String email;
  final int codeLength;
  final int resendTimeoutSeconds;
  final String securityNotice;

  const VerifyEmailModel({
    required this.email,
    this.codeLength = 6,
    this.resendTimeoutSeconds = 45,
    this.securityNotice =
        'Verification codes expire in 10 minutes. Young VIP will never ask for your code via phone or chat.',
  });

  String get maskedEmail {
    if (!email.contains('@')) return email;
    final parts = email.split('@');
    final name = parts[0];
    final domain = parts[1];
    if (name.length <= 2) {
      return '$name***@$domain';
    }
    return '${name.substring(0, 2)}••••••@$domain';
  }

  VerifyEmailModel copyWith({
    String? email,
    int? codeLength,
    int? resendTimeoutSeconds,
    String? securityNotice,
  }) {
    return VerifyEmailModel(
      email: email ?? this.email,
      codeLength: codeLength ?? this.codeLength,
      resendTimeoutSeconds:
          resendTimeoutSeconds ?? this.resendTimeoutSeconds,
      securityNotice: securityNotice ?? this.securityNotice,
    );
  }
}
