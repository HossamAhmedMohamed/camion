import 'dart:async';
import 'package:camion/core/utils/app_colors.dart';
import 'package:camion/core/utils/app_style.dart';
import 'package:camion/features/auth/presentation/logic/verify_cubit/verify_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RepeatingTimer extends StatefulWidget {
  const RepeatingTimer({super.key, required this.code});

  final String code;
  @override
  State<RepeatingTimer> createState() => _RepeatingTimerState();
}

class _RepeatingTimerState extends State<RepeatingTimer> {
  static const int initialTimeInSeconds = 3 * 60 + 20;
  late int remainingSeconds;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    remainingSeconds = initialTimeInSeconds;
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        if (remainingSeconds > 0) {
          remainingSeconds--;
        } else {
          // Reset and restart
          remainingSeconds = initialTimeInSeconds;
          context.read<VerifyCubit>().verify(code: widget.code);
        }
      });
    });
  }

  String formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        formatTime(remainingSeconds),
        style: AppStyle.styleRegular14(
          context,
        ).copyWith(color: AppColors.primaryColor),
      ),
    );
  }
}
