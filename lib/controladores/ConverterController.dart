class ConverterController {
  obtenerUriConParametros(Map<String, String?> params, url) {
    final filteredParams = Map.fromEntries(
      params.entries.where((entry) => entry.value != null && entry.value != ''),
    );
    final uri = Uri.parse(url).replace(queryParameters: filteredParams);

    return uri;
  }
}
