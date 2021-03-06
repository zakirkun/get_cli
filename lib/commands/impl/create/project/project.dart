import 'dart:io';

import 'package:cli_dialog/cli_dialog.dart';
import 'package:cli_menu/cli_menu.dart';
import 'package:get_cli/commands/impl/args_mixin.dart';
import 'package:get_cli/commands/impl/init/flutter/init.dart';
import 'package:get_cli/commands/impl/init/get_server/get_server_command.dart';
import 'package:get_cli/commands/interface/command.dart';
import 'package:get_cli/common/utils/shell/shel.utils.dart';
import 'package:get_cli/core/structure.dart';
import 'package:recase/recase.dart';

class CreateProjectCommand extends Command with ArgsMixin {
  @override
  Future<void> execute() async {
    final menu = Menu([
      'Flutter Project',
      'Get Server',
    ]);
    final result = menu.choose();
    String nameProject = name;
    if (name == '.') {
      final dialog = CLI_Dialog(questions: [
        ['what is the name of the project?', 'name']
      ]);
      nameProject = dialog.ask()['name'];
    }

    String path = Structure.replaceAsExpected(
        path: Directory.current.path + '/${nameProject.snakeCase}');
    await Directory(path).create(recursive: true);

    Directory.current = path;

    if (result.index == 0) {
      final dialog = CLI_Dialog(questions: [
        [
          'What is your company\'s domain? \x1B[33m example: com.yourcompany \x1B[0m',
          'org'
        ]
      ]);
      final org = dialog.ask()['org'];

      await ShellUtils.flutterCreate(path, org);
      await InitCommand().execute();
    } else {
      await InitGetServer().execute();
    }
  }

  @override
  String get hint => 'Use to generate new project';

  @override
  bool validate() {
    return true;
  }
}
