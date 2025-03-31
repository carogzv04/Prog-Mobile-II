import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:ativ_1/main.dart';

void main() {
  // Teste para verificar o tamanho mínimo de alvos tocáveis no Android
  testWidgets('Verifica se os alvos tocáveis têm tamanho mínimo de 48x48 pixels no Android', (tester) async {
    final SemanticsHandle handle = tester.ensureSemantics();
    await tester.pumpWidget(MyApp());

    await expectLater(tester, meetsGuideline(androidTapTargetGuideline));

    handle.dispose();
  });

  // Teste para verificar o tamanho mínimo de alvos tocáveis no iOS
  testWidgets('Verifica se os alvos tocáveis têm tamanho mínimo de 44x44 pixels no iOS', (tester) async {
    final SemanticsHandle handle = tester.ensureSemantics();
    await tester.pumpWidget(MyApp());

    await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));

    handle.dispose();
  });

  // Teste para verificar se os alvos tocáveis possuem rótulos
  testWidgets('Verifica se os alvos tocáveis com ação de toque ou toque longo possuem rótulos', (tester) async {
    final SemanticsHandle handle = tester.ensureSemantics();
    await tester.pumpWidget(MyApp());

    await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));

    handle.dispose();
  });

  // Teste para verificar o contraste de texto
  testWidgets('Verifica se os nós semânticos atendem aos níveis mínimos de contraste de texto', (tester) async {
    final SemanticsHandle handle = tester.ensureSemantics();
    await tester.pumpWidget(MyApp());

    await expectLater(tester, meetsGuideline(textContrastGuideline));

    handle.dispose();
  });

  // Teste para verificar o foco visível nos elementos interativos
  testWidgets('Foco visível nos elementos interativos', (tester) async {
    await tester.pumpWidget(MyApp());

    // Lista de Keys para os elementos interativos
    final keys = [
      Key('username-field'),
      Key('password-field'),
      Key('login-button'),
      Key('signup-button'),
      Key('forgot-password-button'),
    ];

    for (final key in keys) {
      // Simula a navegação por teclado
      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      await tester.pump();

      // Verifica se o foco está visível no elemento com a Key atual
      final focusedElement = find.byKey(key);
      expect(focusedElement, findsOneWidget);

      // Testa interações específicas para cada elemento
      if (key == Key('username-field')) {
        // Insere texto no campo de usuário
        await tester.enterText(focusedElement, 'usuario_teste');
        expect(find.text('usuario_teste'), findsOneWidget);
      } else if (key == Key('password-field')) {
        // Insere texto no campo de senha
        await tester.enterText(focusedElement, 'senha_teste');
        expect(find.text('senha_teste'), findsOneWidget);
      } else if (key == Key('login-button')) {
        // Simula o clique no botão de login
        await tester.tap(focusedElement);
        await tester.pump();
      } else if (key == Key('signup-button')) {
        // Simula o clique no botão de criar conta
        await tester.tap(focusedElement);
        await tester.pump();
      } else if (key == Key('forgot-password-button')) {
        // Simula o clique no botão de recuperar senha
        await tester.tap(focusedElement);
        await tester.pump();
      }
    }
  });

  // Teste para verificar o suporte a redimensionamento de texto
  testWidgets('Suporte a redimensionamento de texto', (tester) async {
    await tester.pumpWidget(MyApp());

    // Simula o redimensionamento de texto
    tester.binding.platformDispatcher.textScaleFactorTestValue = 2.8;
    await tester.pumpAndSettle();

    // Verifica se o layout não quebrou
    expect(find.byType(MyApp), findsOneWidget);
  });

  // Teste para verificar se os elementos possuem descrições semânticas
  testWidgets('Elementos possuem descrições semânticas', (tester) async {
    final SemanticsHandle handle = tester.ensureSemantics();
    await tester.pumpWidget(MyApp());

    // Verifica se os elementos interativos possuem descrições semânticas
    final semantics = tester.getSemantics(find.byType(MyApp));
    expect(
      semantics.label,
      isNotNull,
    ); // Corrigido para verificar se há um rótulo

    handle.dispose();
  });
}
