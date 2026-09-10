import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:young_vip/views/application_review_status_view.dart';
import 'package:young_vip/views/apply_as_expert_view.dart';
import 'package:young_vip/views/build_expert_approved_view.dart';
import 'package:young_vip/views/assessment_result_view.dart';
import 'package:young_vip/views/contextual_connection_view.dart';
import 'package:young_vip/views/create_account_view.dart';
import 'package:young_vip/views/discover_view.dart';
import 'package:young_vip/views/homepage_view.dart';
import 'package:young_vip/views/interests_view.dart';
import 'package:young_vip/views/lab_builder_view.dart';
import 'package:young_vip/views/lab_preview_view.dart';
import 'package:young_vip/views/fluency_assessment_view.dart';
import 'package:young_vip/views/all_access_pricing_view.dart';
import 'package:young_vip/views/main_navigation_view.dart';
import 'package:young_vip/views/premium_locked_gate_view.dart';
import 'package:young_vip/views/profile_setup_view.dart';
import 'package:young_vip/views/proposal_approval_status_view.dart';
import 'package:young_vip/views/propose_lab_view.dart';
import 'package:young_vip/views/review_experts_view.dart';
import 'package:young_vip/views/submit_revision_view.dart';
import 'package:young_vip/views/verify_email_view.dart';
import 'package:young_vip/widgets/custom_drawer.dart';

void main() {
  const List<Size> testViewports = [
    Size(320, 568), // iPhone SE 1st gen / ultra-narrow mobile
    Size(360, 640), // Standard Android compact
    Size(375, 667), // iPhone SE 2nd gen / iPhone 8
    Size(412, 915), // Pixel 7
    Size(768, 1024), // Tablet portrait
  ];

  group('DiscoverView Responsiveness Tests', () {
    for (final size in testViewports) {
      testWidgets('Renders zero overflow at ${size.width}x${size.height}',
          (WidgetTester tester) async {
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await tester.pumpWidget(
          const MaterialApp(
            home: DiscoverView(isRootTab: false),
          ),
        );
        await tester.pumpAndSettle();
        final err = tester.takeException();
        expect(err, isNull);
      });
    }
  });

  group('ContextualConnectionView Responsiveness Tests', () {
    for (final size in testViewports) {
      testWidgets('Renders zero overflow at ${size.width}x${size.height} across all tabs',
          (WidgetTester tester) async {
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await tester.pumpWidget(
          const MaterialApp(
            home: ContextualConnectionView(),
          ),
        );
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);

        // Switch to Tab 1: Industry Precedents
        final precedentsTab = find.byWidgetPredicate((w) =>
            w is Text &&
            (w.data == 'Precedents' || w.data == 'Industry Precedents'));
        expect(precedentsTab, findsOneWidget);
        await tester.tap(precedentsTab, warnIfMissed: false);
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);

        // Switch to Tab 2: Impact Matrix
        final impactTab = find.byWidgetPredicate((w) =>
            w is Text &&
            (w.data == 'Impact' || w.data == 'Impact Matrix'));
        expect(impactTab, findsOneWidget);
        await tester.tap(impactTab, warnIfMissed: false);
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
      });
    }
  });

  group('AssessmentResultView Responsiveness Tests', () {
    for (final size in testViewports) {
      testWidgets('Renders zero overflow at ${size.width}x${size.height} across all tabs',
          (WidgetTester tester) async {
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await tester.pumpWidget(
          MaterialApp(
            key: UniqueKey(),
            home: const AssessmentResultView(),
          ),
        );
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);

        // Switch to Tab 1: Breakdown
        final breakdownTab = find.byWidgetPredicate((w) =>
            w is Text &&
            (w.data == 'Breakdown' || w.data == 'Competency Breakdown'));
        expect(breakdownTab, findsOneWidget);
        await tester.tap(breakdownTab, warnIfMissed: false);
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);

        // Switch to Tab 2: Action Plan
        final actionTab = find.text('Action Plan');
        expect(actionTab, findsOneWidget);
        await tester.tap(actionTab, warnIfMissed: false);
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
      });
    }
  });

  group('VerifyEmailView Responsiveness Tests', () {
    for (final size in testViewports) {
      testWidgets('Renders zero overflow at ${size.width}x${size.height}',
          (WidgetTester tester) async {
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await tester.pumpWidget(
          const MaterialApp(
            home: VerifyEmailView(email: 'test.user@enterprise.org'),
          ),
        );
        await tester.pumpAndSettle();
        final err = tester.takeException();
        if (err != null) {
          debugPrint('VERIFY EMAIL ERROR AT ${size.width}: $err');
        }
        expect(err, isNull);
      });
    }
  });

  group('InterestsView Responsiveness Tests', () {
    for (final size in testViewports) {
      testWidgets('Renders zero overflow at ${size.width}x${size.height}',
          (WidgetTester tester) async {
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await tester.pumpWidget(
          const MaterialApp(
            home: InterestsView(),
          ),
        );
        await tester.pumpAndSettle();
        final err = tester.takeException();
        if (err != null) {
          debugPrint('INTERESTS VIEW OVERFLOW AT ${size.width}: $err');
        }
        expect(err, isNull);

        // Tap a quick start preset
        final preset = find.text('Litigation & Forensics');
        if (preset.evaluate().isNotEmpty) {
          await tester.tap(preset, warnIfMissed: false);
          await tester.pumpAndSettle();
          expect(tester.takeException(), isNull);
        }

        // Switch category filter chip
        final categoryChip = find.text('Regulatory & Risk');
        if (categoryChip.evaluate().isNotEmpty) {
          await tester.tap(categoryChip.first, warnIfMissed: false);
          await tester.pumpAndSettle();
          expect(tester.takeException(), isNull);
        }
      });
    }
  });

  group('FluencyAssessmentView Responsiveness Tests', () {
    for (final size in testViewports) {
      testWidgets('Renders zero overflow at ${size.width}x${size.height}',
          (WidgetTester tester) async {
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await tester.pumpWidget(
          const MaterialApp(
            home: FluencyAssessmentView(),
          ),
        );
        await tester.pumpAndSettle();
        final err = tester.takeException();
        if (err != null) {
          debugPrint('FLUENCY ASSESSMENT OVERFLOW AT ${size.width}: $err');
        }
        expect(err, isNull);

        // Select an option (Option B)
        final optionB = find.text('B');
        if (optionB.evaluate().isNotEmpty) {
          await tester.tap(optionB.first, warnIfMissed: false);
          await tester.pumpAndSettle();
          expect(tester.takeException(), isNull);
        }

        // Tap Flag for Review
        final flagBtn = find.text('Flag');
        if (flagBtn.evaluate().isNotEmpty) {
          await tester.tap(flagBtn, warnIfMissed: false);
          await tester.pumpAndSettle();
          expect(tester.takeException(), isNull);
        }

        // Jump to Question 3 via Question Jumper
        final q3Jumper = find.text('3');
        if (q3Jumper.evaluate().isNotEmpty) {
          await tester.tap(q3Jumper, warnIfMissed: false);
          await tester.pumpAndSettle();
          expect(tester.takeException(), isNull);
        }

        // Tap Next Question
        final nextBtn = find.text('Next Question ➔');
        if (nextBtn.evaluate().isNotEmpty) {
          await tester.tap(nextBtn, warnIfMissed: false);
          await tester.pumpAndSettle();
          expect(tester.takeException(), isNull);
        }
      });
    }
  });

  group('MainNavigationView 5-Tab Navigation Tests', () {
    for (final size in testViewports) {
      testWidgets('Navigates Discover | Labs | Rooms | Builds | Fluency at ${size.width}x${size.height}',
          (WidgetTester tester) async {
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await tester.pumpWidget(
          const MaterialApp(
            home: MainNavigationView(),
          ),
        );
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);

        // Verify initial tab is Discover
        expect(find.byTooltip('Discover'), findsOneWidget);
        expect(find.byTooltip('Labs'), findsOneWidget);
        expect(find.byTooltip('Rooms'), findsOneWidget);
        expect(find.byTooltip('Builds'), findsOneWidget);
        expect(find.byTooltip('Fluency'), findsOneWidget);

        // Tap Labs (Tab 1)
        await tester.tap(find.byTooltip('Labs'));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);

        // Tap Rooms (Tab 2)
        await tester.tap(find.byTooltip('Rooms'));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);

        // Tap Builds (Tab 3)
        await tester.tap(find.byTooltip('Builds'));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);

        // Tap Fluency (Tab 4)
        await tester.tap(find.byTooltip('Fluency'));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);

        // Tap Discover (Tab 0)
        await tester.tap(find.byTooltip('Discover'));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
      });
    }
  });

  group('ProfileSetupView Responsiveness Tests', () {
    for (final size in testViewports) {
      testWidgets('Renders zero overflow at ${size.width}x${size.height}',
          (WidgetTester tester) async {
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await tester.pumpWidget(
          const MaterialApp(
            home: ProfileSetupView(),
          ),
        );
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
      });
    }
  });

  group('Onboarding Navigation Flow End-to-End Test', () {
    testWidgets('Follows Homepage -> Create Account -> Verify Email -> Profile Setup -> Interests -> Fluency Assessment -> Assessment Result -> Discover',
        (WidgetTester tester) async {
      // 1. App Open -> Homepage
      await tester.pumpWidget(
        const MaterialApp(
          home: HomepageView(),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Start Free'), findsOneWidget);
      expect(tester.takeException(), isNull);

      // 2. Tap Start Free -> Navigate to Create Account
      await tester.tap(find.text('Start Free'));
      await tester.pumpAndSettle();
      expect(find.byType(CreateAccountView), findsOneWidget);
      expect(tester.takeException(), isNull);

      // 3. Tap CREATE FREE ACCOUNT -> Navigate to Verify Email
      await tester.ensureVisible(find.text('CREATE FREE ACCOUNT'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('CREATE FREE ACCOUNT'));
      await tester.pumpAndSettle();
      expect(find.byType(VerifyEmailView), findsOneWidget);
      expect(tester.takeException(), isNull);

      // 4. Tap Verify & Continue -> Navigate to Profile Setup
      await tester.ensureVisible(find.text('Verify & Continue'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Verify & Continue'));
      await tester.pumpAndSettle();
      expect(find.byType(ProfileSetupView), findsOneWidget);
      expect(tester.takeException(), isNull);

      // 5. Tap Continue to Topic Interests -> Navigate to Interests
      await tester.ensureVisible(find.text('Continue to Topic Interests ➔'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Continue to Topic Interests ➔'));
      await tester.pumpAndSettle();
      expect(find.byType(InterestsView), findsOneWidget);
      expect(tester.takeException(), isNull);

      // 6. Tap Continue to Fluency Assessment -> Navigate to Fluency Assessment
      await tester.ensureVisible(find.text('Continue to Fluency Assessment'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Continue to Fluency Assessment'));
      await tester.pumpAndSettle();
      expect(find.byType(FluencyAssessmentView), findsOneWidget);
      expect(tester.takeException(), isNull);

      // 7. Tap Skip -> Directly navigates to Assessment Result
      await tester.pumpAndSettle();
      tester.widget<TextButton>(find.byKey(const Key('fluency_skip_button'))).onPressed!();
      await tester.pumpAndSettle();
      expect(find.byType(AssessmentResultView), findsOneWidget);
      expect(tester.takeException(), isNull);

      // 8. Tap Continue to Discover -> Lands on Discover (Main Navigation)
      await tester.tap(find.text('Continue to Discover ➔').first);
      await tester.pumpAndSettle();
      expect(find.byType(MainNavigationView), findsOneWidget);
      expect(find.byTooltip('Discover'), findsOneWidget);
      expect(find.byTooltip('Labs'), findsOneWidget);
      expect(find.byTooltip('Rooms'), findsOneWidget);
      expect(find.byTooltip('Builds'), findsOneWidget);
      expect(find.byTooltip('Fluency'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });

  group('PremiumLockedGateView Responsiveness Tests', () {
    for (final size in testViewports) {
      testWidgets('Renders zero overflow at ${size.width}x${size.height}',
          (WidgetTester tester) async {
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await tester.pumpWidget(
          const MaterialApp(
            home: PremiumLockedGateView(),
          ),
        );
        await tester.pumpAndSettle();
        final err = tester.takeException();
        if (err != null) {
          debugPrint('PREMIUM LOCKED GATE OVERFLOW AT ${size.width}: $err');
        }
        expect(err, isNull);
        expect(find.text('VIP ONLY'), findsOneWidget);
        expect(find.text('WHAT YOU UNLOCK WITH YOUNG VIP'), findsOneWidget);
      });
    }
  });

  group('AllAccessPricingView Responsiveness Tests', () {
    for (final size in testViewports) {
      testWidgets('Renders zero overflow at ${size.width}x${size.height}',
          (WidgetTester tester) async {
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await tester.pumpWidget(
          const MaterialApp(
            home: AllAccessPricingView(),
          ),
        );
        await tester.pumpAndSettle();
        final err = tester.takeException();
        expect(err, isNull);
        expect(find.text('All-Access Membership'), findsOneWidget);
        expect(find.text('Monthly (\$19 / mo)'), findsOneWidget);
        expect(find.text('\$149'), findsOneWidget);
      });
    }

    testWidgets('CustomDrawer contains and navigates to AllAccessPricingView',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(412, 915);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            drawer: CustomDrawer(),
            body: Center(child: Text('Home')),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final scaffoldState = tester.state<ScaffoldState>(find.byType(Scaffold));
      scaffoldState.openDrawer();
      await tester.pumpAndSettle();

      final pricingItem = find.text('All-Access Pricing');
      expect(pricingItem, findsOneWidget);
      expect(find.text('\$19/mo or \$149/yr subscription plans'), findsOneWidget);

      await tester.ensureVisible(pricingItem);
      await tester.pumpAndSettle();

      await tester.tap(pricingItem);
      await tester.pumpAndSettle();

      expect(find.text('All-Access Membership'), findsOneWidget);
      expect(find.text('OFFICIAL SUBSCRIPTION TIERS'), findsOneWidget);
      expect(find.text('Monthly (\$19 / mo)'), findsOneWidget);
      expect(find.text('\$149'), findsOneWidget);
      expect(find.text('FEATURE INCLUSION MATRIX'), findsOneWidget);
    });
  });


  group('ReviewExpertsView Responsiveness Tests', () {
    for (final size in testViewports) {
      testWidgets('Renders zero overflow at ${size.width}x${size.height}',
          (WidgetTester tester) async {
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await tester.pumpWidget(
          const MaterialApp(
            home: ReviewExpertsView(),
          ),
        );
        await tester.pumpAndSettle();
        final err = tester.takeException();
        expect(err, isNull);
        expect(find.text('Review Experts'), findsOneWidget);
        expect(find.text('EXPERT STUDIO GOVERNANCE'), findsOneWidget);
        expect(find.text('Dr. Aris Thorne'), findsOneWidget);
      });
    }

    testWidgets('CustomDrawer contains and navigates to ReviewExpertsView',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(412, 915);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            drawer: CustomDrawer(),
            body: Center(child: Text('Home')),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final scaffoldState = tester.state<ScaffoldState>(find.byType(Scaffold));
      scaffoldState.openDrawer();
      await tester.pumpAndSettle();

      final reviewItem = find.text('Review Experts');
      expect(reviewItem, findsOneWidget);
      expect(find.text('Approve or reject creator applications'), findsOneWidget);

      await tester.ensureVisible(reviewItem);
      await tester.pumpAndSettle();

      await tester.tap(reviewItem);
      await tester.pumpAndSettle();

      expect(find.text('Review Experts'), findsOneWidget);
      expect(find.text('EXPERT STUDIO GOVERNANCE'), findsOneWidget);
      expect(find.text('Dr. Aris Thorne'), findsOneWidget);
    });

    testWidgets('Approving and rejecting applications updates status',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(412, 915);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        const MaterialApp(
          home: ReviewExpertsView(),
        ),
      );
      await tester.pumpAndSettle();

      final approveButton = find.text('Approve Creator').first;
      await tester.ensureVisible(approveButton);
      await tester.pumpAndSettle();
      await tester.tap(approveButton);
      await tester.pumpAndSettle();

      expect(find.text('APPROVED'), findsAtLeastNWidgets(2));
    });
  });

  group('ApplyAsExpertView Responsiveness Tests', () {
    for (final size in testViewports) {
      testWidgets('Renders zero overflow at ${size.width}x${size.height}',
          (WidgetTester tester) async {
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await tester.pumpWidget(
          const MaterialApp(
            home: ApplyAsExpertView(),
          ),
        );
        await tester.pumpAndSettle();

        expect(tester.takeException(), isNull);
      });
    }

    testWidgets('CustomDrawer contains and navigates to ApplyAsExpertView',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(412, 915);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            drawer: const CustomDrawer(),
            body: Builder(
              builder: (ctx) => ElevatedButton(
                onPressed: () => Scaffold.of(ctx).openDrawer(),
                child: const Text('Open'),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      final drawerItem = find.text('Apply as Expert');
      expect(drawerItem, findsOneWidget);

      await tester.ensureVisible(drawerItem);
      await tester.pumpAndSettle();
      await tester.tap(drawerItem);
      await tester.pumpAndSettle();

      expect(find.text('Apply as Build Expert'), findsOneWidget);
      expect(find.text('BUILD EXPERT PROGRAM'), findsOneWidget);
      expect(find.text('Submit Build Expert Application'), findsOneWidget);
    });

    testWidgets('Submitting application shows success confirmation card',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(412, 915);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        const MaterialApp(
          home: ApplyAsExpertView(),
        ),
      );
      await tester.pumpAndSettle();

      final submitButton = find.text('Submit Build Expert Application');
      await tester.ensureVisible(submitButton);
      await tester.pumpAndSettle();
      await tester.tap(submitButton);
      await tester.pump(const Duration(milliseconds: 500));
      await tester.pump(const Duration(seconds: 1));
      await tester.pumpAndSettle();

      expect(find.text('Application Submitted!'), findsOneWidget);
      expect(find.text('EXP-2026-COH4-891'), findsOneWidget);
      expect(find.text('Return to Platform'), findsOneWidget);
    });
  });

  group('ApplicationReviewStatusView Responsiveness Tests', () {
    for (final size in testViewports) {
      testWidgets('Renders zero overflow at ${size.width}x${size.height}',
          (WidgetTester tester) async {
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await tester.pumpWidget(
          const MaterialApp(
            home: ApplicationReviewStatusView(),
          ),
        );
        await tester.pumpAndSettle();

        expect(tester.takeException(), isNull);
        expect(find.text('Your Application is Under Review'), findsOneWidget);
        expect(find.text('APPLICATION STATUS'), findsOneWidget);
        expect(find.text('EXP-2026-COH4-891'), findsOneWidget);
      });
    }

    testWidgets('CustomDrawer contains and navigates to ApplicationReviewStatusView',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(412, 915);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            drawer: const CustomDrawer(),
            body: Builder(
              builder: (ctx) => ElevatedButton(
                onPressed: () => Scaffold.of(ctx).openDrawer(),
                child: const Text('Open'),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      final drawerItem = find.text('Application Review');
      expect(drawerItem, findsOneWidget);
      expect(find.text('Your application is under review'), findsOneWidget);

      await tester.ensureVisible(drawerItem);
      await tester.pumpAndSettle();
      await tester.tap(drawerItem);
      await tester.pumpAndSettle();

      expect(find.text('Your Application is Under Review'), findsOneWidget);
      expect(find.text('APPLICATION STATUS'), findsOneWidget);
      expect(find.text('EXP-2026-COH4-891'), findsOneWidget);
    });

    testWidgets('Interactive actions: Refresh status and FAQ expansion',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(412, 915);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        const MaterialApp(
          home: ApplicationReviewStatusView(),
        ),
      );
      await tester.pumpAndSettle();

      final refreshButton = find.text('Refresh Review Status');
      await tester.ensureVisible(refreshButton);
      await tester.pumpAndSettle();
      await tester.tap(refreshButton);
      await tester.pump(const Duration(milliseconds: 300));
      await tester.pump(const Duration(seconds: 1));
      await tester.pumpAndSettle();

      expect(find.text('Application review status is up to date.'), findsOneWidget);
    });
  });

  group('BuildExpertApprovedView Responsiveness Tests', () {
    for (final size in testViewports) {
      testWidgets('Renders zero overflow at ${size.width}x${size.height}',
          (WidgetTester tester) async {
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await tester.pumpWidget(
          const MaterialApp(
            home: BuildExpertApprovedView(),
          ),
        );
        await tester.pumpAndSettle();

        expect(tester.takeException(), isNull);
        expect(find.text("You're Approved as a Build Expert!"), findsOneWidget);
        expect(find.text('EXP-AUTH-2026-COH4'), findsOneWidget);
        expect(find.text('ACCREDITATION CREDENTIAL'), findsOneWidget);
      });
    }

    testWidgets('CustomDrawer contains and navigates to BuildExpertApprovedView',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(412, 915);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            drawer: const CustomDrawer(),
            body: Builder(
              builder: (ctx) => ElevatedButton(
                onPressed: () => Scaffold.of(ctx).openDrawer(),
                child: const Text('Open'),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      final drawerItem = find.text('Expert Approved');
      expect(drawerItem, findsOneWidget);
      expect(find.text("You're approved as a Build Expert"), findsOneWidget);

      await tester.ensureVisible(drawerItem);
      await tester.pumpAndSettle();
      await tester.tap(drawerItem);
      await tester.pumpAndSettle();

      expect(find.text("You're Approved as a Build Expert!"), findsOneWidget);
      expect(find.text('EXP-AUTH-2026-COH4'), findsOneWidget);
      expect(find.text('Launch Expert Studio'), findsOneWidget);
    });

    testWidgets('Interactive checklist toggle and agreement modal view',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(412, 915);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        const MaterialApp(
          home: BuildExpertApprovedView(),
        ),
      );
      await tester.pumpAndSettle();

      final checklistItem = find.text('Configure Creator Payouts (Stripe Connect)');
      expect(checklistItem, findsOneWidget);
      await tester.ensureVisible(checklistItem);
      await tester.pumpAndSettle();
      await tester.tap(checklistItem);
      await tester.pumpAndSettle();

      final agreementButton = find.text('View Creator Agreement & Royalties');
      await tester.ensureVisible(agreementButton);
      await tester.pumpAndSettle();
      await tester.tap(agreementButton);
      await tester.pumpAndSettle();

      expect(find.text('Creator Agreement & Terms'), findsOneWidget);
      expect(find.text('70% Revenue Share'), findsOneWidget);
    });
  });

  group('ProposeLabView Responsiveness Tests', () {
    for (final size in testViewports) {
      testWidgets('Renders zero overflow at ${size.width}x${size.height}',
          (WidgetTester tester) async {
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await tester.pumpWidget(
          const MaterialApp(
            home: ProposeLabView(),
          ),
        );
        await tester.pumpAndSettle();

        expect(tester.takeException(), isNull);
        expect(find.text('Propose a New Lab'), findsOneWidget);
        expect(find.text('EXPERT STUDIO · AUTHORING'), findsOneWidget);
        expect(find.text('LAB PROPOSALS · COHORT 4'), findsOneWidget);
        expect(find.text('5-Stage Workflow Curriculum'), findsOneWidget);
      });
    }

    testWidgets('CustomDrawer contains and navigates to ProposeLabView',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(412, 915);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            drawer: const CustomDrawer(),
            body: Builder(
              builder: (ctx) => ElevatedButton(
                onPressed: () => Scaffold.of(ctx).openDrawer(),
                child: const Text('Open'),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      final drawerItem = find.text('Propose Lab');
      expect(drawerItem, findsOneWidget);
      expect(find.text('Submit a new lab proposal'), findsOneWidget);

      await tester.ensureVisible(drawerItem);
      await tester.pumpAndSettle();
      await tester.tap(drawerItem);
      await tester.pumpAndSettle();

      expect(find.text('Propose a New Lab'), findsOneWidget);
      expect(find.text('Submit Lab Proposal'), findsOneWidget);
    });

    testWidgets('Submitting proposal form transitions to success confirmation card',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(412, 915);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        const MaterialApp(
          home: ProposeLabView(),
        ),
      );
      await tester.pumpAndSettle();

      final submitBtn = find.text('Submit Lab Proposal');
      expect(submitBtn, findsOneWidget);
      await tester.ensureVisible(submitBtn);
      await tester.pumpAndSettle();
      await tester.tap(submitBtn);
      await tester.pumpAndSettle();

      expect(find.text('Lab Proposal Submitted!'), findsOneWidget);
      expect(find.text('PROP-LAB-2026-904'), findsOneWidget);
      expect(find.text('24 - 48 Hours'), findsOneWidget);
    });
  });

  group('ProposalApprovalStatusView Responsiveness Tests', () {
    for (final size in testViewports) {
      testWidgets('Renders zero overflow at ${size.width}x${size.height}',
          (WidgetTester tester) async {
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await tester.pumpWidget(
          const MaterialApp(
            home: ProposalApprovalStatusView(),
          ),
        );
        await tester.pumpAndSettle();

        expect(tester.takeException(), isNull);
        expect(find.text('Lab Proposal Under Review'), findsOneWidget);
        expect(find.text('PROPOSAL REVIEW STATE'), findsOneWidget);
        expect(find.text('PROP-LAB-2026-904'), findsOneWidget);
        expect(find.text('Evaluation Pipeline'), findsOneWidget);
        expect(find.text('Governance Scorecard'), findsOneWidget);
      });
    }

    testWidgets('CustomDrawer contains and navigates to ProposalApprovalStatusView',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(412, 915);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            drawer: const CustomDrawer(),
            body: Builder(
              builder: (ctx) => ElevatedButton(
                onPressed: () => Scaffold.of(ctx).openDrawer(),
                child: const Text('Open'),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      final drawerItem = find.text('Proposal Approval');
      expect(drawerItem, findsOneWidget);
      expect(find.text('Status screen — proposal review state'), findsOneWidget);

      await tester.ensureVisible(drawerItem);
      await tester.pumpAndSettle();
      await tester.tap(drawerItem);
      await tester.pumpAndSettle();

      expect(find.text('Lab Proposal Under Review'), findsOneWidget);
      expect(find.text('Inspect 5-Stage Proposal Artifact'), findsOneWidget);
    });

    testWidgets('Interactive stage switching and artifact modal inspection',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(412, 915);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        const MaterialApp(
          home: ProposalApprovalStatusView(),
        ),
      );
      await tester.pumpAndSettle();

      // Switch to Approved stage
      final approvedTab = find.text('Approved');
      expect(approvedTab, findsOneWidget);
      await tester.tap(approvedTab);
      await tester.pumpAndSettle();

      expect(find.text('Lab Proposal Approved & Ratified!'), findsOneWidget);
      expect(find.text('Launch Lab in Sandbox'), findsOneWidget);

      // Switch to Revisions stage
      final revisionsTab = find.text('Revisions');
      expect(revisionsTab, findsOneWidget);
      await tester.tap(revisionsTab);
      await tester.pumpAndSettle();

      expect(find.text('Revisions Requested'), findsOneWidget);
      expect(find.text('Calibrate Stage 2 Payload'), findsOneWidget);

      // Inspect full 5-stage proposal artifact
      final inspectButton = find.text('Inspect 5-Stage Proposal Artifact');
      await tester.ensureVisible(inspectButton);
      await tester.pumpAndSettle();
      await tester.tap(inspectButton);
      await tester.pumpAndSettle();

      expect(find.text('Full Lab Proposal Artifact'), findsOneWidget);
      expect(find.text('STAGE 01'), findsOneWidget);
      expect(find.text('Build It — Multi-Agent Architecture'), findsOneWidget);
    });
  });

  group('LabBuilderView Responsiveness Tests', () {
    for (final size in testViewports) {
      testWidgets('Renders zero overflow at ${size.width}x${size.height}',
          (WidgetTester tester) async {
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await tester.pumpWidget(
          const MaterialApp(
            home: LabBuilderView(),
          ),
        );
        await tester.pumpAndSettle();

        expect(tester.takeException(), isNull);
        expect(find.text('LAB BUILDER · AUTHORING ENGINE'), findsOneWidget);
        expect(find.text('Stage Educational Objective'), findsOneWidget);
        expect(find.text('Student Task & Instructions'), findsOneWidget);
        expect(find.text('Publish Lab to Network'), findsOneWidget);
      });
    }

    testWidgets('CustomDrawer contains and navigates to LabBuilderView',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(412, 915);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            drawer: const CustomDrawer(),
            body: Builder(
              builder: (ctx) => ElevatedButton(
                onPressed: () => Scaffold.of(ctx).openDrawer(),
                child: const Text('Open'),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      final drawerItem = find.text('Lab Builder');
      expect(drawerItem, findsOneWidget);
      expect(find.text('Full editor to build lab content'), findsOneWidget);

      await tester.ensureVisible(drawerItem);
      await tester.pumpAndSettle();
      await tester.tap(drawerItem);
      await tester.pumpAndSettle();

      expect(find.text('LAB BUILDER · AUTHORING ENGINE'), findsOneWidget);
      expect(find.text('Publish Lab to Network'), findsOneWidget);
    });

    testWidgets('Interactive tab switching and stress-test suite execution',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(412, 915);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        const MaterialApp(
          home: LabBuilderView(),
        ),
      );
      await tester.pumpAndSettle();

      // Switch to Code & Sandbox tab
      final codeTab = find.text('Code & Sandbox');
      expect(codeTab, findsOneWidget);
      await tester.tap(codeTab);
      await tester.pumpAndSettle();

      expect(find.text('Sandbox Hardware Profile'), findsOneWidget);
      expect(find.text('Runtime Pip Dependencies'), findsOneWidget);

      // Switch to Canary Evals tab
      final canaryTab = find.text('Canary Evals');
      expect(canaryTab, findsOneWidget);
      await tester.tap(canaryTab);
      await tester.pumpAndSettle();

      expect(find.text('Live Sandbox Stress-Test Runner'), findsOneWidget);

      // Run suite test
      final runSuiteBtn = find.text('Run Suite');
      expect(runSuiteBtn, findsOneWidget);
      await tester.tap(runSuiteBtn);
      await tester.pumpAndSettle();

      expect(find.text('ALL TESTS PASSED'), findsOneWidget);

      // Tap Publish Lab to Network
      final publishBtn = find.text('Publish Lab to Network');
      await tester.ensureVisible(publishBtn);
      await tester.pumpAndSettle();
      await tester.tap(publishBtn);
      await tester.pumpAndSettle();

      expect(find.text('Publish Lab to Live Catalog'), findsOneWidget);
      expect(find.text('Confirm & Publish to Network'), findsOneWidget);
    });
  });

  group('LabPreviewView Responsiveness Tests', () {
    for (final size in testViewports) {
      testWidgets('Renders zero overflow at ${size.width}x${size.height}',
          (WidgetTester tester) async {
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await tester.pumpWidget(
          const MaterialApp(
            home: LabPreviewView(),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(LabPreviewView), findsOneWidget);
        expect(tester.takeException(), isNull);
      });
    }

    testWidgets('CustomDrawer contains and navigates to LabPreviewView',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(375, 667);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            drawer: const CustomDrawer(),
            body: Builder(
              builder: (ctx) => Center(
                child: ElevatedButton(
                  onPressed: () => Scaffold.of(ctx).openDrawer(),
                  child: const Text('Open Drawer'),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Open Drawer'));
      await tester.pumpAndSettle();

      final drawerItem = find.text('Lab Preview');
      expect(drawerItem, findsOneWidget);
      await tester.ensureVisible(drawerItem);
      await tester.pumpAndSettle();

      await tester.tap(drawerItem);
      await tester.pumpAndSettle();

      expect(find.byType(LabPreviewView), findsOneWidget);
      expect(find.text('Fine-Tuning Mistral 7B with QLoRA on Dual A100'),
          findsOneWidget);
    });

    testWidgets(
        'Interactive mode toggle, stage switching, and submission bottom-sheet',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(412, 915);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        const MaterialApp(
          home: LabPreviewView(),
        ),
      );
      await tester.pumpAndSettle();

      // Verify initial Student Experience mode
      expect(find.text('Student Experience View'), findsOneWidget);
      expect(find.text('Stage 1: Build It'), findsWidgets);

      // Toggle to Expert Inspector View
      final expertTab = find.text('Expert Inspector View');
      expect(expertTab, findsOneWidget);
      await tester.tap(expertTab);
      await tester.pumpAndSettle();

      expect(find.text('Hidden Canary Assertions (PyTest)'), findsOneWidget);
      expect(find.text('CONFIDENTIAL EVAL'), findsOneWidget);

      // Switch to Stage 2: Break It
      final stage2 = find.text('Stage 2: Break It');
      expect(stage2, findsOneWidget);
      await tester.ensureVisible(stage2);
      await tester.pumpAndSettle();
      await tester.tap(stage2);
      await tester.pumpAndSettle();

      expect(find.text('STAGE 2 · ADVERSARIAL STRESS'), findsOneWidget);

      // Tap Primary CTA: Submit Lab for Governance Review
      final submitBtn = find.text('Submit Lab for Governance Review');
      await tester.ensureVisible(submitBtn);
      await tester.pumpAndSettle();
      await tester.tap(submitBtn);
      await tester.pumpAndSettle();

      expect(find.text('Submit Lab for Governance'), findsOneWidget);
      expect(find.text('Confirm & Submit for Review'), findsOneWidget);
    });
  });

  group('SubmitRevisionView Responsiveness Tests', () {
    for (final size in testViewports) {
      testWidgets('Renders zero overflow at ${size.width}x${size.height}',
          (WidgetTester tester) async {
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await tester.pumpWidget(
          const MaterialApp(
            home: SubmitRevisionView(),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(SubmitRevisionView), findsOneWidget);
        expect(tester.takeException(), isNull);
      });
    }

    testWidgets('CustomDrawer contains and navigates to SubmitRevisionView',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(375, 667);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            drawer: const CustomDrawer(),
            body: Builder(
              builder: (ctx) => Center(
                child: ElevatedButton(
                  onPressed: () => Scaffold.of(ctx).openDrawer(),
                  child: const Text('Open Drawer'),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Open Drawer'));
      await tester.pumpAndSettle();

      final drawerItem = find.text('Submit & Revision');
      expect(drawerItem, findsOneWidget);
      await tester.ensureVisible(drawerItem);
      await tester.pumpAndSettle();

      await tester.tap(drawerItem);
      await tester.pumpAndSettle();

      expect(find.byType(SubmitRevisionView), findsOneWidget);
      expect(find.text('Submit & Revision'), findsWidgets);
      expect(find.text('Submit lab + handle revision requests'), findsOneWidget);
    });

    testWidgets(
        'Interactive revision item toggle and revision submission bottom-sheet',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(412, 915);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        const MaterialApp(
          home: SubmitRevisionView(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Requested Revision Items'), findsOneWidget);
      expect(find.text('2 / 3 RESOLVED'), findsOneWidget);

      // Tap 3rd item actionTask to mark as resolved
      final thirdItem = find.text(
          'Add gradient checkpointing safeguard in Stage 2 starter code snippet');
      expect(thirdItem, findsOneWidget);
      await tester.ensureVisible(thirdItem);
      await tester.pumpAndSettle();
      await tester.tap(thirdItem);
      await tester.pumpAndSettle();

      expect(find.text('3 / 3 RESOLVED'), findsOneWidget);

      // Tap Primary CTA: Submit Revised Lab for Review
      final submitBtn = find.text('Submit Revised Lab for Review');
      await tester.ensureVisible(submitBtn);
      await tester.pumpAndSettle();
      await tester.tap(submitBtn);
      await tester.pumpAndSettle();

      expect(find.text('Submit Revision v1.3'), findsOneWidget);
      expect(find.text('Confirm & Send Revision to Board'), findsOneWidget);

      // Confirm submission
      final confirmBtn = find.text('Confirm & Send Revision to Board');
      await tester.tap(confirmBtn);
      await tester.pumpAndSettle();

      expect(find.text('RE-SUBMITTED · IN REVIEW'), findsOneWidget);
    });
  });
}




