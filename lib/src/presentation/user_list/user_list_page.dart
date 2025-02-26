import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platform_common/src/application/bloc/user_list/user_list_bloc.dart';
import 'package:platform_common/src/application/bloc/user_list/user_list_state.dart';
import 'package:platform_common/src/core/app_constants.dart';
import 'package:platform_common/src/data/database/core/app_database.dart';
import 'package:platform_common/src/presentation/core/app_page.dart';
import 'package:platform_common/src/presentation/core/base_state.dart';
import 'package:platform_common/src/presentation/core/theme/colors.dart';

class UserListPage extends StatefulWidget {
  static String route = '/userListPage';
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends BaseState<UserListPage> {
  UserListBloc? _bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = BlocProvider.of<UserListBloc>(context);
    _bloc!.message.listen((value) => showMessage(value));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserListBloc, UserListState>(
      listener: (context, state) {},
      builder: (context, state) {
        return AppPage(
          backgroundColor: AppColors.white,
          retryOnTap: () {},
          processStateStream: _bloc!.stream.map((state) => state.processState),
          key: const Key("UserList"),
          initStateStream: _bloc!.stream.map((state) => state.isInitCompleted),
          child: _body(context, state),
        );
      },
    );
  }

  Widget _body(BuildContext context, UserListState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: Units.kStandardPadding, vertical: Units.kStandardPadding),
      child: state.userList!.isNotEmpty
          ? ListView.builder(
              itemCount: state.userList!.length,
              itemBuilder: (context, index) {
                final item = state.userList![index];
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(
                    horizontal: Units.kMPadding,
                    vertical: Units.kSPadding,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Units.kStandardPadding,
                      vertical: Units.kStandardPadding,
                    ),
                    child: _getProjectListData(context, state, item),
                  ),
                );
              })
          : Text("No data"),
    );
  }

  Widget _getProjectListData(
      BuildContext context, UserListState state, UserList item) {
    final ScrollController scrollController = ScrollController();
    // final recentList = state.recentList;
    // scrollController.addListener(() {
    //   if (scrollController.position.pixels >=
    //       scrollController.position.maxScrollExtent &&
    //       !(state.isFetching ?? true)) {
    //     bloc?.add(PaginationList(state.pageCount + 1));
    //   }
    // });
    return Row(
      children: [
        Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          child: ClipOval(
            child: Image.network(
              item.avatar!,
              width: 50, // Adjust size as needed
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(width: 20,),
        Text(item.firstName!),
        SizedBox(width: 5,),
        Text(item.lastName!),
      ],
    );
  }
}
