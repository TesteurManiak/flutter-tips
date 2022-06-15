/// A checkbox updating itself according to the state of its [child] if it
/// contains another [DeepCheckbox].
///
/// Example:
/// ```dart
/// class CheckboxesPage extends StatelessWidget {
///   const CheckboxesPage({Key? key}) : super(key: key);
///
///   @override
///   Widget build(BuildContext context) {
///     return Scaffold(
///       body: DeepCheckbox(
///         label: 'Level 1',
///         child: Padding(
///           padding: const EdgeInsets.only(left: 20),
///           child: Column(
///             crossAxisAlignment: CrossAxisAlignment.start,
///             mainAxisSize: MainAxisSize.min,
///             children: const [
///               DeepCheckbox(label: 'Level 2-1'),
///               DeepCheckbox(label: 'Level 2-2'),
///             ],
///           ),
///         ),
///       ),
///     );
///   }
/// }
/// ```
class DeepCheckbox extends StatefulWidget {
  final String label;
  final bool initialValue;
  final ValueChanged<bool?>? onChanged;
  final Widget? child;

  const DeepCheckbox({
    Key? key,
    required this.label,
    this.child,
    this.initialValue = false,
    this.onChanged,
  }) : super(key: key);

  static DeepCheckboxState? of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<_CheckboxScope>();
    return scope?._deepCheckboxState;
  }

  @override
  State<DeepCheckbox> createState() => DeepCheckboxState();
}

class DeepCheckboxState extends State<DeepCheckbox> {
  final _checkboxes = <DeepCheckboxState>{};

  int _generation = 0;
  bool? _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initialValue;
  }

  @override
  void deactivate() {
    DeepCheckbox.of(context)?._unregister(this);
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    DeepCheckbox.of(context)?._register(this);
    final child = widget.child;
    return _CheckboxScope(
      deepCheckboxState: this,
      generation: _generation,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Checkbox(
                tristate: true,
                value: _selected,
                onChanged: _onChanged,
              ),
              Text(widget.label),
            ],
          ),
          if (child != null) child,
        ],
      ),
    );
  }

  void _onChanged(bool? value) {
    setState(() => _selected = value ?? false);

    // Notify the parent if it exists
    DeepCheckbox.of(context)?._fieldDidChange(_selected);

    // Update all registered childrens
    for (final checkboxState in _checkboxes) {
      checkboxState._onChanged(value);
    }
  }

  void _fieldDidChange(bool? value) {
    widget.onChanged?.call(value);

    final hasSelectedBox =
        _checkboxes.any((box) => (box._selected ?? false) == true);
    final hasNullBox = _checkboxes.any((box) => box._selected == null);
    final hasUnselectedBox =
        _checkboxes.any((box) => (box._selected ?? false) == false);

    final bool? selected;
    if (hasSelectedBox && !hasNullBox && !hasUnselectedBox) {
      selected = true;
    } else if (!hasSelectedBox && !hasNullBox && hasUnselectedBox) {
      selected = false;
    } else {
      selected = null;
    }

    setState(() {
      _selected = selected;
      ++_generation;
    });

    // Notify the parent if it exists.
    DeepCheckbox.of(context)?._fieldDidChange(selected);
  }

  void _register(DeepCheckboxState checkbox) {
    _checkboxes.add(checkbox);
  }

  void _unregister(DeepCheckboxState checkbox) {
    _checkboxes.remove(checkbox);
  }
}

class _CheckboxScope extends InheritedWidget {
  final DeepCheckboxState _deepCheckboxState;

  /// Incremented every time a checkbox has changed. This lets us know when
  /// to rebuild.
  final int _generation;

  const _CheckboxScope({
    Key? key,
    required Widget child,
    required DeepCheckboxState deepCheckboxState,
    required int generation,
  })  : _deepCheckboxState = deepCheckboxState,
        _generation = generation,
        super(
          key: key,
          child: child,
        );

  @override
  bool updateShouldNotify(_CheckboxScope old) => _generation != old._generation;
}
