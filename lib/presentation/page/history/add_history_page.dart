import 'package:d_input/d_input.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:money_record_app/config/app_color.dart';
import 'package:money_record_app/config/app_format.dart';

class AddHistoryPage extends StatelessWidget {
  const AddHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DView.appBarLeft('Tambah Baru'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Tanggal'),
          Row(
            children: [
              const Text(
                '2022-11-24',
              ),
              DView.spaceWidth(),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.event),
                label: const Text('Pilih'),
              )
            ],
          ),
          DView.spaceHeight(),
          const Text(
            'Tipe',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          DView.spaceHeight(4),
          DropdownButtonFormField(
            value: 'Pemasukan',
            items: ['Pemasukan', 'Pengeluaran'].map((e) {
              return DropdownMenuItem(
                value: e,
                child: Text(e),
              );
            }).toList(),
            onChanged: (value) {},
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              isDense: true,
            ),
          ),
          DView.spaceHeight(),
          DInput(
            controller: TextEditingController(),
            hint: 'Jualan',
            title: 'Sumber/Objek pengeluaran',
          ),
          DView.spaceHeight(),
          DInput(
            controller: TextEditingController(),
            hint: '30000',
            title: 'Harga',
            inputType: TextInputType.number,
          ),
          DView.spaceHeight(),
          Center(
            child: Container(
              width: 80,
              height: 5,
              decoration: BoxDecoration(
                color: AppColor.bg,
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
          DView.spaceHeight(),
          const Text(
            'Items',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          DView.spaceHeight(4),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Wrap(
              children: [
                Chip(
                  label: const Text('Sumber1'),
                  deleteIcon: const Icon(Icons.clear),
                  onDeleted: () {},
                )
              ],
            ),
          ),
          DView.spaceHeight(),
          Row(
            children: [
              const Text(
                'Total :',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              DView.spaceWidth(4),
              Text(
                AppFormat.currency('300000'),
                style: Theme.of(context).textTheme.headline6!.copyWith(
                    fontWeight: FontWeight.bold, color: AppColor.primary),
              ),
            ],
          ),
          DView.spaceHeight(),
          Material(
            color: AppColor.primary,
            borderRadius: BorderRadius.circular(8),
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Center(
                  child: Text(
                    'SUBMIT',
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
