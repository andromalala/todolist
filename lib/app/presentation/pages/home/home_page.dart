import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/app/core/states/base_state.dart';
import 'package:to_do_list/app/core/utils/constants.dart';
import 'package:to_do_list/app/core/utils/theme.dart';
import 'package:to_do_list/app/presentation/pages/home/bloc/task_bloc.dart';
import 'package:to_do_list/app/presentation/routes/app_routes.dart';
import 'package:to_do_list/app/presentation/widgets/dialog.dart';
import 'package:to_do_list/app/presentation/widgets/snack_bar_widget.dart';
import 'package:to_do_list/app/presentation/widgets/task_item_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    TaskBloc taskBloc = context.read<TaskBloc>();
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        title: const Text("ToDoList"),
        actions: [
          BlocBuilder<TaskBloc, BaseState>(
            buildWhen: (prevState, currState) {
              return prevState != currState;
            },
            builder: (context, state) {
              return PopupMenuButton<SortType>(
                onSelected: (sortType) {
                  taskBloc.add(SortTasksEvent(sortType: sortType));
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    enabled: false,
                    child: Text(
                      'Trier',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  _buildCheckedPopupMenuItem(
                      text: "Plus récent",
                      sortType: SortType.dateNewest,
                      isChecked: state is GetAllTaskState &&
                          state.sortType == SortType.dateNewest),
                  _buildCheckedPopupMenuItem(
                      text: "Plus ancien",
                      sortType: SortType.dateOldest,
                      isChecked: state is GetAllTaskState &&
                          state.sortType == SortType.dateOldest),
                  _buildCheckedPopupMenuItem(
                      text: "A-Z",
                      sortType: SortType.alphabeticalAsc,
                      isChecked: state is GetAllTaskState &&
                          state.sortType == SortType.alphabeticalAsc),
                  _buildCheckedPopupMenuItem(
                      text: "Z-A",
                      sortType: SortType.alphabeticalDesc,
                      isChecked: state is GetAllTaskState &&
                          state.sortType == SortType.alphabeticalDesc),
                ],
                icon: const Icon(Icons.sort),
              );
            },
          ),
        ],
      ),
      backgroundColor: CustomTheme.backgroundColor,
      body: BlocBuilder<TaskBloc, BaseState>(
        buildWhen: (prevState, currState) {
          if (currState.status == Status.error) {
            SnackBarWidget.show(
              isError: true,
              message: currState.message,
              context: context,
            );
          }
          return prevState != currState;
        },
        builder: (context, state) {
          if (state is TaskLoadingState) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            );
          } else if (state is GetAllTaskState) {
            if (state.listTask.isEmpty) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Aucune tâche",
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                ),
              );
            } else {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.listTask.length,
                      itemBuilder: (context, index) {
                        return TaskItem(
                          task: state.listTask[index],
                          onDelete: () async {
                            bool? confirm = await showDialog<bool?>(
                              context: context,
                              barrierDismissible: false,
                              barrierColor: Colors.black.withOpacity(0.5),
                              builder: (BuildContext context) =>
                                  const ConfirmDialog(
                                title: "Voulez-vous vraiment supprimer ?",
                              ),
                            );
                            if (confirm == true) {
                              taskBloc.add(DeleteTaskEvent(
                                  id: state.listTask[index].id));
                            }
                          },
                          onTap: () {
                            taskBloc.add(UpdateTaskEvent(
                                id: state.listTask[index].id,
                                isCompleted:
                                    !state.listTask[index].isCompleted));
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          }
          return Container();
        },
      ),
      bottomNavigationBar: Stack(
        clipBehavior: Clip.none,
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          BlocBuilder<TaskBloc, BaseState>(
            buildWhen: (prevState, currState) {
              return prevState != currState;
            },
            builder: (context, state) {
              return BottomNavigationBar(
                backgroundColor: CustomTheme.primaryColor,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.grey,
                currentIndex: taskBloc.selectedIndex,
                onTap: (value) {
                  if (value == 1) {
                    context.read<TaskBloc>().add(FilterCompletedTasksEvent());
                  } else {
                    context.read<TaskBloc>().add(GetListTaskEvent());
                  }
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.list),
                    label: 'Tous',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.check),
                    label: 'Terminer',
                  ),
                ],
              );
            },
          ),
          Positioned(
            bottom: 10,
            child: Container(
              height: 70,
              width: 70,
              decoration: const BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black45,
                    spreadRadius: 1,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: FloatingActionButton(
                backgroundColor: CustomTheme.primaryColor,
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.addTask);
                },
                elevation: 0,
                child: const Icon(Icons.add, size: 30),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

PopupMenuItem<SortType> _buildCheckedPopupMenuItem(
    {required String text,
    required SortType sortType,
    required bool isChecked}) {
  return PopupMenuItem<SortType>(
    value: sortType,
    child: Row(
      children: [
        Icon(
          isChecked ? Icons.check_circle_rounded : Icons.radio_button_unchecked,
          color: CustomTheme.primaryColor,
        ),
        const SizedBox(width: 8),
        Text(text),
      ],
    ),
  );
}
