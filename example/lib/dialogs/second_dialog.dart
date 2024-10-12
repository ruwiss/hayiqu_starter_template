
import 'package:flutter/material.dart';
import 'package:hayiqu/hayiqu.dart';

const String placeholder = '''
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Scripta periculis ei eam, te pro movet reformidans. Eos verear percipit ex, eos ne eligendi inimicus. Pri posse graeco definitiones cu, id eam populo quaestio adipiscing, usu quod malorum te. Offendit eleifend moderatius ex vix, quem odio mazim et qui, purto expetendis cotidieque quo cu, veri persius vituperata ei nec. Pri viderer tamquam ei. Partiendo adversarium no mea. Offendit eleifend moderatius ex vix, quem odio mazim et qui, purto expetendis cotidieque quo cu, veri persius vituperata ei nec. No vis iuvaret appareat. Scripta periculis ei eam, te pro movet reformidans. Scripta periculis ei eam, te pro movet reformidans. Offendit eleifend moderatius ex vix, quem odio mazim et qui, purto expetendis cotidieque quo cu, veri persius vituperata ei nec. Ad doctus gubergren duo, mel te postea suavitate. Liber nusquam insolens has ei, appetere accusamus intellegam id ius.
''';

class SecondDialogPage extends StatelessWidget {
  const SecondDialogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'And a bigger dialog',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Text(placeholder),
            TextButton(
              onPressed: () => DialogNavigator.of(context).pop(),
              child: const Text('Go back'),
            ),
            TextButton(
              onPressed: () => DialogNavigator.of(context).close(),
              child: const Text('Close the dialog'),
            ),
          ],
        ),
      ),
    );
  }
}
