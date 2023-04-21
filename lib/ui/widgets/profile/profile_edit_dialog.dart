import 'package:flutter/material.dart';
import 'package:hub_client/models/user_model.dart';
import 'package:hub_client/ui/views/profileview/profile_details.dart';
import 'package:hub_client/ui/widgets/profile/profile_edit_form.dart';
import 'package:hub_client/providers/profile_edit_view.dart';
import 'package:hub_client/widgets/loaders.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  final UserModel user;
  const EditProfile({Key? key, required this.user}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    EditProfileViewModel viewModel = Provider.of<EditProfileViewModel>(context);
    return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF05182D), Color(0xFF092A45), Color(0xFF0D2339)],
          ),
        ),
        child: LoadingOverlay(
          progressIndicator: circularProgress(context),
          isLoading: viewModel.loading,
          child: Scaffold(
            key: viewModel.scaffoldKey,
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: const Color(0xFF092A45),
              centerTitle: true,
              title: const Text("Edit Profile"),
            ),
            body: ListView(
              children: [
                Center(
                  child: GestureDetector(
                    child: Container(
                     child: MyStudentWidget(profileId: widget.user.user_id),
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                SizedBox(width: 300, child: UserFormWidget(user: widget.user)),
              ],
            ),
          ),
        ));
  }

  }

