import 'package:get/get.dart';
import 'package:dusto_provider/util/core_export.dart';

class TopCardItem extends StatelessWidget {
  final Color cardColor;
  final String amount;
  final String title;
  final double? height;
  final String iconData;
  final Color? curveColor;
  const TopCardItem({
    super.key,
    this.curveColor,
    required this.amount,
    required this.title,
    required this.cardColor,
    this.height,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: height,
        width: double.infinity,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            Dimensions.radiusLarge,
          ), // M3 Expressive large inner card radius
          color: cardColor.withOpacity(0.8),
        ),

        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * .40,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(280),
                  bottomLeft: Radius.circular(50),
                  topLeft: Radius.circular(50),
                ),
                // Softened curve graphic for an expressive, layered M3 tonal look
                color:
                    curveColor?.withValues(alpha: 0.15) ?? Colors.transparent,
              ),
            ),

            Positioned.fill(
              right: 10,
              left: 10,
              top: 20,
              child: Align(
                alignment: Get.find<LocalizationController>().isLtr
                    ? Alignment.topRight
                    : Alignment.topLeft,
                child: Image.asset(
                  iconData,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeDefault,
              ),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    amount,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    maxLines: 2,
                  ),
                  const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    textDirection: TextDirection.ltr,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
