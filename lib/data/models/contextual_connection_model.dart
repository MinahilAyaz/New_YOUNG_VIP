import 'package:flutter/material.dart';

class KnowledgeNodeModel {
  final String id;
  final String title;
  final String category; // e.g. 'Regulatory Framework', 'Security Standard', 'Architecture Pattern'
  final String connectionStrength; // e.g. '98% Direct Match'
  final String summary;
  final String takeaway;
  final IconData icon;
  final Color accentColor;

  const KnowledgeNodeModel({
    required this.id,
    required this.title,
    required this.category,
    required this.connectionStrength,
    required this.summary,
    required this.takeaway,
    required this.icon,
    required this.accentColor,
  });
}

class IndustryPrecedentModel {
  final String organization;
  final String sector;
  final String title;
  final String incidentSummary;
  final String labSolutionMapping;
  final String quantifiableImpact;
  final IconData icon;

  const IndustryPrecedentModel({
    required this.organization,
    required this.sector,
    required this.title,
    required this.incidentSummary,
    required this.labSolutionMapping,
    required this.quantifiableImpact,
    required this.icon,
  });
}

class CrossDomainImpactModel {
  final String domain;
  final String audience;
  final String keyRisk;
  final String mitigation;
  final IconData icon;

  const CrossDomainImpactModel({
    required this.domain,
    required this.audience,
    required this.keyRisk,
    required this.mitigation,
    required this.icon,
  });
}

class ContextualConnectionModel {
  final String labTitle;
  final String labTag;
  final String contextObjective;
  final String contextSummary;
  final List<KnowledgeNodeModel> knowledgeNodes;
  final List<IndustryPrecedentModel> precedents;
  final List<CrossDomainImpactModel> domainImpacts;
  final String nextRecommendedTopic;

  const ContextualConnectionModel({
    required this.labTitle,
    required this.labTag,
    required this.contextObjective,
    required this.contextSummary,
    required this.knowledgeNodes,
    required this.precedents,
    required this.domainImpacts,
    required this.nextRecommendedTopic,
  });
}
