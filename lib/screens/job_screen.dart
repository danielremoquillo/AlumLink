import 'package:alumlink_app/main.dart';
import 'package:alumlink_app/models/job_post_dto.dart';
import 'package:alumlink_app/services/job_post_service.dart';
import 'package:alumlink_app/widgets/job_post_card.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class JobScreen extends StatefulWidget {
  const JobScreen({super.key});

  @override
  State<JobScreen> createState() => _JobScreenState();
}

class _JobScreenState extends State<JobScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int currentTabIndex = 0;

  void _handleTabSelection() {
    setState(() {
      // Get the current index of the tab controller
      currentTabIndex = _tabController.index;
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TabBar(
        controller: _tabController,
        tabs: [
          Tab(
            icon: Icon(
              currentTabIndex == 0
                  ? Icons.business_center
                  : Icons.business_center_outlined,
              color: const Color(0xFF216831),
            ),
          ),
          Tab(
            icon: Icon(
              currentTabIndex == 1
                  ? Icons.work_history
                  : Icons.work_history_outlined,
              color: const Color(0xFF216831),
            ),
          ),
          Tab(
            icon: Icon(
              currentTabIndex == 2 ? Icons.bookmark : Icons.bookmark_outline,
              color: const Color(0xFF216831),
            ),
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          JobPostService(),
          Center(
            child: Text('This is Tab 2'),
          ),
          Center(
            child: Text('This is Tab 3'),
          ),
        ],
      ),
    );
  }
}
