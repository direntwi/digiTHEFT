from db import get_db

#For Author Table
# def newAuthor(authorName):
#     db = get_db()
#     cursor = db.cursor()
#     statement = "INSERT INTO Author(authorName) VALUES (?)"
#     cursor.execute(statement, [authorName])
#     db.commit()
#     return {"status": 201, "message": "new author added"}


# def updateAuthor(authorName, authorID):
#     db = get_db()
#     cursor = db.cursor()
#     statement = "UPDATE Author SET authorName=? WHERE authorID = ?"
#     cursor.execute(statement, [authorName, authorID])
#     db.commit()
#     return {"status": 202, "message": "author info updated"}

# def getAuthor(authorID=None):
#     db = get_db()
#     cursor = db.cursor()
#     statement = "SELECT authorName FROM Author WHERE authorID =?"
#     cursor.execute(statement, [authorID])
#     result = cursor.fetchone()
#     return{
#         "authorName" : f"{result[0]}"
#     }

# def searchAuthor(authorName=None): ##to be continued
#     db = get_db()
#     cursor = db.cursor()
#     statement = "SELECT authorID,authorName FROM Author WHERE authorName = ?"
#     cursor.execute(statement, ('%' + authorName + '%',))
#     result = cursor.fetchall()
#     resultDict = []
#     for resultItem in result:
#         resultDict.append(
#             {
#                "authorID" : f"{resultItem[0]}",
#                "authorName": resultItem[1]
#             }
#         )
#     return resultDict

# def getAllAuthors():
#     db = get_db()
#     cursor = db.cursor()
#     query = "SELECT * FROM Author"
#     cursor.execute(query)
#     result = cursor.fetchall()
#     resultDict = []
#     for resultItem in result:
#         resultDict.append(
#             {
#                "authorID" : f"{resultItem[0]}",
#                "authorName": resultItem[1]
#             }
#         )

#     return resultDict


# def deleteAuthor(authorID):
#     db = get_db()
#     cursor = db.cursor()
#     statement =  "DELETE FROM Author WHERE authorID=?"
#     cursor.execute(statement, [authorID])
#     db.commit()
#     return {"status": 201, "message": "author successfully deleted"}



#For Category table
def newCategory(category):
    db = get_db()
    cursor = db.cursor()
    statement = "INSERT INTO Categories(category) VALUES (?)"
    cursor.execute(statement, [category])
    db.commit()
    return {"status": 201, "message": "new category added"}

def updateCategory(category, categoryID):
    db = get_db()
    cursor = db.cursor()
    statement = "UPDATE Categories SET category=? WHERE categoryID=?"
    cursor.execute(statement, [category, categoryID])
    db.commit()
    return {"status": 202, "message": "category info updated"}

    

def getCategory(categoryID=None):
    db = get_db()
    cursor = db.cursor()
    statement = "SELECT categoryID, category FROM Categories WHERE categoryID =?"
    cursor.execute(statement, [categoryID])
    result = cursor.fetchone()
    return{
        "categoryID" : f"{result[0]}",
        "category" : result[1]
    }

def getCategoryID(category=None):
    db = get_db()
    cursor = db.cursor()
    statement = "SELECT categoryID, category FROM Categories WHERE category=?"
    cursor.execute(statement, [category])
    result = cursor.fetchone()
    return{
        "categoryID" : f"{result[0]}",
        "category" : result[1]
    }


def getAllCategories():
    db = get_db()
    cursor = db.cursor()
    query = "SELECT * FROM Categories"
    cursor.execute(query)
    result = cursor.fetchall()
    resultDict = []
    for resultItem in result:
        resultDict.append(
            {
               "categoryID" : f"{resultItem[0]}",
               "category": resultItem[1]
            }
        )

    return resultDict




def deleteCategory(categoryID):
    db = get_db()
    cursor = db.cursor()
    statement =  "DELETE FROM Categories WHERE categoryID=?"
    cursor.execute(statement, [categoryID])
    db.commit()
    return {"status": 201, "message": "Category successfully deleted"}



#For Patron Table
def newPatron(referenceID, patronName, patronStatus, programme, nationality):
    db = get_db()
    cursor = db.cursor()
    statement = "INSERT INTO Patron(referenceID, patronName, patronStatus, programme, nationality) VALUES (?,?,?,?,?)"
    cursor.execute(statement, [referenceID, patronName, patronStatus, programme, nationality])
    db.commit()
    return {"status": 201, "message": "new patron added"}


def updatePatronbyid(referenceID, patronName, patronStatus, programme, nationality, id):
    db = get_db()
    cursor = db.cursor()
    statement = "UPDATE Patron SET referenceID=?,patronName=?, patronStatus=?, programme=?, nationality=? WHERE id = ?"
    cursor.execute(statement, [referenceID, patronName, patronStatus, programme, nationality, id])
    db.commit()
    return {"status": 202, "message": "patron info updated"}

def updatePatronbyReferenceID(patronName, patronStatus, programme, nationality, referenceID):
    db = get_db()
    cursor = db.cursor()
    statement = "UPDATE Patron SET patronName=?, patronStatus=?, programme=?, nationality=? WHERE referenceID = ?"
    cursor.execute(statement, [patronName, patronStatus, programme, nationality, referenceID])
    db.commit()
    return {"status": 202, "message": "patron info updated"}

def getPatronByid(id=None):
    db = get_db()
    cursor = db.cursor()
    statement = "SELECT referenceID, patronName, patronStatus, programme, nationality FROM Patron WHERE id =?"
    cursor.execute(statement, [id])
    result = cursor.fetchone()
    return{
        "referenceID" : f"{result[0]}",
        "patronName": result[1],
        "patronStatus": result[2],
        "programme": result[3],
        "nationality": result[4]
    }

def getPatronByReferenceID(referenceID=None):
    db = get_db()
    cursor = db.cursor()
    statement = "SELECT id, referenceID, patronName, patronStatus, programme, nationality FROM Patron WHERE referenceID =?"
    cursor.execute(statement, [referenceID])
    result = cursor.fetchone()
    return{
        "id" : f"{result[0]}",
        "referenceID": result[1],
        "patronName": result[2],
        "patronStatus": result[3],
        "programme": result[4],
        "nationality": result[5]
    }

def searchPatron(patronName=None):
    db = get_db()
    cursor = db.cursor()
    statement = "SELECT * FROM Patron WHERE patronName LIKE ?"
    cursor.execute(statement, ('%' + patronName + '%',))
    result = cursor.fetchall()
    resultDict = []
    for resultItem in result:
        resultDict.append(
            {
               "id" : f"{resultItem[0]}",
               "referenceID": resultItem[1],
               "patronName": resultItem[2],
               "patronStatus": resultItem[3],
               "programme": resultItem[4],
               "nationality": resultItem[5]
            }
        )
    return resultDict

def getAllPatrons():
    db = get_db()
    cursor = db.cursor()
    query = "SELECT * FROM Patron"
    cursor.execute(query)
    result = cursor.fetchall()
    resultDict = []
    for resultItem in result:
        resultDict.append(
            {
               "id" : f"{resultItem[0]}",
               "referenceID": resultItem[1],
               "patronName": resultItem[2],
               "patronStatus": resultItem[3],
               "programme": resultItem[4],
               "nationality": resultItem[5]
            }
        )

    return resultDict


def deletePatronBypid(id):
    db = get_db()
    cursor = db.cursor()
    statement =  "DELETE FROM Patron WHERE id=?"
    cursor.execute(statement, [id])
    db.commit()
    return {"status": 201, "message": "patron successfully deleted"}

def deletePatronByReferenceID(referenceID):
    db = get_db()
    cursor = db.cursor()
    statement =  "DELETE FROM Patron WHERE referenceID=?"
    cursor.execute(statement, [referenceID])
    db.commit()
    return {"status": 201, "message": "patron successfully deleted"}


#For Book Table

def newBook(bookTitle, authorName, dateAdded, rfID, isBorrowed, availability, publicationYear, categoryID, location, callNumber):
    db = get_db()
    cursor = db.cursor()
    statement = "INSERT INTO Book(bookTitle, authorName, dateAdded, rfID, isBorrowed, availability, publicationYear, categoryID, location, callNumber) VALUES(?,?,?,?,?,?,?,?,?,?)"
    cursor.execute(statement, [bookTitle, authorName, dateAdded, rfID, isBorrowed, availability, publicationYear, categoryID, location, callNumber])
    db.commit()
    return {"status": 201, "message": "new Book added"}

# def updateBookByid(bookTitle, authorName, dateAdded, rfID, isBorrowed, availability, publicationYear, categoryID, location, callNumber, id):
#     db = get_db()
#     cursor = db.cursor()
#     statement = "UPDATE Book SET bookTitle=?, authorName=?, dateAdded=?, rfID=?, isBorrowed=?, availability=?, publicationYear=?, categoryID=?, location=?, callNumber=? WHERE id=?"
#     cursor.execute(statement, [bookTitle, authorName, dateAdded, rfID, isBorrowed, availability, publicationYear, categoryID, location, callNumber, id])
#     db.commit()
#     return {"status": 202, "message": "Book information updated"}

def updateBookByRFID(bookTitle, authorName, dateAdded,  isBorrowed, availability, publicationYear, categoryID, location, callNumber, rfID):
    db = get_db()
    cursor = db.cursor()
    statement = "UPDATE Book SET bookTitle=?, authorName=?, dateAdded=?, rfID=?, isBorrowed=?, availability=?, publicationYear=?, categoryID=?, location=?, callNumber=? WHERE rfID=?"
    cursor.execute(statement, [bookTitle, authorName, dateAdded, isBorrowed, availability, publicationYear, categoryID, location, callNumber, rfID])
    db.commit()
    return {"status": 202, "message": "Book information updated"}


# def getBookByid(id=None):
#     db = get_db()
#     cursor = db.cursor()
#     statement = "SELECT bookTitle, authorName, dateAdded, rfID, isBorrowed, availability, publicationYear, categoryID, location, callNumber FROM Book WHERE id=?"
#     cursor.execute(statement, [id])
#     result = cursor.fetchone()
#     return{
#         "bookTitle": f"{result[0]}",
#         "authorName": result[1],
#         "dateAdded": result[2],
#         "rfID": result[3],
#         "isBorrowed": result[4],
#         "availability": result[5],
#         "publicationYear": result[6],
#         "categoryID": result[7],
#         "location": result[8],
#         "callNumber": result[9]        
#     }

def searchBook(bookTitle=None):
    db = get_db()
    cursor = db.cursor()
    statement = "SELECT bookTitle, authorName, dateAdded, rfID, isBorrowed, availability, publicationYear, categoryID, location, callNumber FROM Book WHERE bookTitle LIKE ? "
    cursor.execute(statement, ('%' + bookTitle + '%',))
    result = cursor.fetchone()
    return{
        "bookTitle": f"{result[0]}",
        "authorName": result[1],
        "dateAdded": result[2],
        "rfID": result[3],
        "isBorrowed": result[4],
        "availability": result[5],
        "publicationYear": result[6],
        "categoryID": result[7],
        "location": result[8],
        "callNumber": result[9]        
    }


def getBookByRFID(rfID=None):
    db = get_db()
    cursor = db.cursor()
    statement = "SELECT bookTitle, authorName, dateAdded, rfID, isBorrowed, availability, publicationYear, categoryID, location, callNumber FROM Book WHERE rfID=?"
    cursor.execute(statement, [rfID])
    result = cursor.fetchone()
    return{
        "bookTitle": f"{result[0]}",
        "authorName": result[1],
        "dateAdded": result[2],
        "rfID": result[3],
        "isBorrowed": result[4],
        "availability": result[5],
        "publicationYear": result[6],
        "categoryID": result[7],
        "location": result[8],
        "callNumber": result[9]  
    }

def getAllBooks():
    db = get_db()
    cursor = db.cursor()
    query = "SELECT * FROM Book"
    cursor.execute(query)
    result = cursor.fetchall()
    resultDict = []
    for resultItem in result:
        resultDict.append(
            {
               "id" : f"{resultItem[0]}",
               "bookTitle" : resultItem[1],
               "authorName": resultItem[2],
               "dateAdded": resultItem[3],
               "rfID": resultItem[4],
               "isBorrowed": resultItem[5],
               "availability": resultItem[6],
               "publicationYear": resultItem[7],
               "categoryID": resultItem[8],
               "location": resultItem[9],
               "callNumber": resultItem[10]  
            }
        )

    return resultDict


# def deleteBookById(id):
#     db = get_db()
#     cursor = db.cursor()
#     statement =  "DELETE FROM Book WHERE id=?"
#     cursor.execute(statement, [id])
#     db.commit()
#     return {"status": 201, "message": "Book successfully deleted"}

def deleteBookByRFID(rfID):
    db = get_db()
    cursor = db.cursor()
    statement =  "DELETE FROM Book WHERE rfID=?"
    cursor.execute(statement, [rfID])
    db.commit()
    return {"status": 201, "message": "Book successfully deleted"}


# For Transactions Table
#This is to verify if a patron has any borrowed books in their possession
def checkPatronAccount(referenceID):
    db = get_db()
    cursor = db.cursor()
    statement = "SELECT t.transactionID, p.referenceID, p.patronName, b.bookTitle, t.dueDate FROM Book b, Patron p, Transactions t WHERE t.referenceID = p.referenceID AND b.rfID =t.rfID AND t.isReturned = 0 AND t.referenceID=? "
    cursor.execute(statement, [referenceID])
    result = cursor.fetchall()
    resultDict=[]
    if result:
        for resultItem in result:
            resultDict.append(
            {
               "transactionID" : f"{resultItem[0]}",
               "referenceID" : resultItem[1],
               "patronName" : resultItem[2],
               "bookTitle": resultItem[3],
               "dueDate": resultItem[4]
            }
        )
        return resultDict
    else:
        return "No Books are in Patron's Possession"

def checkPatronLimit(referenceID):
    db = get_db()
    cursor = db.cursor()
    statement = "SELECT t.transactionID, p.referenceID, p.patronName, b.bookTitle, t.dueDate FROM Book b, Patron p, Transactions t WHERE t.referenceID = p.referenceID AND b.rfID =t.rfID AND t.isReturned = 0 AND t.referenceID=? "
    cursor.execute(statement, [referenceID])
    result = cursor.fetchall()
    r = len(result)
    if r < 5:
        return "Patron can still borrow " +str(5-r)+ " more book(s)"
    else:
        return "Patron has reached the maximum borrowing limit"


def checkAvailability(rfID):
    db = get_db()
    cursor = db.cursor()
    statement = "SELECT bookTitle FROM Book WHERE rfID = ? and availability = 1"
    cursor.execute(statement, [rfID])
    result = cursor.fetchone()
    if result:
        return "Book can be borrowed"
    else:
        return "Book cannot be borrowed" 

def checkIfBorrowed(rfID):
    db = get_db()
    cursor = db.cursor()
    statement = "SELECT bookTitle FROM Book WHERE rfID = ? and isBorrowed = 0"
    cursor.execute(statement, [rfID])
    result = cursor.fetchone()
    if result:
        return "Book is available for borrowing"
    else:
        return "Book is currently unavailable. A patron has borrowed it" 

    

def updateisBorrowedTo1(rfID):
    db = get_db()
    cursor = db.cursor()
    statement = "UPDATE Book SET isBorrowed=1 WHERE rfID=?"
    cursor.execute(statement, [rfID])
    db.commit()
    return {"status": 201, "message": "book has been borrowed"}



def borrowBook(referenceID, rfID):
    db = get_db()
    cursor = db.cursor()
    statement1 = "INSERT INTO Transactions(referenceID, rfID) VALUES (?,?)"
    cursor.execute(statement1, [referenceID, rfID])
    db.commit()

    return {"status": 201, "message": "book successfully borrowed"}

def getTransactionInfo(transactionID):
    db = get_db()
    cursor = db.cursor()
    statement = "SELECT * FROM Transactions WHERE transactionID = ?"
    cursor.execute(statement, [transactionID])
    result = cursor.fetchone()
    return{
        "transactionID" : f"{result[0]}",
        "referenceID": result[1],
        "rfID": result[2],
        "transactionDate": result[3],
        "returnDate": result[4],
        "dueDate": result[5],
        "isReturned": result[6]
    }
    

def updateisBorrowedTo0(rfID):
    db = get_db()
    cursor = db.cursor()
    statement = "UPDATE Book SET isBorrowed=0 WHERE rfID=?"
    cursor.execute(statement, [rfID])
    db.commit()
    return {"status": 201, "message": "book is in the library"}

def returnBook(transactionID):
    db = get_db()
    cursor = db.cursor()
    statement = "UPDATE Transactions SET returnDate=CURRENT_TIMESTAMP, isReturned=1 WHERE transactionID = ?"
    cursor.execute(statement, [transactionID])
    db.commit()
    return {"status": 201, "message": "book successfully returned"}



def getAllTransactions():
    db = get_db()
    cursor = db.cursor()
    statement = "SELECT * FROM Transactions"
    cursor.execute(statement)
    result = cursor.fetchall()
    resultDict=[]
    if result:
        for resultItem in result:
            resultDict.append(
            {
               "transactionID" : f"{resultItem[0]}",
                "referenceID": resultItem[1],
                "rfID": resultItem[2],
                "transactionDate": resultItem[3],
                "returnDate": resultItem[4],
                "dueDate": resultItem[5],
                "isReturned": resultItem[6]

            }
        )
        return resultDict
    else:
        return "No Books are in Patron's Possession"


#For the Librarian Table
def newLibrarian(libUsername, libPassword):
    db = get_db()
    cursor = db.cursor()
    statement = "INSERT INTO Librarian(libUsername, libPassword) VALUES (?,?)"
    cursor.execute(statement, [libUsername, libPassword])
    db.commit()
    return {"status": 200, "message": "New librarian added"}

def authorizeLibrarianLogin(libUsername, libPassword):
    db = get_db()
    cursor = db.cursor()
    query = "SELECT * FROM librarian WHERE libUsername = ? AND libPassword =?"
    cursor.execute(query, [libUsername, libPassword])
    result = cursor.fetchone()
    if result:
        return 'Verified. Welcome'
    else:
        return 'Wrong Username or Password. Please try again'
    

        
    