import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../pages/place_detail_page.dart';

class PlaceCard extends StatelessWidget {
  final String title;
  final String address;
  final String status;
  final String hours;
  final double rating;
  final String type;
  final String icon;
  final VoidCallback onTap;
  final bool showType;
  final bool isPinned;
  final VoidCallback onPinPressed;

  const PlaceCard({
    super.key,
    required this.title,
    required this.address,
    required this.status,
    required this.hours,
    required this.rating,
    required this.type,
    required this.icon,
    required this.onTap,
    this.showType = true,
    this.isPinned = false,
    required this.onPinPressed,
  });

  Color _getStatusColor(String status) {
    if (status.toLowerCase().contains('open')) {
      return Colors.green;
    } else if (status.toLowerCase().contains('close')) {
      return Colors.red;
    }
    return Colors.orange;
  }

  IconData _getIconForType(String type) {
    switch (type.toLowerCase()) {
      case 'clinic':
        return Icons.local_hospital;
      case 'store':
        return Icons.store;
      case 'shelter':
        return Icons.pets;
      case 'book':
        return Icons.menu_book;
      case 'view':
        return Icons.remove_red_eye;
      case 'wipe':
        return Icons.clean_hands;
      default:
        return Icons.place;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(status);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 280,
        height: 180,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
          border: Border.all(color: AppColors.secondaryColor.withOpacity(0.1)),
        ),
        child: Stack(
          children: [
            // Main card content
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image/Icon section
                Container(
                  height: 80,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.lightPink,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Icon(
                    _getIconForType(icon),
                    color: AppColors.secondaryColor,
                    size: 35,
                  ),
                ),

                // Content
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Title and Rating
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                title,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryColor,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Row(
                              children: [
                                Icon(Icons.star, color: Colors.amber, size: 14),
                                const SizedBox(width: 2),
                                Text(
                                  rating.toString(),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        // Address
                        Text(
                          address,
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.primaryColor.withOpacity(0.7),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),

                        // Status and Hours
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: statusColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                status,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: statusColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                hours,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: AppColors.primaryColor.withOpacity(
                                    0.6,
                                  ),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),

                        // Type badge
                        if (showType)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.secondaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              type.toUpperCase(),
                              style: TextStyle(
                                fontSize: 8,
                                color: AppColors.secondaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Pin Button - Top Right (using IconButton to properly handle taps)
            Positioned(
              top: 8,
              right: 8,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onPinPressed,
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      isPinned ? Icons.push_pin : Icons.push_pin_outlined,
                      color: isPinned ? AppColors.secondaryColor : Colors.grey,
                      size: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
