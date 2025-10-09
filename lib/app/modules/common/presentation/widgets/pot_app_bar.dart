import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pot_g/app/modules/common/presentation/widgets/pot_icon_button.dart';
import 'package:pot_g/app/values/palette.dart';
import 'package:pot_g/app/values/text_styles.dart';
import 'package:pot_g/gen/assets.gen.dart';
import 'package:pot_g/gen/strings.g.dart';

class PotAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PotAppBar({
    super.key,
    this.actions = const [],
    this.title,
    this.leading,
    this.automaticallyImplyLeading = true,
  });

  final Widget? leading;
  final bool automaticallyImplyLeading;
  final Widget? title;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    final logo = Padding(
      padding: const EdgeInsets.only(left: 16),
      child: SizedBox(
        height: 32,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AspectRatio(aspectRatio: 1, child: Assets.logo.color.image()),
            const SizedBox(width: 4),
            Text(
              context.t.name,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 28,
                height: 1,
              ),
            ),
          ],
        ),
      ),
    );
    final effectiveActions =
        actions.isEmpty
            ? [
              if (Scaffold.maybeOf(context)?.hasEndDrawer ?? false)
                AspectRatio(
                  aspectRatio: 1,
                  child: PotIconButton(
                    icon: Assets.icons.menu.svg(),
                    onPressed: () {
                      Scaffold.maybeOf(context)?.openEndDrawer();
                    },
                  ),
                ),
            ]
            : actions;

    return Container(
      decoration: BoxDecoration(
        color: Palette.white,
        border:
            title == null
                ? null
                : Border(bottom: BorderSide(color: Palette.borderGrey2)),
      ),
      child: SafeArea(
        bottom: false,
        child: AutoLeadingButton(
          ignorePagelessRoutes: true,
          builder: (context, leadingType, action) {
            final effectiveLeading =
                leading ??
                (automaticallyImplyLeading
                    ? leadingType == LeadingType.back
                        ? AspectRatio(
                          aspectRatio: 1,
                          child: PotIconButton(
                            icon: Assets.icons.arrowLeft.svg(),
                            onPressed: action,
                          ),
                        )
                        : title == null
                        ? logo
                        : null
                    : null);
            return ConstrainedBox(
              constraints: BoxConstraints.tightFor(height: 50),
              child: NavigationToolbar(
                leading: effectiveLeading,
                middle:
                    title == null
                        ? null
                        : DefaultTextStyle.merge(
                          style: TextStyles.title3.copyWith(
                            color: Palette.dark,
                          ),
                          child: title!,
                        ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: effectiveActions,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50);
}
