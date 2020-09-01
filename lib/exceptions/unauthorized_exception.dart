class UnauthorizedException implements Exception {
  String _cause;

  UnauthorizedException([String cause = 'Session expired']) {
    this._cause = cause;
  }

  @override
  String toString() {
    return _cause;
  }
}