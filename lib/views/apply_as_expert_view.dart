import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/theme/app_colors.dart';
import '../widgets/young_vip_wordmark.dart';
import 'application_review_status_view.dart';
import 'main_navigation_view.dart';

class ApplyAsExpertView extends StatefulWidget {
  const ApplyAsExpertView({super.key});

  @override
  State<ApplyAsExpertView> createState() => _ApplyAsExpertViewState();
}

class _ApplyAsExpertViewState extends State<ApplyAsExpertView> {
  final _formKey = GlobalKey<FormState>();

  // Form Controllers
  final _nameController = TextEditingController(text: 'Dr. Sarah Lin');
  final _roleController =
      TextEditingController(text: 'Principal AI Alignment Architect');
  final _affiliationController =
      TextEditingController(text: 'Cognitive Systems Institute');
  final _portfolioController =
      TextEditingController(text: 'https://github.com/sarahlin-ai');
  final _trackTitleController = TextEditingController(
      text: 'Dynamic Prompt Injection Defense & Multi-Agent Guardrails');
  final _trackSummaryController = TextEditingController(
    text:
        'A comprehensive 4-stage sprint where builders deploy real-time semantic canary tokens, isolate compromised LLM sub-agents, and synthesize cryptographically signed client advisory reports.',
  );
  final _newCredentialController = TextEditingController();

  // Selection States
  int _selectedDomainIndex = 0;
  int _selectedExpIndex = 2; // 0: <2 yrs, 1: 2-5 yrs, 2: 5-8 yrs, 3: 8+ yrs
  int _selectedAudienceIndex = 1; // 0: Foundational, 1: Practitioner, 2: Architect
  int _selectedCommitmentIndex = 1; // 0: 2-4 hrs, 1: 5-8 hrs, 2: 10+ hrs

  bool _agreedToEthics = true;
  bool _isSubmitting = false;
  bool _isSubmitted = false;

  final List<Map<String, dynamic>> _domains = const [
    {
      'name': 'Autonomous Agents',
      'icon': Icons.psychology_rounded,
    },
    {
      'name': 'Generative AI & LLMs',
      'icon': Icons.auto_awesome_rounded,
    },
    {
      'name': 'AI Safety & Defense',
      'icon': Icons.security_rounded,
    },
    {
      'name': 'RAG & Knowledge Graphs',
      'icon': Icons.hub_rounded,
    },
    {
      'name': 'Multimodal Systems',
      'icon': Icons.visibility_rounded,
    },
  ];

  final List<String> _expLevels = const [
    '< 2 Years',
    '2 - 5 Years',
    '5 - 8 Years',
    '8+ Years',
  ];

  final List<String> _audienceTiers = const [
    'Foundational',
    'Practitioner',
    'Master Architect',
  ];

  final List<String> _commitments = const [
    '2 - 4 hrs/wk',
    '5 - 8 hrs/wk',
    '10+ hrs/wk',
  ];

  final List<String> _credentials = [
    'Lead Author: "Adversarial Robustness in Agent Swarms" (NeurIPS 2025)',
    'US Patent 11,842,910: Real-time context sandboxing for LLM tools',
    'Creator of OpenGuard: 4.8k GitHub stars, 120k monthly pip installs',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _roleController.dispose();
    _affiliationController.dispose();
    _portfolioController.dispose();
    _trackTitleController.dispose();
    _trackSummaryController.dispose();
    _newCredentialController.dispose();
    super.dispose();
  }

  void _addCredential() {
    final text = _newCredentialController.text.trim();
    if (text.isNotEmpty) {
      HapticFeedback.lightImpact();
      setState(() {
        _credentials.add(text);
        _newCredentialController.clear();
      });
    }
  }

  void _removeCredential(int index) {
    HapticFeedback.lightImpact();
    setState(() {
      _credentials.removeAt(index);
    });
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (!_agreedToEthics) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Please accept the Creator Code of Ethics and Safety Terms.',
            style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600),
          ),
          backgroundColor: const Color(0xFFDC2626),
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
      );
      return;
    }

    HapticFeedback.mediumImpact();
    setState(() => _isSubmitting = true);

    await Future.delayed(const Duration(milliseconds: 900));

    if (mounted) {
      setState(() {
        _isSubmitting = false;
        _isSubmitted = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double horizontalPadding =
        screenWidth > 600 ? 28.0 : (screenWidth < 360 ? 14.0 : 20.0);

    return Scaffold(
      backgroundColor: AppColors.warmIvory,
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 580.0),
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: 14.0,
              ),
              child: _isSubmitted
                  ? _buildSuccessCard(context)
                  : Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildTopBar(context),
                          const SizedBox(height: 18.0),
                          _buildHeroHeader(),
                          const SizedBox(height: 16.0),
                          _buildPerksGrid(),
                          const SizedBox(height: 22.0),
                          _buildSectionTitle(
                            stepNumber: '01',
                            title: 'Applicant Profile',
                            subtitle:
                                'Your identity, role, and public AI engineering record',
                          ),
                          const SizedBox(height: 12.0),
                          _buildProfileCard(),
                          const SizedBox(height: 22.0),
                          _buildSectionTitle(
                            stepNumber: '02',
                            title: 'Domain & Experience',
                            subtitle:
                                'Your primary applied field and years architecting systems',
                          ),
                          const SizedBox(height: 12.0),
                          _buildDomainCard(),
                          const SizedBox(height: 22.0),
                          _buildSectionTitle(
                            stepNumber: '03',
                            title: 'Proposed Flagship Track',
                            subtitle:
                                'The hands-on sprint curriculum you will publish for builders',
                          ),
                          const SizedBox(height: 12.0),
                          _buildTrackCard(),
                          const SizedBox(height: 22.0),
                          _buildSectionTitle(
                            stepNumber: '04',
                            title: 'Verified Credentials',
                            subtitle:
                                'Key publications, patents, benchmarks, or repositories',
                          ),
                          const SizedBox(height: 12.0),
                          _buildCredentialsCard(),
                          const SizedBox(height: 22.0),
                          _buildSectionTitle(
                            stepNumber: '05',
                            title: 'Commitment & Ethics',
                            subtitle:
                                'Availability and platform safety compliance',
                          ),
                          const SizedBox(height: 12.0),
                          _buildCommitmentCard(),
                          const SizedBox(height: 24.0),
                          _buildSubmitButton(),
                          const SizedBox(height: 48.0),
                        ],
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Top Bar
  // ---------------------------------------------------------------------------
  Widget _buildTopBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                HapticFeedback.lightImpact();
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const MainNavigationView(initialIndex: 0),
                    ),
                  );
                }
              },
              behavior: HitTestBehavior.opaque,
              child: Container(
                width: 38.0,
                height: 38.0,
                margin: const EdgeInsets.only(right: 10.0),
                decoration: BoxDecoration(
                  color: AppColors.pureWhite,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: AppColors.buttonShadow,
                  border: Border.all(
                    color: AppColors.cardBorder,
                    width: 1.0,
                  ),
                ),
                child: const Icon(
                  Icons.arrow_back_rounded,
                  color: AppColors.deepInk,
                  size: 18.0,
                ),
              ),
            ),
            const YoungVipWordmark(),
          ],
        ),
        const SizedBox(width: 8.0),
        // Cohort Status Badge
        Flexible(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerRight,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              decoration: BoxDecoration(
                color: const Color(0xFFE6F4EC),
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: const Color(0xFFA7F3D0),
                  width: 1.0,
                ),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.lens,
                    size: 8.0,
                    color: Color(0xFF059669),
                  ),
                  SizedBox(width: 6.0),
                  Text(
                    'APPLICATIONS OPEN · COHORT 4',
                    style: TextStyle(
                      color: Color(0xFF065F46),
                      fontSize: 10.0,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.6,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Hero Header
  // ---------------------------------------------------------------------------
  Widget _buildHeroHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 4.5),
          decoration: BoxDecoration(
            color: AppColors.bananiLavender,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: const FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.stars_rounded,
                  size: 14.0,
                  color: AppColors.bananiPrimary,
                ),
                SizedBox(width: 5.0),
                Text(
                  'BUILD EXPERT PROGRAM',
                  style: TextStyle(
                    color: AppColors.bananiPrimary,
                    fontSize: 10.0,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.8,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        const Text(
          'Apply as Build Expert',
          style: TextStyle(
            color: AppColors.deepInk,
            fontSize: 23.0,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.5,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 6.0),
        const Text(
          'Join the vanguard of AI architects authoring and publishing interactive sprint tracks for the Young VIP network. Earn revenue and mentor the next cohort of builders.',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 13.0,
            height: 1.45,
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Perks Grid (3 cards)
  // ---------------------------------------------------------------------------
  Widget _buildPerksGrid() {
    final perks = [
      {
        'icon': Icons.monetization_on_outlined,
        'title': '70% Revenue Share',
        'desc': 'Earn on pass sales & team seats',
        'color': const Color(0xFF059669),
        'bg': const Color(0xFFE6F4EC),
      },
      {
        'icon': Icons.memory_rounded,
        'title': 'Dedicated GPU Sandboxes',
        'desc': 'Cloud sandbox compute provided',
        'color': AppColors.bananiPrimary,
        'bg': AppColors.bananiLavender,
      },
      {
        'icon': Icons.verified_user_outlined,
        'title': 'Verified Author Badge',
        'desc': 'Global Fluency accreditation',
        'color': const Color(0xFFD97706),
        'bg': const Color(0xFFFEF3C7),
      },
    ];

    return LayoutBuilder(builder: (context, constraints) {
      final isCompact = constraints.maxWidth < 460;
      if (isCompact) {
        return Column(
          children: perks
              .map((p) => Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: _buildPerkTile(p),
                  ))
              .toList(),
        );
      }
      return Row(
        children: perks
            .map((p) => Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: p == perks.last ? 0.0 : 8.0,
                    ),
                    child: _buildPerkTile(p),
                  ),
                ))
            .toList(),
      );
    });
  }

  Widget _buildPerkTile(Map<String, dynamic> p) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: AppColors.cardBorder, width: 1.0),
        boxShadow: AppColors.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32.0,
            height: 32.0,
            decoration: BoxDecoration(
              color: p['bg'] as Color,
              borderRadius: BorderRadius.circular(9.0),
            ),
            child: Icon(
              p['icon'] as IconData,
              size: 17.0,
              color: p['color'] as Color,
            ),
          ),
          const SizedBox(height: 8.0),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              p['title'] as String,
              style: const TextStyle(
                color: AppColors.deepInk,
                fontSize: 12.5,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(height: 3.0),
          Text(
            p['desc'] as String,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 10.5,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Section Title Helper
  // ---------------------------------------------------------------------------
  Widget _buildSectionTitle({
    required String stepNumber,
    required String title,
    required String subtitle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 3.0),
          decoration: BoxDecoration(
            color: AppColors.deepInk,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            stepNumber,
            style: const TextStyle(
              color: AppColors.pureWhite,
              fontSize: 10.5,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.5,
            ),
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.deepInk,
                  fontSize: 14.5,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 2.0),
              Text(
                subtitle,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 11.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Section 1: Applicant Profile Card
  // ---------------------------------------------------------------------------
  Widget _buildProfileCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(color: AppColors.cardBorder, width: 1.0),
        boxShadow: AppColors.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFormField(
            label: 'FULL LEGAL NAME',
            controller: _nameController,
            hintText: 'e.g. Dr. Alex Vance',
            icon: Icons.person_outline_rounded,
            validator: (v) => v == null || v.trim().isEmpty
                ? 'Full name is required'
                : null,
          ),
          const SizedBox(height: 14.0),
          _buildFormField(
            label: 'PRIMARY PROFESSIONAL TITLE / ROLE',
            controller: _roleController,
            hintText: 'e.g. Principal AI Research Scientist',
            icon: Icons.work_outline_rounded,
            validator: (v) => v == null || v.trim().isEmpty
                ? 'Current title is required'
                : null,
          ),
          const SizedBox(height: 14.0),
          _buildFormField(
            label: 'ORGANIZATION / AFFILIATION / LAB',
            controller: _affiliationController,
            hintText: 'e.g. Stanford AI Lab / DeepMind Ecosystem',
            icon: Icons.business_outlined,
            validator: (v) => v == null || v.trim().isEmpty
                ? 'Affiliation is required'
                : null,
          ),
          const SizedBox(height: 14.0),
          _buildFormField(
            label: 'PORTFOLIO / GITHUB / HUGGING FACE URL',
            controller: _portfolioController,
            hintText: 'https://github.com/username',
            icon: Icons.link_rounded,
            keyboardType: TextInputType.url,
            validator: (v) => v == null || v.trim().isEmpty
                ? 'A public portfolio or profile link is required'
                : null,
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Section 2: Domain & Experience Card
  // ---------------------------------------------------------------------------
  Widget _buildDomainCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(color: AppColors.cardBorder, width: 1.0),
        boxShadow: AppColors.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'PRIMARY DOMAIN SPECIALTY',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 10.5,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 10.0),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: List.generate(_domains.length, (i) {
              final isSelected = _selectedDomainIndex == i;
              final domain = _domains[i];
              return InkWell(
                onTap: () {
                  HapticFeedback.selectionClick();
                  setState(() => _selectedDomainIndex = i);
                },
                borderRadius: BorderRadius.circular(10.0),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 160),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 7.0),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.bananiPrimary
                        : const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.bananiPrimary
                          : const Color(0xFFE2E8F0),
                      width: 1.0,
                    ),
                  ),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          domain['icon'] as IconData,
                          size: 14.0,
                          color: isSelected
                              ? Colors.white
                              : const Color(0xFF64748B),
                        ),
                        const SizedBox(width: 6.0),
                        Text(
                          domain['name'] as String,
                          style: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : const Color(0xFF334155),
                            fontSize: 11.5,
                            fontWeight:
                                isSelected ? FontWeight.w800 : FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 18.0),
          const Text(
            'YEARS OF APPLIED AI / SYSTEMS EXPERIENCE',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 10.5,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 10.0),
          Row(
            children: List.generate(_expLevels.length, (i) {
              final isSelected = _selectedExpIndex == i;
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    HapticFeedback.selectionClick();
                    setState(() => _selectedExpIndex = i);
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    margin: EdgeInsets.only(
                      right: i == _expLevels.length - 1 ? 0.0 : 6.0,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFFF1F5F9)
                          : AppColors.pureWhite,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.deepInk
                            : const Color(0xFFE2E8F0),
                        width: isSelected ? 1.5 : 1.0,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        _expLevels[i],
                        style: TextStyle(
                          color: isSelected
                              ? AppColors.deepInk
                              : const Color(0xFF64748B),
                          fontSize: 11.0,
                          fontWeight:
                              isSelected ? FontWeight.w800 : FontWeight.w600,
                        ),
                      ),
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

  // ---------------------------------------------------------------------------
  // Section 3: Proposed Flagship Track Card
  // ---------------------------------------------------------------------------
  Widget _buildTrackCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(color: AppColors.cardBorder, width: 1.0),
        boxShadow: AppColors.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFormField(
            label: 'PROPOSED TRACK TITLE',
            controller: _trackTitleController,
            hintText: 'e.g. Adversarial Multi-Agent Swarm Defense',
            icon: Icons.auto_stories_rounded,
            validator: (v) => v == null || v.trim().isEmpty
                ? 'Track title is required'
                : null,
          ),
          const SizedBox(height: 16.0),
          const Text(
            'TARGET BUILDER TIER',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 10.5,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 8.0),
          Row(
            children: List.generate(_audienceTiers.length, (i) {
              final isSelected = _selectedAudienceIndex == i;
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    HapticFeedback.selectionClick();
                    setState(() => _selectedAudienceIndex = i);
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    margin: EdgeInsets.only(
                      right: i == _audienceTiers.length - 1 ? 0.0 : 6.0,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.bananiLavender
                          : AppColors.pureWhite,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.bananiPrimary
                            : const Color(0xFFE2E8F0),
                        width: isSelected ? 1.5 : 1.0,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        _audienceTiers[i],
                        style: TextStyle(
                          color: isSelected
                              ? AppColors.bananiPrimary
                              : const Color(0xFF64748B),
                          fontSize: 11.0,
                          fontWeight:
                              isSelected ? FontWeight.w800 : FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 16.0),
          const Text(
            'CURRICULUM SYNOPSIS & SPRINT ARCHITECTURE',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 10.5,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 6.0),
          TextFormField(
            controller: _trackSummaryController,
            maxLines: 4,
            style: const TextStyle(fontSize: 12.5, color: AppColors.deepInk),
            decoration: InputDecoration(
              hintText:
                  'Explain what students will construct, stress-test, and deploy across the 5 lab workflow steps...',
              hintStyle: const TextStyle(
                fontSize: 12.0,
                color: AppColors.searchHint,
              ),
              filled: true,
              fillColor: const Color(0xFFF8FAFC),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(
                    color: AppColors.bananiPrimary, width: 1.5),
              ),
              contentPadding: const EdgeInsets.all(12.0),
            ),
            validator: (v) => v == null || v.trim().length < 30
                ? 'Please provide at least a 30-character syllabus summary'
                : null,
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Section 4: Verified Credentials Card
  // ---------------------------------------------------------------------------
  Widget _buildCredentialsCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(color: AppColors.cardBorder, width: 1.0),
        boxShadow: AppColors.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ..._credentials.asMap().entries.map((entry) {
            final idx = entry.key;
            final cred = entry.value;
            return Container(
              margin: const EdgeInsets.only(bottom: 8.0),
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: const Color(0xFFE2E8F0), width: 1.0),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.check_circle_rounded,
                    size: 15.0,
                    color: Color(0xFF059669),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      cred,
                      style: const TextStyle(
                        color: AppColors.deepInk,
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _removeCredential(idx),
                    child: const Icon(
                      Icons.close_rounded,
                      size: 16.0,
                      color: Color(0xFF94A3B8),
                    ),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 8.0),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _newCredentialController,
                  style:
                      const TextStyle(fontSize: 12.0, color: AppColors.deepInk),
                  decoration: InputDecoration(
                    hintText: 'Add paper, patent, or open-source repo...',
                    hintStyle: const TextStyle(
                        fontSize: 11.5, color: AppColors.searchHint),
                    filled: true,
                    fillColor: const Color(0xFFF1F5F9),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onSubmitted: (_) => _addCredential(),
                ),
              ),
              const SizedBox(width: 8.0),
              ElevatedButton(
                onPressed: _addCredential,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.bananiPrimary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14.0, vertical: 11.0),
                ),
                child: const FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.add_rounded, size: 16.0),
                      SizedBox(width: 3.0),
                      Text(
                        'Add',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Section 5: Commitment & Ethics Card
  // ---------------------------------------------------------------------------
  Widget _buildCommitmentCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(color: AppColors.cardBorder, width: 1.0),
        boxShadow: AppColors.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'WEEKLY CREATOR TIME COMMITMENT',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 10.5,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 8.0),
          Row(
            children: List.generate(_commitments.length, (i) {
              final isSelected = _selectedCommitmentIndex == i;
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    HapticFeedback.selectionClick();
                    setState(() => _selectedCommitmentIndex = i);
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    margin: EdgeInsets.only(
                      right: i == _commitments.length - 1 ? 0.0 : 6.0,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFFF1F5F9)
                          : AppColors.pureWhite,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.deepInk
                            : const Color(0xFFE2E8F0),
                        width: isSelected ? 1.5 : 1.0,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        _commitments[i],
                        style: TextStyle(
                          color: isSelected
                              ? AppColors.deepInk
                              : const Color(0xFF64748B),
                          fontSize: 11.0,
                          fontWeight:
                              isSelected ? FontWeight.w800 : FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 16.0),
          GestureDetector(
            onTap: () {
              HapticFeedback.selectionClick();
              setState(() => _agreedToEthics = !_agreedToEthics);
            },
            behavior: HitTestBehavior.opaque,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 22.0,
                  height: 22.0,
                  child: Checkbox(
                    value: _agreedToEthics,
                    onChanged: (v) {
                      setState(() => _agreedToEthics = v ?? false);
                    },
                    activeColor: AppColors.bananiPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                const Expanded(
                  child: Text(
                    'I certify that all proposed sprint materials are original work and adhere to Young VIP Zero-Day Disclosure standards and Creator Code of Ethics.',
                    style: TextStyle(
                      color: Color(0xFF475569),
                      fontSize: 11.5,
                      height: 1.4,
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

  // ---------------------------------------------------------------------------
  // Submit Button
  // ---------------------------------------------------------------------------
  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 50.0,
      child: ElevatedButton(
        onPressed: _isSubmitting ? null : _handleSubmit,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.bananiPrimary,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
        child: _isSubmitting
            ? const SizedBox(
                width: 22.0,
                height: 22.0,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : const FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.send_rounded, size: 17.0),
                    SizedBox(width: 8.0),
                    Text(
                      'Submit Build Expert Application',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Success Confirmation Card
  // ---------------------------------------------------------------------------
  Widget _buildSuccessCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 36.0),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(color: const Color(0xFFA7F3D0), width: 1.5),
        boxShadow: AppColors.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 64.0,
            height: 64.0,
            decoration: const BoxDecoration(
              color: Color(0xFFE6F4EC),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_circle_rounded,
              size: 38.0,
              color: Color(0xFF059669),
            ),
          ),
          const SizedBox(height: 18.0),
          const Text(
            'Application Submitted!',
            style: TextStyle(
              color: AppColors.deepInk,
              fontSize: 22.0,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.4,
            ),
          ),
          const SizedBox(height: 6.0),
          const Text(
            'Your Build Expert application has been queued for peer review by the Young VIP Governance Council.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 13.0,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 20.0),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(14.0),
              border: Border.all(color: const Color(0xFFE2E8F0), width: 1.0),
            ),
            child: Column(
              children: [
                _buildSuccessDetailRow(
                  label: 'Application ID',
                  value: 'EXP-2026-COH4-891',
                  valueColor: AppColors.deepInk,
                  fontWeight: FontWeight.w800,
                ),
                const SizedBox(height: 8.0),
                _buildSuccessDetailRow(
                  label: 'Estimated Review Time',
                  value: '48 - 72 Hours',
                  valueColor: const Color(0xFF059669),
                  fontWeight: FontWeight.w800,
                ),
                const SizedBox(height: 8.0),
                _buildSuccessDetailRow(
                  label: 'Target Cohort Launch',
                  value: 'Cohort 4 · October 2026',
                  valueColor: AppColors.deepInk,
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24.0),
          SizedBox(
            width: double.infinity,
            height: 48.0,
            child: ElevatedButton(
              onPressed: () {
                HapticFeedback.mediumImpact();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ApplicationReviewStatusView(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.bananiPrimary,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.0),
                ),
              ),
              child: const FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.hourglass_top_rounded, size: 16.0),
                    SizedBox(width: 8.0),
                    Text(
                      'Track Application Review',
                      style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          SizedBox(
            width: double.infinity,
            height: 44.0,
            child: OutlinedButton(
              onPressed: () {
                HapticFeedback.lightImpact();
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const MainNavigationView(initialIndex: 0),
                    ),
                  );
                }
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.deepInk,
                side: const BorderSide(color: Color(0xFFCBD5E1), width: 1.2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.0),
                ),
              ),
              child: const Text(
                'Return to Platform',
                style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w800),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessDetailRow({
    required String label,
    required String value,
    required Color valueColor,
    required FontWeight fontWeight,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            label,
            style: const TextStyle(
              color: Color(0xFF64748B),
              fontSize: 11.5,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 8.0),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            value,
            style: TextStyle(
              color: valueColor,
              fontSize: 12.0,
              fontWeight: fontWeight,
            ),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Reusable Form Field Builder
  // ---------------------------------------------------------------------------
  Widget _buildFormField({
    required String label,
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 10.5,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.6,
          ),
        ),
        const SizedBox(height: 6.0),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          style: const TextStyle(fontSize: 12.5, color: AppColors.deepInk),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              fontSize: 12.0,
              color: AppColors.searchHint,
            ),
            prefixIcon: Icon(icon, size: 17.0, color: const Color(0xFF64748B)),
            filled: true,
            fillColor: const Color(0xFFF8FAFC),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(
                  color: AppColors.bananiPrimary, width: 1.5),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
          ),
          validator: validator,
        ),
      ],
    );
  }
}
