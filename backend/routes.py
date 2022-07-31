from flask import Flask, jsonify, request
import queries
from db import create_tables

app = Flask(__name__)

# @app.route("/", methods=[""])
# details = request.get_json()

# #For Author Table
# @app.route("/new-author", methods=["POST"])
# def addAuthor():
#     details = request.get_json()
#     authorName = details["authorName"]
#     result = queries.newAuthor(authorName)
#     return jsonify(result)

# # ---THIS WAS CREATED TO ALLOW MULTIPLE AUTHORS TO BE ADDED TO THE DATABASE. WILL BE TESTED LATER---
# # @app.route("/new-authors", methods=["POST"])
# # def addAuthor():
# #     details = request.get_json()
# #     created_authors = []
# #     for author in details["authors"]:
# #         response = queries.newAuthor(author["authorName"])
# #         created_authors.append(response)
# #     return jsonify({"created_authors": created_authors, "message":"Success"}), 200



# @app.route("/update-author-info", methods=["PUT"])
# def reviseAuthor():
#     details = request.get_json()
#     authorName = details["authorName"]
#     authorID = details["authorID"]
#     result = queries.updateAuthor(authorName, authorID)
#     return jsonify(result)

# @app.route("/get-author/<authorID>", methods=["GET"])
# def findAuthor(authorID):
#     result = queries.getAuthor(authorID)
#     return jsonify(result)

# @app.route("/search-author/<authorName>", methods=["GET"])
# def traverseAuthor(authorName):
#     result = queries.searchAuthor(authorName)
#     return jsonify(result)

# @app.route("/authors", methods = ["GET"])
# def allAuthors():
#     result = queries.getAllAuthors()
#     return jsonify(result)


# @app.route("/delete-author/<authorID>", methods=["DELETE"])
# def removeAuthor(authorID):
#     result = queries.deleteAuthor(authorID)
#     return jsonify(result)

#For Category Table
@app.route("/new-category", methods=["POST"])
def addCategory():
    details = request.get_json()
    category = details["category"]
    result = queries.newCategory(category)
    return jsonify(result)

@app.route("/update-category", methods=["PUT"])
def reviseCategory():
    details = request.get_json()
    category = details["category"]
    categoryID = details["categoryID"]
    result = queries.updateCategory(category, categoryID)
    return jsonify(result)

@app.route("/get-category/<categoryID>", methods=["GET"])
def findCategory(categoryID):
    result = queries.getCategory(categoryID)
    return jsonify(result)

@app.route("/categoryid/<category>", methods=["GET"])
def findCategoryID(category):
    result = queries.getCategoryID(category)
    return jsonify(result)

@app.route("/categories", methods = ["GET"])
def allCategories():
    result = queries.getAllCategories()
    return jsonify(result)



@app.route("/delete-category/<categoryID>", methods=["DELETE"])
def removeCategory(categoryID):
    result = queries.deleteCategory(categoryID)
    return jsonify(result)






#For patron Table
@app.route("/new-patron", methods=["POST"])
def addPatron():
    details = request.get_json()
    referenceID = details["referenceID"]
    patronName = details["patronName"]
    patronStatus = details["patronStatus"]
    programme = details["programme"]
    nationality = details["nationality"]
    result = queries.newPatron(referenceID, patronName, patronStatus, programme, nationality)
    return jsonify(result)


@app.route("/update-patron/patronid", methods=["PUT"])
def revisePatronByPatronID():
    details = request.get_json()
    referenceID = details["referenceID"]
    patronName = details["patronName"]
    patronStatus = details["patronStatus"]
    patronID = details["patronID"]
    programme = details["programme"]
    nationality = details["nationality"]
    result = queries.updatePatronbyPatronID(referenceID, patronName, patronStatus, patronID, programme, nationality)
    return jsonify(result)

@app.route("/update-patron/refid", methods=["PUT"])
def revisePatronByReferenceID():
    details = request.get_json()
    patronName = details["patronName"]
    patronStatus = details["patronStatus"]
    referenceID = details["referenceID"]
    programme = details["programme"]
    nationality = details["nationality"]
    result = queries.updatePatronbyReferenceID(patronName, patronStatus, referenceID, programme, nationality)
    return jsonify(result)

@app.route("/get-patronid/<patronID>", methods=["GET"])
def findPatronByPatronID(patronID):
    result = queries.getPatronByPatronID(patronID)
    return jsonify(result)

@app.route("/get-refid/<referenceID>", methods=["GET"])
def findPatronByReferenceID(referenceID):
    result = queries.getPatronByReferenceID(referenceID)
    return jsonify(result)

@app.route("/search-patron/<patronName>", methods=["GET"])
def traversePatron(patronName):
    result = queries.searchPatron(patronName)
    return jsonify(result)

@app.route("/patrons", methods = ["GET"])
def allPatrons():
    result = queries.getAllPatrons()
    return jsonify(result)

@app.route("/delete-patronid/<patronID>", methods=["DELETE"])
def removePatronByPatronID(patronID):
    result = queries.deletePatronBypPatronID(patronID)
    return jsonify(result)

@app.route("/delete-refid/<referenceID>", methods=["DELETE"])
def removepatronByRefID(referenceID):
    result = queries.deletePatronByReferenceID(referenceID)
    return jsonify(result)

#For Book table
@app.route("/new-book", methods=["POST"])
def addBook():
    details = request.get_json()
    barCodeID = details["barCodeID"]
    bookTitle= details["bookTitle"]
    authorName = details["authorName"]
    dateAdded = details["dateAdded"]
    rfID = details ["rfID"]
    borrowStatus = details ["borrowStatus"]
    availability = details ["availability"]
    publicationYear = details ["publicationYear"]
    categoryID = details ["categoryID"]
    location = details ["location"]
    callNumber = details ["callNumber"]
    result = queries.newBook(barCodeID, bookTitle, authorName, dateAdded, rfID, borrowStatus,
                     availability, publicationYear, categoryID, location, callNumber)
    return jsonify(result)

@app.route("/update-book-by-book-id", methods = ["PUT"])
def reviseBookByBookID():
    details = request.get_json()
    bookTitle= details["bookTitle"]
    authorName = details["authorName"]
    dateAdded = details["dateAdded"]
    rfID = details["rfID"]
    borrowStatus = details["borrowStatus"]
    availability = details["availability"]
    publicationYear = details["publicationYear"]
    categoryID = details["categoryID"]
    location = details["location"]
    callNumber = details["callNumber"]
    bookID = details["bookID"]
    result = queries.updateBookByBookID(bookTitle, authorName, dateAdded, rfID, borrowStatus,
                     availability, publicationYear, categoryID, location, callNumber, bookID)
    return jsonify(result)

@app.route("/update-book-by-barcode-id", methods = ["PUT"])
def reviseBookByBarCodeID():
    details = request.get_json()
    bookTitle= details["bookTitle"]
    authorName = details["authorName"]
    dateAdded = details["dateAdded"]
    rfID = details["rfID"]
    borrowStatus = details["borrowStatus"]
    availability = details["availability"]
    publicationYear = details["publicationYear"]
    categoryID = details["categoryID"]
    location = details["location"]
    callNumber = details["callNumber"]
    barCodeID = details["barCodeID"]
    result = queries.updateBookByBarCodeID(bookTitle, authorName, dateAdded, rfID, borrowStatus,
                     availability, publicationYear, categoryID, location, callNumber, barCodeID)
    return jsonify(result)




@app.route("/get-book-by-book-id/<bookID>", methods = ["GET"])
def findBookByBookID(bookID):
    result = queries.getBookByBookID(bookID)
    return result

@app.route("/get-book-by-barcode-id/<barCodeID>", methods = ["GET"])
def findBookByBarCodeID(barCodeID):
    result = queries.getBookByBarCodeID(barCodeID)
    return result

@app.route("/books", methods = ["GET"])
def allBooks():
    result = queries.getAllBooks()
    return jsonify(result)

@app.route("/search-book/<bookTitle>", methods = ["GET"])
def findBook(bookTitle):
    result = queries.searchBook(bookTitle)
    return jsonify(result)

@app.route("/delete-book-by-book-id/<bookID>", methods=["DELETE"])
def removeBookByBookID(bookID):
    result = queries.deleteBookByBookID(bookID)
    return jsonify(result)

@app.route("/delete-book-by-barcode-id/<barCodeID>", methods=["DELETE"])
def removeBookByBarCodeID(barCodeID):
    result = queries.deleteBookByBarCodeID(barCodeID)
    return jsonify(result)

#FOR THE TRANSACTIONS TABLE
@app.route("/patron-account/<referenceID>", methods=['GET'])
def displayAccount(referenceID):
    result = queries.checkPatronAccount(referenceID)
    return jsonify(result) #checks all books in patron's possession and tells the amount of books they can still borrow

@app.route("/limit/<referenceID>", methods=['GET'])
def displayLimit(referenceID):
    result = queries.checkPatronLimit(referenceID)
    return jsonify(result) #only checks how many more books user can borrow

@app.route("/borrowstatus/<bookID>", methods=["GET"])
def status(bookID):
    result = queries.checkIfBorrowed(bookID)
    return jsonify(result)

@app.route("/availability/<bookID>", methods=["GET"])
def isAvailable(bookID):
    result = queries.checkAvailability(bookID)
    return jsonify(result)


@app.route("/borrow-book", methods = ["POST", "PUT"])
def borrow1():
    details = request.json
    referenceID = details["referenceID"]
    bookID = details["bookID"]
    if request.method == "POST":
        result = queries.borrowBook(referenceID, bookID)
        return jsonify(result)
    elif request.method == "PUT":
        result1 = queries.updateBorrowStatusTo1(bookID)
        return jsonify(result1)
    
@app.route("/return-book", methods = ["PUT"])
def returned():
    details = request.json
    transactionID = details["transactionID"]
    bookID = details["bookID"]
    result = queries.returnBook(transactionID)
    result1 = queries.updateBorrowStatusTo0(bookID)
    return jsonify(result, result1)

@app.route("/transaction/<transactionID>", methods = ["GET"])
def oneTransaction(transactionID):
    result = queries.getTransactionInfo(transactionID)
    return jsonify(result)


#Librarian Table
@app.route("/new-lib", methods = ["POST"])
def addLibrarian():
    details = request.get_json()
    libUsername = details["libUsername"]
    libPassword = details["libPassword"]
    result = queries.newLibrarian(libUsername, libPassword)
    return jsonify(result)

@app.route("/login", methods = ["POST"])
def login():
    details = request.get_json()
    libUsername = details["libUsername"]
    libPassword = details["libPassword"]
    result = queries.authorizeLibrarianLogin(libUsername, libPassword)
    return jsonify(result)

if __name__ == "__main__":
    create_tables()
    app.run(host='0.0.0.0', port=8000, debug=True)