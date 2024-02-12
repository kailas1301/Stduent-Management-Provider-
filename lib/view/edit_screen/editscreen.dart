import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'package:studentmanagement_provider/model/student.dart';
import 'package:studentmanagement_provider/services/functions.dart';
import 'package:studentmanagement_provider/utils/constants.dart';
import 'package:studentmanagement_provider/view/widgets/app_bar_widget.dart';
import 'package:studentmanagement_provider/view/widgets/circle_avatar_widget.dart';
import 'package:studentmanagement_provider/view/widgets/text_form_widgetr.dart';
import 'package:studentmanagement_provider/viewmodel/student_controller.dart';

class EditScreen extends StatelessWidget {
  const EditScreen({super.key, required this.student});
  final StudentModel student;
  @override
  Widget build(BuildContext context) {
    final studentController = context.read<StudentProvider>();
    TextEditingController nameeditingController =
        TextEditingController(text: student.name);
    TextEditingController ageeditingController =
        TextEditingController(text: student.age.toString());
    TextEditingController departmenteditingController =
        TextEditingController(text: student.department);
    TextEditingController placeeditingController =
        TextEditingController(text: student.place);
    TextEditingController phoneNoeditingController =
        TextEditingController(text: student.phoneNumber.toString());
    TextEditingController guardianNameeditingController =
        TextEditingController(text: student.guardianName);
    final formKey = GlobalKey<FormState>();

    return Scaffold(
        backgroundColor: Constants().blackColor,
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 70),
          child: AppBarWidget(
            onTapLeft: () {
              Navigator.pop(context);
            },
            title: 'Enter the details',
            lefticon: Icons.arrow_back,
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              children: [
                Center(
                  child: Consumer<StudentProvider>(
                    builder: (context, studentprovider, child) {
                      if (studentController.pickedImage.isEmpty) {
                        studentController.setInitialImage(student.imageUrl);
                      }

                      return InkWell(
                        onTap: () async {
                          final imagepath = await studentController
                              .pickImage(ImageSource.gallery);
                          studentController.setPickedImage(imagepath ?? '');
                        },
                        child: CircleAvatarWidget(
                            pickedimage: studentController.pickedImage,
                            radius: 80),
                      );
                    },
                  ),
                ),
                Constants().kheight20,
                Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormFieldWidget(
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length < 3) {
                              return 'please enter a valid name';
                            }
                            return null;
                          },
                          prefixicon: Icons.person,
                          controller: nameeditingController,
                          hintText: 'Enter the name',
                          labelText: 'Name',
                          inputType: TextInputType.name,
                        ),
                        TextFormFieldWidget(
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                int.parse(value) >= 120 ||
                                int.parse(value) <= 0) {
                              return 'please enter a valid age';
                            }
                            return null;
                          },
                          prefixicon: Icons.numbers,
                          controller: ageeditingController,
                          hintText: 'Enter the age',
                          labelText: 'Age',
                          inputType: TextInputType.number,
                        ),
                        TextFormFieldWidget(
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.length < 3) {
                                return 'please enter a valid department';
                              }
                              return null;
                            },
                            prefixicon: Icons.person,
                            controller: departmenteditingController,
                            hintText: 'Enter the department',
                            labelText: 'Department',
                            inputType: TextInputType.text),
                        TextFormFieldWidget(
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length < 3) {
                              return 'please enter a valid place';
                            }
                            return null;
                          },
                          prefixicon: Icons.location_city,
                          controller: placeeditingController,
                          hintText: 'Enter the place',
                          labelText: 'Place',
                          inputType: TextInputType.text,
                        ),
                        TextFormFieldWidget(
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length != 10) {
                              return 'please enter a valid phone no';
                            }
                            return null;
                          },
                          prefixicon: Icons.phone,
                          controller: phoneNoeditingController,
                          hintText: 'Enter the phone number',
                          labelText: 'Contact Number',
                          inputType: TextInputType.number,
                        ),
                        TextFormFieldWidget(
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length < 3) {
                              return 'please enter a valid name';
                            }
                            return null;
                          },
                          prefixicon: Icons.person,
                          controller: guardianNameeditingController,
                          hintText: 'Enter the name of the Guardian',
                          labelText: 'Guardian Name',
                          inputType: TextInputType.name,
                        ),
                        Constants().kheight10,
                        ElevatedButton(
                            style: ButtonStyle(
                                elevation: const MaterialStatePropertyAll(5),
                                backgroundColor: MaterialStatePropertyAll(
                                    Constants().whiteColor)),
                            onPressed: () {
                              if (formKey.currentState!.validate() &&
                                  studentController.pickedImage.isNotEmpty) {
                                studentController.updateStudent(StudentModel(
                                    id: student.id,
                                    name: nameeditingController.text,
                                    age: int.parse(ageeditingController.text),
                                    department:
                                        departmenteditingController.text,
                                    place: placeeditingController.text,
                                    phoneNumber: int.parse(
                                        phoneNoeditingController.text),
                                    guardianName:
                                        guardianNameeditingController.text,
                                    imageUrl: studentController.pickedImage));
                                print(
                                    'form is validated ${studentController.students}');
                                snackBarFunction(
                                  context: context,
                                  title: 'Success',
                                  subtitle: 'Edited Successfully',
                                  backgroundColor: Colors.green,
                                );
                              }

                              // if the image is not picked up
                              else if (studentController.pickedImage.isEmpty) {
                                snackBarFunction(
                                    title: 'Submission Failed',
                                    subtitle: 'Please select an image',
                                    backgroundColor: Colors.red,
                                    dismissDirection:
                                        DismissDirection.horizontal,
                                    context: context);
                              } else {
                                print('not valid');
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 10),
                              child: Text(
                                'SUBMIT',
                                style: GoogleFonts.openSans(
                                    color: Constants().blackColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18),
                              ),
                            ))
                      ],
                    ))
              ],
            ),
          )),
        ));
  }
}
