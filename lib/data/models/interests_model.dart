import 'package:flutter/material.dart';

/// Represents an individual technology or regulatory topic in Young VIP.
class TopicInterest {
  final String id;
  final String title;
  final String category;
  final String description;
  final IconData icon;
  final String buildersCount;
  final String labsCount;
  final bool isTrending;
  final String badgeText;

  const TopicInterest({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.icon,
    required this.buildersCount,
    required this.labsCount,
    this.isTrending = false,
    this.badgeText = '',
  });
}

/// Curated persona presets to let users auto-select relevant topics in one tap.
class InterestsPreset {
  final String id;
  final String name;
  final String role;
  final IconData icon;
  final List<String> topicIds;

  const InterestsPreset({
    required this.id,
    required this.name,
    required this.role,
    required this.icon,
    required this.topicIds,
  });
}

/// Overall onboarding configuration & state container.
class InterestsOnboardingModel {
  final int minRequiredSelection;
  final int completionXpReward;
  final List<TopicInterest> allTopics;
  final List<InterestsPreset> presets;

  const InterestsOnboardingModel({
    this.minRequiredSelection = 3,
    this.completionXpReward = 100,
    required this.allTopics,
    required this.presets,
  });

  /// Factory providing all canonical Young VIP legal tech topics.
  factory InterestsOnboardingModel.initial() {
    return InterestsOnboardingModel(
      minRequiredSelection: 3,
      completionXpReward: 100,
      presets: const [
        InterestsPreset(
          id: 'litigation',
          name: 'Litigation & Forensics',
          role: 'Trial Lawyers & Litigators',
          icon: Icons.gavel_rounded,
          topicIds: ['ai-agents', 'biometrics', 'bias-fairness', 'cyber-exfil'],
        ),
        InterestsPreset(
          id: 'in-house',
          name: 'In-House & Governance',
          role: 'General Counsel & Risk Officers',
          icon: Icons.shield_outlined,
          topicIds: ['ai-governance', 'rag-knowledge', 'smart-contracts', 'ip-copyright'],
        ),
        InterestsPreset(
          id: 'builder-counsel',
          name: 'Tech Architect & Builder',
          role: 'Legal Engineers & AI Architects',
          icon: Icons.code_rounded,
          topicIds: ['ai-agents', 'rag-knowledge', 'cyber-exfil', 'smart-contracts'],
        ),
      ],
      allTopics: const [
        TopicInterest(
          id: 'ai-agents',
          title: 'AI Agents & Tool Escalation',
          category: 'Core Technologies',
          description:
              'Autonomous execution, tool access boundaries, and delegation liability protocols.',
          icon: Icons.smart_toy_outlined,
          buildersCount: '1.4k builders',
          labsCount: '6 Labs',
          isTrending: true,
          badgeText: 'HOT',
        ),
        TopicInterest(
          id: 'rag-knowledge',
          title: 'Enterprise RAG & Grounding',
          category: 'Core Technologies',
          description:
              'Vector retrieval, citation hallucination forensics, and private index isolation.',
          icon: Icons.storage_rounded,
          buildersCount: '1.1k builders',
          labsCount: '5 Labs',
          isTrending: true,
          badgeText: 'POPULAR',
        ),
        TopicInterest(
          id: 'ai-governance',
          title: 'AI Governance & Compliance',
          category: 'Regulatory & Risk',
          description:
              'EU AI Act conformity assessments, NIST AI RMF controls, and algorithmic audit trails.',
          icon: Icons.verified_user_outlined,
          buildersCount: '920 builders',
          labsCount: '4 Labs',
          isTrending: false,
          badgeText: 'ESSENTIAL',
        ),
        TopicInterest(
          id: 'biometrics',
          title: 'Biometrics & Identity Evidence',
          category: 'Regulatory & Risk',
          description:
              'Deepfake authentication, synthetic audio forensics, and facial recognition admissibility.',
          icon: Icons.fingerprint_rounded,
          buildersCount: '780 builders',
          labsCount: '3 Labs',
          isTrending: false,
          badgeText: '',
        ),
        TopicInterest(
          id: 'cyber-exfil',
          title: 'Prompt Injection & Security',
          category: 'Core Technologies',
          description:
              'Jailbreaks, indirect injection via documents, model inversion, and data leakage defense.',
          icon: Icons.security_rounded,
          buildersCount: '1.2k builders',
          labsCount: '5 Labs',
          isTrending: true,
          badgeText: 'CRITICAL',
        ),
        TopicInterest(
          id: 'ip-copyright',
          title: 'IP & Generative AI Copyright',
          category: 'Regulatory & Risk',
          description:
              'Training data fair use, output copyrightability, style emulation, and dataset provenance.',
          icon: Icons.copyright_rounded,
          buildersCount: '650 builders',
          labsCount: '4 Labs',
          isTrending: false,
          badgeText: '',
        ),
        TopicInterest(
          id: 'smart-contracts',
          title: 'Smart Contracts & Oracles',
          category: 'Emerging Tech',
          description:
              'Deterministic escrow, multi-sig dispute governance, and oracle failure liabilities.',
          icon: Icons.account_tree_outlined,
          buildersCount: '540 builders',
          labsCount: '3 Labs',
          isTrending: false,
          badgeText: '',
        ),
        TopicInterest(
          id: 'bias-fairness',
          title: 'Algorithmic Bias & Fairness',
          category: 'Regulatory & Risk',
          description:
              'Disparate impact testing, statistical parity metrics, and training data skew remediation.',
          icon: Icons.balance_rounded,
          buildersCount: '620 builders',
          labsCount: '3 Labs',
          isTrending: false,
          badgeText: '',
        ),
        TopicInterest(
          id: 'healthcare-ai',
          title: 'HealthTech & Clinical AI',
          category: 'Emerging Tech',
          description:
              'FDA SaMD compliance, HIPAA de-identification pipelines, and diagnostic malpractice risk.',
          icon: Icons.health_and_safety_outlined,
          buildersCount: '430 builders',
          labsCount: '3 Labs',
          isTrending: false,
          badgeText: 'NICHE',
        ),
      ],
    );
  }
}
