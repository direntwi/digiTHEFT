#This file basically has the same tables in db.py, they're just in a different format
#This is also purely experiental and based on the format that was used for the InstaShop Database

import sqlite3
DATABASE_NAME = 'library_database.db'

def get_db():
    conn = sqlite3.connect(DATABASE_NAME)
    return conn

def create_tables():
    tables = [
        """
        CREATE TABLE IF NOT EXISTS Author(
            authorID INTEGER PRIMARY KEY
            authorLastName TEXT NOT NULL
            authorOtherNames TEXT NOT NULL

        )
        """,
        """
        CREATE TABLE IF NOT EXISTS CategoryTable(
            categoryID INTEGER PRIMARY KEY
            category TEXT NOT NULL

        )
        """, 
        """
        CREATE TABLE IF NOT EXISTS Books(
            bookTitle TEXT NOT NULL
            authorID INTEGER NOT NULL
            dateAdded DATETIME
            barCodeID TEXT NOT NULL
            rfid TEXT NOT NULL
            borrowStatus
            availability
            publicationYear
            categoryID INTEGER
            location TEXT NOT NULL
            callNumber    
         
        )
        """,

        """
        CREATE TABLE IF NOT EXISTS BookAndAuthor(
            authorID INTEGER
            bookID INTEGER

        )
        """,
        """
        CREATE TABLE IF NOT EXISTS MemberTable(
            memberID
            lastName
            otherNames
            memberStatus

        )
        """,
        """
        CREATE TABLE IF NOT EXISTS LoanTable(
            memberID
            loanID
            bookID
            loanDate
            returnDate
            dueDate

        ) 
        """,
        """
        CREATE TABLE IF NOT EXISTS FineTable(
            memberID
            loanID
            fineID
            fineAmount
            fineDate
            
        )
        """,
        """
        CREATE TABLE IF NOT EXISTS FinePaymentTable(
            fineID
            memberID
            paymentDate
            paymentID
        )
        """  

    ]
    db = get_db()
    cursor = db.cursor()
    for table in tables:
        cursor.execute(table)


##remember to ask what will be used as the primary key for the books and change it in the BookANdAuthor and Loan tables