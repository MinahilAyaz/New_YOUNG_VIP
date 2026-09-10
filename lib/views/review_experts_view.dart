import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/theme/app_colors.dart';
import '../widgets/young_vip_wordmark.dart';
import 'main_navigation_view.dart';

enum ExpertStatus { pending, approved, rejected }

class ExpertApplicant {
  final String id;
  final String name;
  final String role;
  final String affiliation;
  final String domain;
  final int fluencyScore;
  final String proposedTrack;
  final String trackSummary;
  final List<String> credentials;
  final String appliedTime;
  ExpertStatus status;

  ExpertApplicant({
    required this.id,
    required this.name,
    required this.role,
    required this.affiliation,
    required this.domain,
    required this.fluencyScore,
    required this.proposedTrack,
    required this.trackSummary,
    required this.credentials,
    required this.appliedTime,
    this.status = ExpertStatus.pending,
  });
}

class ReviewExpertsView extends StatefulWidget {
  const ReviewExpertsView({super.key});

  @override
  State<ReviewExpertsView> createState() => _ReviewExpertsViewState();
}

class _ReviewExpertsViewState extends State<ReviewExpertsView> {
  int _selectedFilterIndex = 0; // 0: All, 1: Pending, 2: Approved, 3: Rejected
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  late List<ExpertApplicant> _applicants;

  @override
  void initState() {
    super.initState();
    _applicants = [
      ExpertApplicant(
        id: 'exp-101',
        name: 'Dr. Aris Thorne',
        role: 'Principal Autonomous Systems Architect',
        affiliation: 'Ex-DeepMind / Oxford AI Lab',
        domain: 'Multi-Agent Consensus',
        fluencyScore: 98,
        proposedTrack: 'Byzantine Consensus in Autonomous Agent Swarms',
        trackSummary:
            'Interactive sprint building fault-tolerant message brokers for heterogeneous agent clusters with cryptographic peer consensus.',
        credentials: [
          '14 NeurIPS/ICML Publications',
          'Creator of SwarmMesh Protocol',
          'YVIP Certified Fellow',
        ],
        appliedTime: '2 hours ago',
        status: ExpertStatus.pending,
      ),
      ExpertApplicant(
        id: 'exp-102',
        name: 'Elena Rostova',
        role: 'Staff LLM Security Researcher',
        affiliation: 'Neural Matrix Labs / Red-Team Lead',
        domain: 'Adversarial Defense',
        fluencyScore: 96,
        proposedTrack: 'Autonomous Jailbreak & Injection Defense Arenas',
        trackSummary:
            'Hands-on red-teaming arena stress-testing multi-modal LLM reasoning pipelines against indirect prompt injection vectors.',
        credentials: [
          'Top 1% Global Bug Bounty Lead',
          'Author of DefendLLM Benchmark',
          'BlackHat Speaker',
        ],
        appliedTime: '5 hours ago',
        status: ExpertStatus.pending,
      ),
      ExpertApplicant(
        id: 'exp-103',
        name: 'Kaelen Chen',
        role: 'Founding Engineer & Graph Architect',
        affiliation: 'VectorKnowledge AI / Stanford MS',
        domain: 'Graph RAG & Memory',
        fluencyScore: 95,
        proposedTrack: 'Temporal Graph RAG with Self-Correcting Memory',
        trackSummary:
            'Architecture sprint implementing recursive hierarchical knowledge retrieval with low-latency dynamic graph updates.',
        credentials: [
          'Lead maintainer of GraphRAG-Core',
          '3 Patent Filings in Graph Memory',
          'Fluency Master Rank',
        ],
        appliedTime: '1 day ago',
        status: ExpertStatus.pending,
      ),
      ExpertApplicant(
        id: 'exp-104',
        name: 'Maya Lin',
        role: 'Chief AI Ethics & Governance Fellow',
        affiliation: 'Global AI Institute / Turing Fellow',
        domain: 'Agentic Alignment',
        fluencyScore: 94,
        proposedTrack: 'Verifiable Constitutional AI & Audit Traces',
        trackSummary:
            'Production workshop designing deterministic rule-enforcement layers for enterprise financial copilots.',
        credentials: [
          'EU AI Act Regulatory Advisor',
          '10+ Years Enterprise Auditing',
          'Advisory Board Member',
        ],
        appliedTime: '2 days ago',
        status: ExpertStatus.approved,
      ),
      ExpertApplicant(
        id: 'exp-105',
        name: 'Marcus Vance',
        role: 'Distributed Systems Lead',
        affiliation: 'HyperScale Tensor Labs',
        domain: 'GPU Compute Clusters',
        fluencyScore: 92,
        proposedTrack: 'Zero-Copy Shared Memory IPC for Local Agent Swarms',
        trackSummary:
            'Ultra-high throughput shared memory architecture for coordinating multi-process LLM micro-agents on edge devices.',
        credentials: [
          'Linux Kernel Subsystem Contributor',
          'Former Meta Infrastructure Staff',
          'Fluency Score 92/100',
        ],
        appliedTime: '3 days ago',
        status: ExpertStatus.rejected,
      ),
    ];
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _updateStatus(ExpertApplicant applicant, ExpertStatus newStatus) {
    HapticFeedback.mediumImpact();
    setState(() {
      applicant.status = newStatus;
    });

    final actionLabel = newStatus == ExpertStatus.approved
        ? 'approved as Verified Expert Studio Creator'
        : (newStatus == ExpertStatus.rejected
            ? 'application rejected'
            : 'marked as Pending Review');

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              newStatus == ExpertStatus.approved
                  ? Icons.check_circle_rounded
                  : (newStatus == ExpertStatus.rejected
                      ? Icons.cancel_rounded
                      : Icons.info_outline_rounded),
              color: Colors.white,
              size: 18.0,
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                '${applicant.name} $actionLabel.',
                style: const TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: newStatus == ExpertStatus.approved
            ? const Color(0xFF065F46)
            : (newStatus == ExpertStatus.rejected
                ? const Color(0xFF991B1B)
                : const Color(0xFF1E293B)),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        action: SnackBarAction(
          label: 'UNDO',
          textColor: Colors.white,
          onPressed: () {
            setState(() {
              applicant.status = ExpertStatus.pending;
            });
          },
        ),
      ),
    );
  }

  List<ExpertApplicant> get _filteredApplicants {
    return _applicants.where((applicant) {
      // Filter by status tab
      if (_selectedFilterIndex == 1 &&
          applicant.status != ExpertStatus.pending) {
        return false;
      }
      if (_selectedFilterIndex == 2 &&
          applicant.status != ExpertStatus.approved) {
        return false;
      }
      if (_selectedFilterIndex == 3 &&
          applicant.status != ExpertStatus.rejected) {
        return false;
      }

      // Filter by search query
      if (_searchQuery.isNotEmpty) {
        final query = _searchQuery.toLowerCase();
        final matchName = applicant.name.toLowerCase().contains(query);
        final matchRole = applicant.role.toLowerCase().contains(query);
        final matchDomain = applicant.domain.toLowerCase().contains(query);
        final matchTrack = applicant.proposedTrack.toLowerCase().contains(query);
        return matchName || matchRole || matchDomain || matchTrack;
      }

      return true;
    }).toList();
  }

  int get _pendingCount =>
      _applicants.where((a) => a.status == ExpertStatus.pending).length;
  int get _approvedCount =>
      _applicants.where((a) => a.status == ExpertStatus.approved).length;
  int get _rejectedCount =>
      _applicants.where((a) => a.status == ExpertStatus.rejected).length;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double horizontalPadding =
        screenWidth > 600 ? 28.0 : (screenWidth < 360 ? 14.0 : 20.0);

    final filteredList = _filteredApplicants;

    return Scaffold(
      backgroundColor: AppColors.bananiBackground,
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640.0),
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: 12.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTopBar(context),
                  const SizedBox(height: 18.0),
                  _buildHeaderSection(),
                  const SizedBox(height: 16.0),
                  _buildSearchBar(),
                  const SizedBox(height: 14.0),
                  _buildFilterTabs(),
                  const SizedBox(height: 18.0),
                  if (filteredList.isEmpty)
                    _buildEmptyState()
                  else
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: filteredList.length,
                      separatorBuilder: (_, __) =>
                          const SizedBox(height: 14.0),
                      itemBuilder: (ctx, index) =>
                          _buildApplicantCard(filteredList[index]),
                    ),
                  const SizedBox(height: 28.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.centerLeft,
      child: SizedBox(
        width: 560.0,
        child: Row(
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
            // Review Counter Badge
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              decoration: BoxDecoration(
                color: const Color(0xFFFEF3C7),
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: const Color(0xFFFDE68A),
                  width: 1.0,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.how_to_reg_rounded,
                    size: 13.0,
                    color: Color(0xFFD97706),
                  ),
                  const SizedBox(width: 5.0),
                  Text(
                    '$_pendingCount PENDING REVIEW',
                    style: const TextStyle(
                      color: Color(0xFFB45309),
                      fontSize: 10.5,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.6,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
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
                  Icons.verified_user_rounded,
                  size: 13.0,
                  color: AppColors.bananiPrimary,
                ),
                SizedBox(width: 4.0),
                Text(
                  'EXPERT STUDIO GOVERNANCE',
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
          'Review Experts',
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
          'Evaluate expert studio creator submissions. Approve verified AI architects to publish interactive sprint tracks.',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 13.0,
            height: 1.45,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 44.0,
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: AppColors.cardBorder,
          width: 1.0,
        ),
        boxShadow: AppColors.buttonShadow,
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (val) {
          setState(() {
            _searchQuery = val.trim();
          });
        },
        style: const TextStyle(fontSize: 13.0, color: AppColors.deepInk),
        decoration: InputDecoration(
          hintText: 'Search by applicant name, domain, or track...',
          hintStyle: const TextStyle(
            fontSize: 12.0,
            color: AppColors.searchHint,
          ),
          prefixIcon: const Icon(
            Icons.search_rounded,
            size: 18.0,
            color: AppColors.textSecondary,
          ),
          suffixIcon: _searchQuery.isNotEmpty
              ? GestureDetector(
                  onTap: () {
                    _searchController.clear();
                    setState(() => _searchQuery = '');
                  },
                  child: const Icon(
                    Icons.close_rounded,
                    size: 16.0,
                    color: AppColors.textSecondary,
                  ),
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
        ),
      ),
    );
  }

  Widget _buildFilterTabs() {
    final tabs = [
      'All (${_applicants.length})',
      'Pending ($_pendingCount)',
      'Approved ($_approvedCount)',
      'Rejected ($_rejectedCount)',
    ];

    return Container(
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(
          color: AppColors.cardBorder,
          width: 1.0,
        ),
      ),
      child: Row(
        children: List.generate(tabs.length, (index) {
          final isSelected = _selectedFilterIndex == index;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                HapticFeedback.selectionClick();
                setState(() => _selectedFilterIndex = index);
              },
              behavior: HitTestBehavior.opaque,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.pureWhite : Colors.transparent,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: isSelected ? AppColors.buttonShadow : null,
                ),
                alignment: Alignment.center,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    tabs[index],
                    style: TextStyle(
                      color:
                          isSelected ? AppColors.deepInk : AppColors.textSecondary,
                      fontSize: 11.5,
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
    );
  }

  Widget _buildApplicantCard(ExpertApplicant applicant) {
    Color statusBg;
    Color statusFg;
    String statusLabel;
    IconData statusIcon;

    switch (applicant.status) {
      case ExpertStatus.approved:
        statusBg = const Color(0xFFE6F4EC);
        statusFg = const Color(0xFF065F46);
        statusLabel = 'APPROVED';
        statusIcon = Icons.check_circle_rounded;
        break;
      case ExpertStatus.rejected:
        statusBg = const Color(0xFFFDEEEC);
        statusFg = const Color(0xFF991B1B);
        statusLabel = 'REJECTED';
        statusIcon = Icons.cancel_rounded;
        break;
      case ExpertStatus.pending:
        statusBg = const Color(0xFFFEF3C7);
        statusFg = const Color(0xFFB45309);
        statusLabel = 'PENDING REVIEW';
        statusIcon = Icons.hourglass_top_rounded;
        break;
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: applicant.status == ExpertStatus.approved
              ? const Color(0xFFA7F3D0)
              : (applicant.status == ExpertStatus.rejected
                  ? const Color(0xFFFECACA)
                  : AppColors.cardBorder),
          width: 1.0,
        ),
        boxShadow: AppColors.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row: Avatar, Name/Role, Status Badge
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar
              Container(
                width: 44.0,
                height: 44.0,
                decoration: BoxDecoration(
                  color: AppColors.bananiLavender,
                  borderRadius: BorderRadius.circular(14.0),
                  border: Border.all(
                    color: AppColors.bananiPrimary.withValues(alpha: 0.2),
                    width: 1.0,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  applicant.name
                      .split(' ')
                      .map((e) => e.isNotEmpty ? e[0] : '')
                      .take(2)
                      .join(),
                  style: const TextStyle(
                    color: AppColors.bananiPrimary,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(width: 12.0),
              // Name and Role
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      applicant.name,
                      style: const TextStyle(
                        color: AppColors.deepInk,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 2.0),
                    Text(
                      applicant.role,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 11.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2.0),
                    Text(
                      applicant.affiliation,
                      style: const TextStyle(
                        color: Color(0xFF94A3B8),
                        fontSize: 11.0,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8.0),
              // Status Badge
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 7.0, vertical: 3.5),
                  decoration: BoxDecoration(
                    color: statusBg,
                    borderRadius: BorderRadius.circular(7.0),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(statusIcon, size: 12.0, color: statusFg),
                      const SizedBox(width: 4.0),
                      Text(
                        statusLabel,
                        style: TextStyle(
                          color: statusFg,
                          fontSize: 9.5,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14.0),
          // Domain & Fluency Score Row
          Wrap(
            spacing: 8.0,
            runSpacing: 6.0,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 3.5),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.hub_outlined,
                          size: 12.0, color: Color(0xFF475569)),
                      const SizedBox(width: 4.0),
                      Text(
                        applicant.domain,
                        style: const TextStyle(
                          color: Color(0xFF475569),
                          fontSize: 11.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 3.5),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE6F4EC),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.verified_rounded,
                          size: 12.0, color: Color(0xFF059669)),
                      const SizedBox(width: 4.0),
                      Text(
                        'Fluency ${applicant.fluencyScore}/100 · Certified',
                        style: const TextStyle(
                          color: Color(0xFF065F46),
                          fontSize: 11.0,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          // Proposed Track Box
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(
                color: const Color(0xFFE2E8F0),
                width: 1.0,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.auto_stories_rounded,
                        size: 13.0,
                        color: AppColors.bananiPrimary,
                      ),
                      SizedBox(width: 5.0),
                      Text(
                        'PROPOSED FLAGSHIP TRACK',
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
                const SizedBox(height: 4.0),
                Text(
                  applicant.proposedTrack,
                  style: const TextStyle(
                    color: AppColors.deepInk,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  applicant.trackSummary,
                  style: const TextStyle(
                    color: Color(0xFF475569),
                    fontSize: 11.5,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          // Credentials List
          ...applicant.credentials.map(
            (cred) => Padding(
              padding: const EdgeInsets.only(bottom: 3.0),
              child: Row(
                children: [
                  const Icon(
                    Icons.check_circle_outline_rounded,
                    size: 13.0,
                    color: AppColors.bananiPrimary,
                  ),
                  const SizedBox(width: 6.0),
                  Expanded(
                    child: Text(
                      cred,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 11.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14.0),
          // Action Buttons Bar
          Row(
            children: [
              // Approve Button
              Expanded(
                child: SizedBox(
                  height: 38.0,
                  child: ElevatedButton(
                    onPressed: applicant.status == ExpertStatus.approved
                        ? null
                        : () => _updateStatus(applicant, ExpertStatus.approved),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF059669),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      disabledBackgroundColor: const Color(0xFFE2E8F0),
                      disabledForegroundColor: const Color(0xFF94A3B8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    child: const FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.check_rounded, size: 16.0),
                          SizedBox(width: 5.0),
                          Text(
                            'Approve Creator',
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              // Reject Button
              Expanded(
                child: SizedBox(
                  height: 38.0,
                  child: OutlinedButton(
                    onPressed: applicant.status == ExpertStatus.rejected
                        ? null
                        : () => _updateStatus(applicant, ExpertStatus.rejected),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFFDC2626),
                      side: const BorderSide(
                        color: Color(0xFFFCA5A5),
                        width: 1.0,
                      ),
                      disabledForegroundColor: const Color(0xFFCBD5E1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    child: const FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.close_rounded, size: 16.0),
                          SizedBox(width: 5.0),
                          Text(
                            'Reject Application',
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 36.0, horizontal: 20.0),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: AppColors.cardBorder, width: 1.0),
      ),
      child: const Column(
        children: [
          Icon(
            Icons.filter_list_off_rounded,
            size: 40.0,
            color: Color(0xFF94A3B8),
          ),
          SizedBox(height: 12.0),
          Text(
            'No applications found',
            style: TextStyle(
              color: AppColors.deepInk,
              fontSize: 15.0,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            'Try adjusting your search query or switching tabs.',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12.0,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
