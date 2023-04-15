import 'package:flutter/material.dart';

class CustomerTerms extends StatelessWidget {
  const CustomerTerms({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text(
            '1. Introduction\nEasyLife.com is an on-demand household service booking app that enables customers to book a range of household services such as cleaning, cook, babysitter, oldage care and driver services. These terms and conditions ("Terms") govern your use of the EasyLife.com app ("App") and the services offered by EasyLife.com ("Services"). By using the App or Services, you agree to be bound by these Terms.\n\n2. Use of the App and Services\na. To use the App and Services, you must beat least 18 years old and have the legal capacity to enter into a binding contract.\nb. You must provide accurate and complete information when registering for the App and Services.\nc. You are responsible for maintaining the confidentiality of your account and password.\n\n3. Booking Services\na. You may book Services through the App by selecting the desired service, date, time, and cash payment.\nb. EasyLife.com will use reasonable efforts to ensure that the Service is provided to you on the date and time agreed upon.\nc. You may cancel or reschedule a booking subject to EasyLife.com cancellation policy.\n\n4. Payments\na. You will be charged for the Services after the appointment.\nb. Payment must be made using the cash payment method accepted by EasyLife.com.\nc. If you cancel a booking in accordance with EasyLife.com cancellation policy, a refund will be issued to your account.\n\n5. Service Providers\na. EasyLife.com engages third-party service providers to provide the Services.\nb. EasyLife.com does not guarantee the quality or suitability of the Services provided by the service providers.\nc. EasyLife.com will use reasonable efforts to ensure that the service providers comply with applicable laws and regulations.\n\n6. Liability\na. EasyLife.com shall not be liable for any loss or damage arising from your use of the App or Services.\nb. EasyLife.com liability for any claim arising from your use of the App or Services shall be limited to the amount paid by you for the Services.\n\n7. Indemnity\nYou agree to indemnify and hold harmless EasyLife.com and its affiliates, officers, directors, employees, and agents from any claim, demand, or damage, including reasonable attorneys fees, arising from your use of the App or Services.\n\n8. Modification\nEasyLife.com reserves the right to modify these Terms at any time. Any modifications will be effective immediately upon posting on the App.\n\n9. Governing Law\nThese Terms shall be governed by and construed in accordance with the laws of [insert country/state here].\n\n10. Privacy Policy\na. EasyLife.com takes the privacy of its customers seriously and collects and processes personal data in accordance with its Privacy Policy. By using the App and Services, you consent to the collection, use, and processing of your personal data in accordance with the Privacy Policy.\n\n11. Termination\na. EasyLife.com may terminate these Terms and your access to the App and Services at any time for any reason.\nb. Upon termination, you must immediately cease all use of the App and Services.\n\n12. Severability\nIf any provision of these Terms is found to be invalid or unenforceable, the remaining provisions shall remain in full force and effect.\n\n13. Entire Agreement\nThese Terms, along with the Privacy Policy, constitute the entire agreement between you and EasyLife.com regarding your use of the App and Services and supersedes all prior or contemporaneous communications and proposals, whether oral or written.',
            textAlign: TextAlign.justify,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 22, 32, 28)),
          ),
        ),
      ),
    );
  }
}
