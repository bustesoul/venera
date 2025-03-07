part of 'components.dart';

class MouseBackDetector extends StatelessWidget {
  const MouseBackDetector(
      {super.key, required this.onTapDown, required this.child});

  final Widget child;

  final void Function() onTapDown;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (event) {
        if (event.buttons == kBackMouseButton) {
          onTapDown();
        }
      },
      behavior: HitTestBehavior.translucent,
      child: child,
    );
  }
}

class AnimatedTapRegion extends StatefulWidget {
  const AnimatedTapRegion({
    super.key,
    required this.child,
    required this.onTap,
    this.borderRadius = 0,
  });

  final Widget child;

  final void Function() onTap;

  final double borderRadius;

  @override
  State<AnimatedTapRegion> createState() => _AnimatedTapRegionState();
}

class _AnimatedTapRegionState extends State<AnimatedTapRegion> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          isHovered = false;
        });
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedPhysicalModel(
          duration: _fastAnimationDuration,
          elevation: isHovered ? 3 : 1,
          color: context.colorScheme.surface,
          shadowColor: context.colorScheme.shadow,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          child: widget.child,
        ),
      ),
    );
  }
}
