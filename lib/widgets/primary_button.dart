import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class PrimaryButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
  });

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.96).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    if (widget.onPressed != null && !widget.isLoading) {
      _controller.forward();
    }
  }

  void _onTapUp(TapUpDetails details) {
    if (widget.onPressed != null && !widget.isLoading) {
      _controller.reverse();
    }
  }

  void _onTapCancel() {
    if (widget.onPressed != null && !widget.isLoading) {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEnabled = widget.onPressed != null && !widget.isLoading;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: isEnabled ? widget.onPressed : null,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) => Transform.scale(
          scale: _scaleAnimation.value,
          child: child,
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 52,
          width: double.infinity,
          decoration: BoxDecoration(
            color: isEnabled ? AppColors.forest : AppColors.forest.withOpacity(0.6),
            borderRadius: BorderRadius.circular(16),
            boxShadow: isEnabled
                ? [
                    BoxShadow(
                      color: AppColors.forest.withOpacity(0.28),
                      blurRadius: 14,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: Center(
            child: widget.isLoading
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.label,
                        style: AppTypography.actionLabel.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.2,
                        ),
                      ),
                      if (widget.icon != null) ...[
                        const SizedBox(width: 8),
                        Icon(widget.icon, size: 18, color: AppColors.white),
                      ],
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
