import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../controllers/singin_controller.dart';
import '../../../common/widgets/custom_textformfield.dart';
import '../../../common/constant.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';



class SinginView extends GetView<SinginController> {
  const SinginView({Key? key}) : super(key: key);
  @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Thông tin cá nhân'),
          backgroundColor: primaryColor,
          centerTitle: true,
        ),
        body: Stack(
          children: [
            Container(
               color: Colors.white,
              // decoration: const BoxDecoration(
              //   image: DecorationImage(
              //     image: AssetImage('assets/images/background.jpg'),
              //     fit: BoxFit.fill,
              //   ),
              // ),
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                //  const SizedBox(height: 10),
                  Flexible(
                    child: _buildLoginForm(context),
                  ),
                //  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      );
    }
  Form _buildLoginForm(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: SingleChildScrollView(
        controller: controller.scrollController,
        child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(46, 15, 46, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                    style: const TextStyle(
                      color: texColor, // Đặt màu sắc cho chữ khi nhập liệu
                    ),
                  keyboardType: TextInputType.text,
                  controller: controller.fullnameController,
                  decoration: buildDecorationTextFormField(
                  hintText: 'Họ tên...', icon: Icons.drive_file_rename_outline),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Họ tên không được rỗng";
                    } else if (GetUtils.isNum(value) || value.replaceAll(' ', '').length <= 2) {
                      return "Vui lòng nhập họ tên hợp lệ";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    controller.userInfo.fullname = value ?? '';
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                    style: const TextStyle(
                      color: texColor, // Đặt màu sắc cho chữ khi nhập liệu
                    ),
                  keyboardType: TextInputType.number,
                  controller: controller.cccdController,
                  decoration: buildDecorationTextFormField(
                      hintText: 'Số CCCD...', icon: Icons.recent_actors),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return null;
                    } else if (value.replaceAll(' ', '').length != 12 && value.replaceAll(' ', '').length != 9 || !GetUtils.isNum(value)) {
                      return 'Số CMND/CCCD chưa hợp lệ (phải có 9 hoặc 12 số)';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    controller.userInfo.cccd = value ?? '';
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                    style: const TextStyle(
                      color: texColor, // Đặt màu sắc cho chữ khi nhập liệu
                    ),
                  keyboardType: TextInputType.number,
                  decoration: buildDecorationTextFormField(
                      hintText: 'Số điện thoại...', icon: Icons.phone_android),
                  validator: (value) {
                    if (value!.isEmpty) {
                    //  return "Số điện thoại không được rỗng";
                      return null;
                    } else if (!GetUtils.isNum(value.replaceAll(' ', ''))) {
                      return "Vui lòng nhập số điện thoại hợp lệ";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    controller.userInfo.phone = value ?? '';
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                    style: const TextStyle(
                      color: texColor, // Đặt màu sắc cho chữ khi nhập liệu
                    ),
                  keyboardType: TextInputType.emailAddress,
                  decoration: buildDecorationTextFormField(
                      hintText: 'Email...', icon: Icons.email),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return null;
                    } else if (!GetUtils.isEmail(value)) {
                      return "Vui lòng nhập email hợp lệ";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    controller.userInfo.email = value;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                    style: const TextStyle(
                      color: texColor, // Đặt màu sắc cho chữ khi nhập liệu
                    ),
                  keyboardType: TextInputType.text,
                  controller: controller.adressController,
                  decoration: buildDecorationTextFormField(
                      hintText: 'Địa chỉ...', icon: Icons.location_city),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                    //  return "Địa chỉ không được rỗng";
                    } else if (value.replaceAll(' ', '').length < 5) {
                      return 'Vui lòng nhập địa chỉ hợp lệ';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    controller.userInfo.address = value;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                     style: const TextStyle(
                      color: texColor, // Đặt màu sắc cho chữ khi nhập liệu
                    ),
                  keyboardType: TextInputType.text,
                  decoration: buildDecorationTextFormField(
                  hintText: 'Học vấn...', icon: Icons.school),
                  validator: (value) {
                    if (value!.isEmpty) {
                    //  return "Học vấn không được rỗng";
                      return null;
                    } else if (value.replaceAll(' ', '').length < 2) {
                      return "Vui lòng nhập học vấn hợp lệ";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    controller.userInfo.education = value;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  style: const TextStyle(
                      color: texColor, // Đặt màu sắc cho chữ khi nhập liệu
                    ),
                  keyboardType: TextInputType.text,
                  decoration: buildDecorationTextFormField(
                  hintText: 'Dân tộc...', icon: Icons.pix),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return null;
                    } else if (value.replaceAll(' ', '').length < 2) {
                      return "Vui lòng nhập tên dân tộc hợp lệ";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    controller.userInfo.nation = value;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  style: const TextStyle(
                      color: texColor, // Đặt màu sắc cho chữ khi nhập liệu
                    ),
                  keyboardType: TextInputType.text,
                  decoration: buildDecorationTextFormField(
                  hintText: 'Nghề nghiệp...', icon: Icons.work),
                  validator: (value) {
                    if (value!.isEmpty) {
                    //  return "Nghề nghiệp không được rỗng";
                      return null;
                    } else if (value.replaceAll(' ', '').length < 2) {
                      return "Vui lòng nhập nghề nghiệp hợp lệ";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    controller.userInfo.job = value;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  style: const TextStyle(
                      color: texColor, // Đặt màu sắc cho chữ khi nhập liệu
                    ),
                  keyboardType: TextInputType.number,
                  decoration: buildDecorationTextFormField(
                  hintText: 'Thu nhập...', icon: Icons.money),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return null;
                    } else if (!GetUtils.isNum(value)) {
                      return "Vui lòng nhập số thu nhập hợp lệ";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    controller.userInfo.income = int.tryParse(value ?? '');
                  },
                ),
                const SizedBox(height: 10),
                // TextFormField(
                //   style: const TextStyle(
                //       color: texColor, // Đặt màu sắc cho chữ khi nhập liệu
                //     ),
                //   keyboardType: TextInputType.text,
                //   decoration: buildDecorationTextFormField(
                //   hintText: 'Dịch vụ công từng sử dụng...', icon: Icons.accessibility_sharp),
                //   validator: (value) {
                //     if (value!.isEmpty) {
                //       return null;
                //     } else if (value.replaceAll(' ', '').length <= 1) {
                //       return "Vui lòng nhập dịch vụ hợp lệ";
                //     }
                //     return null;
                //   },
                //   onSaved: (value) {
                //     controller.userInfo.usedservice = value;
                //   },
                // ),
                // const SizedBox(height: 10),
                // Row(
                //   children: [
                //     Expanded(
                //       child: TextField(
                //         controller: controller.textEditingController,
                //         decoration: const InputDecoration(
                //           labelText: 'Dịch vụ công',
                //         ),
                //       ),
                //     ),
                //     const SizedBox(width: 10),
                //     DropdownButton<String>(
                //       value: controller.selectedOption.value,
                //       onChanged: (String? newValue) {
                //         if (newValue != null) {
                //           controller.selectedOption.value = newValue;
                //           controller.textEditingController.text = newValue;
                //         }
                //       },
                //       items: controller.options.map((String option) {
                //         return DropdownMenuItem<String>(
                //           value: option,
                //           child: Text(option),
                //         );
                //       }).toList(),
                //     ),
                //   ],
                // ),
                // const SizedBox(height: 15),
                TypeAheadField<String>(
                  textFieldConfiguration: TextFieldConfiguration(
                    decoration: const InputDecoration(
                      labelText: 'Dịch vụ công từng sử dụng: ',
                    ),
                    controller: controller.typeAheadController,
                  ),
                  suggestionsCallback: (pattern) async {
                    controller.scrollController.animateTo(
                    controller.scrollController.position.maxScrollExtent,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                    );
                    return controller.options;
                  },
                  itemBuilder: (context, suggestion) {
                    return ListTile(
                      title: Text(suggestion),
                    );
                  },
                  onSuggestionSelected: (suggestion) {
                    controller.typeAheadController.text = suggestion;
                  },
                  suggestionsBoxDecoration: const SuggestionsBoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    constraints: BoxConstraints(maxHeight: 150), // Giới hạn chiều cao của phần chứa tùy chọn
                  ),
                  suggestionsBoxVerticalOffset: -190,
                  animationDuration: Duration.zero, // Hiển thị gợi ý ngay lập tức
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    const Text('Giới tính:',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: texColor,
                      )),
                    const SizedBox(width: 20),
                    Obx(
                      () => DropdownButton<String>(
                        value: controller.selectedGender.value,
                        dropdownColor: Colors.white, // Đặt màu sắc cho menu dropdown
                        items: controller.genderOptions.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,
                            style: const TextStyle(
                                  color: texColor, // Đặt màu sắc cho văn bản trong tùy chọn
                                ),
                            ),
                          );
                        }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null && controller.genderOptions.contains(newValue)) {
                          controller.selectedGender.value = newValue;
                        }
                      },
                      ),
                    ),
                    //const SizedBox(width: 26),
                    const Spacer(),
                    const Text('Tuổi:',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: texColor,
                              )),
                    const SizedBox(width: 10),
                    Obx(
                      () => DropdownButton<int>(
                        value: controller.selectedAge.value,
                        dropdownColor: Colors.white, // Đặt màu sắc cho menu dropdown
                        items: controller.numSelected.map((int age) {
                          return DropdownMenuItem<int>(
                            value: age,
                            child: Text(age.toString()),
                          );
                        }).toList(),
                      onChanged: (int? newValue) {
                        if (newValue != null && controller.numSelected.contains(newValue)) {
                          controller.selectedAge.value = newValue;
                          controller.userInfo.age = newValue;
                        }
                      },
                      ),
                    ),
                    // Flexible(
                    //   child: TextFormField(
                    //     textAlign: TextAlign.center, // Căn giữa nội dung ngay khi nhập liệu
                    //     keyboardType: TextInputType.number,
                    //     controller: controller.ageController,
                    //     decoration: buildDecorationTextFormField2(hintText: ''),
                    //     style: const TextStyle(
                    //       color: texColor,
                    //     ),
                    //     validator: (value) {
                    //       if (value!.isEmpty) {
                    //         return null;
                    //       } else if (!GetUtils.isNum(value) || value.length > 3) {
                    //         return "Không hợp lệ";
                    //       }
                    //       return null;
                    //     },
                    //     onSaved: (value) {
                    //       controller.userInfo.age = int.tryParse(value ?? '');
                    //     },
                    //   ),
                    // ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text('Nhân khẩu:',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: texColor,
                      )),
                    const SizedBox(width: 10),
                    Obx(
                      () => DropdownButton<int>(
                        value: controller.selectedNumpeople.value,
                        dropdownColor: Colors.white, // Đặt màu sắc cho menu dropdown
                        items: controller.numSelected.map((int age) {
                          return DropdownMenuItem<int>(
                            value: age,
                            child: Text(age.toString()),
                          );
                        }).toList(),
                      onChanged: (int? newValue) {
                        if (newValue != null && controller.numSelected.contains(newValue)) {
                          controller.selectedNumpeople.value = newValue;
                          controller.userInfo.numpeople = newValue;
                        }
                      },
                      ),
                    ),
                    // Flexible(
                    //     child: TextFormField(
                    //       style: const TextStyle(
                    //         color: texColor, // Đặt màu sắc cho chữ khi nhập liệu
                    //       ),
                    //       textAlign: TextAlign.center, // Căn giữa nội dung ngay khi nhập liệu
                    //       keyboardType: TextInputType.number,
                    //       decoration: buildDecorationTextFormField2(
                    //       hintText: ''),
                    //       validator: (value) {
                    //         if (value!.isEmpty) {
                    //           return null;
                    //         } else if (!GetUtils.isNum(value) || value.length > 4) {
                    //           return "Không hợp lệ";
                    //         }
                    //         return null;
                    //       },
                    //       onSaved: (value) {
                    //         controller.userInfo.numpeople = int.tryParse(value ?? '');
                    //       },
                    //     ),
                    //   ),
                    const SizedBox(width: 5),
                    const Spacer(),
                    const Text('Số nữ:',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: texColor,
                              )),
                    const SizedBox(width: 10),
                    Obx(
                      () => DropdownButton<int>(
                        value: controller.selectedNumfemale.value,
                        dropdownColor: Colors.white, // Đặt màu sắc cho menu dropdown
                        items: controller.numSelected.map((int age) {
                          return DropdownMenuItem<int>(
                            value: age,
                            child: Text(age.toString()),
                          );
                        }).toList(),
                      onChanged: (int? newValue) {
                        if (newValue != null && controller.numSelected.contains(newValue)) {
                          controller.selectedNumfemale.value = newValue;
                          controller.userInfo.numfemale = newValue;
                        }
                      },
                      ),
                    ),
                    // Flexible(
                    //     child: TextFormField(
                    //       style: const TextStyle(
                    //       color: texColor, // Đặt màu sắc cho chữ khi nhập liệu
                    //     ),
                    //     textAlign: TextAlign.center, // Căn giữa nội dung ngay khi nhập liệu
                    //     keyboardType: TextInputType.number,
                    //     decoration: buildDecorationTextFormField2(
                    //     hintText: ''),
                    //     validator: (value) {
                    //       if (value!.isEmpty) {
                    //         return null;
                    //       } else if (!GetUtils.isNum(value) || value.length > 4) {
                    //         return "Không hợp lệ";
                    //       }
                    //       return null;
                    //     },
                    //     onSaved: (value) {
                    //       controller.userInfo.numfemale = int.tryParse(value ?? '');
                    //     },
                    //   ),
                    // ),
                  ],
                ),
                const SizedBox(height: 10),  
                Obx(() {
                if (controller.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(), // Hiển thị vòng xoay tròn ở giữa màn hình
                  );
                } else {
                  return  InkWell(
                        onTap: () {
                          if (controller.formKey.currentState!.validate()) {
                            controller.formKey.currentState!.save(); // Gọi hàm onSaved của TextFormField
                            controller.userInfo.gender = controller.selectedGender.value;
                            controller.userInfo.usedservice = controller.typeAheadController.text;
                            controller.formKey.currentState!.reset();
                            
                            controller.fullnameController.clear();
                            controller.cccdController.clear();
                            controller.phoneController.clear();
                            controller.emailController.clear();
                            controller.adressController.clear();
                            controller.ageController.clear();
                            controller.genderController.clear();
                            controller.nationController.clear();
                            controller.educationController.clear();
                            controller.numpeopleController.clear();
                            controller.numfemaleController.clear();
                            controller.jobController.clear();
                            controller.incomeController.clear();

                            controller.selectedAge.value = 18;
                            controller.selectedNumfemale.value = 0;
                            controller.selectedNumpeople.value = 0;
                            controller.typeAheadController.clear();
                            controller.saveUser1(controller.userInfo);
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: primaryColor,
                          ),
                          child: const Text(
                            'Tiếp tục',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    }
                  }
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          InkWell(
            onTap: () => Get.toNamed(Routes.QRSCANER),
            child: TextButton(
              onPressed: () {
                scanQRCode(context);
              },
              child: const Text('Tiếp tục bằng QR CCCD',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 115, 92, 92),
                  )),
            ),
          ),
          // const SizedBox(height: 10),
          // InkWell(
          //   onTap: () => Get.toNamed(Routes.TESTQR),
          //   child: TextButton(
          //     onPressed: () {
          //       Get.toNamed(Routes.TESTQR);
          //     },
          //     child: const Text('Test Lib',
          //         style: TextStyle(
          //           fontSize: 17,
          //           fontWeight: FontWeight.w600,
          //           color: Colors.grey,
          //         )),
          //   ),
          // ),
        ],
      ),
      ),
    );
  }  

    Future<void> scanQRCode(BuildContext context) async {
      try{
          String barcodeScanResult = await FlutterBarcodeScanner.scanBarcode(
            '#ff6666', // Màu sắc của thanh quét
            'Hủy', // Văn bản nút hủy
            true, // Chế độ quét liên tục
            ScanMode.QR, // Chế độ quét mã QR
          );

          if (barcodeScanResult != '-1') {
            // Xử lý dữ liệu mã QR đã quét thành công
          //  controller.showDialogMessagenew(barcodeScanResult);
            List<String> values = barcodeScanResult.split("|");

            String cccd = values[0];
            String cmnd = values[1];
            String fullName = values[2];
            String birthDate = values[3];
            String gender = values[4];
            String address = values[5];
            String expiryDate = values[6];

            int birthDay = int.parse(birthDate.substring(0, 2)); // Lấy 2 ký tự đầu tiên
            int birthMonth = int.parse(birthDate.substring(2, 4)); // Lấy 2 ký tự tiếp theo
            int birthYear = int.parse(birthDate.substring(4, 8)); // Lấy 4 ký tự cuối cùng

            // Lấy ngày tháng năm hiện tại
            DateTime currentDate = DateTime.now();
            int currentDay = currentDate.day;
            int currentMonth = currentDate.month;
            int currentYear = currentDate.year;

            // Tính tuổi
            int age = currentYear - birthYear;
            if (currentMonth < birthMonth || (currentMonth == birthMonth && currentDay < birthDay)) {
              age--;
            }

            controller.fullnameController.text = fullName;
            controller.adressController.text = address;
            controller.cccdController.text = cccd;
            controller.selectedGender.value = gender;
            //controller.selectedGender.value = gender;
            controller.selectedAge.value = age;
            controller.userInfo.age = age;
            controller.update;
            //controller.showDialogMessagenew("${age}");

          } else {
            // Người dùng đã hủy quét mã QR
            // controller.showDialogMessagenew("Scan Erorr");
          }
      }catch(e){
        controller.showDialogMessagenew("QR không hợp lệ!");
      }
  }
}
