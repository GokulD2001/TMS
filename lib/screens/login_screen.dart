import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management/widgets/layout/common_layout.dart';
import '../../constants/regex_patterns.dart';
import '../../constants/all_pages_text_strings/login_text_strings.dart';
import '../../widgets/Buttons/primary_button.dart';
import '../../widgets/text_form_field/common_text_form_field.dart';
import '../../controllers/login_controller.dart';
import '../widgets/sized_box/sized_box.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return CommonLayoutDrawer(
      appBarTitle: LoginPageText.loginTitle,
      hasDrawer: false,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CommonSizedBox(
                  child: CommonTextFormField(
                    text: LoginPageText.nameLabel,
                    inputformat: alphabetsSpace,
                    limitLength: 30,
                    inputtype: TextInputType.name,
                    validator: (val) =>
                          val == null || val.isEmpty ? "Enter Name" : null,
                    star: star,
                    onSaved: (val) => controller.name.value = val ?? '',
                  ),
                ),
                const SizedBox(height: 16),
                Obx(
                  () => CommonSizedBox(
                    child: CommonTextFormField(
                      text: LoginPageText.passwordLabel,
                      obscureText: controller.obscurePassword.value,
                      showEye: true,
                      onEyeTap: controller.togglePasswordVisibility,
                      inputformat: alphabetsAndNumbersPassword,
                      limitLength: 20,
                      validator: (val) =>
                          val == null || val.isEmpty ? "Enter Password" : null,
                      inputtype: TextInputType.visiblePassword,
                      star: star,
                      onSaved: (val) => controller.password.value = val ?? '',
                    ),
                  ),
                ),
                const SizedBox(height: 24),
               Obx(() {
  return controller.isLoading.value
      ? const CircularProgressIndicator()
      : PrimaryButton(
          text: LoginPageText.enterButton,
          onPressed: () {
            if (controller.formKey.currentState!.validate()) {
              controller.formKey.currentState!.save();
              controller.loginOrSignup();
            }
          },
        );
}),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
