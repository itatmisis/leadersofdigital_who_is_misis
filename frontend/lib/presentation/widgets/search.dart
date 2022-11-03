import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/presentation/theme/app_colors.dart';
import 'package:frontend/presentation/theme/app_fonts.dart';

class Search extends StatefulWidget {

  final Color _backgroundColor;
  final double _elevation;

  final Function(String)? onSubmitted;

  const Search.v1({super.key, this.onSubmitted}): _backgroundColor = AppColors.white, _elevation = 3;
  const Search.v2({super.key, this.onSubmitted}): _backgroundColor = AppColors.neutral200, _elevation = 3;
  const Search.v3({super.key, this.onSubmitted}): _backgroundColor = AppColors.neutral100, _elevation = 1;

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {

  final FocusNode _focusNode = FocusNode();
  late OverlayEntry _overlayEntry;
  final LayerLink _layerLink = LayerLink();

  @override
  void initState() {
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        this._overlayEntry = this._createOverlayEntry();
        Overlay.of(context).insert(this._overlayEntry);

      } else {
        this._overlayEntry.remove();
      }
      setState(() {});
    });
  }

  OverlayEntry _createOverlayEntry() {

    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;

    return OverlayEntry(
        builder: (context) => Positioned(
          width: size.width,
          child: CompositedTransformFollower(
            link: this._layerLink,
            showWhenUnlinked: false,
            offset: Offset(0.0, size.height),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
                color: widget._backgroundColor
              ),
              height: 60,
              child: Material(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
                color: widget._backgroundColor,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(color: AppColors.lightGray, height: 1,),
                    Padding(
                      padding: EdgeInsets.only(left: 10, top: 10),
                      child: Text('Последние результаты:', style: AppFonts.body1Regular.copyWith(color: AppColors.lightGray),),
                    )
                  ],
                ),
              )
            )
          ),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
        link: _layerLink,
      child: Material(
        elevation: widget._elevation,
        borderRadius: BorderRadius.circular(8),
        child: TextField(
          focusNode: _focusNode,
          onSubmitted: widget.onSubmitted,
          decoration: InputDecoration(
              isDense: true,
              filled: true,
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: _focusNode.hasFocus? BorderRadius.vertical(top: Radius.circular(8)) : BorderRadius.circular(8)),
              hintText: 'Поиск по участкам',
              constraints: BoxConstraints(maxWidth: 400, maxHeight: 60),
              fillColor: widget._backgroundColor,
              hintStyle: AppFonts.body1Regular.copyWith(color: AppColors.lightGray),
              prefixIcon: Padding(
                padding: const EdgeInsets.only(right: 15, top: 12, bottom: 12, left: 15),
                child: SvgPicture.asset('assets/icons/search.svg', color: AppColors.neutral800, height: 20,),
              )
          ),
        ),
      ),
    );
  }
}