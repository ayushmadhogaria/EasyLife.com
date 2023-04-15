import 'package:flutter/material.dart';

class ServicemanTerms extends StatelessWidget {
  const ServicemanTerms({super.key});

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
            '1. Service Provider Eligibility: The service provider must be at least 18 years old and legally eligible to provide household services in their respective jurisdiction. They must have a verified personal identity and have a good reputation.\n\n'
            '2. Service Provider Registration: The service provider must register their service after logging into the system and then the company will proceed with further process for keeping or deleting the serviceman.\n\n'
            '3. Background Check and Verification: EasyLife.com will conduct a thorough background check and personal verification on each service provider before approving them for the platform.\n\n'
            '4. Service Provider Availability: The service provider must be available to provide services during the hours and days specified in their profile.\n\n'
            '5. Service Provider Standards: The service provider must provide high-quality services and ensure customer satisfaction. Any complaints from customers regarding the quality of services will be investigated by EasyLife.com.\n\n'
            '6. Payment: The service provider will receive payment directly from the customer for the services provided. At the end of each day, the service provider must hand over the cash amount received from the customers to the EasyLife.com admin.\n\n'
            '7. Taxes: The service provider is responsible for paying any applicable taxes on the earnings they receive from providing services on the EasyLife.com app.\n\n'
            '8. Cancellation and Rescheduling: The service provider must notify the customer as soon as possible if they need to cancel or reschedule an appointment. Failure to do so may result in suspension or termination of their account on the EasyLife.com app.\n\n'
            '9. Non-compete Clause: The service provider agrees not to use the customer information obtained through the EasyLife.com app to compete with the platform or solicit customers for any other services.\n\n'
            '10. Termination: EasyLife.com reserves the right to terminate the service provider\'s account at any time for any reason, including violation of any of these terms and conditions.\n\n'
            '11. Governing Law: These terms and conditions shall be governed by and interpreted in accordance with the laws of the jurisdiction where EasyLife.com operates. Any disputes arising out of these terms and conditions shall be resolved through arbitration.',
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
