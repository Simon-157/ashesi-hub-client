import 'package:flutter/material.dart';
import 'package:hub_client/components/custom_textbox.dart';
import 'package:hub_client/models/user_model.dart';
import 'package:hub_client/utils/data_validations.dart';
import 'package:hub_client/providers/profile_edit_view.dart';
import 'package:hub_client/utils/firebase_collections.dart';
import 'package:hub_client/widgets/loaders.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  final UserModel user;
  const EditProfile({required this.user});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String currentUid() {
    return firebaseAuth.currentUser!.uid;
  }

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
              actions: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 0),
                    child: GestureDetector(
                      onTap: () => viewModel.editProfile(context),
                      child: Text(
                        'SAVE',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 15.0,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            body: ListView(
              children: [
                Center(
                  child: GestureDetector(
                    onTap: () => viewModel.pickImage(),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.transparent,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            offset: const Offset(0.0, 0.0),
                            blurRadius: 2.0,
                            spreadRadius: 0.0,
                          ),
                        ],
                      ),
                      child: viewModel.imgLink != null
                          ? Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: CircleAvatar(
                                radius: 65.0,
                                backgroundImage:
                                    NetworkImage(viewModel.imgLink!),
                              ),
                            )
                          : viewModel.image == null
                              ? Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: CircleAvatar(
                                    radius: 65.0,
                                    backgroundImage:
                                        NetworkImage(widget.user.avatar_url),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: CircleAvatar(
                                    radius: 65.0,
                                    backgroundImage:
                                        FileImage(viewModel.image!),
                                  ),
                                ),
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                SizedBox(width: 300, child: buildForm(viewModel, context)),
              ],
            ),
          ),
        ));
  }

  buildForm(viewModel, BuildContext context) {
    DateTime? selectedDate;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Form(
        key: viewModel.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 400, // set the desired width here
              child: TextFormBuilder(
                enabled: !viewModel.loading,
                initialValue: widget.user.residence,
                prefix: Icons.account_balance_outlined,
                hintText: "Residence",
                textInputAction: TextInputAction.next,
                validateFunction: DataValidation.requiredFieldValidation,
                onSaved: (String val) {
                  viewModel.setResidence(val);
                },
              ),
            ),
            const SizedBox(height: 10.0),
            Container(
              width: 400, // set the desired width here
              child: TextFormBuilder(
                enabled: !viewModel.loading,
                initialValue: widget.user.major,
                prefix: Icons.golf_course_outlined,
                hintText: "Major",
                textInputAction: TextInputAction.next,
                validateFunction: DataValidation.requiredFieldValidation,
                onSaved: (String val) {
                  viewModel.setMajor(val);
                },
              ),
            ),
            const SizedBox(height: 10.0),
            Container(
              width: 400, // set the desired width here
              child: TextFormBuilder(
                enabled: !viewModel.loading,
                initialValue: widget.user.year_group,
                prefix: Icons.class_outlined,
                hintText: "Year Group",
                textInputAction: TextInputAction.next,
                validateFunction: DataValidation.notNull,
                onSaved: (String val) {
                  viewModel.setYearGroup(val);
                },
              ),
            ),
            const SizedBox(height: 10.0),
            Container(
              width: 400, // set the desired width here
              child: TextFormField(
                enabled: !viewModel.loading,
                readOnly: true,
                onTap: () async {
                  selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (selectedDate != null) {
                    setState(() {
                      // set the selected date in the TextFormBuilder widget
                      // or pass it to a method to process
                    });
                  }
                },
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.class_outlined),
                  hintText: 'Date of Birth',
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Container(
              width: 400, // set the desired width here
              child: TextFormBuilder(
                enabled: !viewModel.loading,
                initialValue: widget.user.best_movie,
                prefix: Icons.movie_outlined,
                hintText: "Best Movie",
                textInputAction: TextInputAction.next,
                validateFunction: DataValidation.requiredFieldValidation,
                onSaved: (String val) {
                  viewModel.setBestMovie(val);
                },
              ),
            ),
            const SizedBox(height: 10.0),
            Container(
              width: 400, // set the desired width here
              child: TextFormBuilder(
                enabled: !viewModel.loading,
                initialValue: widget.user.best_food,
                prefix: Icons.movie_outlined,
                hintText: "Best Food",
                textInputAction: TextInputAction.next,
                validateFunction: DataValidation.requiredFieldValidation,
                onSaved: (String val) {
                  viewModel.setBestFood(val);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
