import 'package:apistsk/model/Data/userModel/user_model.dart';
import 'package:apistsk/model/Widgets/textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import '../../model/Data/Api/api_services.dart';
import '../../model/Data/UserMobx/user_mobx.dart';

class UserHome extends StatefulWidget {
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome>
    with SingleTickerProviderStateMixin {
  late TextEditingController nameController;
  late TextEditingController jobController;
  late AnimationController controller;
  final UserStore userStore = GetIt.instance<UserStore>();
  Future<dynamic>?
      _data; // TODO :will be applied in Future builder future:_data like this
  @override
  void initState() {
    _data = userStore.fetchUsers();
    userStore.fetchUsers();
    nameController = TextEditingController();
    jobController = TextEditingController();
    controller = BottomSheet.createAnimationController(this);
    controller.duration = const Duration(seconds: 1);
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    jobController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
      ),
      body: Observer(
        builder: (_) {
          if (userStore.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (userStore.errorMessage.isNotEmpty) {
            return Center(
              child: Text(userStore.errorMessage),
            );
          } else if (userStore.userData == null ||
              userStore.userData!.data.isEmpty) {
            return const Center(
              child: Text('No users available'),
            );
          } else {
            return ListView.builder(
              itemCount: userStore.userData!.data.length,
              itemBuilder: (context, index) {
                final user = userStore.userData!.data[index];

                return ListTile(
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          nameController.text = user.firstName!;
                          jobController.text = user.lastName!;
                          showModalBottomSheet(
                            showDragHandle: true,
                            transitionAnimationController: controller,
                            context: context,
                            builder: (context) => editUser(user),
                          );
                        },
                        icon: const Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(
                                  'User ${user.firstName} ${user.lastName}',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              content: const Text(
                                'Do you want to Delete ?',
                                style:
                                    TextStyle(fontSize: 18, color: Colors.red),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('No'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    userStore.deleteUser(user.id!);
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Yes'),
                                ),
                              ],
                            ),
                          );
                        },
                        icon: const Icon(Icons.delete, color: Colors.red),
                      ),
                    ],
                  ),
                  title: Text('${user.firstName} ${user.lastName}'),
                  subtitle: Text(user.email!),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(user.avatar!),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Widget editUser(Datum user) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const HeaderTetxt(
              text: 'Edit', fontSize: 18, fontWeight: FontWeight.bold),
          const SizedBox(
            height: 30,
          ),
          AppTextField(
            controller: nameController,
            hintText: 'Enter Name',
            keyboradtype: TextInputType.name,
            textInputAcxtion: TextInputAction.next,
            borderRadius: 50,
            fillColor: const Color.fromARGB(255, 152, 152, 164),
          ),
          const SizedBox(
            height: 10,
          ),
          AppTextField(
            controller: jobController,
            hintText: 'Enter Job',
            keyboradtype: TextInputType.name,
            textInputAcxtion: TextInputAction.done,
            borderRadius: 50,
            fillColor: const Color.fromARGB(255, 152, 152, 164),
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButtons(
            bgcolor: Colors.blue,
            text: 'Save',
            txtcolors: Colors.white,
            onPressed: () {
              var userData =
                  SaveJob(name: nameController.text, job: jobController.text)
                      .toJson();

              userStore.updateUser(user.id!, userData);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
