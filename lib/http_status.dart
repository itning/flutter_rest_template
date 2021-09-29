class HttpStatus {
  int value;
  String? reasonPhrase;

  HttpStatus(this.value, {this.reasonPhrase});

  @override
  String toString() {
    return '$value $reasonPhrase';
  }
}
