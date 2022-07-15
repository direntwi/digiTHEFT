from flask import Flask, jsonify, request
import queries
from db import create_tables

app = Flask(__name__)

# @app.route("/", methods=[""])
# details = request.get_json()

#For Author Table
@app.route("/new-author", methods=["POST"])
def addAuthor():
    details = request.get_json()
    authorLastName = details["authorLastName"]
    authorOtherNames = details["authorOtherNames"]
    result = queries.newAuthor(authorLastName, authorOtherNames)
    return jsonify(result)


@app.route("/update-author-info", methods=["PUT"])
def reviseAuthor():
    details = request.get_json()
    authorLastName = details["authorLastName"]
    authorOtherNames = details["authorOtherNames"]
    authorID = details["authorID"]
    result = queries.updateAuthor(authorLastName, authorOtherNames, authorID)
    return jsonify(result)

@app.route("/get-author/<authorID>", methods=["GET"])
def findAuthor(authorID):
    result = queries.getAuthor(authorID)
    return jsonify(result)

@app.route("/search-author/<authorName>", methods=["GET"])
def traverseAuthor(authorName):
    result = queries.searchAuthor(authorName)
    return jsonify(result)

@app.route("/delete-author/<authorID>", methods=["DELETE"])
def removeAuthor(authorID):
    result = queries.deleteAuthor(authorID)
    return jsonify(result)

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
    result = queries.updateCategory(category)
    return jsonify(result)

@app.route("/get-category/<categoryID>", methods=["GET"])
def findCategory(categoryID):
    result = queries.getCategory(categoryID)
    return jsonify(result)

@app.route("/delete-category/<categoryID>", methods=["DELETE"])
def removeCategory(categoryID):
    result = queries.deleteCategory(categoryID)
    return jsonify(result)






#For Member Table
@app.route("/new-member", methods=["POST"])
def addMember():
    details = request.get_json()
    memberLastName = details["memberLastName"]
    memberOtherNames = details["memberOtherNames"]
    memberStatus = details["memberStatus"]
    result = queries.newMember(memberLastName, memberOtherNames, memberStatus)
    return jsonify(result)


@app.route("/update-member-info", methods=["PUT"])
def reviseMember():
    details = request.get_json()
    memberLastName = details["memberLastName"]
    memberOtherNames = details["memberOtherNames"]
    memberStatus = details["memberStatus"]
    memberID = details["memberID"]
    result = queries.updateMember(memberLastName, memberOtherNames, memberStatus, memberID)
    return jsonify(result)

@app.route("/get-member/<memberID>", methods=["GET"])
def findMember(memberID):
    result = queries.getMember(memberID)
    return jsonify(result)

@app.route("/search-member/<memberName>", methods=["GET"])
def traverseMember(memberName):
    result = queries.searchMember(memberName)
    return jsonify(result)

@app.route("/delete-member/<memberID>", methods=["DELETE"])
def removeMember(memberID):
    result = queries.deleteMember(memberID)
    return jsonify(result)

#For Book table
@app.route("/new-book", methods=["POST"])
def addBook():
    details = request.get_json()
    barCodeID = details["barCodeID"]
    bookTitle= details["bookTitle"]
    authorID = details["authorID"]
    dateAdded = details["dateAdded"]
    rfID = details ["rfID"]
    borrowStatus = details ["borrowStatus"]
    availability = details ["availability"]
    publicationYear = details ["publicationYear"]
    categoryID = details ["categoryID"]
    location = details ["location"]
    callNumber = details ["callNumber"]
    result = queries.newBook(barCodeID, bookTitle, authorID, dateAdded, rfID, borrowStatus,
                     availability, publicationYear, categoryID, location, callNumber)
    return jsonify(result)

@app.route("/update-book-by-book-id", methods = ["PUT"])
def reviseBookByBookID():
    details = request.get_json()
    bookTitle= details["bookTitle"]
    authorID = details["authorID"]
    dateAdded = details["dateAdded"]
    rfID = details["rfID"]
    borrowStatus = details["borrowStatus"]
    availability = details["availability"]
    publicationYear = details["publicationYear"]
    categoryID = details["categoryID"]
    location = details["location"]
    callNumber = details["callNumber"]
    bookID = details["bookID"]
    result = queries.updateBookByBookID(bookTitle, authorID, dateAdded, rfID, borrowStatus,
                     availability, publicationYear, categoryID, location, callNumber, bookID)
    return jsonify(result)

@app.route("/update-book-by-barcode-id", methods = ["PUT"])
def reviseBookByBarCodeID():
    details = request.get_json()
    bookTitle= details["bookTitle"]
    authorID = details["authorID"]
    dateAdded = details["dateAdded"]
    rfID = details["rfID"]
    borrowStatus = details["borrowStatus"]
    availability = details["availability"]
    publicationYear = details["publicationYear"]
    categoryID = details["categoryID"]
    location = details["location"]
    callNumber = details["callNumber"]
    barCodeID = details["barCodeID"]
    result = queries.updateBookByBarCodeID(bookTitle, authorID, dateAdded, rfID, borrowStatus,
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

@app.route("/delete-book-by-book-id/<bookID>", methods=["DELETE"])
def removeBookByBookID(bookID):
    result = queries.deleteBookByBookID(bookID)
    return result

@app.route("/delete-book-by-barcode-id/<barCodeID>", methods=["DELETE"])
def removeBookByBarCodeID(barCodeID):
    result = queries.deleteBookByBarCodeID(barCodeID)
    return result


if __name__ == "__main__":
    create_tables()
    app.run(host='0.0.0.0', port=8000, debug=True)