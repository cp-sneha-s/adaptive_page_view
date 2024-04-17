import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThreePageScrollView extends StatefulWidget {
  final Widget current;
  final Widget? next;
  final Widget? previous;
  final Function(int)? onPageChanged;

  const ThreePageScrollView({
    super.key,
    required this.current,
    this.next,
    this.previous,
    required this.onPageChanged,
  });

  @override
  State<ThreePageScrollView> createState() => _ThreePageScrollViewState();
}

class _ThreePageScrollViewState extends State<ThreePageScrollView> {
  late PageController _pageController;

  double? _currentItemHeight;
  late int currentPage;

  @override
  void initState() {
    super.initState();
    currentPage = widget.previous == null ? 0 : 1;

    _pageController = PageController(initialPage: currentPage);
    _pageController.addListener(() {
      final newPage = _pageController.page?.toInt();
      if (newPage == null || newPage.toDouble() != _pageController.page) return;

      if (newPage == currentPage) {
        return;
      }

      _pageController.jumpToPage(1);
      widget.onPageChanged!(newPage > currentPage ? 1 : -1);
      currentPage = 1;
    });
  }

  @override
  void didUpdateWidget(covariant ThreePageScrollView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.previous != oldWidget.previous) {
      final newPage = widget.previous == null ? 0 : 1;
      if (newPage != currentPage) {
        currentPage = newPage;
        _pageController.jumpToPage(newPage);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Opacity(
          opacity: 0,
          child: SizeNotifierWidget(
            child: widget.current,
            onSizeChange: (size) {
              setState(() {
                _currentItemHeight = size.height;
              });
            },
          ),
        ),
        SizedBox(
            height: _currentItemHeight ?? 0,
            child: PageView(
              controller: _pageController,
              physics: const FastPageViewScrollPhysics(),
              children: [
                if (widget.previous != null)
                  widget.previous!,
                widget.current,
                if (widget.next != null)
                  widget.next!,
              ],
            )),
      ],
    );
  }
}

class SizeNotifierWidget extends StatefulWidget {
  final Widget child;
  final ValueChanged<Size> onSizeChange;

  const SizeNotifierWidget({
    super.key,
    required this.child,
    required this.onSizeChange,
  });

  @override
  State<SizeNotifierWidget> createState() => _SizeNotifierWidgetState();
}

class _SizeNotifierWidgetState extends State<SizeNotifierWidget> {
  Size? _oldSize;

  @override
  void didUpdateWidget(covariant SizeNotifierWidget oldWidget) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _notifySize());
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void _notifySize() {
    final size = context.size;
    if (size != null && _oldSize != size) {
      _oldSize = size;
      widget.onSizeChange(size);
    }
  }
}

class FastPageViewScrollPhysics extends ScrollPhysics {
  const FastPageViewScrollPhysics({super.parent});

  @override
  FastPageViewScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return FastPageViewScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  SpringDescription get spring => const SpringDescription(
        mass: 80,
        stiffness: 100,
        damping: 1,
      );
}
