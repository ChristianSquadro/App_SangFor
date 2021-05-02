import 'package:meta/meta.dart';

/// {@template todo}
/// Model for a todo. Can contain an optional list of [items] for
/// additional sub-todos.
/// {@endtemplate}
class DetailsModel {
  /// {@macro todo}
  const DetailsModel({
    required this.id,
    required this.title,
    required this.showHero,
    required this.items,
  });

  /// The id of this todo.
  final String id;

  final String title;

  final bool showHero;

  /// A list of [DetailsItem]s for sub-todos.
  final List<DetailsItem> items;
}

/// {@template item}
/// An individual item model, used within a [DetailsModel].
/// {@endtemplate}
class DetailsItem {
  /// {@macro item}
  DetailsItem({
    required this.key,
    required this.value,
  });

  /// The id of this item.
  final String key;

  /// Description of this item.
  final String value;

}
