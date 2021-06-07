class XferUriDto {
  final String url;
  final Map<String, String> headers;

  XferUriDto({required this.url, this.headers = const {}});
}
