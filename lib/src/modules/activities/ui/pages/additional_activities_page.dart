import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/ui/design_system/design_system.dart';
import '../../../../core/ui/widgets/default_app_bar.dart';
import '../../../../core/utils/redirect_to_url.dart';
import '../widgets/activity_progress_card_widget.dart';
import '../widgets/teacher_information_card_widget.dart';

class AdditionalActivities extends StatelessWidget {
  const AdditionalActivities({super.key});

  static String get route => '/activities';

  @override
  Widget build(BuildContext context) {
    var bottomPadding = MediaQuery.paddingOf(context).bottom;

    return Scaffold(
      appBar: const DefaultAppBar(
        title: 'Atividades complementares',
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: 16 + bottomPadding,
        ),
        child: SolidButton.primary(
          label: 'Link para envio de atividades',
          icon: PhosphorIconsRegular.arrowSquareOut,
          style: SolidButtonStyle.outlined,
          onPressed: () => redirectToUrl(
              'https://github.com/bernardoveras/myschool/discussions'),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: 16,
          right: 16,
          left: 16,
          bottom: 16 + bottomPadding,
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ActivityProgressCard(
              currentHours: 90,
              totalHours: 160,
            ),
            SizedBox(height: 16),
            TeacherInformationCard(
              name: 'Prof. José Neto',
              email: 'jose.neto@myschool.com',
              pictureUrl:
                  'https://avatars.githubusercontent.com/u/56937988?v=4',
            ),
          ],
        ),
      ),
    );
  }
}
