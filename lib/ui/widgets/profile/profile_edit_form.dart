import 'package:flutter/material.dart';
import 'package:hub_client/components/custom_widget_attributes.dart';
import 'package:hub_client/models/user_model.dart';
import 'package:hub_client/services/api_services/update_profile.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class UserFormWidget extends StatefulWidget {
  final UserModel user;

  const UserFormWidget({required this.user});

  @override
  _UserFormWidgetState createState() => _UserFormWidgetState();
}

class _UserFormWidgetState extends State<UserFormWidget> {
  late TextEditingController _usernameController;
  late TextEditingController _yearGroupController;
  late TextEditingController _bestFoodController;
  late TextEditingController _bestMovieController;
  late TextEditingController _majorController;
  late TextEditingController _residenceController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: widget.user.username);
    _yearGroupController = TextEditingController(text: widget.user.year_group);
    _bestFoodController = TextEditingController(text: widget.user.best_food);
    _bestMovieController = TextEditingController(text: widget.user.best_movie);
    _majorController = TextEditingController(text: widget.user.major);
    _residenceController = TextEditingController(text: widget.user.residence);
    // _isOnline = widget.user.isOnline;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 400,
            child: Column(
              children: [
                TextFormField(
                  style: const TextStyle(
                      color: Color.fromARGB(222, 198, 230, 235)),
                  decoration: InputDecoration(
                    labelText: 'Username',
                    labelStyle: const TextStyle(
                        color: Color.fromARGB(188, 159, 234, 245),
                        fontSize: 16),
                    prefixIcon: Icon(
                      Icons.perm_identity,
                      size: 15.0,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    filled: true,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20.0),
                    border: border(context),
                    enabledBorder: border(context),
                    focusedBorder: focusBorder(context),
                  ),
                  controller: _usernameController,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  style: const TextStyle(
                      color: Color.fromARGB(222, 198, 230, 235)),
                  controller: _yearGroupController,
                  decoration: InputDecoration(
                    labelText: 'Year Group',
                    labelStyle: const TextStyle(
                        color: Color.fromARGB(188, 159, 234, 245),
                        fontSize: 16),
                    prefixIcon: Icon(
                      Icons.group,
                      size: 15.0,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    filled: true,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20.0),
                    border: border(context),
                    enabledBorder: border(context),
                    focusedBorder: focusBorder(context),
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  style: const TextStyle(
                      color: Color.fromARGB(222, 198, 230, 235)),
                  controller: _bestFoodController,
                  decoration: InputDecoration(
                    labelText: 'Best Food',
                    labelStyle: const TextStyle(
                        color: Color.fromARGB(188, 159, 234, 245),
                        fontSize: 16),
                    prefixIcon: Icon(
                      Icons.food_bank,
                      size: 15.0,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    filled: true,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20.0),
                    border: border(context),
                    enabledBorder: border(context),
                    focusedBorder: focusBorder(context),
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  style: const TextStyle(
                      color: Color.fromARGB(222, 198, 230, 235)),
                  controller: _bestMovieController,
                  decoration: InputDecoration(
                    labelText: 'Best Movie',
                    labelStyle: const TextStyle(
                        color: Color.fromARGB(188, 159, 234, 245),
                        fontSize: 16),
                    prefixIcon: Icon(
                      Icons.movie,
                      size: 15.0,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    filled: true,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20.0),
                    border: border(context),
                    enabledBorder: border(context),
                    focusedBorder: focusBorder(context),
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  style: const TextStyle(
                      color: Color.fromARGB(222, 198, 230, 235)),
                  controller: _majorController,
                  decoration: InputDecoration(
                    labelText: 'Major',
                    labelStyle: const TextStyle(
                        color: Color.fromARGB(188, 159, 234, 245),
                        fontSize: 16),
                    prefixIcon: Icon(
                      Icons.cast_for_education,
                      size: 15.0,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    filled: true,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20.0),
                    border: border(context),
                    enabledBorder: border(context),
                    focusedBorder: focusBorder(context),
                  ),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField(
                  style: const TextStyle(
                      color: Color.fromARGB(222, 198, 230, 235)),
                  decoration: InputDecoration(
                    labelText: 'Residence',
                    labelStyle: const TextStyle(
                        color: Color.fromARGB(188, 159, 234, 245),
                        fontSize: 16),
                    prefixIcon: Icon(
                      Icons.location_city,
                      size: 15.0,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    filled: true,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20.0),
                    border: border(context),
                    enabledBorder: border(context),
                    focusedBorder: focusBorder(context),
                  ),
                  // value: widget.user.residence,
                  items: [
                    if (widget.user.residence == 'On-Campus')
                      const DropdownMenuItem(
                          value: 'On-Campus', child: Text('On Campus')),
                    if (widget.user.residence == 'Off-Campus-Residence')
                      const DropdownMenuItem(
                          value: 'Off-Campus-Residence',
                          child: Text('Off Campus')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      widget.user.residence = value.toString();
                    });
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  style: const TextStyle(
                      color: Color.fromARGB(222, 198, 230, 235)),
                  decoration: InputDecoration(
                    labelText: 'Date of Birth',
                    labelStyle: const TextStyle(
                        color: Color.fromARGB(188, 159, 234, 245),
                        fontSize: 16),
                    prefixIcon: Icon(
                      Icons.calendar_month,
                      size: 15.0,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    filled: true,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20.0),
                    border: border(context),
                    enabledBorder: border(context),
                    focusedBorder: focusBorder(context),
                  ),
                  readOnly: true,
                  onTap: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: widget.user.date_of_birth,
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        widget.user.date_of_birth = pickedDate;
                      });
                    }
                  },
                  controller: TextEditingController(
                    text: widget.user.date_of_birth != null
                        ? widget.user.date_of_birth.toIso8601String()
                        : '',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              print(
                  ' username: ${_usernameController.text}, year_group: ${_yearGroupController.text}, best_food: ${_bestFoodController.text}');
              // TODO: Update user in database or other data store
              Map<String, dynamic> formData = {
                'username': _usernameController.text,
                'major': _majorController.text,
                'year_group': _yearGroupController.text,
                'best_food': _bestFoodController.text,
                'best_movie': _bestMovieController.text,
                // 'date_of_birth': widget.user.date_of_birth,
                'residence': widget.user.residence
              };

              try {
                // Call the ApiService method to submit the form data
                Map<String, dynamic> userUpdated =
                    await UpdateProfileService.updateProfile(
                        formData, widget.user.user_id);

                if (userUpdated["status"] == "success") {
                  // Show a success message or navigate to a success page
                  // ignore: use_build_context_synchronously
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Success'),
                      content: const Text('Profile Updated'),
                      actions: [
                        TextButton(
                          onPressed: () =>
                              Navigator.pop(context, userUpdated['data']),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                } else {
                  // Handle error
                  print('error');
                }
              } catch (e) {
                print(e.toString());
                // Handle error
              }
              Navigator.pop(context);
            },
            child: const Text('Save Changes'),
          ),
        ],
      ),
    );
  }
}
