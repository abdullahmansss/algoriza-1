// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:test1/core/util/blocs/app/cubit.dart';
// import 'package:test1/core/util/blocs/app/states.dart';
// import 'package:test1/features/users/presentation/widgets/user_item.dart';
//
// class UsersWidget extends StatelessWidget {
//   const UsersWidget({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<AppBloc, AppStates>(
//       listener: (context, state) {},
//       builder: (context, state) {
//         return Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               TextFormField(
//                 controller: AppBloc.get(context).usernameController,
//                 decoration: InputDecoration(
//                   suffixIcon: TextButton(
//                     onPressed: () {
//                       // AppBloc.get(context).insertUserData();
//                     },
//                     child: Text(
//                       AppBloc.get(context).selectedUser.isEmpty ? 'Save' : 'Update',
//                     ),
//                   ),
//                   border: const OutlineInputBorder(),
//                   labelText: 'Username',
//                 ),
//               ),
//               Expanded(
//                 child: RefreshIndicator(
//                   onRefresh: () async {
//                     AppBloc.get(context).getTasksData();
//                   },
//                   child: ListView.separated(
//                     itemBuilder: (context, index) => UserItem(
//                       item: AppBloc.get(context).users[index],
//                     ),
//                     separatorBuilder: (context, index) => Container(
//                       width: double.infinity,
//                       height: 1,
//                       color: Colors.grey[300],
//                     ),
//                     itemCount: AppBloc.get(context).users.length,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
