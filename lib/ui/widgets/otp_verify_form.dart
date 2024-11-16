import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager/ui/controllers/otp_verify_controller.dart';


import 'snack_bar_message.dart';
import 'tm_process_indicator.dart';

class OtpVerifyForm extends StatefulWidget {
  const OtpVerifyForm({super.key, required this.email});

  final String email;

  @override
  State<OtpVerifyForm> createState() => _OtpVerifyFormState();
}

class _OtpVerifyFormState extends State<OtpVerifyForm> {
  final TextEditingController _otpTEController = TextEditingController();
  final OTPVerifyController _otpVerifyController =
  Get.find<OTPVerifyController>();

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.sizeOf(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: size.height * 0.2),
        Text(
          'Pin Verification',
          style: textTheme.displayMedium,
        ),
        SizedBox(height: size.height * 0.010),
        const Text(
          '  A 6 digit verification pin will send to your email address',
        ),
        SizedBox(height: size.height * 0.036),
        PinCodeTextField(
          controller: _otpTEController,
          backgroundColor: Colors.transparent,
          appContext: (context),
          length: 6,
          pinTheme: PinTheme(
            fieldWidth: 44,
            fieldHeight: 56,
            activeFillColor: Colors.transparent,
            selectedFillColor: Colors.transparent,
            inactiveFillColor: Colors.transparent,
            inactiveColor: Colors.grey[200],
            selectedColor: Colors.grey,
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(8),
          ),
          enableActiveFill: true,
        ),
        SizedBox(height: size.height * 0.036),
        GetBuilder<OTPVerifyController>(
            builder: (controller) {
              return Visibility(
                visible: !controller.inProgress,
                replacement: const TMProgressIndicator(),
                child: ElevatedButton(
                  onPressed: _onTapNextScreen,
                  child: const Text('Verify'),
                ),
              );
            }
        ),
        SizedBox(height: size.height * 0.046),
      ],
    );
  }

  void _onTapNextScreen() {
    _otpVerify();
  }

  Future<void> _otpVerify() async {
    final bool result = await _otpVerifyController.otpVerify(
      widget.email,
      _otpTEController.text,
    );

    if (result) {
      snackMassage(false, _otpVerifyController.successMessage!);
    } else {
      snackMassage(true, _otpVerifyController.errorMessage!);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _otpTEController.dispose();
  }
}