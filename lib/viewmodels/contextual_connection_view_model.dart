import 'package:flutter/material.dart';

import '../core/base/base_view_model.dart';
import '../core/theme/app_colors.dart';
import '../data/models/contextual_connection_model.dart';

class ContextualConnectionViewModel extends BaseViewModel {
  final ContextualConnectionModel _data;
  int _activeTab = 0; // 0 = Knowledge Nodes, 1 = Industry Precedents, 2 = Cross-Domain Synthesis
  String? _selectedNodeId;
  final Set<String> _bookmarkedIds = {};

  ContextualConnectionViewModel()
      : _data = const ContextualConnectionModel(
          labTitle: 'AI Agents: Prompt Injection & Tool Escalation',
          labTag: 'CONTEXTUAL CONNECTION • KNOWLEDGE SYNTHESIS',
          contextObjective:
              'Bridge your hands-on code discoveries from this lab to global security benchmarks, regulatory frameworks, and enterprise threat intelligence.',
          contextSummary:
              'The prompt injection and tool privilege escalation you uncovered in this lab is directly cataloged under OWASP LLM01, regulated by the EU AI Act Article 14, and mitigated by NIST SP 800-207 Zero-Trust Architecture.',
          knowledgeNodes: [
            KnowledgeNodeModel(
              id: 'owasp-llm01',
              title: 'OWASP Top 10 for LLM: LLM01 & LLM02',
              category: 'Global Security Standard',
              connectionStrength: '99% Direct Match',
              summary:
                  'Covers Prompt Injection and Insecure Output Handling where adversarial inputs manipulate LLMs into executing unintended backend tools.',
              takeaway:
                  'Our lab demonstrated how unescaped user text bypasses system instructions and invokes database write tools without authorization.',
              icon: Icons.security_rounded,
              accentColor: AppColors.bananiCoral,
            ),
            KnowledgeNodeModel(
              id: 'nist-ai-rmf',
              title: 'NIST AI Risk Management Framework 1.0',
              category: 'Enterprise Risk Taxonomy',
              connectionStrength: '94% Structural Match',
              summary:
                  'Defines the Map, Measure, and Manage functions for autonomous systems with probabilistic decision-making and external integrations.',
              takeaway:
                  'The dual-agent verification pattern built in this lab implements the NIST "Manage" function by placing an independent gatekeeper between the model and operational tools.',
              icon: Icons.account_tree_rounded,
              accentColor: AppColors.bananiPrimary,
            ),
            KnowledgeNodeModel(
              id: 'eu-ai-act',
              title: 'EU AI Act: Article 14 Human Oversight',
              category: 'Regulatory Compliance',
              connectionStrength: '91% Legal Precedent',
              summary:
                  'Requires high-risk autonomous systems to be designed such that natural persons can oversee, override, or immediately halt systemic actions.',
              takeaway:
                  'The escalation checkpoint you configured provides legally verifiable human-in-the-loop compliance before sensitive records can be permanently deleted.',
              icon: Icons.gavel_rounded,
              accentColor: AppColors.youngVipGold,
            ),
            KnowledgeNodeModel(
              id: 'zero-trust-agent',
              title: 'Zero-Trust Architecture (NIST SP 800-207)',
              category: 'Systems Engineering',
              connectionStrength: '96% Architectural Match',
              summary:
                  'Presumes breach and treats every agent-to-tool invocation as an untrusted transaction requiring cryptographic authentication and session-bound scopes.',
              takeaway:
                  'Eliminating ambient LLM privileges through ephemeral execution tokens reduces blast radius by 98% against multi-turn jailbreaks.',
              icon: Icons.shield_moon_rounded,
              accentColor: AppColors.softGreen,
            ),
          ],
          precedents: [
            IndustryPrecedentModel(
              organization: 'Fortune 100 Legal Tech Deployment',
              sector: 'Enterprise Legal Operations',
              title: 'Adversarial Prompt Contamination Incident',
              incidentSummary:
                  'An autonomous contract-review agent processed a malicious PDF containing hidden white-on-white text instructions, leaking confidential merger terms to an external webhook.',
              labSolutionMapping:
                  'Directly prevented by the XML delimiter fencing and separate parser agent configured during our Build It stage.',
              quantifiableImpact: 'Prevented \$14M in Fines',
              icon: Icons.business_rounded,
            ),
            IndustryPrecedentModel(
              organization: 'Global FinTech Banking Copilot',
              sector: 'Financial Technology',
              title: 'Recursive Tool Calling Budget Exhaustion',
              incidentSummary:
                  'A customer support bot was triggered into a circular lookup query loop through ambiguous prompt syntax, consuming \$180,000 in API token spend in under 6 hours.',
              labSolutionMapping:
                  'Mitigated by the hard token budget ceilings and loop timeout breakers implemented in our governance matrix.',
              quantifiableImpact: 'Saved \$2.4M in Token Spend',
              icon: Icons.monetization_on_rounded,
            ),
          ],
          domainImpacts: [
            CrossDomainImpactModel(
              domain: 'Legal & Regulatory Compliance',
              audience: 'General Counsel & Compliance Officers',
              keyRisk:
                  'Breach of confidentiality agreements and strict liability under emerging global AI safety legislation.',
              mitigation:
                  'Cryptographically audited execution logs with immutable human sign-off records.',
              icon: Icons.balance_rounded,
            ),
            CrossDomainImpactModel(
              domain: 'Enterprise Architecture & Cloud',
              audience: 'Chief Technology Officers & Principal Architects',
              keyRisk:
                  'Database injection, unauthorized microservice invocation, and cascading microservice outages.',
              mitigation:
                  'Independent verifier agent topologies with ephemeral privilege scopes.',
              icon: Icons.dns_rounded,
            ),
            CrossDomainImpactModel(
              domain: 'Executive Strategy & Fiduciary',
              audience: 'Board Directors & C-Suite Leadership',
              keyRisk:
                  'Reputational brand damage and loss of enterprise customer trust following unauthorized AI output leaks.',
              mitigation:
                  'Quantifiable SLA metrics, insurance-underwritten guardrail policies, and verifiable fluency benchmarks.',
              icon: Icons.trending_up_rounded,
            ),
          ],
          nextRecommendedTopic:
              'Advanced Multi-Modal RAG: Vector Indexing & Context Injection Defenses',
        );

  ContextualConnectionModel get data => _data;
  int get activeTab => _activeTab;
  String? get selectedNodeId => _selectedNodeId;
  Set<String> get bookmarkedIds => _bookmarkedIds;

  void setActiveTab(int index) {
    _activeTab = index;
    notifyListeners();
  }

  void selectNode(String? nodeId) {
    _selectedNodeId = (_selectedNodeId == nodeId) ? null : nodeId;
    notifyListeners();
  }

  void toggleBookmark(String id) {
    if (_bookmarkedIds.contains(id)) {
      _bookmarkedIds.remove(id);
    } else {
      _bookmarkedIds.add(id);
    }
    notifyListeners();
  }
}
