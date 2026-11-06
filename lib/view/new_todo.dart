import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_multi_screen_project/constant/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_multi_screen_project/model/model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyNewScreen extends StatefulWidget {
  const MyNewScreen({super.key});

  @override
  State<MyNewScreen> createState() => _MyNewScreenState();
}

class _MyNewScreenState extends State<MyNewScreen> {
  List<MyTask> listTask = [];

  bool isDone = false;
  Future<void> convertTaskToString() async {
    ///Model -> Map -> String
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var taskList = listTask.map((i) => i.toMap()).toList();
    List<String> jsonTaskList = taskList.map((e) => jsonEncode(e)).toList();
    await prefs.setStringList("To-Do", jsonTaskList);
  }

  //Jsonstring -> Map -> Model
  Future<void> convertStringToTaskModel() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> stringList = prefs.getStringList('To-Do') ?? [];
    var mapListTask = stringList.map((e) => jsonDecode(e)).toList();
    listTask = mapListTask.map((i) => MyTask.fromMap(i)).toList();
    setState(() {});
  }

  @override
  void initState() {
    convertStringToTaskModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double sh1 = MediaQuery.of(context).size.height;
    double sw1 = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appbarColor,
        title: Text(
          "DSTP-TODO",
          style: GoogleFonts.poppins(
            color: AppColors.primaryText,
            fontSize: 29,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: AppColors.bgColor,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: listTask.length,
                itemBuilder: (context, index) {
                  var singleTask = listTask[index];
                  return Container(
                    margin: EdgeInsets.only(
                      top: sh1 * 0.03,
                      right: sw1 * 0.05,
                      left: sw1 * 0.05,
                      bottom: sh1 * 0.01,
                    ),
                    padding: EdgeInsets.only(
                      top: sh1 * 0.02,
                      bottom: sh1 * 0.02,
                      left: sw1 * 0.03,
                    ),
                    decoration: BoxDecoration(
                      color: singleTask.isDone
                          ? AppColors.bgColor.withValues(alpha: 0.5)
                          : AppColors.bgColor.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.fabColor,
                          blurRadius: 3.0,
                          spreadRadius: singleTask.isDone ? 1.0 : 3.0,
                          offset: const Offset(0, 0),
                        ),
                      ],
                      border: Border.all(color: Colors.blue.shade100),
                    ),
                    child: Row(
                      children: [
                        Checkbox(
                          activeColor: const Color.fromARGB(255, 231, 8, 8),
                          value: singleTask.isDone,
                          onChanged: (isCheckedFlag) {
                            singleTask.isDone = isCheckedFlag!;
                            convertTaskToString();
                            setState(() {});
                          },
                        ),
                        CircleAvatar(
                          backgroundColor: AppColors.appbarColor,
                          radius: 34,
                          child: CircleAvatar(
                            backgroundImage: AssetImage(
                              "assests/images/bike.jpg",
                            ),
                            backgroundColor: Colors.blueAccent,
                            radius: 30,
                          ),
                        ),
                        SizedBox(width: sw1 * 0.05),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                singleTask.title,
                                style: TextStyle(
                                  color: AppColors.primaryText,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  decoration: singleTask.isDone
                                      ? TextDecoration.lineThrough
                                      : null,
                                  decorationThickness: 4,
                                  decorationColor: Colors.green,
                                ),
                              ),
                              if (singleTask.description != null) ...[
                                Text(
                                  singleTask.description!,
                                  style: TextStyle(
                                    color: AppColors.secondaryText,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                              Text(
                                "${singleTask.taskDate?.day}/${singleTask.taskDate?.month}/${singleTask.taskDate?.year}",
                                style: TextStyle(
                                  color: AppColors.secondaryText,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        PopupMenuButton<String>(
                          color: Colors.transparent.withValues(alpha: 0.8),
                          iconColor: AppColors.primaryText,
                          offset: const Offset(-25, 30),
                          iconSize: 35,
                          onSelected: (value) {
                            if (value == "delete") {
                              listTask.removeAt(index);
                              convertTaskToString();
                              setState(() {});
                            } else if (value == "edit") {
                              TextEditingController titleController =
                                  TextEditingController(text: singleTask.title);
                              TextEditingController descriptionController =
                                  TextEditingController(
                                    text: singleTask.description,
                                  );
                              DateTime selectDate = DateTime(
                                singleTask.taskDate!.year,
                                singleTask.taskDate!.month,
                                singleTask.taskDate!.day,
                              );
                              TimeOfDay selectTime = TimeOfDay(
                                hour: singleTask.taskDate!.hour,
                                minute: singleTask.taskDate!.minute,
                              );

                              showModalBottomSheet(
                                backgroundColor: AppColors.bgColor.withValues(
                                  alpha: 0.9,
                                ),
                                context: context,
                                isScrollControlled: true,
                                builder: (context) {
                                  return StatefulBuilder(
                                    builder: (context, showBottomState) {
                                      return SafeArea(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            bottom: MediaQuery.of(context)
                                                .viewInsets
                                                .bottom,
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(
                                                  10.0,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Text(
                                                      "Edit Todo",
                                                      style: TextStyle(
                                                        color: AppColors
                                                            .secondaryText,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    IconButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                            context,
                                                          ),
                                                      icon: const Icon(
                                                        Icons
                                                            .arrow_drop_down_circle,
                                                        color: AppColors
                                                            .cancelIconColor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                  top: sh1 * 0.02,
                                                  left: sw1 * 0.07,
                                                  right: sw1 * 0.07,
                                                ),
                                                decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color:
                                                          AppColors.appbarColor,
                                                      blurRadius: 6,
                                                      spreadRadius: 0.4,
                                                    ),
                                                  ],
                                                ),
                                                child: TextField(
                                                  controller: titleController,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  onTap: () {
                                                    setState(() {});
                                                  },
                                                  onEditingComplete: () {},
                                                  enableSuggestions: true,
                                                  style: const TextStyle(
                                                    color:
                                                        AppColors.secondaryText,
                                                  ),
                                                  decoration: InputDecoration(
                                                    fillColor: AppColors
                                                        .inputFieldBgColor,
                                                    filled: true,
                                                    labelText: 'Title',
                                                    hintStyle: const TextStyle(
                                                      color: AppColors
                                                          .secondaryText,
                                                    ),
                                                    prefixIconColor: AppColors
                                                        .inputHintTextColor,
                                                    enabledBorder: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            12.0,
                                                          ),
                                                      borderSide: const BorderSide(
                                                        color: AppColors
                                                            .taskCardBorderColor,
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            12.0,
                                                          ),
                                                      borderSide: const BorderSide(
                                                        color: AppColors
                                                            .taskCardBorderColor,
                                                        width: 2.0,
                                                      ),
                                                    ),
                                                    border:
                                                        const OutlineInputBorder(),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                  top: sh1 * 0.03,
                                                  left: sw1 * 0.07,
                                                  right: sw1 * 0.07,
                                                ),
                                                decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color:
                                                          AppColors.appbarColor,
                                                      blurRadius: 6,
                                                      spreadRadius: 0.4,
                                                    ),
                                                  ],
                                                ),
                                                child: TextField(
                                                  controller:
                                                      descriptionController,
                                                  textInputAction:
                                                      TextInputAction.done,
                                                  maxLines: 3,
                                                  onTap: () {
                                                    setState(() {});
                                                  },
                                                  onEditingComplete: () {},
                                                  enableSuggestions: true,
                                                  style: const TextStyle(
                                                    color:
                                                        AppColors.secondaryText,
                                                  ),
                                                  decoration: InputDecoration(
                                                    fillColor: AppColors
                                                        .inputFieldBgColor,
                                                    filled: true,
                                                    labelText: 'Description',
                                                    alignLabelWithHint: true,
                                                    hintStyle: const TextStyle(
                                                      color: AppColors
                                                          .secondaryText,
                                                    ),
                                                    prefixIconColor: AppColors
                                                        .inputHintTextColor,
                                                    enabledBorder: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            12.0,
                                                          ),
                                                      borderSide: const BorderSide(
                                                        color: AppColors
                                                            .taskCardBorderColor,
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            12.0,
                                                          ),
                                                      borderSide: const BorderSide(
                                                        color: AppColors
                                                            .taskCardBorderColor,
                                                        width: 2.0,
                                                      ),
                                                    ),
                                                    border:
                                                        const OutlineInputBorder(),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: sh1 * 0.03),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                    ),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: OutlinedButton.icon(
                                                        onPressed: () async {
                                                          DateTime?
                                                          tumhareselectedDate =
                                                              await showDatePicker(
                                                                context:
                                                                    context,
                                                                firstDate:
                                                                    DateTime(
                                                                      200,
                                                                    ),
                                                                lastDate:
                                                                    DateTime(
                                                                      3000,
                                                                    ),
                                                                initialDate:
                                                                    DateTime.now(),
                                                              );
                                                          if (tumhareselectedDate !=
                                                              null) {
                                                            selectDate =
                                                                tumhareselectedDate;
                                                          }
                                                          showBottomState(
                                                            () {},
                                                          );
                                                        },
                                                        label: Text(
                                                          "${selectDate.year}/${selectDate.month}/${selectDate.day}",
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 10),
                                                    Expanded(
                                                      child: OutlinedButton.icon(
                                                        onPressed: () async {
                                                          TimeOfDay? tempTime =
                                                              await showTimePicker(
                                                                context:
                                                                    context,
                                                                initialTime:
                                                                    TimeOfDay.now(),
                                                              );
                                                          if (tempTime !=
                                                              null) {
                                                            selectTime =
                                                                tempTime;
                                                          }
                                                          showBottomState(
                                                            () {},
                                                          );
                                                        },
                                                        label: Text(
                                                          "${selectTime.hour}:${selectTime.minute}",
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: sh1 * 0.03),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: sw1 * 0.07,
                                                ),
                                                child: SizedBox(
                                                  width: double.infinity,
                                                  child: ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor: AppColors
                                                          .primaryBtnColor,
                                                    ),
                                                    onPressed: () {
                                                      String title =
                                                          titleController.text;
                                                      String description =
                                                          descriptionController
                                                              .text;
                                                      if (title.isNotEmpty) {
                                                        listTask[index] = MyTask(
                                                          title: title,
                                                          description:
                                                              description
                                                                  .isNotEmpty
                                                              ? description
                                                              : null,
                                                          isDone:
                                                              singleTask.isDone,
                                                          datetime: DateTime(
                                                            selectDate.year,
                                                            selectDate.month,
                                                            selectDate.day,
                                                            selectTime.hour,
                                                            selectTime.minute,
                                                          ),
                                                        );

                                                        convertTaskToString();
                                                        Navigator.pop(context);
                                                      }
                                                      setState(() {});
                                                    },
                                                    child: const Text(
                                                      "Add",
                                                      style: TextStyle(
                                                        color: AppColors
                                                            .appbarColor,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: sh1 * 0.03),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                            }
                          },
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: "delete",
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                    size: 20,
                                  ),
                                  Text(
                                    "Delete",
                                    style: GoogleFonts.lato(
                                      color: AppColors.secondaryText,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              value: "edit",
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.edit,
                                    color: Colors.amber,
                                    size: 20,
                                  ),
                                  Text(
                                    "Edit",
                                    style: GoogleFonts.lato(
                                      color: AppColors.secondaryText,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.fabColor,
        onPressed: () {
          TextEditingController titleController = TextEditingController();
          TextEditingController descriptionController = TextEditingController();
          DateTime selectDate = DateTime.now();
          TimeOfDay selectTime = TimeOfDay.now();

          showModalBottomSheet(
            backgroundColor: AppColors.bgColor.withValues(alpha: 0.9),
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return StatefulBuilder(
                builder: (context, showBottomState) {
                  return SafeArea(
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Add Todo",
                                  style: TextStyle(
                                    color: AppColors.secondaryText,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () => Navigator.pop(context),
                                  icon: const Icon(
                                    Icons.arrow_drop_down_circle,
                                    color: AppColors.cancelIconColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: sh1 * 0.02,
                              left: sw1 * 0.07,
                              right: sw1 * 0.07,
                            ),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.appbarColor,
                                  blurRadius: 6,
                                  spreadRadius: 0.4,
                                ),
                              ],
                            ),
                            child: TextField(
                              controller: titleController,
                              textInputAction: TextInputAction.next,
                              onTap: () {
                                setState(() {});
                              },
                              onEditingComplete: () {},
                              enableSuggestions: true,
                              style: const TextStyle(
                                color: AppColors.secondaryText,
                              ),
                              decoration: InputDecoration(
                                fillColor: AppColors.inputFieldBgColor,
                                filled: true,
                                labelText: 'Title',
                                hintStyle: const TextStyle(
                                  color: AppColors.secondaryText,
                                ),
                                prefixIconColor: AppColors.inputHintTextColor,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  borderSide: const BorderSide(
                                    color: AppColors.taskCardBorderColor,
                                    width: 1.0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  borderSide: const BorderSide(
                                    color: AppColors.taskCardBorderColor,
                                    width: 2.0,
                                  ),
                                ),
                                border: const OutlineInputBorder(),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: sh1 * 0.06,
                              left: sw1 * 0.07,
                              right: sw1 * 0.07,
                            ),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.appbarColor,
                                  blurRadius: 6,
                                  spreadRadius: 0.4,
                                ),
                              ],
                            ),
                            child: TextField(
                              controller: descriptionController,
                              textInputAction: TextInputAction.done,
                              maxLines: 3,
                              onTap: () {
                                setState(() {});
                              },
                              onEditingComplete: () {},
                              enableSuggestions: true,
                              style: const TextStyle(
                                color: AppColors.secondaryText,
                              ),
                              decoration: InputDecoration(
                                fillColor: AppColors.inputFieldBgColor,
                                filled: true,
                                labelText: 'Description',
                                alignLabelWithHint: true,
                                hintStyle: const TextStyle(
                                  color: AppColors.secondaryText,
                                ),
                                prefixIconColor: AppColors.inputHintTextColor,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  borderSide: const BorderSide(
                                    color: AppColors.taskCardBorderColor,
                                    width: 1.0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  borderSide: const BorderSide(
                                    color: AppColors.taskCardBorderColor,
                                    width: 2.0,
                                  ),
                                ),
                                border: const OutlineInputBorder(),
                              ),
                            ),
                          ),
                          SizedBox(height: sh1 * 0.03),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton.icon(
                                    onPressed: () async {
                                      DateTime? tumhareselectedDate =
                                          await showDatePicker(
                                            context: context,
                                            firstDate: DateTime(200),
                                            lastDate: DateTime(3000),
                                            initialDate: selectDate,
                                          );
                                      if (tumhareselectedDate != null) {
                                        selectDate = tumhareselectedDate;
                                      }
                                      showBottomState(() {});
                                    },
                                    label: Text(
                                      "${selectDate.year}/${selectDate.month}/${selectDate.day}",
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: OutlinedButton.icon(
                                    onPressed: () async {
                                      TimeOfDay? tempTime =
                                          await showTimePicker(
                                            context: context,
                                            initialTime: selectTime,
                                          );
                                      if (tempTime != null) {
                                        selectTime = tempTime;
                                      }
                                      showBottomState(() {});
                                    },
                                    label: Text(
                                      "${selectTime.hour}:${selectTime.minute}",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: sh1 * 0.03),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: sw1 * 0.07,
                            ),
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryBtnColor,
                                ),
                                onPressed: () {
                                  String title = titleController.text;
                                  String description =
                                      descriptionController.text;
                                  if (title.isNotEmpty) {
                                    listTask.add(
                                      MyTask(
                                        title: title,
                                        description: description.isNotEmpty
                                            ? description
                                            : null,
                                        datetime: DateTime(
                                          selectDate.year,
                                          selectDate.month,
                                          selectDate.day,
                                          selectTime.hour,
                                          selectTime.minute,
                                        ),
                                      ),
                                    );
                                    convertTaskToString();
                                    Navigator.pop(context);
                                  }
                                  setState(() {});
                                },
                                child: const Text(
                                  "Add",
                                  style: TextStyle(
                                    color: AppColors.appbarColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
        child: Icon(Icons.add, color: AppColors.primaryText),
      ),
    );
  }
}
