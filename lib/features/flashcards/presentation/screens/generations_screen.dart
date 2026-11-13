import 'package:flashcards/core/extensions/dev.dart';
import 'package:flashcards/core/navigation/app_routes.dart';
import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';

class GenerationsScreen extends StatelessWidget {
  const GenerationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Generations".hc),
        actions: [
          IconButton(
            onPressed: () {
              context.goNamed(AppRoutes.createRequest.name);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
