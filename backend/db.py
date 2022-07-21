import sqlite3
DATABASE_NAME = 'library_database.db'

def get_db():
    conn = sqlite3.connect(DATABASE_NAME)
    return conn

def create_tables():
    tables = [
        """
        CREATE TABLE IF NOT EXISTS Categories(
            categoryID INTEGER PRIMARY KEY,
            category TEXT NOT NULL

        )
        """, 
        """
        CREATE TABLE IF NOT EXISTS Member(
            memberID INTEGER PRIMARY KEY,
            referenceID TEXT UNIQUE NOT NULL,
            memberName TEXT NOT NULL,
            memberStatus TEXT NOT NULL            

        )
        """,
        """
        CREATE TABLE IF NOT EXISTS Book(
            bookID INTEGER PRIMARY KEY,
            barCodeID TEXT NOT NUll,
            bookTitle TEXT NOT NULL,
            authorName INTEGER NOT NULL,
            dateAdded DATETIME,
            rfID TEXT NOT NULL,
            borrowStatus BOOLEAN NOT NULL,
            availability BOOLEAN NOT NULL,
            publicationYear TEXT NOT NULL,
            categoryID INTEGER NOT NULL,
            location TEXT NOT NULL,
            callNumber TEXT NOT NULL,
            FOREIGN KEY (categoryID) REFERENCES Categories (categoryID)
         
        )
        """

    ]

    db = get_db()
    cursor = db.cursor()
    for table in tables:
        cursor.execute(table)

    #More Tables To Be Added Later

# ,

#         """
#         CREATE TABLE IF NOT EXISTS BookAndAuthor(
#             authorID INTEGER
#             bookID INTEGER

#         )
#         """,
#         """
#         CREATE TABLE IF NOT EXISTS Loan(
#             memberID
#             loanID
#             bookID
#             loanDate
#             returnDate
#             dueDate

#         ) 
#         """,
#         """
#         CREATE TABLE IF NOT EXISTS Fine(
#             memberID
#             loanID
#             fineID
#             fineAmount
#             fineDate
            
#         )
#         """,
#         """
#         CREATE TABLE IF NOT EXISTS Payment(
#             fineID
#             memberID
#             paymentDate
#             paymentID
#         )
#         """  

# """
#         CREATE TABLE IF NOT EXISTS Author(
#             authorID INTEGER PRIMARY KEY,
#             authorName TEXT NOT NULL

#         )
#         """,