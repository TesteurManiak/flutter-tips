/// Returns a [Stack] widget with multiple gradients overlapped in the
/// background.
class StackedGradients extends StatelessWidget {
  final Widget child;
  final List<Gradient> gradients;

  const StackedGradients({
    Key? key,
    required this.child,
    required this.gradients,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        for (final e in gradients)
          Positioned.fill(
            child: DecoratedBox(decoration: BoxDecoration(gradient: e)),
          ),
        child,
      ],
    );
  }
}
