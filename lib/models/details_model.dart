import 'package:meta/meta.dart';

/// {@template todo}
/// Model for a todo. Can contain an optional list of [items] for
/// additional sub-todos.
/// {@endtemplate}
class DetailsModel {
  /// {@macro todo}
  const DetailsModel({
    this.id="",
    required this.title,
    this.items= const [],
    this.images=const []
  });

  /// The id of this todo.
  final String id;

  final String title;

  /// A list of [DetailsItem]s for sub-todos.
  final List<DetailsItem> items;

  final List<DetailsImage> images;
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

/// {@template item}
/// An individual item model, used within a [DetailsModel].
/// {@endtemplate}
class DetailsImage {
  /// {@macro item}
  DetailsImage({
    required this.pathImage,
    required this.value,
  });

  /// The id of this item.
  final String pathImage;

  /// Description of this item.
  final String value;

}
