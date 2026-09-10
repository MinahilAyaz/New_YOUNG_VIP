import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/theme/app_colors.dart';
import '../widgets/young_vip_wordmark.dart';
import 'lab_preview_view.dart';
import 'main_navigation_view.dart';

class LabBuilderView extends StatefulWidget {
  final String labId;
  final String initialTitle;
  final String domainTrack;

  const LabBuilderView({
    super.key,
    this.labId = 'LAB-BLD-2026-904',
    this.initialTitle = 'Adversarial Jailbreak Defense in Multi-Agent Swarms',
    this.domainTrack = 'Autonomous Agents & LLM Safety',
  });

  @override
  State<LabBuilderView> createState() => _LabBuilderViewState();
}

class _LabBuilderViewState extends State<LabBuilderView> {
  // Current active main tab: 0: Curriculum (5 Stages), 1: Code & Sandbox, 2: Canary Evals, 3: Settings
  int _selectedMainTab = 0;

  // Selected stage in Curriculum (0: Build It, 1: Break It, 2: Understand It, 3: Advise Better, 4: Contextual Connection)
  int _selectedStageIndex = 0;

  // Form & Text Controllers
  late final TextEditingController _titleController;
  final _objectiveController = TextEditingController(
    text:
        'Construct an isolated multi-agent cluster, simulate an indirect prompt injection via poisoned RAG chunks, analyze attention drift, and deploy an automated cryptographic canary firewall.',
  );
  final _challengePromptController = TextEditingController(
    text:
        'Builders must inspect the memory state graph of Sub-Agent B, detect unauthorized tool invocation, and implement token-level boundary isolation before the canary payload executes.',
  );
  final _assertionCodeController = TextEditingController(
    text:
        'def test_canary_defense():\n    cluster = init_swarm(isolated=True)\n    result = cluster.inject_payload(adversarial_rag_doc)\n    assert result.canary_triggered == True\n    assert result.tool_hijacked == False\n    assert result.token_firewall_status == "ISOLATED"',
  );
  final _newPackageController = TextEditingController();

  final List<String> _packages = [
    'langgraph>=0.2.14',
    'vllm>=0.6.2',
    'guardrails-ai>=0.5.1',
    'qdrant-client>=1.9.0',
  ];

  final List<String> _hints = [
    'Inspect the message schema validation interceptor in the cluster gateway.',
    'Ensure sub-agents do not inherit unrestricted filesystem tool handles.',
    'Use HMAC signed canary tokens in vector retrieval context metadata.',
  ];

  bool _isSaving = false;
  bool _isTestRunning = false;
  String _testRunOutput = '';
  bool _hasRanTest = false;

  final List<Map<String, dynamic>> _stages = const [
    {
      'number': '01',
      'name': 'Build It',
      'subtitle': 'System Architecture & Swarm Deployment',
      'icon': Icons.construction_rounded,
      'badge': 'FOUNDATION',
    },
    {
      'number': '02',
      'name': 'Break It',
      'subtitle': 'Vulnerability & Poisoned RAG Exploit',
      'icon': Icons.bug_report_outlined,
      'badge': 'EXPLOIT',
    },
    {
      'number': '03',
      'name': 'Understand It',
      'subtitle': 'State DAG Forensics & Token Drift',
      'icon': Icons.psychology_rounded,
      'badge': 'DIAGNOSTICS',
    },
    {
      'number': '04',
      'name': 'Advise Better',
      'subtitle': 'Remediation Advisory & Canary Proof',
      'icon': Icons.record_voice_over_rounded,
      'badge': 'ADVISORY',
    },
    {
      'number': '05',
      'name': 'Contextual Connection',
      'subtitle': 'MITRE ATLAS & Enterprise Policy',
      'icon': Icons.hub_outlined,
      'badge': 'MAPPING',
    },
  ];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTitle);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _objectiveController.dispose();
    _challengePromptController.dispose();
    _assertionCodeController.dispose();
    _newPackageController.dispose();
    super.dispose();
  }

  Future<void> _handleSaveDraft() async {
    HapticFeedback.lightImpact();
    setState(() => _isSaving = true);
    await Future.delayed(const Duration(milliseconds: 600));
    if (mounted) {
      setState(() => _isSaving = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle_rounded,
                  color: Colors.white, size: 18.0),
              const SizedBox(width: 8.0),
              Flexible(
                child: Text(
                  'Lab content draft saved (${widget.labId})',
                  style: const TextStyle(
                      fontSize: 12.5, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          backgroundColor: const Color(0xFF059669),
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _handleRunSandboxTest() async {
    HapticFeedback.mediumImpact();
    setState(() {
      _isTestRunning = true;
      _hasRanTest = false;
      _testRunOutput = 'Booting Docker container on NVIDIA A100 (80GB)...\n';
    });

    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;
    setState(() {
      _testRunOutput +=
          'Installing dependencies: langgraph, vllm, guardrails-ai...\n';
    });

    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;
    setState(() {
      _testRunOutput +=
          'Executing test suite test_canary_defense()...\n'
          '[PASS] Test 1: Clean LangGraph swarm init (210ms)\n'
          '[PASS] Test 2: Injected adversarial RAG vector canary (440ms)\n'
          '[PASS] Test 3: Token firewall containment verified (180ms)\n'
          'Result: 3 passed, 0 failed in 0.83s. ZERO HOST ESCAPE DETECTED.';
      _isTestRunning = false;
      _hasRanTest = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.verified_rounded, color: Colors.white, size: 18.0),
            SizedBox(width: 8.0),
            Flexible(
              child: Text(
                'Sandbox verification passed (3/3 tests passed)',
                style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF059669),
        behavior: SnackBarBehavior.floating,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showPublishModal() {
    HapticFeedback.mediumImpact();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 24.0),
          decoration: const BoxDecoration(
            color: AppColors.pureWhite,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
            boxShadow: [
              BoxShadow(
                color: Color(0x1A000000),
                blurRadius: 24.0,
                offset: Offset(0, -6),
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 36.0,
                    height: 4.0,
                    margin: const EdgeInsets.only(bottom: 18.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFCBD5E1),
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: 44.0,
                      height: 44.0,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE6F4EC),
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      child: const Icon(
                        Icons.rocket_launch_rounded,
                        color: Color(0xFF059669),
                        size: 24.0,
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Publish Lab to Live Catalog',
                            style: TextStyle(
                              color: AppColors.deepInk,
                              fontSize: 16.5,
                              fontWeight: FontWeight.w900,
                              letterSpacing: -0.3,
                            ),
                          ),
                          Text(
                            'Deploy content to VIP builders and weekly sprint rooms',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 11.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18.0),
                Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(12.0),
                    border:
                        Border.all(color: const Color(0xFFE2E8F0), width: 1.0),
                  ),
                  child: const Column(
                    children: [
                      _PublishDetailRow(
                        label: 'Lab Version',
                        value: 'v1.2.0 · Production Ready',
                      ),
                      SizedBox(height: 6.0),
                      _PublishDetailRow(
                        label: 'Allocated Sandbox',
                        value: 'Dual A100 GPU (80GB VRAM)',
                      ),
                      SizedBox(height: 6.0),
                      _PublishDetailRow(
                        label: 'Revenue Share Escrow',
                        value: '70% Active (Stripe Connect)',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                SizedBox(
                  width: double.infinity,
                  height: 48.0,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Lab published to catalog! Live compute nodes provisioned.'),
                          backgroundColor: Color(0xFF059669),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF059669),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                    ),
                    child: const Text(
                      'Confirm & Publish to Network',
                      style: TextStyle(
                          fontSize: 13.5, fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () => Navigator.pop(ctx),
                    child: const Text(
                      'Keep in Draft Mode',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _addPackage() {
    final text = _newPackageController.text.trim();
    if (text.isNotEmpty && !_packages.contains(text)) {
      HapticFeedback.lightImpact();
      setState(() {
        _packages.add(text);
        _newPackageController.clear();
      });
    }
  }

  void _removePackage(int index) {
    HapticFeedback.lightImpact();
    setState(() => _packages.removeAt(index));
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
            constraints: const BoxConstraints(maxWidth: 820.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTopBar(context),
                  const SizedBox(height: 18.0),
                  _buildHeroHeader(),
                  const SizedBox(height: 16.0),
                  _buildMainTabBar(),
                  const SizedBox(height: 18.0),
                  _buildActiveTabContent(),
                  const SizedBox(height: 24.0),
                  _buildBottomActionButtons(),
                  const SizedBox(height: 48.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Top Navigation Bar
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
        // Version & Save Status Badge
        Flexible(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerRight,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: const Color(0xFFE2E8F0),
                  width: 1.0,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 7.0,
                    height: 7.0,
                    decoration: const BoxDecoration(
                      color: Color(0xFF059669),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6.0),
                  Text(
                    '${widget.labId} · DRAFT v1.2',
                    style: const TextStyle(
                      color: AppColors.deepInk,
                      fontSize: 10.5,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'monospace',
                      letterSpacing: 0.5,
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 9.0, vertical: 4.5),
                    decoration: BoxDecoration(
                      color: AppColors.bananiLavender,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.architecture_rounded,
                          size: 13.0,
                          color: AppColors.bananiPrimary,
                        ),
                        SizedBox(width: 5.0),
                        Text(
                          'LAB BUILDER · AUTHORING ENGINE',
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
              ),
            ),
            const SizedBox(width: 8.0),
            // Save Draft quick button
            GestureDetector(
              onTap: _isSaving ? null : _handleSaveDraft,
              behavior: HitTestBehavior.opaque,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                decoration: BoxDecoration(
                  color: AppColors.pureWhite,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: AppColors.cardBorder,
                    width: 1.0,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _isSaving
                        ? const SizedBox(
                            width: 11.0,
                            height: 11.0,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.0,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  AppColors.bananiPrimary),
                            ),
                          )
                        : const Icon(
                            Icons.save_outlined,
                            size: 13.0,
                            color: AppColors.deepInk,
                          ),
                    const SizedBox(width: 4.0),
                    Text(
                      _isSaving ? 'Saving...' : 'Save Draft',
                      style: const TextStyle(
                        color: AppColors.deepInk,
                        fontSize: 11.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        // Editable Title Box
        TextField(
          controller: _titleController,
          style: const TextStyle(
            color: AppColors.deepInk,
            fontSize: 20.0,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.4,
            height: 1.25,
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            isDense: true,
            contentPadding: EdgeInsets.zero,
            suffixIcon: Icon(Icons.edit_note_rounded,
                size: 20.0, color: AppColors.textSecondary),
            suffixIconConstraints: BoxConstraints(),
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          'Track: ${widget.domainTrack} · Level: Master Architect · 90m Active Sandbox',
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 12.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Main Tab Selector (Curriculum, Code/Sandbox, Canary Evals, Settings)
  // ---------------------------------------------------------------------------
  Widget _buildMainTabBar() {
    final tabs = [
      {'label': 'Curriculum', 'icon': Icons.view_timeline_rounded},
      {'label': 'Code & Sandbox', 'icon': Icons.code_rounded},
      {'label': 'Canary Evals', 'icon': Icons.security_rounded},
      {'label': 'Settings', 'icon': Icons.tune_rounded},
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: const Color(0xFFE2E8F0),
        borderRadius: BorderRadius.circular(14.0),
      ),
      child: Row(
        children: List.generate(tabs.length, (idx) {
          final isSelected = _selectedMainTab == idx;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                HapticFeedback.selectionClick();
                setState(() => _selectedMainTab = idx);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.pureWhite : Colors.transparent,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: isSelected
                      ? [
                          const BoxShadow(
                            color: Color(0x14000000),
                            blurRadius: 4.0,
                            offset: Offset(0, 1),
                          ),
                        ]
                      : null,
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        tabs[idx]['icon'] as IconData,
                        size: 13.0,
                        color: isSelected
                            ? AppColors.deepInk
                            : const Color(0xFF64748B),
                      ),
                      const SizedBox(width: 4.0),
                      Text(
                        tabs[idx]['label'] as String,
                        style: TextStyle(
                          color: isSelected
                              ? AppColors.deepInk
                              : const Color(0xFF64748B),
                          fontSize: 11.5,
                          fontWeight:
                              isSelected ? FontWeight.w800 : FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Active Tab Content Router
  // ---------------------------------------------------------------------------
  Widget _buildActiveTabContent() {
    switch (_selectedMainTab) {
      case 0:
        return _buildCurriculumTab();
      case 1:
        return _buildCodeSandboxTab();
      case 2:
        return _buildCanaryEvalsTab();
      case 3:
      default:
        return _buildSettingsTab();
    }
  }

  // ---------------------------------------------------------------------------
  // TAB 0: 5-Stage Curriculum Content Editor
  // ---------------------------------------------------------------------------
  Widget _buildCurriculumTab() {
    final activeStage = _stages[_selectedStageIndex];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Horizontal Stage Stepper Chips
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: List.generate(_stages.length, (idx) {
              final stage = _stages[idx];
              final isSelected = _selectedStageIndex == idx;
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: GestureDetector(
                  onTap: () {
                    HapticFeedback.selectionClick();
                    setState(() => _selectedStageIndex = idx);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 7.0),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.deepInk
                          : AppColors.pureWhite,
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.deepInk
                            : AppColors.cardBorder,
                        width: 1.0,
                      ),
                      boxShadow: AppColors.softShadow,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          stage['icon'] as IconData,
                          size: 13.0,
                          color: isSelected ? Colors.white : AppColors.deepInk,
                        ),
                        const SizedBox(width: 5.0),
                        Text(
                          'Stage ${stage['number']}: ${stage['name']}',
                          style: TextStyle(
                            color:
                                isSelected ? Colors.white : AppColors.deepInk,
                            fontSize: 11.5,
                            fontWeight: isSelected
                                ? FontWeight.w800
                                : FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        const SizedBox(height: 16.0),

        // Active Stage Header Card
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: AppColors.pureWhite,
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: AppColors.cardBorder, width: 1.0),
            boxShadow: AppColors.softShadow,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          width: 32.0,
                          height: 32.0,
                          decoration: BoxDecoration(
                            color: AppColors.bananiLavender,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Icon(
                            activeStage['icon'] as IconData,
                            color: AppColors.bananiPrimary,
                            size: 16.0,
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Stage ${activeStage['number']} · ${activeStage['name']}',
                                style: const TextStyle(
                                  color: AppColors.deepInk,
                                  fontSize: 14.5,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: -0.3,
                                ),
                              ),
                              Text(
                                activeStage['subtitle'] as String,
                                style: const TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 11.0,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Flexible(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 3.5),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: Text(
                          activeStage['badge'] as String,
                          style: const TextStyle(
                            color: Color(0xFF475569),
                            fontSize: 10.0,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),

              // Section: Stage Objective
              const Text(
                'Stage Educational Objective',
                style: TextStyle(
                  color: AppColors.deepInk,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 6.0),
              TextField(
                controller: _objectiveController,
                maxLines: 2,
                style:
                    const TextStyle(color: AppColors.deepInk, fontSize: 12.0),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFF8FAFC),
                  contentPadding: const EdgeInsets.all(12.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide:
                        const BorderSide(color: Color(0xFFE2E8F0), width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide:
                        const BorderSide(color: Color(0xFFE2E8F0), width: 1.0),
                  ),
                ),
              ),
              const SizedBox(height: 14.0),

              // Section: Student Challenge Task
              const Text(
                'Student Task & Instructions',
                style: TextStyle(
                  color: AppColors.deepInk,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 6.0),
              TextField(
                controller: _challengePromptController,
                maxLines: 2,
                style:
                    const TextStyle(color: AppColors.deepInk, fontSize: 12.0),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFF8FAFC),
                  contentPadding: const EdgeInsets.all(12.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide:
                        const BorderSide(color: Color(0xFFE2E8F0), width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide:
                        const BorderSide(color: Color(0xFFE2E8F0), width: 1.0),
                  ),
                ),
              ),
              const SizedBox(height: 14.0),

              // Section: Starter Code / Canary Assertion Script
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Text(
                      'Sandbox Assertion Script (Python)',
                      style: TextStyle(
                        color: AppColors.deepInk,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w800,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7.0, vertical: 2.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF6FF),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: const Text(
                        'pytest runner',
                        style: TextStyle(
                          color: Color(0xFF2563EB),
                          fontSize: 10.0,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6.0),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF0F172A),
                  borderRadius: BorderRadius.circular(12.0),
                  border:
                      Border.all(color: const Color(0xFF1E293B), width: 1.0),
                ),
                child: TextField(
                  controller: _assertionCodeController,
                  maxLines: 6,
                  style: const TextStyle(
                    color: Color(0xFF38BDF8),
                    fontSize: 11.5,
                    fontFamily: 'monospace',
                    height: 1.45,
                  ),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(14.0),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 14.0),

              // Hints Section
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Builder Scaffolding Hints (3)',
                      style: TextStyle(
                        color: AppColors.deepInk,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w800,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: 8.0),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'Unlocks after 5m',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 11.0,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Column(
                children: List.generate(_hints.length, (idx) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 6.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 8.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                            color: const Color(0xFFE2E8F0), width: 1.0),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 1.5),
                            decoration: BoxDecoration(
                              color: AppColors.bananiLavender,
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Text(
                              'H${idx + 1}',
                              style: const TextStyle(
                                color: AppColors.bananiPrimary,
                                fontSize: 9.5,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Expanded(
                            child: Text(
                              _hints[idx],
                              style: const TextStyle(
                                color: Color(0xFF334155),
                                fontSize: 11.0,
                                height: 1.35,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // TAB 1: Code & Sandbox Runtime Settings
  // ---------------------------------------------------------------------------
  Widget _buildCodeSandboxTab() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: AppColors.cardBorder, width: 1.0),
        boxShadow: AppColors.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Sandbox Hardware Profile',
            style: TextStyle(
              color: AppColors.deepInk,
              fontSize: 13.5,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 10.0),
          _buildSandboxProfileTile(
            title: 'Dual NVIDIA A100 GPU (80GB VRAM)',
            subtitle: 'Isolated Kubernetes pod · High throughput vLLM',
            icon: Icons.memory_rounded,
            isSelected: true,
          ),
          const SizedBox(height: 8.0),
          _buildSandboxProfileTile(
            title: 'Standard Python Compute (4 vCPU · 16GB)',
            subtitle: 'Fast boot lightweight cluster for deterministic scripts',
            icon: Icons.developer_board_rounded,
            isSelected: false,
          ),
          const SizedBox(height: 16.0),

          const Divider(color: Color(0xFFF1F5F9), height: 1.0),
          const SizedBox(height: 16.0),

          // Python Dependencies
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text(
                  'Runtime Pip Dependencies',
                  style: TextStyle(
                    color: AppColors.deepInk,
                    fontSize: 13.0,
                    fontWeight: FontWeight.w800,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8.0),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  '${_packages.length} installed',
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 11.0,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Wrap(
            spacing: 6.0,
            runSpacing: 6.0,
            children: List.generate(_packages.length, (idx) {
              return Chip(
                label: Text(
                  _packages[idx],
                  style: const TextStyle(
                    fontSize: 11.0,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w700,
                    color: AppColors.deepInk,
                  ),
                ),
                deleteIcon: const Icon(Icons.close_rounded, size: 13.0),
                onDeleted: () => _removePackage(idx),
                backgroundColor: const Color(0xFFF1F5F9),
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
              );
            }),
          ),
          const SizedBox(height: 10.0),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _newPackageController,
                  style: const TextStyle(
                      fontSize: 12.0, fontFamily: 'monospace'),
                  decoration: InputDecoration(
                    hintText: 'e.g. transformers>=4.40.0',
                    hintStyle: const TextStyle(
                        fontSize: 11.5, color: AppColors.searchHint),
                    filled: true,
                    fillColor: const Color(0xFFF8FAFC),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 8.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                    ),
                  ),
                  onSubmitted: (_) => _addPackage(),
                ),
              ),
              const SizedBox(width: 8.0),
              ElevatedButton(
                onPressed: _addPackage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.bananiPrimary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14.0, vertical: 10.0),
                ),
                child: const Text('Add',
                    style:
                        TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSandboxProfileTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isSelected,
  }) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFF5F3FF) : const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: isSelected
              ? AppColors.bananiPrimary
              : const Color(0xFFE2E8F0),
          width: isSelected ? 1.5 : 1.0,
        ),
      ),
      child: Row(
        children: [
          Icon(icon,
              size: 20.0,
              color: isSelected
                  ? AppColors.bananiPrimary
                  : const Color(0xFF64748B)),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: AppColors.deepInk,
                    fontSize: 12.5,
                    fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 11.0,
                  ),
                ),
              ],
            ),
          ),
          if (isSelected)
            const Icon(Icons.check_circle_rounded,
                size: 16.0, color: AppColors.bananiPrimary),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // TAB 2: Canary & Automated Stress-Test Evals
  // ---------------------------------------------------------------------------
  Widget _buildCanaryEvalsTab() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: AppColors.cardBorder, width: 1.0),
        boxShadow: AppColors.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Live Sandbox Stress-Test Runner',
                      style: TextStyle(
                        color: AppColors.deepInk,
                        fontSize: 13.5,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      'Simulate student execution & adversarial canary verification',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 11.0,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8.0),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: ElevatedButton.icon(
                  onPressed: _isTestRunning ? null : _handleRunSandboxTest,
                  icon: _isTestRunning
                      ? const SizedBox(
                          width: 12.0,
                          height: 12.0,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.0,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Icon(Icons.play_arrow_rounded, size: 16.0),
                  label: Text(
                    _isTestRunning ? 'Testing...' : 'Run Suite',
                    style: const TextStyle(
                        fontSize: 11.5, fontWeight: FontWeight.w800),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.bananiPrimary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 8.0),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14.0),

          // Output Terminal
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: const Color(0xFF0F172A),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: const Color(0xFF1E293B)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.terminal_rounded,
                              size: 13.0, color: Color(0xFF94A3B8)),
                          SizedBox(width: 5.0),
                          Flexible(
                            child: Text(
                              'A100 RUNTIME LOG',
                              style: TextStyle(
                                color: Color(0xFF94A3B8),
                                fontSize: 10.0,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.8,
                                fontFamily: 'monospace',
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (_hasRanTest) ...[
                      const SizedBox(width: 8.0),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6.0, vertical: 2.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFF059669),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: const Text(
                            'ALL TESTS PASSED',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 9.0,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const Divider(color: Color(0xFF1E293B), height: 16.0),
                Text(
                  _testRunOutput.isNotEmpty
                      ? _testRunOutput
                      : 'Ready for test execution. Tap "Run Suite" above to launch automated pytest runner against container image.',
                  style: TextStyle(
                    color: _hasRanTest
                        ? const Color(0xFF4ADE80)
                        : const Color(0xFF94A3B8),
                    fontSize: 11.0,
                    fontFamily: 'monospace',
                    height: 1.45,
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
  // TAB 3: Settings & Governance Escrow
  // ---------------------------------------------------------------------------
  Widget _buildSettingsTab() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: AppColors.cardBorder, width: 1.0),
        boxShadow: AppColors.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Lab Access & Reward Settings',
            style: TextStyle(
              color: AppColors.deepInk,
              fontSize: 13.5,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 12.0),
          _buildSettingsRow(
            label: 'Builder XP Reward Bounty',
            value: '+450 XP · Fluency Level 14+',
          ),
          const SizedBox(height: 8.0),
          _buildSettingsRow(
            label: 'Creator Revenue Share',
            value: '70% Monthly Royalties Active',
          ),
          const SizedBox(height: 8.0),
          _buildSettingsRow(
            label: 'Governance Accreditation',
            value: 'Ratified by Dr. Thorne & E. Rostova',
          ),
          const SizedBox(height: 8.0),
          _buildSettingsRow(
            label: 'Weekly Sprint Eligibility',
            value: 'Approved for Room Observation',
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsRow({required String label, required String value}) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: Text(
            label,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 8.0),
        Expanded(
          flex: 6,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerRight,
            child: Text(
              value,
              style: const TextStyle(
                color: AppColors.deepInk,
                fontSize: 12.0,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Bottom Action Buttons
  // ---------------------------------------------------------------------------
  Widget _buildBottomActionButtons() {
    return Column(
      children: [
        // Primary CTA: Publish Lab
        SizedBox(
          width: double.infinity,
          height: 50.0,
          child: ElevatedButton(
            onPressed: _showPublishModal,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF059669),
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
                  Icon(Icons.rocket_launch_rounded, size: 17.0),
                  SizedBox(width: 8.0),
                  Text(
                    'Publish Lab to Network',
                    style: TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 10.0),

        // Secondary: Preview in Full Staging Preview / Student Sandbox
        SizedBox(
          width: double.infinity,
          height: 46.0,
          child: OutlinedButton(
            onPressed: () {
              HapticFeedback.mediumImpact();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => LabPreviewView(
                    labId: widget.labId,
                    labTitle: _titleController.text.isNotEmpty
                        ? _titleController.text
                        : widget.initialTitle,
                    domainTrack: widget.domainTrack,
                  ),
                ),
              );
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.deepInk,
              side: const BorderSide(color: Color(0xFFCBD5E1), width: 1.2),
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
                  Icon(Icons.remove_red_eye_outlined, size: 16.0),
                  SizedBox(width: 8.0),
                  Text(
                    'Preview Student Experience (Stage 1)',
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w800,
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
}

class _PublishDetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _PublishDetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 5,
          child: Text(
            label,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 11.5,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 8.0),
        Expanded(
          flex: 6,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerRight,
            child: Text(
              value,
              style: const TextStyle(
                color: AppColors.deepInk,
                fontSize: 12.0,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
