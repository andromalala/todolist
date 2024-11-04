import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:to_do_list/app/core/utils/extension.dart';
import 'package:to_do_list/app/core/utils/theme.dart';

class PrimaryButton extends StatelessWidget {
  final Widget child;
  final EdgeInsets? margin;
  final MaterialStateProperty<EdgeInsetsGeometry>? padding;
  final Color? borderColor;
  final Color? backgroundColor;
  final double? elevation;
  final double? height;
  final double? width;
  final void Function()? onPressed;
  final double? radius;

  const PrimaryButton({
    required this.child,
    Key? key,
    this.onPressed,
    this.margin,
    this.padding,
    this.borderColor,
    this.backgroundColor,
    this.elevation,
    this.height,
    this.width,
    this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: margin ?? const EdgeInsets.all(0),
      child: TextButton(
        style: ButtonStyle(
          padding: padding ??
              MaterialStateProperty.all(
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
              ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius ?? 60.0),
              side: BorderSide(color: borderColor ?? Colors.transparent),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(
            backgroundColor ?? CustomTheme.primaryColor,
          ),
        ),
        child: child,
        onPressed: onPressed,
      ),
    );
  }
}

class TextFieldFilled extends StatelessWidget {
  final String? initialValue;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final bool? obscureText;
  final String? labelText;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final TextAlign? textAlign;
  final int? maxLines;
  final int? minLines;
  final Function(String)? onChanged;
  final bool? enabled;
  final IconData? suffixIcon;
  final void Function()? onTapSuffixIcon;

  const TextFieldFilled({
    Key? key,
    this.textAlign,
    this.labelText,
    this.initialValue,
    this.textInputType,
    this.controller,
    this.obscureText,
    this.validator,
    this.focusNode,
    this.inputFormatters,
    this.maxLines,
    this.minLines,
    this.onChanged,
    this.enabled,
    this.suffixIcon,
    this.onTapSuffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormField(
      validator: validator,
      initialValue: initialValue,
      builder: (FormFieldState<String> state) {
        return Column(
          children: [
            TextFormField(
              focusNode: focusNode,
              inputFormatters: inputFormatters,
              enabled: enabled,
              onChanged: (v) {
                state.didChange(v);
                if (onChanged != null) {
                  onChanged!(v);
                }
              },
              onSaved: (v) {
                state.save();
              },
              onFieldSubmitted: (v) {
                state.save();
              },
              minLines: minLines ?? 1,
              maxLines: maxLines ?? 1,
              controller: controller,
              keyboardType: textInputType,
              textAlign: textAlign ?? TextAlign.start,
              obscureText: obscureText ?? false,
              decoration: InputDecoration(
                alignLabelWithHint: true,
                suffixIcon: suffixIcon != null
                    ? InkWell(
                        onTap: onTapSuffixIcon,
                        child: Icon(suffixIcon),
                      )
                    : null,
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.error,
                    width: 0.5,
                  ),
                  borderRadius:
                      BorderRadius.circular(CustomTheme.defaultBorderRadius),
                ),
                labelStyle: TextStyle(
                  fontSize: CustomTheme.bodyText1.sp(context),
                  color: const ColorScheme.light().onSecondary,
                ),
                labelText: labelText,
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 0.5,
                  ),
                  borderRadius:
                      BorderRadius.circular(CustomTheme.defaultBorderRadius),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 0.5,
                  ),
                  borderRadius:
                      BorderRadius.circular(CustomTheme.defaultBorderRadius),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: CustomTheme.primaryColor,
                    width: 2.0,
                  ),
                  borderRadius:
                      BorderRadius.circular(CustomTheme.defaultBorderRadius),
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 0.5,
                  ),
                  borderRadius:
                      BorderRadius.circular(CustomTheme.defaultBorderRadius),
                ),
                filled: true,
                fillColor: CustomTheme.greyColor,
              ),
            ),
            Offstage(
              offstage: !state.hasError,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 10.0,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Icon(
                        Icons.error,
                        color: Theme.of(context).colorScheme.error,
                        size: CustomTheme.bodyText1.sp(context),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Text(
                          "${state.errorText}",
                          maxLines: 2,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                            fontSize: CustomTheme.bodyText2.sp(context),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
