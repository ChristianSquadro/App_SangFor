import 'package:app_sangfor/models/details_model.dart';
import 'package:app_sangfor/styles.dart';
import 'package:flutter/material.dart';

class DetailsCard extends StatelessWidget {

  const DetailsCard({
    required this.model,
  });

  final DetailsModel model;

  @override
  Widget build(BuildContext context) {
    return Material(
            color: AppColors.cardColor,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  _InfoTitle(title: model.title),
                  const SizedBox(
                    height: 8,
                  ),
                  ...[
                    const Divider(),
                    _InfoItemsBox(items: model.items),
                  ]
                ],
              ),
            ),
          );
  }
}

/// {@template todo_title}
/// Title of a [Todo].
/// {@endtemplate}
class _InfoTitle extends StatelessWidget {
  /// {@macro todo_title}
  const _InfoTitle({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 19, color: Colors.white),
    );
  }
}

class _InfoItemsBox extends StatelessWidget {
  /// {@macro todo_items_box}
  const _InfoItemsBox({
    required this.items,
  });

  final List<DetailsItem> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final item in items) Text(item.key.toUpperCase()+": "+item.value, style: TextStyle(color: Colors.white, fontSize: 15),),
      ],
    );
  }
}