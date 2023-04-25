import 'package:hub_client/models/user_model.dart';
import 'package:hub_client/ui/views/profileview/full_user_details.dart';

detailedProfile(UserModel user) {
  return ReadOnlyDialog(
    title: 'User Information',
    fields: [
      ReadOnlyTextField(
        label: 'Username',
        value: user.username,
      ),
      ReadOnlyTextField(
        label: 'Email',
        value: user.email,
      ),
      ReadOnlyTextField(
        label: 'Year Group',
        value: user.yearGroup,
      ),
      ReadOnlyTextField(
        label: 'Best Movie',
        value: user.bestMovie,
      ),
      ReadOnlyTextField(
        label: 'Residence',
        value: user.residence,
      ),
      ReadOnlyTextField(
        label: 'Major',
        value: user.major,
      ),
      ReadOnlyTextField(
        label: 'Date of Birth',
        value: user.dateOfBirth.toString(),
      ),

      // Add more fields here
    ],
  );
}
