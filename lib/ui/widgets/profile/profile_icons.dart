import 'package:flutter/material.dart';
import 'package:hub_client/ui/widgets/profile/profile_edit_dialog.dart';
import 'package:hub_client/ui/widgets/profile/profile_tooltip.dart';

class ProfileIcons extends StatelessWidget {
  final Function editProfile;

  const ProfileIcons({Key key, this.editProfile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ProfileTooltip(
            message: 'Suspend',
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: editProfile,
                child: const Center(
                    child: Icon(
                  Icons.delete_rounded,
                  color: Color.fromARGB(255, 229, 125, 22),
                )),
              ),
            )),
        const SizedBox(width: 10),
        ProfileTooltip(
            message: 'Edit Profile',
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => {
                  showDialog(
                    context: context,
                    builder: (context) => const EditProfileDialog(),
                  )
                },
                child: const Center(
                    child: Icon(Icons.edit,
                        color: Color.fromARGB(231, 152, 239, 38))),
              ),
            )),
        const SizedBox(width: 10),
        ProfileTooltip(
            message: 'post',
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: editProfile,
                child: const Center(
                    child: Icon(
                  Icons.add_to_photos_rounded,
                  color: Color.fromARGB(255, 229, 125, 22),
                )),
              ),
            )),
        const SizedBox(width: 10),
      ],
    ));
  }
}
