import 'package:flutter/material.dart';
import '../utils/index.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final AppButtonType type;
  final bool isFullWidth;
  final bool isLoading;
  final IconData? icon;
  final Color? customColor;
  final double? height;
  final double? fontSize;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.type = AppButtonType.primary,
    this.isFullWidth = false,
    this.isLoading = false,
    this.icon,
    this.customColor,
    this.height,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    final buttonColor = _getButtonColor();
    final textColor = _getTextColor();
    final borderColor = _getBorderColor();

    Widget buttonContent = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isLoading) ...[
          const SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
          const SizedBox(width: AppTheme.spacingS),
        ] else if (icon != null) ...[
          Icon(icon, size: 18),
          const SizedBox(width: AppTheme.spacingS),
        ],
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize ?? 16,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
      ],
    );

    if (isFullWidth) {
      buttonContent = SizedBox(
        width: double.infinity,
        child: buttonContent,
      );
    }

    switch (type) {
      case AppButtonType.primary:
        return Container(
          height: height ?? 48,
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(AppTheme.radiusM),
            boxShadow: [
              BoxShadow(
                color: buttonColor.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onPressed,
              borderRadius: BorderRadius.circular(AppTheme.radiusM),
              child: Center(child: buttonContent),
            ),
          ),
        );

      case AppButtonType.outline:
        return Container(
          height: height ?? 48,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(AppTheme.radiusM),
            border: Border.all(color: borderColor, width: 2),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onPressed,
              borderRadius: BorderRadius.circular(AppTheme.radiusM),
              child: Center(child: buttonContent),
            ),
          ),
        );

      case AppButtonType.text:
        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(AppTheme.radiusM),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.spacingM,
                vertical: AppTheme.spacingS,
              ),
              child: buttonContent,
            ),
          ),
        );
    }
  }

  Color _getButtonColor() {
    if (customColor != null) return customColor!;
    
    switch (type) {
      case AppButtonType.primary:
        return const Color(0xFFE53E3E); // Màu thương hiệu chính
      case AppButtonType.outline:
      case AppButtonType.text:
        return Colors.transparent;
    }
  }

  Color _getTextColor() {
    if (customColor != null) return customColor!;
    
    switch (type) {
      case AppButtonType.primary:
        return Colors.white;
      case AppButtonType.outline:
        return const Color(0xFFE53E3E); // Màu thương hiệu chính
      case AppButtonType.text:
        return const Color(0xFFE53E3E); // Màu thương hiệu chính
    }
  }

  Color _getBorderColor() {
    if (customColor != null) return customColor!;
    
    switch (type) {
      case AppButtonType.primary:
        return const Color(0xFFE53E3E); // Màu thương hiệu chính
      case AppButtonType.outline:
        return const Color(0xFFE53E3E); // Màu thương hiệu chính
      case AppButtonType.text:
        return Colors.transparent;
    }
  }
}

enum AppButtonType {
  primary,
  outline,
  text,
}
