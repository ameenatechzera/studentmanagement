class TimeAgoHelper {
  static String getFeedTime({String? createdDate, String? modifiedDate}) {
    final rawDate = (modifiedDate != null && modifiedDate.trim().isNotEmpty)
        ? modifiedDate
        : createdDate;

    if (rawDate == null || rawDate.trim().isEmpty) {
      return '';
    }

    try {
      final dateTime = DateTime.parse(rawDate).toLocal();
      final now = DateTime.now();
      final difference = now.difference(dateTime);

      if (difference.inSeconds < 60) {
        return 'Just now';
      } else if (difference.inMinutes < 60) {
        return '${difference.inMinutes} min${difference.inMinutes == 1 ? '' : 's'} ago';
      } else if (difference.inHours < 24) {
        return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
      } else if (difference.inDays == 1) {
        return 'Yesterday';
      } else if (difference.inDays < 7) {
        return '${difference.inDays} days ago';
      } else {
        return '${dateTime.day.toString().padLeft(2, '0')}-'
            '${dateTime.month.toString().padLeft(2, '0')}-'
            '${dateTime.year}';
      }
    } catch (e) {
      return '';
    }
  }
}
