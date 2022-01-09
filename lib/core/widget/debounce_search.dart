import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:robo_test/core/widget/local_text_provider.dart';

typedef SearchQueryListener(String listener);

class DebounceSearch extends StatefulWidget {
  final Duration? duration;
  final String? initialValue;
  final SearchQueryListener listener;
  final String? hint;

  const DebounceSearch({
    Key? key,
    this.duration,
    this.initialValue,
    required this.listener,
    this.hint,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DebounceSearchState();
}

class _DebounceSearchState extends State<DebounceSearch> with LocaleTextProvider {
  Timer? timer;
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.initialValue);
    controller.addListener(() {
      timer?.cancel();
      timer = Timer(widget.duration ?? const Duration(milliseconds: 200), () {
        widget.listener(controller.text);
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fillColor = Theme.of(context).colorScheme.primary;
    return TextFormField(
      style: Theme.of(context).textTheme.bodyText1!,
      controller: controller,
      decoration: InputDecoration(
        hintText: widget.hint ?? local.search,
        suffixIconConstraints: const BoxConstraints.expand(width: 32, height: 24),
        suffixIcon: GestureDetector(
          child: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: controller.text.isNotEmpty
                ? SvgPicture.asset(
                    "assets/svg/ic_cancel.svg",
                    color: const Color(0xff808080),
                  )
                : SvgPicture.asset(
                    "assets/svg/ic_search.svg",
                    color: const Color(0xff808080),
                  ),
          ),
          onTap: () {
            if (controller.text.isNotEmpty) {
              controller.text = "";
              widget.listener("");
            }
          },
        ),
        filled: true,
        isDense: true,
        focusColor: Theme.of(context).primaryColor,
        fillColor: Theme.of(context).colorScheme.surface,
        contentPadding: const EdgeInsets.all(16),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: fillColor),
          borderRadius: const BorderRadius.all(Radius.circular(4)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: fillColor),
          borderRadius: const BorderRadius.all(Radius.circular(4)),
        ),
      ),
    );
  }
}
