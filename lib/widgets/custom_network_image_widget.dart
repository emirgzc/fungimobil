import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fungimobil/widgets/loading_widget.dart';

class CustomNetworkImageWidget extends StatelessWidget {
  CustomNetworkImageWidget({
    Key? key,
    required this.imageUrl,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
  }) : super(key: key);

  final String? imageUrl;
  double? height;
  double? width;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    height = width != null && height == null ? double.infinity : height;
    width = height != null && width == null ? double.infinity : width;
    return imageUrl == null
        ? SizedBox(
            height: height,
            width: width,
          )
        : CachedNetworkImage(
            imageUrl: imageUrl!,
            height: height,
            width: width,
            fit: fit,
            placeholder: (context, url) {
              return const LoadingWidget(
                isMinimal: true,
              );
            },
          );
  }
}
