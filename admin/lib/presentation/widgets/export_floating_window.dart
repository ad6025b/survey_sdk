import 'package:flutter/material.dart';
import 'package:survey_admin/presentation/app/localization/app_localizations_ext.dart';
import 'package:activity_builder/activity_sdk.dart';

//ignore_for_file: prefer-static-class
void showExportFloatingWindow(
  BuildContext context, {
  required VoidCallback onDownloadPressed,
  required VoidCallback onCopy,
}) {
  showDialog(
    context: context,
    builder: (context) => ExportFloatingWindow(
      onClose: () => Navigator.pop(context),
      onDownload: () {
        onDownloadPressed();
        Navigator.pop(context);
      },
      onCopyPressed: () {
        onCopy();
        Navigator.pop(context);
      },
    ),
  );
}

@visibleForTesting
class ExportFloatingWindow extends StatelessWidget {
  final VoidCallback onClose;
  final VoidCallback onDownload;
  final VoidCallback onCopyPressed;

  const ExportFloatingWindow({
    required this.onClose,
    required this.onDownload,
    required this.onCopyPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const opacity = 0.2;
    final labelLarge = context.theme.textTheme.labelLarge;
    return Material(
      color: ActivityColors.black.withOpacity(opacity),
      child: Center(
        child: Container(
          decoration: const BoxDecoration(
            color: ActivityColors.whitePrimaryBackground,
            borderRadius: BorderRadius.all(
              Radius.circular(ActivityDimensions.circularRadiusS),
            ),
          ),
          width: ActivityDimensions.exportWindowWidth,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: onClose,
                  icon: const Icon(Icons.close),
                  splashRadius: ActivityDimensions.sizeS,
                  iconSize: ActivityDimensions.sizeS,
                  color: ActivityColors.black,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: ActivityDimensions.marginXS,
                  left: ActivityDimensions.margin2XL,
                  right: ActivityDimensions.margin2XL,
                ),
                child: Text(
                  context.localization.exportFloatingWindowTitle,
                  textAlign: TextAlign.center,
                  style: context.textTheme.headLineMediumBold,
                ),
              ),
              const Image(
                image: AssetImage('assets/images/task_completed.png'),
                width: ActivityDimensions.imageSizeM,
                height: ActivityDimensions.imageSizeM,
              ),
              Padding(
                padding: const EdgeInsets.all(ActivityDimensions.marginL),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      onPressed: onCopyPressed,
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                          ActivityColors.white,
                        ),
                        side: MaterialStatePropertyAll(
                          BorderSide(),
                        ),
                        shape: MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                ActivityDimensions.circularRadiusXS,
                              ),
                            ),
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: ActivityDimensions.sizeL,
                        ),
                        child: Text(
                          context.localization.copy,
                          style: labelLarge?.copyWith(
                            fontFamily: ActivityFonts.karla,
                          ),
                        ),
                      ),
                    ),
                    FilledButton(
                      onPressed: onDownload,
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                          ActivityColors.black,
                        ),
                        shape: MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                ActivityDimensions.circularRadiusXS,
                              ),
                            ),
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: ActivityDimensions.margin5XL,
                        ),
                        child: Text(
                          context.localization.download,
                          style: labelLarge?.copyWith(
                            fontFamily: ActivityFonts.karla,
                            color: ActivityColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
