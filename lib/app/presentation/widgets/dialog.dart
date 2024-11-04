import 'package:flutter/material.dart';
import 'package:to_do_list/app/core/utils/extension.dart';
import 'package:to_do_list/app/core/utils/theme.dart';
import 'package:to_do_list/app/presentation/widgets/basic_widgets.dart';

class ConfirmDialog extends StatelessWidget {
  final String title;
  final Widget? child;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final String? btnCancelTitle;

  const ConfirmDialog(
      {required this.title,
      super.key,
      this.child,
      this.onConfirm,
      this.onCancel,
      this.btnCancelTitle});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      backgroundColor: Colors.white,
      title: Text(
        title,
        style: TextStyle(
          fontSize: CustomTheme.headline1.sp(context),
          color: CustomTheme.primaryColor,
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 10.0, 24.0, 0.0),
          child: Column(
            children: [
              Container(child: child),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: PrimaryButton(
                      radius: CustomTheme.defaultBorderRadius,
                      backgroundColor: Colors.transparent,
                      borderColor: CustomTheme.primaryColor,
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(vertical: 6.0),
                      ),
                      onPressed: () async {
                        if (onCancel != null) {
                          onCancel!();
                        } else {
                          Navigator.pop(context, false);
                        }
                      },
                      child: Text(
                        btnCancelTitle ?? 'Annuler',
                        style: TextStyle(
                          fontSize: CustomTheme.button.sp(context),
                          color: CustomTheme.primaryColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: PrimaryButton(
                      radius: CustomTheme.defaultBorderRadius,
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(vertical: 6.0),
                      ),
                      onPressed: () async {
                        if (onConfirm != null) {
                          onConfirm!();
                        } else {
                          Navigator.pop(context, true);
                        }
                      },
                      child: Text(
                        'Continuer',
                        style: TextStyle(
                          fontSize: CustomTheme.button.sp(context),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
