import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/theme/app_colors.dart';
import '../widgets/young_vip_wordmark.dart';
import 'lab_builder_view.dart';
import 'main_navigation_view.dart';

/// Full interactive preview screen enabling authors, reviewers, and build experts
/// to inspect, test, and validate lab curriculum across both Student Experience
/// and Expert Inspector modes before final governance submission.
class LabPreviewView extends StatefulWidget {
  final String labId;
  final String labTitle;
  final String domainTrack;
  final String authorName;

  const LabPreviewView({
    super.key,
    this.labId = 'LAB-PRV-2026-880',
    this.labTitle = 'Fine-Tuning Mistral 7B with QLoRA on Dual A100',
    this.domainTrack = 'LLM & Generative AI',
    this.authorName = 'Dr. Alex Vance',
  });

  @override
  State<LabPreviewView> createState() => _LabPreviewViewState();
}

class _LabPreviewViewState extends State<LabPreviewView> {
  // 0: Student Experience Mode, 1: Expert Inspector Mode
  int _previewMode = 0;

  // Selected curriculum stage (0 to 4)
  int _selectedStageIndex = 0;

  // Interactive sandbox simulation state
  bool _isSimulatingRun = false;
  bool _simulationPassed = false;
  String _simulationLog = '';

  // Expandable checklist items
  bool _isChecklistExpanded = true;
  bool _isSubmitted = false;

  // Track expanded hints in student mode
  final Set<int> _revealedHints = {};

  // 5 Stages Curriculum Mock Data
  final List<Map<String, dynamic>> _stages = [
    {
      'number': 1,
      'name': 'Build It',
      'icon': Icons.construction_rounded,
      'badge': 'STAGE 1 · ARCHITECTURE',
      'objective':
          'Configure 4-bit NormalFloat (NF4) quantization and double quantization with bitsandbytes for Mistral 7B.',
      'task':
          'Initialize BitsAndBytesConfig with bnb_4bit_quant_type="nf4", compute_dtype=torch.bfloat16, and attach LoRA target modules ["q_proj", "v_proj", "k_proj", "o_proj"].',
      'sampleCode': '''import torch
from peft import LoraConfig, get_peft_model
from transformers import BitsAndBytesConfig, AutoModelForCausalLM

bnb_config = BitsAndBytesConfig(
    load_in_4bit=True,
    bnb_4bit_quant_type="nf4",
    bnb_4bit_use_double_quant=True,
    bnb_4bit_compute_dtype=torch.bfloat16
)

model = AutoModelForCausalLM.from_pretrained(
    "mistralai/Mistral-7B-v0.1",
    quantization_config=bnb_config,
    device_map="auto"
)''',
      'assertions': '''def test_quantization_config():
    assert bnb_config.load_in_4bit is True
    assert bnb_config.bnb_4bit_quant_type == "nf4"
    assert bnb_config.bnb_4bit_compute_dtype == torch.bfloat16
    assert model.device.type == "cuda"''',
      'hints': [
        'Ensure load_in_4bit=True is passed to BitsAndBytesConfig.',
        'Use bfloat16 instead of float16 to avoid underflow in attention heads.',
        'Set device_map="auto" to evenly balance memory across the dual A100 GPUs.',
      ],
      'vramQuota': '18.4 GB / 80.0 GB',
      'estimatedMinutes': '20m',
    },
    {
      'number': 2,
      'name': 'Break It',
      'icon': Icons.bolt_rounded,
      'badge': 'STAGE 2 · ADVERSARIAL STRESS',
      'objective':
          'Inject unpadded sequence batches and adversarial sequence lengths to trigger CUDA OOM and identify gradient accumulation bottlenecks.',
      'task':
          'Trigger an intentional out-of-memory exception by scaling batch_size to 64 without gradient accumulation, then implement dynamic length bucketing to resolve it.',
      'sampleCode': '''# Adversarial Stress Test: Dynamic Length Bucketing
from torch.utils.data import DataLoader
from transformers import DataCollatorWithPadding

def build_resilient_loader(dataset, tokenizer, max_tokens_per_batch=4096):
    collator = DataCollatorWithPadding(tokenizer=tokenizer, pad_to_multiple_of=8)
    return DataLoader(
        dataset,
        batch_size=4,
        collate_fn=collator,
        pin_memory=True
    )''',
      'assertions': '''def test_adversarial_vram_bounds():
    peak_vram = torch.cuda.max_memory_allocated() / (1024 ** 3)
    assert peak_vram < 74.2, f"VRAM overflow: {peak_vram}GB exceeds 74.2GB safety bound"
    assert not torch.isnan(loss), "Gradient explosion detected"''',
      'hints': [
        'Pad sequences to multiples of 8 to leverage NVIDIA Tensor Core MMA acceleration.',
        'Enable gradient_checkpointing=True on the PEFT model to reduce activation memory by 60%.',
        'Use per-device batch size of 4 with gradient accumulation steps of 4.',
      ],
      'vramQuota': '62.8 GB / 80.0 GB',
      'estimatedMinutes': '25m',
    },
    {
      'number': 3,
      'name': 'Understand It',
      'icon': Icons.psychology_rounded,
      'badge': 'STAGE 3 · MECHANISTIC AUDIT',
      'objective':
          'Profile LoRA adapter rank delta matrices (W = W_0 + B * A) and inspect attention entropy across quantized layers.',
      'task':
          'Compute singular value decomposition (SVD) on adapter delta weights B @ A across layers 16-24 to verify rank utilization is not collapsed.',
      'sampleCode': '''import torch

def inspect_adapter_rank_energy(lora_layer):
    A = lora_layer.lora_A['default'].weight
    B = lora_layer.lora_B['default'].weight
    delta_W = (B @ A).float()
    U, S, V = torch.linalg.svd(delta_W)
    explained_variance = torch.cumsum(S ** 2, dim=0) / torch.sum(S ** 2)
    return explained_variance[:8]''',
      'assertions': '''def test_adapter_rank_health():
    energy = inspect_adapter_rank_energy(model.model.layers[16].self_attn.q_proj)
    assert energy[3] < 0.90, "Rank collapse detected: 4 dimensions explain >90% variance"''',
      'hints': [
        'Lora rank r=16 with alpha=32 ensures scaling factor 2.0.',
        'Verify target modules include all projection matrices (q, k, v, o).',
      ],
      'vramQuota': '24.1 GB / 80.0 GB',
      'estimatedMinutes': '15m',
    },
    {
      'number': 4,
      'name': 'Advise Better',
      'icon': Icons.insights_rounded,
      'badge': 'STAGE 4 · ARCHITECTURAL TRADE-OFFS',
      'objective':
          'Formulate an executive trade-off decision between 4-bit QLoRA vs 16-bit Full Fine-Tuning for real-time customer support latency.',
      'task':
          'Analyze token generation latency (tokens/sec), cold-start initialization latency, and training dollar cost across 100k conversational turns.',
      'sampleCode': '''# Trade-off evaluation matrix
tradeoffs = {
    "4-bit QLoRA": {"train_cost_usd": 14.20, "eval_perplexity": 4.12, "vram_needed_gb": 18.4},
    "16-bit LoRA": {"train_cost_usd": 38.60, "eval_perplexity": 4.05, "vram_needed_gb": 44.0},
    "Full FT": {"train_cost_usd": 194.00, "eval_perplexity": 3.98, "vram_needed_gb": 160.0}
}''',
      'assertions': '''def test_recommendation_rationale():
    assert "vLLM merged checkpoint" in recommendation.deployment_strategy
    assert recommendation.budget_efficiency_ratio > 3.0''',
      'hints': [
        'Recommend merging LoRA weights back into 16-bit base weights for zero-overhead vLLM inference.',
        'Consider cost delta (\$14.20 vs \$194.00) vs minimal perplexity improvement (4.12 vs 3.98).',
      ],
      'vramQuota': '12.0 GB / 80.0 GB',
      'estimatedMinutes': '15m',
    },
    {
      'number': 5,
      'name': 'Contextual Connection',
      'icon': Icons.hub_rounded,
      'badge': 'STAGE 5 · ENTERPRISE DEPLOYMENT',
      'objective':
          'Export merged GGUF / AWQ quantized artifacts and deploy behind a high-concurrency OpenAI-compatible vLLM endpoint with Prometheus metrics.',
      'task':
          'Write a production Dockerfile and Helm configuration that mounts dual A100 GPUs, sets tensor_parallel_size=2, and enforces p99 latency < 65ms.',
      'sampleCode': '''# vLLM Production Runtime Launch Command
# python -m vllm.entrypoints.openai.api_server \\
#   --model /models/mistral-7b-qlora-merged \\
#   --tensor-parallel-size 2 \\
#   --gpu-memory-utilization 0.92 \\
#   --max-model-len 8192 \\
#   --port 8000''',
      'assertions': '''def test_production_deployment_health():
    resp = requests.get("http://localhost:8000/health")
    assert resp.status_code == 200
    metrics = requests.get("http://localhost:8000/metrics").text
    assert "vllm:num_requests_running" in metrics''',
      'hints': [
        'Use tensor-parallel-size 2 to split layers across both physical A100 GPUs.',
        'Pin max-model-len to match sequence context window without memory fragmentation.',
      ],
      'vramQuota': '74.2 GB / 80.0 GB',
      'estimatedMinutes': '15m',
    },
  ];

  void _handleSimulateTestRun() {
    HapticFeedback.mediumImpact();
    setState(() {
      _isSimulatingRun = true;
      _simulationPassed = false;
      _simulationLog = 'Provisioning isolated A100 worker container...\n';
    });

    Future.delayed(const Duration(milliseconds: 900), () {
      if (!mounted) return;
      setState(() {
        _simulationLog +=
            'Loading PyTorch 2.4.0 + CUDA 12.4 runtime environment...\n'
            'Executing pytest test_suite.py against student code...\n'
            '✓ test_quantization_config (0.24s)\n'
            '✓ test_adversarial_vram_bounds (0.88s)\n'
            '✓ test_adapter_rank_health (0.31s)\n'
            '✓ All canary evaluations passed (100% assertions green).\n'
            'VRAM utilization peak: 62.8 GB / 80.0 GB (Stable)';
        _isSimulatingRun = false;
        _simulationPassed = true;
      });
    });
  }

  void _handleSubmitForReview() {
    HapticFeedback.heavyImpact();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.pureWhite,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.0),
              topRight: Radius.circular(24.0),
            ),
          ),
          padding: EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            top: 20.0,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 28.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 44.0,
                  height: 4.5,
                  decoration: BoxDecoration(
                    color: const Color(0xFFCBD5E1),
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                ),
              ),
              const SizedBox(height: 18.0),
              Row(
                children: [
                  Container(
                    width: 46.0,
                    height: 46.0,
                    decoration: BoxDecoration(
                      color: const Color(0xFFECFDF5),
                      borderRadius: BorderRadius.circular(14.0),
                      border: Border.all(
                          color: const Color(0xFFA7F3D0), width: 1.0),
                    ),
                    child: const Icon(
                      Icons.verified_rounded,
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
                          'Submit Lab for Governance',
                          style: TextStyle(
                            color: AppColors.deepInk,
                            fontSize: 16.5,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.3,
                          ),
                        ),
                        Text(
                          'Dispatch to Senior Peer Reviewers & Governance Board',
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
                padding: const EdgeInsets.all(14.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(14.0),
                  border:
                      Border.all(color: const Color(0xFFE2E8F0), width: 1.0),
                ),
                child: const Column(
                  children: [
                    _SubmissionInfoRow(
                      label: 'Assigned Reviewers',
                      value: 'Dr. Thorne & E. Rostova',
                    ),
                    SizedBox(height: 8.0),
                    _SubmissionInfoRow(
                      label: 'Review Turnaround SLA',
                      value: '24 - 48 Business Hours',
                    ),
                    SizedBox(height: 8.0),
                    _SubmissionInfoRow(
                      label: 'Catalog Revenue Tier',
                      value: '70% Author Royalties (Escrow)',
                    ),
                    SizedBox(height: 8.0),
                    _SubmissionInfoRow(
                      label: 'Compute Allocation',
                      value: 'Dual NVIDIA A100 (80GB VRAM)',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              SizedBox(
                width: double.infinity,
                height: 50.0,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                    setState(() => _isSubmitted = true);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            'Lab submitted for review! Reviewers notified via priority dispatch.'),
                        backgroundColor: Color(0xFF059669),
                        duration: Duration(seconds: 4),
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
                    'Confirm & Submit for Review',
                    style:
                        TextStyle(fontSize: 14.0, fontWeight: FontWeight.w800),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text(
                    'Cancel & Continue Editing',
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
        );
      },
    );
  }

  void _handleSharePreviewLink() {
    HapticFeedback.lightImpact();
    Clipboard.setData(ClipboardData(
        text: 'https://youngvip.club/preview/lab/${widget.labId}'));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
            'Secure staging preview link copied to clipboard (Valid 48 hours).'),
        backgroundColor: AppColors.deepInk,
        duration: Duration(seconds: 3),
      ),
    );
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
                  _buildHeroCard(),
                  const SizedBox(height: 16.0),
                  _buildModeSwitcher(),
                  const SizedBox(height: 16.0),
                  _buildStageStepper(),
                  const SizedBox(height: 16.0),
                  _buildActiveStageCard(),
                  const SizedBox(height: 20.0),
                  _buildQualityGateChecklist(),
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
        // Staging Status Badge
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
                    decoration: BoxDecoration(
                      color: _isSubmitted
                          ? const Color(0xFF2563EB)
                          : const Color(0xFF059669),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6.0),
                  Text(
                    _isSubmitted
                        ? 'SUBMITTED · IN REVIEW'
                        : 'LAB PREVIEW · STAGING',
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
  // Hero Header Card
  // ---------------------------------------------------------------------------
  Widget _buildHeroCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18.0),
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
                            Icons.visibility_rounded,
                            size: 13.0,
                            color: AppColors.bananiPrimary,
                          ),
                          SizedBox(width: 5.0),
                          Text(
                            'LAB PREVIEW · PRE-SUBMISSION AUDIT',
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
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  widget.labId,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 11.0,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          const Text(
            'Lab Preview',
            style: TextStyle(
              color: AppColors.deepInk,
              fontSize: 22.0,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.5,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 4.0),
          const Text(
            'Preview the lab before submission',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10.0),
          Container(
            width: double.infinity,
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Row(
              children: [
                const Icon(Icons.science_outlined,
                    size: 15.0, color: AppColors.bananiPrimary),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    widget.labTitle,
                    style: const TextStyle(
                      color: AppColors.deepInk,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w800,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          Wrap(
            spacing: 12.0,
            runSpacing: 6.0,
            children: [
              _buildMetaTag(
                  Icons.person_outline_rounded, 'Author: ${widget.authorName}'),
              _buildMetaTag(Icons.category_rounded, widget.domainTrack),
              _buildMetaTag(
                  Icons.memory_rounded, 'Dual A100 GPU (80GB PyTorch)'),
              _buildMetaTag(Icons.timer_outlined, '90 Mins Active Sandbox'),
              _buildMetaTag(Icons.workspace_premium_rounded, '+450 XP Bounty'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetaTag(IconData icon, String text) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 240.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13.0, color: AppColors.textSecondary),
          const SizedBox(width: 4.0),
          Flexible(
            child: Text(
              text,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 11.0,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Mode Switcher: Student Experience vs Expert Inspector
  // ---------------------------------------------------------------------------
  Widget _buildModeSwitcher() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: const Color(0xFFE2E8F0),
        borderRadius: BorderRadius.circular(14.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                HapticFeedback.selectionClick();
                setState(() => _previewMode = 0);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 9.0),
                decoration: BoxDecoration(
                  color: _previewMode == 0
                      ? AppColors.pureWhite
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: _previewMode == 0
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
                        Icons.school_outlined,
                        size: 14.0,
                        color: _previewMode == 0
                            ? AppColors.deepInk
                            : const Color(0xFF64748B),
                      ),
                      const SizedBox(width: 6.0),
                      Text(
                        'Student Experience View',
                        style: TextStyle(
                          color: _previewMode == 0
                              ? AppColors.deepInk
                              : const Color(0xFF64748B),
                          fontSize: 12.0,
                          fontWeight: _previewMode == 0
                              ? FontWeight.w800
                              : FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                HapticFeedback.selectionClick();
                setState(() => _previewMode = 1);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 9.0),
                decoration: BoxDecoration(
                  color: _previewMode == 1
                      ? AppColors.pureWhite
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: _previewMode == 1
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
                        Icons.admin_panel_settings_outlined,
                        size: 14.0,
                        color: _previewMode == 1
                            ? AppColors.bananiPrimary
                            : const Color(0xFF64748B),
                      ),
                      const SizedBox(width: 6.0),
                      Text(
                        'Expert Inspector View',
                        style: TextStyle(
                          color: _previewMode == 1
                              ? AppColors.bananiPrimary
                              : const Color(0xFF64748B),
                          fontSize: 12.0,
                          fontWeight: _previewMode == 1
                              ? FontWeight.w800
                              : FontWeight.w600,
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
    );
  }

  // ---------------------------------------------------------------------------
  // Stage Stepper Chips
  // ---------------------------------------------------------------------------
  Widget _buildStageStepper() {
    return SingleChildScrollView(
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
                setState(() {
                  _selectedStageIndex = idx;
                  _simulationPassed = false;
                  _simulationLog = '';
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 7.0),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.deepInk : AppColors.pureWhite,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color:
                        isSelected ? AppColors.deepInk : AppColors.cardBorder,
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
                        color: isSelected ? Colors.white : AppColors.deepInk,
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
    );
  }

  // ---------------------------------------------------------------------------
  // Active Stage Content Card
  // ---------------------------------------------------------------------------
  Widget _buildActiveStageCard() {
    final stage = _stages[_selectedStageIndex];

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
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Stage ${stage['number']}: ${stage['name']}',
                  style: const TextStyle(
                    color: AppColors.deepInk,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w900,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
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
                      stage['badge'] as String,
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
          const SizedBox(height: 12.0),

          // Objective Box
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.flag_outlined,
                        size: 14.0, color: AppColors.bananiPrimary),
                    SizedBox(width: 6.0),
                    Expanded(
                      child: Text(
                        'Stage Learning Objective',
                        style: TextStyle(
                          color: AppColors.deepInk,
                          fontSize: 11.5,
                          fontWeight: FontWeight.w800,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6.0),
                Text(
                  stage['objective'] as String,
                  style: const TextStyle(
                    color: Color(0xFF334155),
                    fontSize: 11.5,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12.0),

          // Task Prompt
          const Text(
            'Challenge Instructions',
            style: TextStyle(
              color: AppColors.deepInk,
              fontSize: 12.5,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            stage['task'] as String,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 11.5,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 14.0),

          // Code Box
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text(
                  'Student Sandbox Solution Template',
                  style: TextStyle(
                    color: AppColors.deepInk,
                    fontSize: 12.0,
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
                    'Python 3.11',
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
            width: double.infinity,
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: const Color(0xFF0F172A),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: const Color(0xFF1E293B)),
            ),
            child: SelectableText(
              stage['sampleCode'] as String,
              style: const TextStyle(
                color: Color(0xFF38BDF8),
                fontSize: 11.5,
                fontFamily: 'monospace',
                height: 1.45,
              ),
            ),
          ),
          const SizedBox(height: 14.0),

          // Mode-specific sections
          if (_previewMode == 0) ...[
            _buildStudentModeExtras(stage),
          ] else ...[
            _buildExpertInspectorExtras(stage),
          ],
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Student Mode: Hints & Test Run
  // ---------------------------------------------------------------------------
  Widget _buildStudentModeExtras(Map<String, dynamic> stage) {
    final hints = stage['hints'] as List<String>;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Scaffolding Hints
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Expanded(
              child: Text(
                'Builder Scaffolding Hints',
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
              child: Text(
                '${_revealedHints.length}/${hints.length} Revealed',
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 11.0,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Column(
          children: List.generate(hints.length, (idx) {
            final isRevealed = _revealedHints.contains(idx);
            return Padding(
              padding: const EdgeInsets.only(bottom: 6.0),
              child: Container(
                decoration: BoxDecoration(
                  color: isRevealed
                      ? const Color(0xFFF8FAFC)
                      : const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                      color: isRevealed
                          ? const Color(0xFFE2E8F0)
                          : const Color(0xFFCBD5E1)),
                ),
                child: ListTile(
                  dense: true,
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 0.0),
                  leading: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5.0, vertical: 1.5),
                    decoration: BoxDecoration(
                      color: isRevealed
                          ? AppColors.bananiLavender
                          : const Color(0xFFE2E8F0),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      'H${idx + 1}',
                      style: TextStyle(
                        color: isRevealed
                            ? AppColors.bananiPrimary
                            : const Color(0xFF64748B),
                        fontSize: 9.5,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  title: isRevealed
                      ? Text(
                          hints[idx],
                          style: const TextStyle(
                            color: Color(0xFF334155),
                            fontSize: 11.5,
                            height: 1.35,
                          ),
                        )
                      : const Text(
                          'Tap to reveal hint (-15 XP Penalty)',
                          style: TextStyle(
                            color: Color(0xFF64748B),
                            fontSize: 11.5,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                  trailing: Icon(
                    isRevealed
                        ? Icons.lock_open_rounded
                        : Icons.lock_outline_rounded,
                    size: 15.0,
                    color: isRevealed
                        ? AppColors.bananiPrimary
                        : const Color(0xFF94A3B8),
                  ),
                  onTap: () {
                    HapticFeedback.selectionClick();
                    setState(() {
                      if (isRevealed) {
                        _revealedHints.remove(idx);
                      } else {
                        _revealedHints.add(idx);
                      }
                    });
                  },
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 14.0),

        // Test Run Button
        SizedBox(
          width: double.infinity,
          height: 44.0,
          child: ElevatedButton.icon(
            onPressed: _isSimulatingRun ? null : _handleSimulateTestRun,
            icon: _isSimulatingRun
                ? const SizedBox(
                    width: 14.0,
                    height: 14.0,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : const Icon(Icons.play_circle_fill_rounded, size: 17.0),
            label: Text(
              _isSimulatingRun
                  ? 'Simulating Student Run on A100...'
                  : 'Simulate Run in Student Sandbox',
              style:
                  const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w800),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.bananiPrimary,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          ),
        ),

        // Terminal Output
        if (_simulationLog.isNotEmpty) ...[
          const SizedBox(height: 10.0),
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
                              'STUDENT SANDBOX OUTPUT',
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
                    if (_simulationPassed) ...[
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
                            'STAGE PASSED',
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
                  _simulationLog,
                  style: TextStyle(
                    color: _simulationPassed
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
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Expert Inspector Mode: Hidden Canary Assertions & Rubric Metrics
  // ---------------------------------------------------------------------------
  Widget _buildExpertInspectorExtras(Map<String, dynamic> stage) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Hidden Canary Assertions
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Expanded(
              child: Text(
                'Hidden Canary Assertions (PyTest)',
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 7.0, vertical: 2.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF3C7),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: const Text(
                  'CONFIDENTIAL EVAL',
                  style: TextStyle(
                    color: Color(0xFFD97706),
                    fontSize: 9.5,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E2E),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: const Color(0xFF313244)),
          ),
          child: SelectableText(
            stage['assertions'] as String,
            style: const TextStyle(
              color: Color(0xFFA6E3A1),
              fontSize: 11.5,
              fontFamily: 'monospace',
              height: 1.45,
            ),
          ),
        ),
        const SizedBox(height: 14.0),

        // Runtime Quota & Rubric Grid
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Column(
            children: [
              _buildInspectorRow(
                label: 'Peak VRAM Quota Allowance',
                value: stage['vramQuota'] as String,
                icon: Icons.speed_rounded,
              ),
              const SizedBox(height: 8.0),
              _buildInspectorRow(
                label: 'Stage Completion Target',
                value: stage['estimatedMinutes'] as String,
                icon: Icons.timer_outlined,
              ),
              const SizedBox(height: 8.0),
              _buildInspectorRow(
                label: 'Automated Scoring Weight',
                value: '20% Total Lab Score (100 pts)',
                icon: Icons.analytics_outlined,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInspectorRow({
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Row(
      children: [
        Icon(icon, size: 14.0, color: AppColors.bananiPrimary),
        const SizedBox(width: 8.0),
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
          flex: 5,
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
  // Pre-Submission Quality Gate Checklist
  // ---------------------------------------------------------------------------
  Widget _buildQualityGateChecklist() {
    final checklist = [
      {'title': '5/5 Curriculum Stages Defined', 'isDone': true},
      {'title': 'PyTest Canary Evals Passing', 'isDone': true},
      {'title': 'Dual A100 VRAM Allocated (<= 74.2 GB)', 'isDone': true},
      {'title': 'Scaffolding Hints Configured (3/stage)', 'isDone': true},
      {'title': 'Revenue Escrow Agreement Signed (70%)', 'isDone': true},
    ];

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
          GestureDetector(
            onTap: () {
              HapticFeedback.lightImpact();
              setState(() => _isChecklistExpanded = !_isChecklistExpanded);
            },
            behavior: HitTestBehavior.opaque,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  child: Row(
                    children: [
                      Icon(Icons.verified_outlined,
                          size: 16.0, color: Color(0xFF059669)),
                      SizedBox(width: 6.0),
                      Flexible(
                        child: Text(
                          'Pre-Submission Quality Gate',
                          style: TextStyle(
                            color: AppColors.deepInk,
                            fontSize: 13.5,
                            fontWeight: FontWeight.w900,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8.0),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7.0, vertical: 2.5),
                        decoration: BoxDecoration(
                          color: const Color(0xFFECFDF5),
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: const Text(
                          '5/5 PASSED',
                          style: TextStyle(
                            color: Color(0xFF059669),
                            fontSize: 10.0,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      const SizedBox(width: 4.0),
                      Icon(
                        _isChecklistExpanded
                            ? Icons.keyboard_arrow_up_rounded
                            : Icons.keyboard_arrow_down_rounded,
                        size: 18.0,
                        color: AppColors.textSecondary,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (_isChecklistExpanded) ...[
            const SizedBox(height: 12.0),
            Column(
              children: List.generate(checklist.length, (idx) {
                final item = checklist[idx];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 7.0),
                  child: Row(
                    children: [
                      Container(
                        width: 18.0,
                        height: 18.0,
                        decoration: const BoxDecoration(
                          color: Color(0xFF059669),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.check,
                            size: 12.0, color: Colors.white),
                      ),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: Text(
                          item['title'] as String,
                          style: const TextStyle(
                            color: AppColors.deepInk,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ],
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Bottom Action Buttons
  // ---------------------------------------------------------------------------
  Widget _buildBottomActionButtons() {
    return Column(
      children: [
        // Primary: Submit for Review
        SizedBox(
          width: double.infinity,
          height: 50.0,
          child: ElevatedButton(
            onPressed: _isSubmitted ? null : _handleSubmitForReview,
            style: ElevatedButton.styleFrom(
              backgroundColor: _isSubmitted
                  ? const Color(0xFF94A3B8)
                  : const Color(0xFF059669),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.0),
              ),
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _isSubmitted
                        ? Icons.check_circle_rounded
                        : Icons.assignment_turned_in_rounded,
                    size: 17.0,
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    _isSubmitted
                        ? 'Submitted · Awaiting Board Approval'
                        : 'Submit Lab for Governance Review',
                    style: const TextStyle(
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

        // Secondary: Return to Lab Builder Editor
        SizedBox(
          width: double.infinity,
          height: 46.0,
          child: OutlinedButton.icon(
            onPressed: () {
              HapticFeedback.lightImpact();
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              } else {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LabBuilderView()),
                );
              }
            },
            icon: const Icon(Icons.edit_note_rounded, size: 16.0),
            label: const Text(
              'Edit Content in Lab Builder',
              style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w800),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.deepInk,
              side: const BorderSide(color: Color(0xFFCBD5E1), width: 1.2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.0),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10.0),

        // Tertiary: Share Staging Link
        SizedBox(
          width: double.infinity,
          child: TextButton.icon(
            onPressed: _handleSharePreviewLink,
            icon: const Icon(Icons.share_outlined,
                size: 14.0, color: AppColors.textSecondary),
            label: const Text(
              'Share Staging Preview Link',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SubmissionInfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _SubmissionInfoRow({required this.label, required this.value});

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
