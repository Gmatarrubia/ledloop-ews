import 'package:flutter/material.dart';
import 'package:ews_ledloop/services/api_service.dart';
import 'package:ews_ledloop/resources/ui_constants.dart';
import 'package:ews_ledloop/providers/figures_provider.dart';

class QuickActionsButton extends StatelessWidget {
  const QuickActionsButton({
    super.key,
    required this.figureProvider,
    required this.api,
  });

  final FiguresProvider figureProvider;
  final ApiService api;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kCornerRadius)),
      minWidth: double.infinity,
      height: 70.0,
      color: appTheme.secondaryHeaderColor,
      onPressed: () {
        _displayBottomSheet(context);
      },
      child: const Icon(
        Icons.play_arrow,
      ),
    );
  }

  Future _displayBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      showDragHandle: false,
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.add),
              title: Text('Agregar'),
              onTap: () {
                // Acción cuando se toca la opción de agregar
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('Editar'),
              onTap: () {
                // Acción cuando se toca la opción de editar
                Navigator.pop(context);
              },
            ),
            // Agrega más opciones según sea necesario
          ],
        );
      },
    );
  }
}
