import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platform_common/src/application/bloc/user_list/user_list_bloc.dart';
import 'package:platform_common/src/application/bloc/user_list/user_list_event.dart';
import 'package:platform_common/src/application/bloc/user_list/user_list_state.dart';
import 'package:platform_common/src/core/app_constants.dart';
import 'package:platform_common/src/data/database/core/app_database.dart';
import 'package:platform_common/src/presentation/core/app_page.dart';
import 'package:platform_common/src/presentation/core/base_state.dart';
import 'package:platform_common/src/presentation/core/theme/colors.dart';
import 'package:platform_common/src/presentation/movie_list/movie_list_page.dart';

/// api key: f67d8258ca62da88008a27a360221bca

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
      listener: (context, state) {
        if (state.userList!.length < 9 && state.userList!.isNotEmpty) {
          _bloc!.add(MoreUserList(state.page + 1));
        }
      },
      builder: (context, state) {
        return AppPage(
          backgroundColor: AppColors.white,
          retryOnTap: () {},
          title: "Users list",
          processStateStream: _bloc!.stream.map((state) => state.processState),
          key: const Key("UserList"),
          initStateStream: _bloc!.stream.map((state) => state.isInitCompleted),
          child: _body(context, state),
        );
      },
    );
  }

  Widget _body(BuildContext context, UserListState state) {
    final ScrollController scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        if (!(_bloc!.state.isFetching ?? true)) {
          _bloc?.add(MoreUserList(_bloc!.state.page + 1));
        }
      }
    });
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Units.kStandardPadding,
        vertical: Units.kStandardPadding,
      ),
      child: state.userList!.isNotEmpty
          ? ListView.builder(
              controller: scrollController,
              itemCount: state.userList!.length,
              itemBuilder: (context, index) {
                if (index == state.userList!.length) {
                  return state.isFetching == true
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : const SizedBox.shrink();
                }
                final item = state.userList![index];
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, MovieListPage.route);
                  },
                  child: Card(
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
                  ),
                );
              })
          : const Center(
              child: Text("No data"),
            ),
    );
  }

  Widget _getProjectListData(
      BuildContext context, UserListState state, UserList item) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
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
            const SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text("First Name: "),
                    Text(item.firstName!),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    const Text("Last Name: "),
                    Text(item.lastName!),
                  ],
                ),
              ],
            ),
          ],
        ),
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, MovieListPage.route);
          },
          icon: const Icon(Icons.arrow_forward),
        ),
      ],
    );
  }
}
