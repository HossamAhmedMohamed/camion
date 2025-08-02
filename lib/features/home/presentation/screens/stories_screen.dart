// widgets/story_viewer.dart
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/home/data/models/stories_model.dart/stories_model.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

class StoryViewerScreen extends StatefulWidget {
  final List<StoriesModel> stories;
  final int initialIndex;
  final Duration duration;

  const StoryViewerScreen({
    super.key,
    required this.stories,
    this.initialIndex = 0,
    this.duration = const Duration(seconds: 5),
  });

  @override
  State<StoryViewerScreen> createState() => _StoryViewerScreenState();
}

class _StoryViewerScreenState extends State<StoryViewerScreen>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _progressController;
  late AnimationController _exitController;
  int _currentIndex = 0;
  bool _isPressed = false;
  bool _isDragging = false;
  double _dragDistance = 0;
  // bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
    _progressController = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _exitController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _startProgress();
        // setState(() {
        //   _isInitialized = true;
        // });
      }
    });
  }

  @override
  void dispose() {
    _progressController.dispose();
    _exitController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _startProgress() {
    if (!mounted) return;

    _progressController.reset();
    _progressController.forward().then((_) {
      if (!_isPressed && !_isDragging && mounted) {
        _nextStory();
      }
    });
  }

  void _pauseProgress() {
    if (_progressController.isAnimating) {
      _progressController.stop();
    }
  }

  void _resumeProgress() {
    if (!_isDragging && mounted && !_isPressed) {
      _progressController.forward().then((_) {
        if (!_isPressed && !_isDragging && mounted) {
          _nextStory();
        }
      });
    }
  }

  void _nextStory() {
    if (_currentIndex < widget.stories.length - 1) {
      setState(() {
        _currentIndex++;
      });
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      _startProgress();
      // Don't call _startProgress() here, it will be called in onPageChanged
    } else {
      GoRouter.of(context).pop();
    }
  }

  void _previousStory() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
      });
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      _startProgress();
      // Don't call _startProgress() here, it will be called in onPageChanged
    } else {
      _restartCurrentStory();
    }
  }

  void _restartCurrentStory() {
    _startProgress();
  }

  void _exitStory() {
    GoRouter.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: AnimatedBuilder(
          animation: _exitController,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, _dragDistance),
              child: Transform.scale(
                scale: 1 - (_exitController.value * 0.1),
                child: GestureDetector(
                  onLongPressStart: (_) {
                    setState(() {
                      _isPressed = true;
                    });
                    _pauseProgress();
                  },
                  onLongPressEnd: (_) {
                    setState(() {
                      _isPressed = false;
                    });
                    _resumeProgress();
                  },
                  onTapUp: (details) {
                    if (_isDragging) return;

                    final screenWidth = MediaQuery.of(context).size.width;
                    final tapX = details.globalPosition.dx;

                    if (tapX < screenWidth * 0.3) {
                      _nextStory();
                    } else if (tapX > screenWidth * 0.7) {
                      // if (_currentIndex < widget.stories.length - 1) {
                      _previousStory();
                      // } else {
                      //   _exitController.forward().then((_) {
                      //     _exitStory();
                      //   });
                      // }
                    }
                  },

                  onPanStart: (details) {
                    setState(() {
                      _isDragging = true;
                    });
                    _pauseProgress();
                  },
                  onPanUpdate: (details) {
                    if (details.delta.dy > 0) {
                      setState(() {
                        _dragDistance += details.delta.dy;
                        _dragDistance = _dragDistance.clamp(0.0, 200.0);
                      });

                      _exitController.value = (_dragDistance / 200.0).clamp(
                        0.0,
                        1.0,
                      );
                    }
                  },
                  onPanEnd: (details) {
                    setState(() {
                      _isDragging = false;
                    });

                    if (_dragDistance > 100) {
                      _exitController.forward().then((_) {
                        _exitStory();
                      });
                    } else {
                      _exitController.reverse();
                      setState(() {
                        _dragDistance = 0;
                      });
                      _resumeProgress();
                    }
                  },
                  child: Stack(
                    children: [
                      PageView.builder(
                        controller: _pageController,
                        // physics: const NeverScrollableScrollPhysics(),
                        onPageChanged: (index) {
                          setState(() {
                            _currentIndex = index;
                          });
                          _startProgress();
                        },
                        itemCount: widget.stories.length,
                        itemBuilder: (context, index) {
                          return _buildStoryContent(widget.stories[index]);
                        },
                      ),
                      _buildProgressBar(),
                      _buildCloseButton(),
                      _buildStoryInfo(),
                      // if (_isPressed) _buildPauseIndicator(),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildStoryContent(StoriesModel story) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black,
      child: Center(
        child: CachedNetworkImage(
          width: screenWidth,
          height: screenHeight / 2,
          imageUrl: story.mediaUrl,
          fit: BoxFit.fill,
          placeholder: (context, url) => Skeletonizer(
            enabled: true,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                shape: BoxShape.rectangle,
              ),
            ),
          ),
          errorWidget: (context, url, error) => Container(
            color: Colors.grey[900],
            child: const Center(
              child: Icon(Icons.error, color: Colors.white, size: 50),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProgressBar() {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 20,
      left: 8,
      right: 8,
      child: Row(
        children: List.generate(
          1,
          // widget
          //     .stories
          //     .length, // هنا كان المشكلة - كان مكتوب 1 بدلاً من widget.stories.length
          (index) => Expanded(
            child: Container(
              height: 3.h,
              margin: EdgeInsets.symmetric(horizontal: 1.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1.5.r),
                color: Colors.white.withAlpha(76),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(1.5.r),
                child: AnimatedBuilder(
                  animation: _progressController,
                  builder: (context, child) {
                    double value = 0.0;

                    // if (index < _currentIndex) {
                    //   value = 1.0;
                    // } else if (index == _currentIndex) {
                    value = _progressController.value;
                    // } else {
                    //   value = 0.0;
                    // }

                    return LinearProgressIndicator(
                      value: value,
                      backgroundColor: Colors.transparent,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Colors.white,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCloseButton() {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 40,
      right: 8,
      child: GestureDetector(
        onTap: _exitStory,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black.withAlpha(100),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.close, color: Colors.white, size: 20),
        ),
      ),
    );
  }

  Widget _buildStoryInfo() {
    final currentStory = widget.stories[_currentIndex];

    return Positioned(
      bottom: MediaQuery.of(context).padding.bottom + 20,
      left: 20,
      // right: 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (currentStory.title.isNotEmpty)
            Text(
              currentStory.title,
              style: AppStyle.styleBold25(context).copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                shadows: const [
                  Shadow(
                    offset: Offset(0, 1),
                    blurRadius: 3,
                    color: Colors.black54,
                  ),
                ],
              ),
            ),
          if (currentStory.description.isNotEmpty) ...[
            SizedBox(height: 8.h),
            Text(
              currentStory.description,
              style: AppStyle.styleBold25(context).copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                shadows: const [
                  Shadow(
                    offset: Offset(0, 1),
                    blurRadius: 3,
                    color: Colors.black54,
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  // Widget _buildPauseIndicator() {
  //   return Center(
  //     child: Container(
  //       padding: const EdgeInsets.all(16),
  //       decoration: const BoxDecoration(
  //         color: Colors.black54,
  //         shape: BoxShape.circle,
  //       ),
  //       child: const Icon(Icons.pause, color: Colors.white, size: 32),
  //     ),
  //   );
  // }
}
