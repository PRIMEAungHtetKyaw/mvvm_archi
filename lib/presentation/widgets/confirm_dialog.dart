import 'package:flutter/cupertino.dart'; 

class CupertinoConfirmDialog extends StatelessWidget {
  final String title;
  final String message;
  final String confirmButtonText;
  final String cancelButtonText;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const CupertinoConfirmDialog({
    super.key,
    required this.title,
    required this.message,
    this.confirmButtonText = "Confirm",
    this.cancelButtonText = "Cancel",
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
      ),
      content: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Text(
          message,
          style: const TextStyle(fontSize: 14),
        ),
      ),
      actions: [
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: onCancel,
          child: Text(
            cancelButtonText,
            style: const TextStyle(color: CupertinoColors.destructiveRed),
          ),
        ),
        CupertinoDialogAction(
          onPressed: onConfirm,
          child: Text(
            confirmButtonText,
            style: const TextStyle(color: CupertinoColors.activeBlue),
          ),
        ),
      ],
    );
  }
}
