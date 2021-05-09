import 'package:app_sangfor/animations/custom_rect_tween.dart';
import 'package:app_sangfor/models/details_model.dart';
import 'package:app_sangfor/styles.dart';
import 'package:flutter/material.dart';
import 'hero_dialog_route.dart';

/// {@template todo_card}
/// Card that display a [Todo]'s content.
///
/// On tap it opens a [HeroDialogRoute] with [_InfoPopupCard] as the content.
/// {@endtemplate}
class InfoCard extends StatelessWidget {
  /// {@macro todo_card}
  const InfoCard({
    required this.model,
  });

  final DetailsModel model;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          HeroDialogRoute(
            builder: (context) => Center(
              child: _InfoPopupCard(model: model),
            ),
          ),
        );
      },
      child: Hero(
        createRectTween: (begin, end) {
          return CustomRectTween(begin: begin!, end: end!);
        },
        tag: model.id,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Material(
            color: AppColors.cardColor,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  _InfoTitle(title: model.title),
                  const SizedBox(
                    height: 8,
                  )
                ],
              ),
            ),
          ),
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
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
    );
  }
}

/// {@template todo_popup_card}
/// Popup card to expand the content of a [Todo] card.
///
/// Activated from [_InfoCard].
/// {@endtemplate}
class _InfoPopupCard extends StatelessWidget {
  const _InfoPopupCard({required this.model});
  final DetailsModel model;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: model.id,
      createRectTween: (begin, end) {
        return CustomRectTween(begin: begin!, end: end!);
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Material(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.cardColor,
          child: SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _InfoTitle(title: model.title),
                    const SizedBox(
                      height: 8,
                    ),
                    ...[
                      const Divider(),
                      _InfoItemsBox(items: model.items),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// {@template todo_items_box}
/// Box containing the list of a [Todo]'s items.
///
/// These items can be checked.
/// {@endtemplate}
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