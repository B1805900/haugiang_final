import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../controllers/singin_controller.dart';
import '../../../common/widgets/custom_textformfield.dart';
import '../../../common/constant.dart';
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
        child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(46, 30, 46, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                    style: const TextStyle(
                      color: texColor, // Đặt màu sắc cho chữ khi nhập liệu
                    ),
                  keyboardType: TextInputType.text,
                  decoration: buildDecorationTextFormField(
                      hintText: 'Họ tên...', icon: Icons.drive_file_rename_outline),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Họ tên không được rỗng";
                    } else if (GetUtils.isNum(value)) {
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
                  decoration: buildDecorationTextFormField(
                      hintText: 'Số CCCD...', icon: Icons.recent_actors),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return null;
                    } else if (value.length != 12 && value.length != 9) {
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
                      return null;
                    } else if (!GetUtils.isNum(value)) {
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
                      hintText: 'Email...', icon: Icons.person),
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
                  decoration: buildDecorationTextFormField(
                      hintText: 'Địa chỉ...', icon: Icons.location_city),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return null;
                    } else if (value.length < 6) {
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
                      return null;
                    } else if (value.length < 2) {
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
                    } else if (value.length < 3) {
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
                      return null;
                    } else if (value.length < 2) {
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
                const SizedBox(height: 15),
                Row(
                  children: [
                    const Text('Giới tính:',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: texColor,
                              )),
                    const SizedBox(width: 26),
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
                    const SizedBox(width: 26),
                    const Text('Tuổi:',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: texColor,
                              )),
                    const SizedBox(width: 10),
                    Flexible(
                        child: TextFormField(
                          style: const TextStyle(
                      color: texColor, // Đặt màu sắc cho chữ khi nhập liệu
                    ),
                          keyboardType: TextInputType.number,
                          decoration: buildDecorationTextFormField(
                          hintText: '.'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return null;
                            } else if (!GetUtils.isNum(value)) {
                              return "Vui lòng nhập số tuổi hợp lệ";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            controller.userInfo.age = int.tryParse(value ?? '');
                          },
                        ),
                      ),
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
                    const SizedBox(width: 5),
                    Flexible(
                        child: TextFormField(
                          style: const TextStyle(
                      color: texColor, // Đặt màu sắc cho chữ khi nhập liệu
                    ),
                          keyboardType: TextInputType.number,
                          decoration: buildDecorationTextFormField(
                          hintText: '.'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return null;
                            } else if (!GetUtils.isNum(value)) {
                              return "Vui lòng nhập số nhân khẩu hợp lệ";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            controller.userInfo.numpeople = int.tryParse(value ?? '');
                          },
                        ),
                      ),
                    const SizedBox(width: 5),
                    const Text('Số nữ:',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: texColor,
                              )),
                    const SizedBox(width: 5),
                    Flexible(
                        child: TextFormField(
                          style: const TextStyle(
                      color: texColor, // Đặt màu sắc cho chữ khi nhập liệu
                    ),
                          keyboardType: TextInputType.number,
                          decoration: buildDecorationTextFormField(
                          hintText: '.'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return null;
                            } else if (!GetUtils.isNum(value)) {
                              return "Vui lòng nhập số thành viên nữ hợp lệ";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            controller.userInfo.numfemale = int.tryParse(value ?? '');
                          },
                        ),
                      ),
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
                            controller.userInfo.usedservice = "Hành chính công";
                            controller.formKey.currentState!.reset();
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
          const SizedBox(height: 10),
          InkWell(
            onTap: () => Get.toNamed(Routes.QRSCANER),
            child: TextButton(
              onPressed: () {
                Get.toNamed(Routes.QRSCANER);
              },
              child: const Text('Tiếp tục bằng QR CCCD',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  )),
            ),
          ),
          // const SizedBox(height: 10),
          // InkWell(
          //   onTap: () => Get.toNamed(Routes.APIDEMO),
          //   child: TextButton(
          //     onPressed: () {
          //       Get.toNamed(Routes.APIDEMO);
          //     },
          //     child: const Text('Test API',
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
}
