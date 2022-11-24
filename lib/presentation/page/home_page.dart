import 'package:d_chart/d_chart.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_record_app/config/app_asset.dart';
import 'package:money_record_app/config/app_color.dart';
import 'package:money_record_app/config/app_format.dart';
import 'package:money_record_app/config/session.dart';
import 'package:money_record_app/presentation/controller/c_home.dart';
import 'package:money_record_app/presentation/controller/c_user.dart';
import 'package:money_record_app/presentation/page/auth/login_page.dart';
import 'package:money_record_app/presentation/page/history/add_history_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final cUser = Get.put(CUser());
  final cHome = Get.put(CHome());

  @override
  void initState() {
    cHome.getAnalysis(cUser.data.idUser!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: drawer(),
      body: Column(
        children: [
          header(),
          Expanded(
              child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
            children: [
              Text(
                'Pengeluaran Hari ini',
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              DView.spaceHeight(),
              cardToday(context),
              DView.spaceHeight(30),
              Center(
                child: Container(
                  height: 5,
                  width: 80,
                  decoration: BoxDecoration(
                    color: AppColor.bg,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              Text(
                'Pengeluaran Minggu ini',
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              DView.spaceHeight(),
              weekly(),
              DView.spaceHeight(),
              Text(
                'Perbandingan Bulan ini',
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              DView.spaceHeight(),
              monthly(context)
            ],
          ))
        ],
      ),
    );
  }

  Drawer drawer() {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            margin: const EdgeInsets.only(bottom: 0),
            padding: const EdgeInsets.fromLTRB(20, 16, 16, 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(AppAsset.profile),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(
                            () {
                              return Text(
                                cUser.data.name ?? '',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            },
                          ),
                          Obx(
                            () {
                              return Text(
                                cUser.data.email ?? '',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Material(
                  color: AppColor.primary,
                  borderRadius: BorderRadius.circular(30),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () {
                      Session.clearUser();
                      Get.off(() => const LoginPage());
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 24,
                      ),
                      child: Text(
                        'Logout',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          ListTile(
            onTap: () {
              Get.to(() => const AddHistoryPage())?.then((value) {
                if (value ?? false) {
                  cHome.getAnalysis(cUser.data.idUser!);
                }
              });
            },
            leading: const Icon(Icons.add),
            horizontalTitleGap: 0,
            title: const Text('Tambah Baru'),
            trailing: const Icon(Icons.navigate_next),
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.south_west),
            horizontalTitleGap: 0,
            title: const Text('Pemasukan'),
            trailing: const Icon(Icons.navigate_next),
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.north_east),
            horizontalTitleGap: 0,
            title: const Text('Pengeluaran'),
            trailing: const Icon(Icons.navigate_next),
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.history),
            horizontalTitleGap: 0,
            title: const Text('Riwayat'),
            trailing: const Icon(Icons.navigate_next),
          ),
        ],
      ),
    );
  }

  Row monthly(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.width * 0.5,
          child: Stack(
            children: [
              DChartPie(
                data: [
                  {'domain': 'income', 'measure': cHome.monthIncome},
                  {'domain': 'outcome', 'measure': cHome.monthOutcome},
                  if (cHome.monthIncome == 0 && cHome.monthOutcome == 0)
                    {'domain': 'nol', 'measure': 1}
                ],
                fillColor: (pieData, index) {
                  switch (pieData['domain']) {
                    case 'income':
                      return AppColor.primary;
                    case 'outcome':
                      return AppColor.chart;
                    default:
                      return AppColor.bg.withOpacity(0.5);
                  }
                },
                donutWidth: 20,
                labelColor: Colors.transparent,
              ),
              Center(
                child: Obx(() {
                  return Text(
                    '${cHome.percentIncome}%',
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                          color: AppColor.chart,
                        ),
                  );
                }),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 16,
                  height: 16,
                  color: AppColor.primary,
                ),
                DView.spaceWidth(8),
                const Text('Pemasukan'),
              ],
            ),
            DView.spaceHeight(8),
            Row(
              children: [
                Container(
                  width: 16,
                  height: 16,
                  color: AppColor.chart,
                ),
                DView.spaceWidth(8),
                const Text('Pegneluaran'),
              ],
            ),
            DView.spaceHeight(20),
            Obx(() {
              return Text(cHome.monthPercent);
            }),
            DView.spaceHeight(10),
            const Text('Atau setara :'),
            Obx(() {
              return Text(
                AppFormat.currency(cHome.differentMonth.toString()),
                style: const TextStyle(
                  color: AppColor.primary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              );
            }),
          ],
        ),
      ],
    );
  }

  AspectRatio weekly() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Obx(() {
        return DChartBar(
          data: [
            {
              'id': 'Bar',
              'data': List.generate(7, (index) {
                return {
                  'domain': cHome.weekText()[index],
                  'measure': cHome.week[index]
                };
              }),
            }
          ],
          domainLabelPaddingToAxisLine: 8,
          axisLineTick: 2,
          axisLineColor: AppColor.primary,
          barColor: (barData, index, id) => AppColor.primary,
          showBarValue: true,
        );
      }),
    );
  }

  Material cardToday(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(16),
      elevation: 5,
      color: AppColor.primary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 4),
            child: Obx(() {
              return Text(
                AppFormat.currency(cHome.today.toString()),
                style: Theme.of(context).textTheme.headline4!.copyWith(
                    fontWeight: FontWeight.bold, color: AppColor.secondary),
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 30),
            child: Obx(() {
              return Text(
                cHome.todayPercent,
                style: const TextStyle(
                  color: AppColor.bg,
                  fontSize: 16,
                ),
              );
            }),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(16, 0, 0, 16),
            padding: const EdgeInsets.symmetric(vertical: 6),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Text(
                  'Selengkapnya',
                  style: TextStyle(color: AppColor.primary),
                ),
                Icon(Icons.navigate_next, color: AppColor.primary),
              ],
            ),
          )
        ],
      ),
    );
  }

  Padding header() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 70, 20, 30),
      child: Row(
        children: [
          Image.asset(AppAsset.profile),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Hi,',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Obx(() {
                  return Text(
                    cUser.data.name ?? '',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                })
              ],
            ),
          ),
          Builder(builder: (ctx) {
            return Material(
              borderRadius: BorderRadius.circular(4),
              color: AppColor.chart,
              child: InkWell(
                onTap: () {
                  Scaffold.of(ctx).openEndDrawer();
                },
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    Icons.menu,
                    color: AppColor.primary,
                  ),
                ),
              ),
            );
          })
        ],
      ),
    );
  }
}
