// widgets/story_viewer.dart
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/home/data/models/stories_model.dart/stories_model.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:video_player/video_player.dart';

class StoryViewerScreen extends StatefulWidget {
  final List<StoriesModel> stories;
  final int initialIndex;

  final String mediaType;
  final int durationPeriod;
  const StoryViewerScreen({
    super.key,
    required this.stories,
    this.initialIndex = 0,

    required this.mediaType,
    required this.durationPeriod,
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

  late Duration duration;
  // bool _isInitialized = false;

  final Map<int, VideoPlayerController> _videoControllers = {};
  final Map<int, bool> _videoInitialized = {};
  final Map<int, bool> _videoEnded = {};

  @override
  void initState() {
    super.initState();
    duration = Duration(seconds: widget.durationPeriod);
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
    _progressController = AnimationController(duration: duration, vsync: this);
    _exitController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _initializeVideoControllers();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _startProgress();
        // setState(() {
        //   _isInitialized = true;
        // });
      }
    });
  }

  void _initializeVideoControllers() {
    for (int i = 0; i < widget.stories.length; i++) {
      final story = widget.stories[i];
      if (story.mediaType == "video") {
        _videoControllers[i] = VideoPlayerController.networkUrl(
          Uri.parse(story.mediaUrl),
        );
        _videoInitialized[i] = false;

        _videoControllers[i]!.initialize().then((_) {
          if (mounted) {
            setState(() {
              _videoInitialized[i] = true;
              _videoEnded[i] = false; // لسه الفيديو ما خلصش
            });

            // لو هو الاستوري الحالية
            if (i == _currentIndex) {
              final videoDuration = _videoControllers[i]!.value.duration;
              _progressController.duration = videoDuration != Duration.zero
                  ? videoDuration
                  : duration;

              _videoControllers[i]!.play().then((_) {
                _startProgress(); // يبدأ يعد بعد التشغيل
              });
            }
          }
        });

        // Listen to video end
        _videoControllers[i]!.addListener(() {
          final controller = _videoControllers[i]!;
          if (controller.value.isInitialized &&
              controller.value.position >= controller.value.duration &&
              _videoEnded[i] != true) {
            _videoEnded[i] = true; // علّم إنه خلص
            if (i == _currentIndex && !_isPressed && !_isDragging && mounted) {
              _nextStory();
            }
          }
        });
      }
    }
  }

  // bool _isVideoStory(StoriesModel story) {
  //   // You can check the mediaType from the story model or check file extension
  //   return widget.mediaType.toLowerCase() == 'video' ||
  //       story.mediaUrl.toLowerCase().contains('.mp4') ||
  //       story.mediaUrl.toLowerCase().contains('.mov') ||
  //       story.mediaUrl.toLowerCase().contains('.avi');
  // }

  @override
  void dispose() {
    _progressController.dispose();
    _exitController.dispose();
    _pageController.dispose();

    for (var controller in _videoControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _startProgress() {
    if (!mounted) return;

    final currentStory = widget.stories[_currentIndex];
    _videoEnded[_currentIndex] = false; // نبدأ القصة من الأول

    if (currentStory.mediaType == "video") {
      if (_videoInitialized[_currentIndex] != true) {
        return; // استنى لحد ما يجهز الفيديو
      }
    }

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
    final currentStory = widget.stories[_currentIndex];
    if (currentStory.mediaType == "video" &&
        _videoControllers[_currentIndex] != null) {
      _videoControllers[_currentIndex]!.pause();
    }
  }

  void _resumeProgress() {
    if (!_isDragging && mounted && !_isPressed) {
      final currentStory = widget.stories[_currentIndex];
      if ( currentStory.mediaType == "video" &&
          _videoControllers[_currentIndex] != null) {
        _videoControllers[_currentIndex]!.play();
      }
      _progressController.forward().then((_) {
        if (!_isPressed && !_isDragging && mounted) {
          _nextStory();
        }
      });
    }
  }

  void _nextStory() {
    if (_videoControllers[_currentIndex] != null) {
      _videoControllers[_currentIndex]!.pause();
    }
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
    if (_videoControllers[_currentIndex] != null) {
      _videoControllers[_currentIndex]!.pause();
    }

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
    final currentStory = widget.stories[_currentIndex];
    if (currentStory.mediaType == "video" &&
        _videoControllers[_currentIndex] != null) {
      _videoControllers[_currentIndex]!.seekTo(Duration.zero);
    }
    _startProgress();
  }

  void _exitStory() {
    for (var controller in _videoControllers.values) {
      controller.pause();
    }
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
                          if (_videoControllers[_currentIndex] != null) {
                            _videoControllers[_currentIndex]!.pause();
                          }
                          setState(() {
                            _currentIndex = index;
                          });
                          _startProgress();
                        },
                        itemCount: widget.stories.length,
                        itemBuilder: (context, index) {
                          return _buildStoryContent(
                            widget.stories[_currentIndex],
                            _currentIndex,
                          );
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

  Widget _buildStoryContent(StoriesModel story, int index) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black,
      child: Center(
        child: story.mediaType == "video"
            ? _buildVideoPlayer(story, index, screenWidth, screenHeight)
            : _buildImagePlayer(story, screenWidth, screenHeight),
      ),
    );
  }

  Widget _buildVideoPlayer(
    StoriesModel story,
    int index,
    double screenWidth,
    double screenHeight,
  ) {
    final videoController = _videoControllers[index];
    final isInitialized = _videoInitialized[index] ?? false;

    if (videoController == null || !isInitialized) {
      return Skeletonizer(
        enabled: true,
        child: Container(
          width: screenWidth,
          height: screenHeight / 2,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            shape: BoxShape.rectangle,
          ),
          child: const Center(
            child: CircularProgressIndicator(color: Colors.white),
          ),
        ),
      );
    }

    return SizedBox(
      width: screenWidth,
      height: screenHeight / 2,
      child: VideoPlayer(videoController),
    );
  }

  Widget _buildImagePlayer(
    StoriesModel story,
    double screenWidth,
    double screenHeight,
  ) {
    return CachedNetworkImage(
      width: screenWidth,
      height: screenHeight * 0.7,
      imageUrl: story.mediaUrl,
      // fit: BoxFit.fill,
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
