import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:sizer/sizer.dart';

class NetworkMediaPlayer extends StatefulWidget {
  final String mediaUrl;
  final double height;
  final double width;
  final String placeholder;

  const NetworkMediaPlayer({
    super.key,
    required this.mediaUrl,
    required this.height,
    required this.width,
    required this.placeholder,
  });

  @override
  State<NetworkMediaPlayer> createState() => _NetworkMediaPlayerState();
}

class _NetworkMediaPlayerState extends State<NetworkMediaPlayer> {
  VideoPlayerController? _videoController;
  ChewieController? _chewieController;
  bool isVideo = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkMediaType();
  }

  void _checkMediaType() {
    final url = widget.mediaUrl.toLowerCase();

    if (url.endsWith(".mp4") ||
        url.endsWith(".mov") ||
        url.endsWith(".webm") ||
        url.contains("video")) {
      isVideo = true;
      _initializeVideo();
    } else {
      isVideo = false;
      isLoading = false;
    }
  }

  Future<void> _initializeVideo() async {
    try {
      _videoController = VideoPlayerController.network(widget.mediaUrl);

      await _videoController!.initialize();

      _chewieController = ChewieController(
        videoPlayerController: _videoController!,
        autoPlay: false,
        looping: false,
        showControls: true,
        allowFullScreen: false,
      );

      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      debugPrint("Video initialization error: $e");
      if (mounted) {
        setState(() {
          isLoading = false;
          isVideo = false; // fallback to image
        });
      }
    }
  }

  @override
  void dispose() {
    _chewieController?.dispose();
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.sp),
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : isVideo
            ? (_chewieController != null &&
            _videoController!.value.isInitialized)
            ? Chewie(controller: _chewieController!)
            : Image.asset(widget.placeholder, fit: BoxFit.cover)
            : Image.network(
          widget.mediaUrl,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) =>
              Image.asset(widget.placeholder, fit: BoxFit.cover),
        ),
      ),
    );
  }
}