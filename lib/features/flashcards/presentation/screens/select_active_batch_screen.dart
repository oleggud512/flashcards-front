import 'package:flashcards/core/extensions/dev.dart';
import 'package:material_ui/material_ui.dart';

class SelectActiveBatchScreen extends StatelessWidget {
  const SelectActiveBatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select active batch'.hc)),
      body: SingleChildScrollView(
        padding: .all(16),
        child: Column(
          spacing: 16,
          crossAxisAlignment: .stretch,
          mainAxisSize: .min,
          children: [
            //
          ],
        ),
      ),
    );
  }
}
