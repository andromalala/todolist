import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/app/core/states/base_state.dart';
import 'package:to_do_list/app/core/utils/extension.dart';
import 'package:to_do_list/app/core/utils/theme.dart';
import 'package:to_do_list/app/presentation/pages/home/bloc/task_bloc.dart';
import 'package:to_do_list/app/presentation/widgets/basic_widgets.dart';
import 'package:to_do_list/app/presentation/widgets/circular_progress_widget.dart';
import 'package:to_do_list/app/presentation/widgets/snack_bar_widget.dart';

class AddTaskPage extends StatelessWidget {
  const AddTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    TaskBloc taskBloc = context.read<TaskBloc>();
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        title: const Text(
          "Ajouter une tâche",
        ),
      ),
      backgroundColor: Colors.white,
      body: BlocBuilder<TaskBloc, BaseState>(
        buildWhen: (prevState, currState) {
          if (currState.status == Status.success) {
            Navigator.of(context).pop();
            SnackBarWidget.show(
              isError: false,
              message: "Tâche ajoutée avec succès",
              context: context,
            );
          } else if (currState.status == Status.error) {
            SnackBarWidget.show(
              isError: true,
              message: currState.message,
              context: context,
            );
          }
          return prevState != currState;
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Form(
              key: taskBloc.formKey,
              child: Column(
                children: [
                  TextFieldFilled(
                    labelText: 'Titre',
                    controller: taskBloc.titleControllerField,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Veuillez ajouter une titre';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFieldFilled(
                    labelText: 'Description',
                    maxLines: 3,
                    controller: taskBloc.descriptionControllerField,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Veuillez ajouter une description';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 40),
                  Visibility(
                    visible: state is AddTaskLoadingState,
                    replacement: PrimaryButton(
                      width: 50.w(context),
                      onPressed: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        if (taskBloc.formKey.currentState!.validate()) {
                          context.read<TaskBloc>().add(const AddTaskEvent());
                        }
                      },
                      child: Text(
                        'Ajouter',
                        style: TextStyle(
                            fontSize: CustomTheme.subtitle1.sp(context),
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    child: PrimaryButton(
                      height: 6.h(context),
                      width: 50.w(context),
                      child: const CircularProgress(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
