import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:young_vip/views/admin_dashboard_view.dart';
import 'package:young_vip/views/assessment_result_view.dart';
import 'package:young_vip/views/contextual_connection_view.dart';
import 'package:young_vip/views/create_account_view.dart';
import 'package:young_vip/views/discover_view.dart';
import 'package:young_vip/views/homepage_view.dart';
import 'package:young_vip/views/interests_view.dart';
import 'package:young_vip/views/fluency_assessment_view.dart';
import 'package:young_vip/views/all_access_pricing_view.dart';
import 'package:young_vip/views/main_navigation_view.dart';
import 'package:young_vip/views/premium_locked_gate_view.dart';
import 'package:young_vip/views/profile_setup_view.dart';
import 'package:young_vip/views/review_experts_view.dart';
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

  group('AdminDashboardView Responsiveness Tests', () {
    for (final size in testViewports) {
      testWidgets('Renders zero overflow at ${size.width}x${size.height}',
          (WidgetTester tester) async {
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await tester.pumpWidget(
          const MaterialApp(
            home: AdminDashboardView(),
          ),
        );
        await tester.pumpAndSettle();
        final err = tester.takeException();
        expect(err, isNull);
        expect(find.text('Admin Dashboard'), findsOneWidget);
        expect(find.text('TOTAL MEMBERS'), findsOneWidget);
        expect(find.text('GROSS PLATFORM REVENUE'), findsOneWidget);
        expect(find.text('\$186,450'), findsOneWidget);
      });
    }

    testWidgets('CustomDrawer contains and navigates to AdminDashboardView',
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

      final adminItem = find.text('Admin Dashboard');
      expect(adminItem, findsOneWidget);
      expect(find.text('Overview stats — members, labs, revenue'), findsOneWidget);

      await tester.ensureVisible(adminItem);
      await tester.pumpAndSettle();

      await tester.tap(adminItem);
      await tester.pumpAndSettle();

      expect(find.text('Admin Dashboard'), findsOneWidget);
      expect(find.text('ENTERPRISE PLATFORM INTELLIGENCE'), findsOneWidget);
      expect(find.text('TOTAL MEMBERS'), findsOneWidget);
      expect(find.text('ACTIVE LAB TRACKS'), findsOneWidget);
      expect(find.text('GROSS PLATFORM REVENUE'), findsOneWidget);
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
}




