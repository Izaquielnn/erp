import 'package:erp/app/shared/styles/custom_colors.dart';
import 'package:erp/app/shared/styles/styles.dart';
import 'package:flutter/material.dart';

class CustomDropDown extends StatefulWidget {
  CustomDropDown({
    Key? key,
    required this.child,
    this.button,
    required this.itens,
    this.maxExtend = 200,
    this.onTap,
    this.actionButton,
  }) : super(key: key);

  Widget child;
  Widget? button;
  double maxExtend;
  void Function(String)? onTap;
  Widget? actionButton;

  List<String> itens;

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  FocusNode focus = FocusNode();
  final layerLink = LayerLink();
  late OverlayEntry dropdownOverlay;

  @override
  void initState() {
    super.initState();
  }

  Widget textButton(String text) {
    return TextButton(
      onPressed: () {
        focus.unfocus();
        widget.onTap?.call(text);
      },
      child: Container(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            text,
            style: TextStyles.Body1,
          ),
        ),
      ),
    );
  }

  Widget createDropDownWidget() {
    return Material(
      borderRadius: Corners.s10Border,
      elevation: 10,
      color: CustomColors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: widget.maxExtend,
                minHeight: 0,
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.itens.length,
                itemBuilder: (context, index) =>
                    textButton(widget.itens[index]),
              ),
            ),
            SizedBox(height: 10),
            widget.actionButton ?? Container(),
          ],
        ),
      ),
    );
  }

  showOverlay() {
    final renderBox = context.findRenderObject() as RenderBox;
    final width = renderBox.size.width;
    final height = renderBox.size.height;
    print('$width, $height');

    dropdownOverlay = OverlayEntry(
      builder: (context) => Positioned(
        width: width,
        child: CompositedTransformFollower(
          link: layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, height + 10),
          child: createDropDownWidget(),
        ),
      ),
    );

    final overlay = Overlay.of(context)!;
    overlay.insert(dropdownOverlay);
  }

  closeOverlay() {
    dropdownOverlay.remove();
  }

  @override
  void dispose() {
    focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (focus.hasFocus) {
          focus.unfocus();
        } else {
          focus.requestFocus();
        }
      },
      child: Focus(
        focusNode: focus,
        onFocusChange: (bool focused) {
          if (focused) {
            showOverlay();
          } else {
            closeOverlay();
          }
        },
        child: CompositedTransformTarget(
          link: layerLink,
          child: widget.child,
        ),
      ),
    );
  }
}
