import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bookswap_app/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the app starts with login screen
    expect(find.text('BookSwap'), findsOneWidget);
    expect(find.text('Swap Your Books\nWith Other Students'), findsOneWidget);
    expect(find.text('Sign In'), findsAtLeast(1));
  });

  testWidgets('Login screen has email and password fields', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Verify email and password fields exist
    expect(find.byType(TextField), findsAtLeast(2));
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
  });

  testWidgets('Sign up navigation works', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Find and tap the Sign Up button
    final signUpButton = find.text('Sign Up');
    expect(signUpButton, findsOneWidget);
    
    await tester.tap(signUpButton);
    await tester.pumpAndSettle();

    // Verify navigation to sign up screen
    expect(find.text('Create Account'), findsOneWidget);
    expect(find.text('Full Name'), findsOneWidget);
  });
}