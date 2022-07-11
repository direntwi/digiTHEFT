from unittest import result
from db import get_db

#For Author Table
def newAuthor(authorLastName, authorOtherNames):
    db = get_db()
    cursor = db.cursor()
    statement = "INSERT INTO Author(authorLastName, authorOtherNames) VALUES (?,?)"
    cursor.execute(statement, [authorLastName, authorOtherNames])
    db.commit()
    return {"status": 201, "message": "new author added"}


def updateAuthor(authorLastName, authorOtherNames, authorID):
    db = get_db()
    cursor = db.cursor()
    statement = "UPDATE Author SET authorLastName=?, authorOtherNames=? WHERE authorID = ?"
    cursor.execute(statement, [authorLastName, authorOtherNames, authorID])
    db.commit()
    return {"status": 202, "message": "author info updated"}

def getAuthor(authorID=None):
    db = get_db()
    cursor = db.cursor()
    statement = "SELECT authorLastName, authorOtherNames FROM Author WHERE authorID =?"
    cursor.execute(statement, [authorID])
    result = cursor.fetchone()
    return{
        "authorLastName" : f"{result[0]}",
        "authorOtherNames" : result[1]
    }

def deleteAuthor(authorID):
    db = get_db()
    cursor = db.cursor()
    statement =  "DELETE FROM Author WHERE authorID=?"
    cursor.execute(statement, [authorID])
    db.commit()
    return {"status": 201, "message": "author successfully deleted"}



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

def deleteCategory(categoryID):
    db = get_db()
    cursor = db.cursor()
    statement =  "DELETE FROM Categories WHERE categoryID=?"
    cursor.execute(statement, [categoryID])
    db.commit()
    return {"status": 201, "message": "Member successfully deleted"}



#For Member Table
def newMember(memberLastName, memberOtherNames, memberStatus):
    db = get_db()
    cursor = db.cursor()
    statement = "INSERT INTO Member(memberLastName, memberOtherNames, memberStatus) VALUES (?,?,?)"
    cursor.execute(statement, [memberLastName, memberOtherNames, memberStatus])
    db.commit()
    return {"status": 201, "message": "new Member added"}


def updateMember(memberLastName, memberOtherNames, memberStatus, memberID):
    db = get_db()
    cursor = db.cursor()
    statement = "UPDATE Member SET memberLastName=?, memberOtherNames=?, memberStatus=? WHERE memberID = ?"
    cursor.execute(statement, [memberLastName, memberOtherNames, memberStatus, memberID])
    db.commit()
    return {"status": 202, "message": "Member info updated"}

def getMember(memberID=None):
    db = get_db()
    cursor = db.cursor()
    statement = "SELECT memberLastName, memberOtherNames FROM Member WHERE memberID =?"
    cursor.execute(statement, [memberID])
    result = cursor.fetchone()
    return{
        "memberLastName" : f"{result[0]}",
        "memberOtherNames" : result[1],
        "memberStatus": result[2]
    }

def deleteMember(memberID):
    db = get_db()
    cursor = db.cursor()
    statement =  "DELETE FROM Member WHERE memberID=?"
    cursor.execute(statement, [memberID])
    db.commit()
    return {"status": 201, "message": "Member successfully deleted"}


#For Book Table

def newBook(barCodeID, bookTitle, authorID, dateAdded, rfID, borrowStatus, availability, publicationYear, categoryID, location, callNumber):
    db = get_db()
    cursor = db.cursor()
    statement = "INSERT INTO Book(barCodeID, bookTitle, authorID, dateAdded, rfID, borrowStatus, availability, publicationYear, categoryID, location, callNumber) VALUES(?,?,?,?,?,?,?,?,?,?,?)"
    cursor.execute(statement, [barCodeID, bookTitle, authorID, dateAdded, rfID, borrowStatus, availability, publicationYear, categoryID, location, callNumber])
    db.commit()
    return {"status": 201, "message": "new Book added"}

def updateBookByBookID(bookTitle, authorID, dateAdded, rfID, borrowStatus, availability, publicationYear, categoryID, location, callNumber, bookID):
    db = get_db()
    cursor = db.cursor()
    statement = "UPDATE Book SET bookTitle=?, authorID=?, dateAdded=?, rfID=?, borrowStatus=?, availability=?, publicationYear=?, categoryID=?, location=?, callNumber=? WHERE bookID=?"
    cursor.execute(statement, [bookTitle, authorID, dateAdded, rfID, borrowStatus, availability, publicationYear, categoryID, location, callNumber, bookID])
    db.commit()
    return {"status": 202, "message": "Book information updated"}

def updateBookByBarCodeID(bookTitle, authorID, dateAdded, rfID, borrowStatus, availability, publicationYear, categoryID, location, callNumber, barCodeID):
    db = get_db()
    cursor = db.cursor()
    statement = "UPDATE Book SET bookTitle=?, authorID=?, dateAdded=?, rfID=?, borrowStatus=?, availability=?, publicationYear=?, categoryID=?, location=?, callNumber=? WHERE barCodeID=?"
    cursor.execute(statement, [bookTitle, authorID, dateAdded, rfID, borrowStatus, availability, publicationYear, categoryID, location, callNumber, barCodeID])
    db.commit()
    return {"status": 202, "message": "Book information updated"}

def getBookByBookID(bookID=None):
    db = get_db()
    cursor = db.cursor()
    statement = "SELECT bookTitle, authorID, dateAdded, rfID, borrowStatus, availability, publicationYear, categoryID, location, callNumber FROM Book WHERE bookID=?"
    cursor.execute(statement, [bookID])
    result = cursor.fetchone()
    return{
        "bookTitle": f"{result[0]}",
        "authorID": result[1],
        "dateAdded": result[2],
        "rfID": result[3],
        "borrowStatus": result[4],
        "availability": result[5],
        "publicationYear": result[6],
        "categoryID": result[7],
        "location": result[8],
        "callNumber": result[9]        
    }

def getBookByBarCodeID(barCodeID=None):
    db = get_db()
    cursor = db.cursor()
    statement = "SELECT bookTitle, authorID, dateAdded, rfID, borrowStatus, availability, publicationYear, categoryID, location, callNumber FROM Book WHERE barCodeID=?"
    cursor.execute(statement, [barCodeID])
    result = cursor.fetchone()
    return{
        "bookTitle": f"{result[0]}",
        "authorID": result[1],
        "dateAdded": result[2],
        "rfID": result[3],
        "borrowStatus": result[4],
        "availability": result[5],
        "publicationYear": result[6],
        "categoryID": result[7],
        "location": result[8],
        "callNumber": result[9]        
    }

def deleteBookByBookID(bookID):
    db = get_db()
    cursor = db.cursor()
    statement =  "DELETE FROM Book WHERE bookID=?"
    cursor.execute(statement, [bookID])
    db.commit()
    return {"status": 201, "message": "Book successfully deleted"}

def deleteBookByBarCodeID(barCodeID):
    db = get_db()
    cursor = db.cursor()
    statement =  "DELETE FROM Book WHERE barCodeID=?"
    cursor.execute(statement, [barCodeID])
    db.commit()
    return {"status": 201, "message": "Book successfully deleted"}


    
