class Book {
  final String authorName;
  final int availability;
  final String bookTitle;
  final int isBorrowed;
  final String callNumber;
  final int categoryId;
  final DateTime dateAdded;
  final String location;
  final String publicationYear;
  final String rfId;

  Book({
    required this.authorName,
    required this.availability,
    required this.bookTitle,
    required this.isBorrowed,
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
        "bookTitle": bookTitle,
        "isBorrowed": isBorrowed,
        "callNumber": callNumber,
        "categoryID": categoryId,
        "dateAdded":
            "${dateAdded.year.toString().padLeft(4, '0')}-${dateAdded.month.toString().padLeft(2, '0')}-${dateAdded.day.toString().padLeft(2, '0')}",
        "location": location,
        "publicationYear": publicationYear,
        "rfID": rfId,
      };
}
