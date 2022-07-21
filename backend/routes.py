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

@app.route("/categories", methods = ["GET"])
def allCategories():
    result = queries.getAllCategories()
    return jsonify(result)

@app.route("/delete-category/<categoryID>", methods=["DELETE"])
def removeCategory(categoryID):
    result = queries.deleteCategory(categoryID)
    return jsonify(result)






#For Member Table
@app.route("/new-member", methods=["POST"])
def addMember():
    details = request.get_json()
    referenceID = details["referenceID"]
    memberName = details["memberName"]
    memberStatus = details["memberStatus"]
    result = queries.newMember(referenceID, memberName, memberStatus)
    return jsonify(result)


@app.route("/update-member/memberid", methods=["PUT"])
def reviseMemberByMemberID():
    details = request.get_json()
    referenceID = details["referenceID"]
    memberName = details["memberName"]
    memberStatus = details["memberStatus"]
    memberID = details["memberID"]
    result = queries.updateMemberbyMemberID(referenceID, memberName, memberStatus, memberID)
    return jsonify(result)

@app.route("/update-member/refid", methods=["PUT"])
def reviseMemberByRefID():
    details = request.get_json()
    memberName = details["memberName"]
    memberStatus = details["memberStatus"]
    referenceID = details["referenceID"]
    result = queries.updateMemberbyReferenceID(memberName, memberStatus, referenceID)
    return jsonify(result)

@app.route("/get-memberid/<memberID>", methods=["GET"])
def findMemberByMemberID(memberID):
    result = queries.getMemberByMemberID(memberID)
    return jsonify(result)

@app.route("/get-refid/<referenceID>", methods=["GET"])
def findMemberbyRefID(referenceID):
    result = queries.getMemberByReferenceID(referenceID)
    return jsonify(result)

@app.route("/search-member/<memberName>", methods=["GET"])
def traverseMember(memberName):
    result = queries.searchMember(memberName)
    return jsonify(result)

@app.route("/members", methods = ["GET"])
def allMembers():
    result = queries.getAllMembers()
    return jsonify(result)

@app.route("/delete-memberid/<memberID>", methods=["DELETE"])
def removeMemberByMemberID(memberID):
    result = queries.deleteMember(memberID)
    return jsonify(result)

@app.route("/delete-refid/<referenceID>", methods=["DELETE"])
def removeMemberByRefID(referenceID):
    result = queries.deleteMemberbyReferenceID(referenceID)
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

@app.route("/books", methods = ["GET"])
def allBooks():
    result = queries.getAllBooks()
    return jsonify(result)

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