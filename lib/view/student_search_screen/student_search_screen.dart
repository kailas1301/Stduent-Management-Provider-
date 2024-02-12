import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:studentmanagement_provider/services/functions.dart';
import 'package:studentmanagement_provider/utils/constants.dart';
import 'package:studentmanagement_provider/view/student_list_screen.dart/student_list_screen.dart';
import 'package:studentmanagement_provider/view/widgets/app_bar_widget.dart';
import 'package:studentmanagement_provider/view/widgets/text_form_widgetr.dart';
import 'package:studentmanagement_provider/viewmodel/student_controller.dart';

class SearchStudentScreen extends StatelessWidget {
  const SearchStudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    return Scaffold(
      backgroundColor: Constants().blackColor,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 90),
        child: AppBarWidget(
          title: 'Search Students',
          lefticon: Icons.arrow_back,
          onTapLeft: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<StudentProvider>(
            builder: (context, studentProvider, _) {
              final filteredStudents = studentProvider.filteredStudents;
              return Column(
                children: [
                  TextFormFieldWidget(
                    onChanged: (p0) {
                      print('filtering query changed: $p0');
                      studentProvider.filterStudents(p0);
                    },
                    controller: searchController,
                    hintText: 'Type the name of the student',
                    inputType: TextInputType.name,
                    prefixicon: Icons.search,
                  ),
                  Constants().kheight20,
                  Expanded(
                    child: filteredStudents.isEmpty
                        ? Center(
                            child: Text(
                              'No Student Found.',
                              style: GoogleFonts.openSans(
                                  fontSize: 20, color: Constants().whiteColor),
                            ),
                          )
                        : ListView.separated(
                            itemBuilder: (context, index) {
                              final student = filteredStudents[index];
                              return InkWell(
                                onTap: () =>
                                    showStudentDetailsDialog(context, student),
                                child: StudentCardWidget(
                                    student: student,
                                    studentController: studentProvider),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                Constants().kheight10,
                            itemCount: filteredStudents.length,
                          ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
