import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/theme/app_colors.dart';
import '../widgets/young_vip_wordmark.dart';
import 'main_navigation_view.dart';
import 'proposal_approval_status_view.dart';

class ProposeLabView extends StatefulWidget {
  const ProposeLabView({super.key});

  @override
  State<ProposeLabView> createState() => _ProposeLabViewState();
}

class _ProposeLabViewState extends State<ProposeLabView> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _titleController = TextEditingController(
    text: 'Adversarial Jailbreak Defense in Multi-Agent Swarms',
  );
  final _synopsisController = TextEditingController(
    text:
        'Builders deploy a resilient multi-agent architecture, inject stealthy indirect prompt payloads into vector contexts, diagnose token drift, and construct cryptographically verified canary guardrails.',
  );

  // 5-Stage Controllers
  final _stage1Controller = TextEditingController(
    text:
        'Build It: Deploy LangGraph multi-agent cluster with isolated memory pools and strict message schema validators.',
  );
  final _stage2Controller = TextEditingController(
    text:
        'Break It: Execute indirect prompt injection payload via poisoned external RAG documents to hijack sub-agent roles.',
  );
  final _stage3Controller = TextEditingController(
    text:
        'Understand It: Inspect state transition graph and token attention weights to isolate the exact compromised message node.',
  );
  final _stage4Controller = TextEditingController(
    text:
        'Advise Better: Generate automated client remediation advisory including canary signature proof and policy diffs.',
  );
  final _stage5Controller = TextEditingController(
    text:
        'Contextual Connection: Map attack surface to MITRE ATLAS matrix and NIST AI Risk Management Framework.',
  );

  final _newDependencyController = TextEditingController();

  // Selection states
  int _selectedDomainIndex = 0;
  int _selectedTierIndex = 1; // 0: Foundational, 1: Practitioner, 2: Architect
  int _selectedDurationIndex = 2; // 0: 45m, 1: 60m, 2: 90m, 3: 120m
  int _selectedComputeIndex = 1; // 0: Standard, 1: Dual A100, 2: Vector DB, 3: Swarm

  bool _agreedToEthics = true;
  bool _isSubmitting = false;
  bool _isSubmitted = false;

  final List<Map<String, dynamic>> _domains = const [
    {'name': 'Autonomous Agents', 'icon': Icons.psychology_rounded},
    {'name': 'LLM Defense & Safety', 'icon': Icons.security_rounded},
    {'name': 'RAG & Graphs', 'icon': Icons.hub_rounded},
    {'name': 'Multimodal AI', 'icon': Icons.visibility_rounded},
    {'name': 'Prompt Engineering', 'icon': Icons.auto_awesome_rounded},
  ];

  final List<String> _tiers = const [
    'Foundational',
    'Practitioner',
    'Master Architect',
  ];

  final List<String> _durations = const [
    '45 Min',
    '60 Min',
    '90 Min',
    '120 Min',
  ];

  final List<String> _computeEnvironments = const [
    'Standard Python Sandbox',
    'Dual A100 GPU Cluster',
    'Qdrant Vector DB Sandbox',
    'Multi-Agent Isolated Swarm',
  ];

  final List<String> _dependencies = [
    'langgraph>=0.2.14',
    'vllm>=0.6.2',
    'guardrails-ai>=0.5.1',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _synopsisController.dispose();
    _stage1Controller.dispose();
    _stage2Controller.dispose();
    _stage3Controller.dispose();
    _stage4Controller.dispose();
    _stage5Controller.dispose();
    _newDependencyController.dispose();
    super.dispose();
  }

  void _addDependency() {
    final text = _newDependencyController.text.trim();
    if (text.isNotEmpty) {
      HapticFeedback.lightImpact();
      setState(() {
        _dependencies.add(text);
        _newDependencyController.clear();
      });
    }
  }

  void _removeDependency(int index) {
    HapticFeedback.lightImpact();
    setState(() {
      _dependencies.removeAt(index);
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
            'Please accept the Lab Creator Guidelines & Ethics standards.',
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
                          const SizedBox(height: 18.0),
                          _buildSectionTitle(
                            stepNumber: '01',
                            title: 'Core Lab Parameters',
                            subtitle:
                                'Title, domain specialty, target tier, and time allocation',
                          ),
                          const SizedBox(height: 12.0),
                          _buildCoreParametersCard(),
                          const SizedBox(height: 22.0),
                          _buildSectionTitle(
                            stepNumber: '02',
                            title: 'Problem Statement & Synopsis',
                            subtitle:
                                'The architectural objective builders will master',
                          ),
                          const SizedBox(height: 12.0),
                          _buildSynopsisCard(),
                          const SizedBox(height: 22.0),
                          _buildSectionTitle(
                            stepNumber: '03',
                            title: '5-Stage Workflow Curriculum',
                            subtitle:
                                'Detailed specifications across the Young VIP learning cycle',
                          ),
                          const SizedBox(height: 12.0),
                          _buildFiveStagesCard(),
                          const SizedBox(height: 22.0),
                          _buildSectionTitle(
                            stepNumber: '04',
                            title: 'Sandbox Compute & Runtime',
                            subtitle:
                                'Environment image, GPU provisioning, and pip dependencies',
                          ),
                          const SizedBox(height: 12.0),
                          _buildSandboxSpecsCard(),
                          const SizedBox(height: 22.0),
                          _buildSectionTitle(
                            stepNumber: '05',
                            title: 'Author Compliance',
                            subtitle:
                                'Zero-Day disclosure agreement and platform ethics',
                          ),
                          const SizedBox(height: 12.0),
                          _buildComplianceCard(),
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
                      builder: (_) => const MainNavigationView(initialIndex: 0),
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
                color: AppColors.bananiLavender,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: const Color(0xFFDDD6FE),
                  width: 1.0,
                ),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.science_outlined,
                    size: 11.0,
                    color: AppColors.bananiPrimary,
                  ),
                  SizedBox(width: 5.0),
                  Text(
                    'LAB PROPOSALS · COHORT 4',
                    style: TextStyle(
                      color: AppColors.bananiPrimary,
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
                  Icons.auto_stories_outlined,
                  size: 13.0,
                  color: AppColors.bananiPrimary,
                ),
                SizedBox(width: 5.0),
                Text(
                  'EXPERT STUDIO · AUTHORING',
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
          'Propose a New Lab',
          style: TextStyle(
            color: AppColors.deepInk,
            fontSize: 22.0,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.5,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 6.0),
        const Text(
          'Submit a structured 5-stage interactive lab proposal for review by the Young VIP Governance Council. Approved labs receive dedicated GPU sandboxes and 70% revenue royalties.',
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
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.3,
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
  // Section 01: Core Parameters Card
  // ---------------------------------------------------------------------------
  Widget _buildCoreParametersCard() {
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
          // Lab Title
          _buildInputLabel('LAB TITLE'),
          const SizedBox(height: 6.0),
          TextFormField(
            controller: _titleController,
            style: const TextStyle(fontSize: 13.0, color: AppColors.deepInk),
            decoration: InputDecoration(
              hintText: 'e.g. Adversarial Jailbreak Defense in Multi-Agent Swarms',
              hintStyle: const TextStyle(
                fontSize: 12.0,
                color: AppColors.searchHint,
              ),
              prefixIcon: const Icon(Icons.title_rounded,
                  size: 17.0, color: Color(0xFF64748B)),
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
            validator: (v) => v == null || v.trim().length < 8
                ? 'Please provide a descriptive title (min 8 chars)'
                : null,
          ),
          const SizedBox(height: 16.0),

          // Primary Domain Specialty
          _buildInputLabel('PRIMARY DOMAIN SPECIALTY'),
          const SizedBox(height: 8.0),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: List.generate(_domains.length, (index) {
              final domain = _domains[index];
              final isSelected = _selectedDomainIndex == index;

              return GestureDetector(
                onTap: () {
                  HapticFeedback.selectionClick();
                  setState(() => _selectedDomainIndex = index);
                },
                behavior: HitTestBehavior.opaque,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 7.0),
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
          const SizedBox(height: 16.0),

          // Target Builder Audience Tier
          _buildInputLabel('TARGET AUDIENCE TIER'),
          const SizedBox(height: 8.0),
          Row(
            children: List.generate(_tiers.length, (i) {
              final isSelected = _selectedTierIndex == i;
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    HapticFeedback.selectionClick();
                    setState(() => _selectedTierIndex = i);
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    margin: EdgeInsets.only(
                      right: i == _tiers.length - 1 ? 0.0 : 6.0,
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
                        _tiers[i],
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

          // Estimated Duration
          _buildInputLabel('ESTIMATED LAB DURATION'),
          const SizedBox(height: 8.0),
          Row(
            children: List.generate(_durations.length, (i) {
              final isSelected = _selectedDurationIndex == i;
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    HapticFeedback.selectionClick();
                    setState(() => _selectedDurationIndex = i);
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    margin: EdgeInsets.only(
                      right: i == _durations.length - 1 ? 0.0 : 6.0,
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
                        _durations[i],
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
  // Section 02: Synopsis Card
  // ---------------------------------------------------------------------------
  Widget _buildSynopsisCard() {
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
          _buildInputLabel('LAB OVERVIEW & CORE PROBLEM STATEMENT'),
          const SizedBox(height: 6.0),
          TextFormField(
            controller: _synopsisController,
            maxLines: 4,
            style: const TextStyle(fontSize: 12.5, color: AppColors.deepInk),
            decoration: InputDecoration(
              hintText:
                  'Explain what builders will construct, what failure mode they will diagnose, and the practical value...',
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
                ? 'Please provide a comprehensive summary (min 30 characters)'
                : null,
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Section 03: 5-Stage Workflow Curriculum Card
  // ---------------------------------------------------------------------------
  Widget _buildFiveStagesCard() {
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
          _buildStageInputField(
            stageNumber: '01',
            stageName: 'BUILD IT',
            stageSubtitle: 'Architecture & Initial Configuration',
            controller: _stage1Controller,
            icon: Icons.construction_rounded,
          ),
          const SizedBox(height: 14.0),
          _buildStageInputField(
            stageNumber: '02',
            stageName: 'BREAK IT',
            stageSubtitle: 'Vulnerability Injection & Exploitation',
            controller: _stage2Controller,
            icon: Icons.bug_report_outlined,
          ),
          const SizedBox(height: 14.0),
          _buildStageInputField(
            stageNumber: '03',
            stageName: 'UNDERSTAND IT',
            stageSubtitle: 'Root Cause Diagnostics & Forensics',
            controller: _stage3Controller,
            icon: Icons.psychology_rounded,
          ),
          const SizedBox(height: 14.0),
          _buildStageInputField(
            stageNumber: '04',
            stageName: 'ADVISE BETTER',
            stageSubtitle: 'Client Advisory & Remediation Report',
            controller: _stage4Controller,
            icon: Icons.record_voice_over_rounded,
          ),
          const SizedBox(height: 14.0),
          _buildStageInputField(
            stageNumber: '05',
            stageName: 'CONTEXTUAL CONNECTION',
            stageSubtitle: 'Systemic Taxonomy & Standards Mapping',
            controller: _stage5Controller,
            icon: Icons.hub_outlined,
          ),
        ],
      ),
    );
  }

  Widget _buildStageInputField({
    required String stageNumber,
    required String stageName,
    required String stageSubtitle,
    required TextEditingController controller,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.5),
              decoration: BoxDecoration(
                color: AppColors.deepInk,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Text(
                'STAGE $stageNumber',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 9.0,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            Icon(icon, size: 14.0, color: AppColors.bananiPrimary),
            const SizedBox(width: 5.0),
            Expanded(
              child: Text(
                '$stageName — $stageSubtitle',
                style: const TextStyle(
                  color: AppColors.deepInk,
                  fontSize: 11.5,
                  fontWeight: FontWeight.w800,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        TextFormField(
          controller: controller,
          maxLines: 2,
          style: const TextStyle(fontSize: 12.0, color: AppColors.deepInk),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFF8FAFC),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                  color: AppColors.bananiPrimary, width: 1.5),
            ),
            contentPadding: const EdgeInsets.all(10.0),
          ),
          validator: (v) => v == null || v.trim().length < 15
              ? 'Please describe this stage (min 15 characters)'
              : null,
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Section 04: Sandbox & Runtime Specs Card
  // ---------------------------------------------------------------------------
  Widget _buildSandboxSpecsCard() {
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
          _buildInputLabel('PRE-PROVISIONED CLOUD COMPUTE CLUSTER'),
          const SizedBox(height: 8.0),
          Column(
            children: List.generate(_computeEnvironments.length, (i) {
              final isSelected = _selectedComputeIndex == i;
              return GestureDetector(
                onTap: () {
                  HapticFeedback.selectionClick();
                  setState(() => _selectedComputeIndex = i);
                },
                behavior: HitTestBehavior.opaque,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 6.0),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 10.0),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFFF1F5F9)
                        : const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.bananiPrimary
                          : const Color(0xFFE2E8F0),
                      width: isSelected ? 1.5 : 1.0,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isSelected
                            ? Icons.radio_button_checked_rounded
                            : Icons.radio_button_unchecked_rounded,
                        size: 16.0,
                        color: isSelected
                            ? AppColors.bananiPrimary
                            : const Color(0xFF94A3B8),
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: Text(
                          _computeEnvironments[i],
                          style: TextStyle(
                            color: isSelected
                                ? AppColors.deepInk
                                : const Color(0xFF475569),
                            fontSize: 12.0,
                            fontWeight:
                                isSelected ? FontWeight.w800 : FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 14.0),

          _buildInputLabel('CUSTOM RUNTIME PIP DEPENDENCIES'),
          const SizedBox(height: 6.0),
          ..._dependencies.asMap().entries.map((entry) {
            final idx = entry.key;
            final dep = entry.value;
            return Container(
              margin: const EdgeInsets.only(bottom: 6.0),
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 7.0),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: const Color(0xFFE2E8F0), width: 1.0),
              ),
              child: Row(
                children: [
                  const Icon(Icons.code_rounded,
                      size: 14.0, color: AppColors.bananiPrimary),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      dep,
                      style: const TextStyle(
                        color: AppColors.deepInk,
                        fontSize: 11.5,
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _removeDependency(idx),
                    child: const Icon(
                      Icons.close_rounded,
                      size: 15.0,
                      color: Color(0xFF94A3B8),
                    ),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 6.0),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _newDependencyController,
                  style: const TextStyle(
                      fontSize: 12.0,
                      color: AppColors.deepInk,
                      fontFamily: 'monospace'),
                  decoration: InputDecoration(
                    hintText: 'e.g. transformers>=4.40.0',
                    hintStyle: const TextStyle(
                        fontSize: 11.5, color: AppColors.searchHint),
                    filled: true,
                    fillColor: const Color(0xFFF1F5F9),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 9.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onSubmitted: (_) => _addDependency(),
                ),
              ),
              const SizedBox(width: 8.0),
              ElevatedButton(
                onPressed: _addDependency,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.bananiPrimary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 10.0),
                ),
                child: const FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.add_rounded, size: 15.0),
                      SizedBox(width: 3.0),
                      Text(
                        'Add',
                        style: TextStyle(
                          fontSize: 11.5,
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
  // Section 05: Compliance Card
  // ---------------------------------------------------------------------------
  Widget _buildComplianceCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(color: AppColors.cardBorder, width: 1.0),
        boxShadow: AppColors.softShadow,
      ),
      child: GestureDetector(
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
                'I certify that this lab proposal contains original educational architecture, complies with Young VIP safety disclosure standards, and will not introduce malicious uncontained payloads into student compute nodes.',
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
                      'Submit Lab Proposal',
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
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 32.0),
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
          const SizedBox(height: 16.0),
          const Text(
            'Lab Proposal Submitted!',
            style: TextStyle(
              color: AppColors.deepInk,
              fontSize: 22.0,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.4,
            ),
          ),
          const SizedBox(height: 6.0),
          const Text(
            'Your lab architecture has been successfully queued for technical evaluation by the Young VIP Governance Council.',
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
                  label: 'Proposal ID',
                  value: 'PROP-LAB-2026-904',
                  valueColor: AppColors.deepInk,
                  fontWeight: FontWeight.w800,
                ),
                const SizedBox(height: 8.0),
                _buildSuccessDetailRow(
                  label: 'Evaluation Window',
                  value: '24 - 48 Hours',
                  valueColor: const Color(0xFF059669),
                  fontWeight: FontWeight.w800,
                ),
                const SizedBox(height: 8.0),
                _buildSuccessDetailRow(
                  label: 'Proposed Compute',
                  value: _computeEnvironments[_selectedComputeIndex],
                  valueColor: AppColors.deepInk,
                  fontWeight: FontWeight.w700,
                ),
                const SizedBox(height: 8.0),
                _buildSuccessDetailRow(
                  label: 'Assigned Council',
                  value: 'Expert Studio Technical Fellows',
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
                    builder: (_) => ProposalApprovalStatusView(
                      proposalId: 'PROP-LAB-2026-904',
                      labTitle: _titleController.text.trim().isNotEmpty
                          ? _titleController.text.trim()
                          : 'Adversarial Jailbreak Defense in Multi-Agent Swarms',
                    ),
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
                      'Track Proposal Status',
                      style: TextStyle(
                          fontSize: 13.5, fontWeight: FontWeight.w800),
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
        Expanded(
          flex: 4,
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
        Expanded(
          flex: 5,
          child: Align(
            alignment: Alignment.centerRight,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                value,
                style: TextStyle(
                  color: valueColor,
                  fontSize: 11.5,
                  fontWeight: fontWeight,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInputLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        color: AppColors.textSecondary,
        fontSize: 10.5,
        fontWeight: FontWeight.w800,
        letterSpacing: 0.6,
      ),
    );
  }
}
