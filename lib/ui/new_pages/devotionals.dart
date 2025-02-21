import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class DevotionalsPage extends ConsumerStatefulWidget {
  const DevotionalsPage({super.key});

  @override
  ConsumerState<DevotionalsPage> createState() => _DevotionalsPageState();
}

class _DevotionalsPageState extends ConsumerState<DevotionalsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        toolbarHeight: 80.0,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          'Devotionals',
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.headlineSmall?.fontSize,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(32.0),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Material(
                color: Colors.transparent,
                child: TabBar(
                  indicatorPadding: const EdgeInsets.all(4),
                  indicatorSize: TabBarIndicatorSize.tab,
                  controller: _tabController,
                  tabs: const [
                    Tab(child: Text('Devotional')),
                    Tab(child: Text('Bible Study')),
                  ],
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  labelColor: Theme.of(context).colorScheme.onPrimary,
                  unselectedLabelColor: Theme.of(context).colorScheme.onSurface,
                  dividerColor: Colors.transparent,
                ),
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _DevotionalList(),
                _BibleStudyList(),
              ],
            ),
          ),
          SizedBox(height: 0),
        ],
      ),
    );
  }
}

class _DevotionalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 12,
              itemBuilder: (context, index) {
                DateTime now = DateTime.now();
                String month =
                    DateFormat('MMMM').format(DateTime(now.year, index + 1));
                return _MonthCard(month: month, index: index);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _BibleStudyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16.0),
            itemCount: 12,
            itemBuilder: (context, index) {
              DateTime now = DateTime.now();
              String month =
                  DateFormat('MMMM').format(DateTime(now.year, index + 1));
              return Card(
                margin: const EdgeInsets.only(bottom: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                elevation: 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Material(
                    color: Theme.of(context).colorScheme.surfaceContainer,
                    child: ListTile(
                      title: Text(
                        month,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      onTap: () {},
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 120.0),
        ],
      ),
    );
  }
}

class _MonthCard extends StatelessWidget {
  final String month;
  final int index;

  const _MonthCard({required this.month, required this.index});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Material(
            color: Theme.of(context).colorScheme.surfaceContainer,
            child: ExpansionTile(
              title: Text(
                month,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              onExpansionChanged: (expanded) {
                if (expanded) {
                  // Delay the scroll to ensure the expansion animation has started
                  Future.delayed(const Duration(milliseconds: 300), () {
                    Scrollable.ensureVisible(
                      context,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      alignment: 0.0,
                    );
                  });
                }
              },
              children: [
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(16.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0,
                  ),
                  itemCount: DateTime(now.year, index + 2, 0).day,
                  itemBuilder: (context, dayIndex) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Center(
                        child: Text('${dayIndex + 1}'),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
