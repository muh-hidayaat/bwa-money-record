import 'package:d_chart/d_chart.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_record_app/config/app_asset.dart';
import 'package:money_record_app/config/app_color.dart';
import 'package:money_record_app/presentation/controller/c_user.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final cUser = Get.put(CUser());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const Drawer(),
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
              AspectRatio(
                aspectRatio: 16 / 9,
                child: DChartBar(
                  data: const [
                    {
                      'id': 'Bar',
                      'data': [
                        {'domain': '2023', 'measure': 3},
                        {'domain': '2024', 'measure': 5},
                        {'domain': '2025', 'measure': 7},
                        {'domain': '2026', 'measure': 1},
                      ],
                    }
                  ],
                  domainLabelPaddingToAxisLine: 16,
                  axisLineTick: 2,
                  axisLinePointTick: 2,
                  axisLinePointWidth: 10,
                  axisLineColor: Colors.green,
                  measureLabelPaddingToAxisLine: 16,
                  barColor: (barData, index, id) => Colors.green,
                  showBarValue: true,
                ),
              ),
              DView.spaceHeight(),
              Text(
                'Perbandingan Bulan ini',
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              DView.spaceHeight(),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.width * 0.5,
                    child: Stack(
                      children: [
                        DChartPie(
                          data: const [
                            {'domain': '2023', 'measure': 28},
                            {'domain': '2024', 'measure': 27},
                          ],
                          fillColor: (pieData, index) => Colors.purple,
                          donutWidth: 30,
                          labelColor: Colors.white,
                        ),
                        Center(
                          child: Text(
                            '60%',
                            style:
                                Theme.of(context).textTheme.headline4!.copyWith(
                                      color: AppColor.primary,
                                    ),
                          ),
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
                      const Text('Pemasukan'),
                      const Text('lebih besar 20%'),
                      const Text('dari pengeluaran'),
                      DView.spaceHeight(10),
                      const Text('Atau setara :'),
                      const Text(
                        'Rp.200.000',
                        style: TextStyle(
                          color: AppColor.primary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ))
        ],
      ),
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
            child: Text(
              'Rp. 500.000',
              style: Theme.of(context).textTheme.headline4!.copyWith(
                  fontWeight: FontWeight.bold, color: AppColor.secondary),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 30),
            child: Text(
              '+20% dibandin kemarin',
              style: TextStyle(
                color: AppColor.bg,
                fontSize: 16,
              ),
            ),
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
