import 'package:cached_network_image/cached_network_image.dart';
import 'package:camion/core/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:photo_view/photo_view.dart';
import 'package:skeletonizer/skeletonizer.dart';

class FullScreenImageViewer extends StatelessWidget {
  final String imageUrl;

  const FullScreenImageViewer({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PhotoView(
            imageProvider: CachedNetworkImageProvider(imageUrl),
            backgroundDecoration: const BoxDecoration(color: Colors.black),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 3,
            heroAttributes: const PhotoViewHeroAttributes(tag: "single_image"),
            loadingBuilder: (context, event) => Skeletonizer(
              enabled: true,
              child: SizedBox(
                height: 400.h,
                width: double.infinity,
                child: Image.asset(Assets.imagesShoes, fit: BoxFit.fill),
              ),
            ),
            errorBuilder: (context, error, stackTrace) => const Center(
              child: Icon(Icons.error, color: Colors.white, size: 50),
            ),
          ),

          Positioned(
            top: MediaQuery.of(context).padding.top + 16.h,
            right: 16.w,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: IconButton(
                onPressed: () => GoRouter.of(context).pop(),
                icon: Icon(Icons.close, color: Colors.white, size: 24.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
