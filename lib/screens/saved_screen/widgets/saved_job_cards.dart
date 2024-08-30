import 'package:flutter/material.dart';
import 'package:jazzee/core/theme/base_color.dart';
import 'package:jazzee/models/recruiter/jobs_posting_model.dart';
import 'package:jazzee/models/student/job_applied_model.dart';
import 'package:jazzee/models/student/job_saved_model.dart';

class appliedJobCard extends StatefulWidget {
  final JobApplied jobapplied;

  const appliedJobCard({
    Key? key,
    required this.jobapplied,
  }) : super(key: key);

  @override
  State<appliedJobCard> createState() => _appliedJobCardState();
}

class _appliedJobCardState extends State<appliedJobCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.jobapplied.jobRole,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            widget.jobapplied.companyName,
            style: TextStyle(
                color: Colors.grey[800],
                fontSize: 12,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 8),
          Text(
            '₹' + widget.jobapplied.salary!,
            style:
                TextStyle(color: AppColors.green, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              Text(
                widget.jobapplied.jobLocation,
                style: TextStyle(color: Colors.grey[600]),
              ),
              SizedBox(width: 5),
              Text(
                '• ${widget.jobapplied.jobType}',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
          SizedBox(height: 8),
          // Posted Time
          Text(
            widget.jobapplied.applyTill!,
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class savedJobCard extends StatefulWidget {
  final JobSaved jobapplied;

  const savedJobCard({
    Key? key,
    required this.jobapplied,
  }) : super(key: key);

  @override
  State<savedJobCard> createState() => _savedJobCardState();
}

class _savedJobCardState extends State<savedJobCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.jobapplied.jobRole,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            widget.jobapplied.companyName,
            style: TextStyle(
                color: Colors.grey[800],
                fontSize: 12,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 8),
          Text(
            '₹' + widget.jobapplied.salary!,
            style:
                TextStyle(color: AppColors.green, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              Text(
                widget.jobapplied.jobLocation,
                style: TextStyle(color: Colors.grey[600]),
              ),
              SizedBox(width: 5),
              Text(
                '• ${widget.jobapplied.jobType}',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
          SizedBox(height: 8),
          // Posted Time
          Text(
            widget.jobapplied.applyTill!,
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
