import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:studentmanagement_provider/model/student.dart';
import 'package:studentmanagement_provider/services/db_helper.dart';

class StudentProvider extends ChangeNotifier {
  final List<StudentModel> students = [];
  final List<StudentModel> filteredStudents = [];
  String pickedImage = '';

  StudentProvider() {
    loadStudents();
  }

  Future<void> setPickedImage(String imagePath) async {
    pickedImage = imagePath;
    notifyListeners();
  }

  Future<void> setInitialImage(String imageUrl) async {
    pickedImage = imageUrl;
  }

  Future pickImage(ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: source);
      if (pickedFile == null) {
        return;
      }
      return pickedFile.path;
    } catch (e) {
      print('error fetching error');
    }
  }

  Future<void> loadStudents() async {
    List<Map<String, dynamic>> studentData =
        await DbHelper().getAllStudentsData();
    students.clear();
    students
        .addAll(studentData.map((data) => StudentModel.fromMap(data)).toList());
    filterStudents('');
    notifyListeners();
  }

  void filterStudents(String query) {
    print('Filtering students with query: $query');
    filteredStudents.clear();
    filteredStudents.addAll(students
        .where((student) =>
            student.name.toLowerCase().contains(query.toLowerCase()))
        .toList());
    print('Filtered students: $filteredStudents');
    notifyListeners();
  }

  Future<void> addStudent(StudentModel student) async {
    await DbHelper().insertData(student);
    loadStudents();
  }

  Future<void> updateStudent(StudentModel updatedStudent) async {
    await DbHelper().updateStudentDetailsFromDB(updatedStudent);
    loadStudents();
  }

  Future<void> deleteStudent(int id) async {
    await DbHelper().deleteStudent(id);
    loadStudents();
  }
}
