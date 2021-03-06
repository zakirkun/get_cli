import 'package:get_cli/common/utils/pubspec/pubspec_utils.dart';
import 'package:recase/recase.dart';
import '../interface/sample_interface.dart';

/// [Sample] file from Provider file creation.
class ProviderSample extends Sample {
  final String _fileName;
  final bool isServer;
  final bool createEndpoints;
  final String modelPath;
  String _namePascal;
  String _nameLower;
  ProviderSample(this._fileName,
      {bool overwrite = false,
      this.createEndpoints = false,
      this.modelPath = '',
      this.isServer = false,
      path = ''})
      : super(path, overwrite: overwrite) {
    _namePascal = _fileName.pascalCase;
    _nameLower = _fileName.toLowerCase();
  }

  String get _import => isServer
      ? "import 'package:get_server/get_server.dart';"
      : "import 'package:get/get.dart';";
  String get _importModelPath => createEndpoints
      ? "import 'package:${PubspecUtils.getProjectName()}/$modelPath';\n"
      : '\n';

  @override
  Future<String> get content async => '''$_import
$_importModelPath
class ${_fileName.pascalCase}Provider extends GetConnect {
\t@override
\tvoid onInit() {
$_defaultEncoder\t\thttpClient.baseUrl = 'YOUR-API-URL';
\t}
$_defaultEndpoint}
''';

  String get _defaultEndpoint => createEndpoints
      ? ''' 
\tFuture<Response<$_namePascal>> get$_namePascal(int id) async => 
\t\tawait get('$_nameLower/\$id');
\tFuture<Response<$_namePascal>> post$_namePascal($_namePascal $_nameLower) async => 
\t\tawait post('$_nameLower', $_nameLower);
\tFuture<Response> delete$_namePascal(int id) async => 
\t\tawait delete('$_nameLower/\$id');
'''
      : '\n';
  String get _defaultEncoder => createEndpoints
      ? '\t\thttpClient.defaultDecoder = (map) => $_namePascal.fromJson(map);\n'
      : '\n';
}
