class Book {
  final String authorName;
  final int availability;
  final String barCodeId;
  final String bookId;
  final String bookTitle;
  final int borrowStatus;
  final String callNumber;
  final int categoryId;
  final DateTime dateAdded;
  final String location;
  final String publicationYear;
  final String rfId;

  Book({
    required this.authorName,
    required this.availability,
    required this.barCodeId,
    required this.bookId,
    required this.bookTitle,
    required this.borrowStatus,
    required this.callNumber,
    required this.categoryId,
    required this.dateAdded,
    required this.location,
    required this.publicationYear,
    required this.rfId,
  });

  Map<String, dynamic> toJson() => {
        "authorName": authorName,
        "availability": availability,
        "barCodeID": barCodeId,
        "bookID": bookId,
        "bookTitle": bookTitle,
        "borrowStatus": borrowStatus,
        "callNumber": callNumber,
        "categoryID": categoryId,
        "dateAdded":
            "${dateAdded.year.toString().padLeft(4, '0')}-${dateAdded.month.toString().padLeft(2, '0')}-${dateAdded.day.toString().padLeft(2, '0')}",
        "location": location,
        "publicationYear": publicationYear,
        "rfID": rfId,
      };
}
