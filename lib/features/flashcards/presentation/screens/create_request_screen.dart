import 'package:flashcards/core/extensions/dev.dart';
import 'package:flashcards/core/navigation/app_routes.dart';
import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';

class CreateRequestScreen extends StatelessWidget {
  const CreateRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Request'.hc)),
      body: SingleChildScrollView(
        padding: .all(16),
        child: Column(
          crossAxisAlignment: .stretch,
          mainAxisSize: .min,
          spacing: 16,
          children: [
            TextFormField(decoration: InputDecoration(hintText: 'Word')),
            TextFormField(
              decoration: InputDecoration(hintText: 'Additional Params'),
            ),
            FilledButton(
              onPressed: () {
                context.goNamed(AppRoutes.selectActiveBatch.name);
              },
              child: Text('Batch: ${'some batch'.hc}'),
            ),
            ListTile(
              title: Text('Start generating'.hc),
              trailing: Checkbox(
                onChanged: (v) {
                  //
                },
                value: false,
              ),
            ),
            FilledButton.icon(
              onPressed: () {
                //
              },
              label: Text('Add'.hc),
              icon: Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
