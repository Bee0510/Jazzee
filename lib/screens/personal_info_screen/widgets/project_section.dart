import 'package:flutter/material.dart';
import 'package:jazzee/screens/personal_info_screen/widgets/components/projects_component.dart';

import '../../../constants.dart/constants.dart';
import '../../../main.dart';
import '../../../models/student/projects_model.dart';
import 'components/work_experience_component.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({Key? key, required this.projectList})
      : super(key: key);
  final List<Projects> projectList;
  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'PROJECTS/CERTIFICATIONS',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        SizedBox(height: 8),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: widget.projectList.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(widget.projectList[index].projectTitle,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      '${widget.projectList[index].startDate} - ${widget.projectList[index].endDate == null ? 'Present' : widget.projectList[index].endDate}',
                      style: TextStyle(fontSize: 12, color: Colors.grey)),
                  Text(widget.projectList[index].link,
                      style: TextStyle(fontSize: 12, color: Colors.blue)),
                  Text(widget.projectList[index].projectDescription!,
                      style: TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.grey),
                    onPressed: () {
                      navigatorKey.currentState!.push(MaterialPageRoute(
                          builder: (context) => editprojectsComponent(
                                projects: widget.projectList[index],
                              )));
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.grey),
                    onPressed: () async {
                      await supabase
                          .from('projects')
                          .delete()
                          .eq('project_id', widget.projectList[index].projectId)
                          .then((value) {
                        setState(() {
                          widget.projectList.removeAt(index);
                        });
                      });
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
