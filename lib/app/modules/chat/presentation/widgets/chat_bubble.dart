import 'package:flutter/material.dart';
import 'package:pot_g/app/modules/chat/domain/entities/pot_info_entity.dart';
import 'package:pot_g/app/modules/chat/domain/entities/pot_user_entity.dart';
import 'package:pot_g/app/modules/chat/presentation/widgets/pot_profile_image.dart';
import 'package:pot_g/app/values/palette.dart';
import 'package:pot_g/app/values/text_styles.dart';
import 'package:pot_g/gen/assets.gen.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.message,
    this.user,
    this.isFirst = false,
    required this.pot,
  });

  final String message;
  final PotUserEntity? user;
  final bool isFirst;
  final PotInfoEntity pot;

  @override
  Widget build(BuildContext context) {
    final isMe = user == null;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!isMe)
          isFirst
              ? PotProfileImage(user: user!, pot: pot)
              : const SizedBox(width: 40),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 240),
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              if (!isMe && isFirst) ...[
                Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: Text(
                    user!.name,
                    style: TextStyles.description.copyWith(
                      color: Palette.textGrey,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
              ],
              Stack(
                children: [
                  if (isFirst)
                    Positioned(
                      left: isMe ? null : 0,
                      right: isMe ? 0 : null,
                      bottom: 0,
                      child: Transform.flip(
                        flipX: isMe,
                        child: Assets.icons.chatTip.svg(
                          colorFilter: ColorFilter.mode(
                            isMe ? Palette.primary : Palette.borderGrey,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color:
                            user == null ? Palette.primary : Palette.borderGrey,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        message,
                        style: TextStyles.description.copyWith(
                          color:
                              user == null
                                  ? Palette.primaryLight
                                  : Palette.textGrey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
