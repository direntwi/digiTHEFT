from unittest import result
from flask import Flask, jsonify, request
import queries
from db import create_tables

app = Flask(__name__)

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


@app.route("/update-patron/id", methods=["PUT"])
def revisePatronByid():
    details = request.get_json()
    referenceID = details["referenceID"]
    patronName = details["patronName"]
    patronStatus = details["patronStatus"]
    id = details["id"]
    programme = details["programme"]
    nationality = details["nationality"]
    result = queries.updatePatronbyid(referenceID, patronName, patronStatus, id, programme, nationality)
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

@app.route("/get-id/<id>", methods=["GET"])
def findPatronByid(id):
    result = queries.getPatronByid(id)
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

@app.route("/delete-id/<id>", methods=["DELETE"])
def removePatronByid(id):
    result = queries.deletePatronBypid(id)
    return jsonify(result)

@app.route("/delete-refid/<referenceID>", methods=["DELETE"])
def removepatronByRefID(referenceID):
    result = queries.deletePatronByReferenceID(referenceID)
    return jsonify(result)

#For Book table
@app.route("/new-book", methods=["POST"])
def addBook():
    details = request.get_json()
    bookTitle= details["bookTitle"]
    authorName = details["authorName"]
    dateAdded = details["dateAdded"]
    rfID = details ["rfID"]
    isBorrowed = details ["isBorrowed"]
    availability = details ["availability"]
    publicationYear = details ["publicationYear"]
    categoryID = details ["categoryID"]
    location = details ["location"]
    callNumber = details ["callNumber"]
    result = queries.newBook(bookTitle, authorName, dateAdded, rfID, isBorrowed,
                     availability, publicationYear, categoryID, location, callNumber)
    return jsonify(result)


@app.route("/update-book-by-rfid", methods = ["PUT"])
def reviseBookByRFID():
    details = request.get_json()
    bookTitle= details["bookTitle"]
    authorName = details["authorName"]
    dateAdded = details["dateAdded"]
    isBorrowed = details["isBorrowed"]
    availability = details["availability"]
    publicationYear = details["publicationYear"]
    categoryID = details["categoryID"]
    location = details["location"]
    callNumber = details["callNumber"]
    rfID = details["rfID"]
    result = queries.updateBookByRFID(bookTitle, authorName, dateAdded, isBorrowed,
                     availability, publicationYear, categoryID, location, callNumber, rfID)
    return jsonify(result)


@app.route("/get-book-by-rfid/<rfID>", methods = ["GET"])
def findBookByRFID(rfID):
    result = queries.getBookByRFID(rfID)
    return jsonify(result)


@app.route("/books", methods = ["GET"])
def allBooks():
    result = queries.getAllBooks()
    return jsonify(result)

@app.route("/search-book/<bookTitle>", methods = ["GET"])
def findBook(bookTitle):
    result = queries.searchBook(bookTitle)
    return jsonify(result)

@app.route("/delete-book-by-rfid/<rfID>", methods=["DELETE"])
def removeBookByRFID(rfID):
    result = queries.deleteBookByRFID(rfID)
    return jsonify(result)

#FOR THE TRANSACTIONS TABLE
@app.route("/patron-account/<referenceID>", methods=['GET'])
def displayAccount(referenceID):
    result = queries.checkPatronAccount(referenceID)
    return jsonify(result) #checks all books in patron's possession

@app.route("/limit/<referenceID>", methods=['GET'])
def displayLimit(referenceID):
    result = queries.checkPatronLimit(referenceID)
    return jsonify(result) #only checks how many more books user can borrow

@app.route("/isBorrowed/<rfID>", methods=["GET"])
def status(rfID):
    result = queries.checkIfBorrowed(rfID)
    return result

@app.route("/availability/<rfID>", methods=["GET"])
def isAvailable(rfID):
    result = queries.checkAvailability(rfID)
    return jsonify(result)


@app.route("/borrow-book", methods = ["POST", "PUT"])
def borrow1():
    details = request.json
    referenceID = details["referenceID"]
    rfID = details["rfID"]
    if request.method == "POST":
        result = queries.borrowBook(referenceID, rfID)
        return jsonify(result)
    elif request.method == "PUT":
        result1 = queries.updateisBorrowedTo1(rfID)
        return jsonify(result1)
    
@app.route("/return-book", methods = ["PUT"])
def returned():
    details = request.json
    # transactionID = details["transactionID"]
    rfID = details["rfID"]
    result = queries.returnBook(rfID)
    result1 = queries.updateisBorrowedTo0(rfID)
    return jsonify(result, result1)



@app.route("/transaction/<transactionID>", methods = ["GET"])
def oneTransaction(transactionID):
    result = queries.getTransactionInfo(transactionID)
    return jsonify(result)

@app.route("/transactions", methods=["GET"])
def allTransactions():
    result=queries.getAllTransactions()
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