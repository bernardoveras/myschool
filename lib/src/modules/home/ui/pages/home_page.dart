import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/dependecy_injection/injector.dart';
import '../../../../core/extensions/query_parameters_extension.dart';
import '../../../../core/ui/design_system/design_system.dart';
import '../../../../core/user_session.dart';
import '../../../activities/ui/pages/additional_activities_page.dart';
import '../../../calendar/ui/pages/calendar_page.dart';
import '../../../campaigns/ui/pages/campaign_page.dart';
import '../../../campaigns/ui/parameters/campaign_page_parameter.dart';
import '../../../notifications/ui/pages/notification_list_page.dart';
import '../../../profile/ui/pages/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static String get route => '/';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final UserSession userSession;

  @override
  void initState() {
    super.initState();

    userSession = Injector.resolve();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: PrimaryColors.brand,
        height: size.height,
        width: double.infinity,
        child: Column(
          children: [
            const SizedBox(height: 50),
            ListTile(
              leading: IconButton(
                onPressed: () => context.push(ProfilePage.route),
                splashColor: Colors.transparent,
                icon: const Icon(
                  PhosphorIconsRegular.user,
                  color: Colors.white,
                ),
              ),
              title: RichText(
                text: TextSpan(
                  text: 'Olá, ',
                  style: const Text2Typography(),
                  children: [
                    TextSpan(
                      text: '${userSession.user?.name ?? ''}!',
                      style: const Text2Typography(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              trailing: IconButton(
                onPressed: () => context.push(NotificationListPage.route),
                splashColor: Colors.transparent,
                icon: const Icon(
                  PhosphorIconsRegular.bellSimple,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          SolidButton.primary(
                            label: 'Calendário',
                            onPressed: () => context.push(CalendarPage.route
                                .addQuery(
                                    '?date=${DateTime(2024, 3, 7).toIso8601String()}')),
                          ),
                          const SizedBox(height: 16),
                          SolidButton.primary(
                            label: 'Atividades complementares',
                            onPressed: () =>
                                context.push(AdditionalActivitiesPage.route),
                          ),
                          const SizedBox(height: 16),
                          SolidButton.primary(
                            label: 'Campanha',
                            onPressed: () => context.push(
                              CampaignPage.route.addQuery(
                                const CampaignPageParameter(
                                  title: 'Open Design 2024',
                                  description:
                                      '''Não fique de fora do Open! Garanta sua inscrição no maior evento de design da região!
                
                Se inscreva até dia 31/05 na entrada do evento! Os pagamentos serão feitos na hora por PIX, na área de credenciamento do auditório do bloco F. Corre que ainda dá tempo! 💜
                ''',
                                  link: 'https://google.com',
                                  bannerUrl:
                                      'https://img.freepik.com/premium-vector/trendy-event-banner-template_85212-590.jpg',
                                ).toQueryParameters(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
