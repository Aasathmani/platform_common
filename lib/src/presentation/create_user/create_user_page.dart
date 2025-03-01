import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platform_common/src/application/bloc/create_user/create_user_bloc.dart';
import 'package:platform_common/src/application/bloc/create_user/create_user_event.dart';
import 'package:platform_common/src/application/bloc/create_user/create_user_state.dart';
import 'package:platform_common/src/core/app_constants.dart';
import 'package:platform_common/src/presentation/core/app_page.dart';
import 'package:platform_common/src/presentation/core/base_state.dart';
import 'package:platform_common/src/presentation/core/theme/colors.dart';
import 'package:platform_common/src/presentation/core/theme/text_styles.dart';
import 'package:platform_common/src/presentation/widgets/app_button.dart';

class CreateUserPage extends StatefulWidget {
  static String route = '/createUserPage';
  const CreateUserPage({super.key});

  @override
  State<CreateUserPage> createState() => _CreateUserPageState();
}

class _CreateUserPageState extends BaseState<CreateUserPage> {
  CreateUserBloc? _bloc;
  late ColorScheme _theme;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = BlocProvider.of<CreateUserBloc>(context);
    _bloc!.message.listen((value) => showMessage(value));
  }

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context).colorScheme;
    return BlocConsumer<CreateUserBloc, CreateUserState>(
      listener: (context, state) {
        if (state.createStatusSuccess == true) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return AppPage(
          key: const Key("create user"),
          title: "New user",
          retryOnTap: () {},
          processStateStream: _bloc!.stream.map((state) => state.processState),
          initStateStream: _bloc!.stream.map((state) => state.isInitCompleted),
          child: _getBody(context, state),
        );
      },
    );
  }

  Widget _getBody(BuildContext context, CreateUserState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Units.kLPadding),
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          _geNameTextField(context, state),
          const SizedBox(
            height: 30,
          ),
          _getJobTextField(context, state),
          const SizedBox(
            height: 50,
          ),
          _createNewUserButton(context),
        ],
      ),
    );
  }

  Widget _geNameTextField(BuildContext context, CreateUserState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Name",
          style: TextStyles.title2Medium(context),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 40,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            border: Border.all(color: AppColors.primary),
            //color: AppColors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Units.kSPadding,
              vertical: Units.kSPadding,
            ),
            child: Center(
              child: TextField(
                onChanged: (value) {
                  _bloc!.add(NameFieldChanged(value));
                },
                decoration: const InputDecoration(
                  hintText: "Enter your name",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _getJobTextField(BuildContext context, CreateUserState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Job",
          style: TextStyles.title2Medium(context),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 40,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            border: Border.all(color: AppColors.primary),
            //color: AppColors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Units.kSPadding,
              vertical: Units.kSPadding,
            ),
            child: Center(
              child: TextField(
                onChanged: (value) {
                  _bloc!.add(JobTextChanged(value));
                },
                decoration: const InputDecoration(
                  hintText: "Enter your job",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _createNewUserButton(BuildContext context) {
    return AppButton(
      height: 40,
      onTap: () {
        _bloc!.add(CreateUserTapped());
      },
      label: "Create user".toUpperCase(),
      color: _theme.primary,
    );
  }
}
