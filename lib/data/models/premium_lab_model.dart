import 'package:flutter/material.dart';

class PricingOptionModel {
  final String label;
  final Color backgroundColor;
  final Color textColor;

  const PricingOptionModel({
    required this.label,
    required this.backgroundColor,
    required this.textColor,
  });
}

class PremiumLabModel {
  final String screenTitle;
  final String heading;
  final String description;
  final String footnote;
  final List<PricingOptionModel> pricingOptions;

  const PremiumLabModel({
    required this.screenTitle,
    required this.heading,
    required this.description,
    required this.footnote,
    required this.pricingOptions,
  });
}
