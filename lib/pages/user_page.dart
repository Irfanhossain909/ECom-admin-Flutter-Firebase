import 'package:ecom_admin/providers/auth_provider.dart';
import 'package:ecom_admin/utils/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserListPage extends StatelessWidget {
  static const String routeName = '/userlist';

  const UserListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Text(
              'User',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26,
                color: Colors.blue,
              ),
            ),
            Text(
              'List',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26,
                color: Colors.orange,
              ),
            ),
          ],
        ),
      ),
      body: Consumer<FirebaseAuthProvider>(
        builder: (context, provider, child) => provider.userList.isEmpty
            ? const Center(
                child: Text('No User'),
              )
            : ListView.builder(
                itemCount: provider.userList.length,
                itemBuilder: (context, index) {
                  final user = provider.userList[index];
                  return Card(
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        // onTap: () => Navigator.pushNamed(
                        //   context,
                        //   OrderDetailsPage.routeName,
                        //   arguments: order.orderId,
                        // ),
                        title: Text(user.email),
                        subtitle: Text(user.uid),
                        trailing: Text(
                            ' Registered \n${getFormattedDateTime(user.creationTime.toDate())}'),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
