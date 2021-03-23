class Pair<E,F> {
  final E left;
  final F right;

  const Pair(this.left, this.right);

  @override
  String toString() => 'Pair[$left, $right]';
}