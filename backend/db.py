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
        CREATE TABLE IF NOT EXISTS Patron(
            patronID INTEGER PRIMARY KEY,
            referenceID TEXT UNIQUE NOT NULL,
            patronName TEXT NOT NULL,
            patronStatus TEXT NOT NULL,
            programme TEXT,
            nationality TEXT NOT NULL
                     
        )
        """,
        """
        CREATE TABLE IF NOT EXISTS Book(
            id INTEGER PRIMARY KEY,
            barCodeID TEXT UNIQUE NOT NULL,
            bookTitle TEXT NOT NULL,
            authorName TEXT NOT NULL,
            dateAdded DATETIME,
            rfID TEXT UNIQUE NOT NULL,
            borrowStatus BOOLEAN NOT NULL,
            availability BOOLEAN NOT NULL,
            publicationYear TEXT NOT NULL,
            categoryID INTEGER NOT NULL,
            location TEXT NOT NULL,
            callNumber TEXT NOT NULL,
            FOREIGN KEY (categoryID) REFERENCES Categories (categoryID)

        )
        
        """,
        """
        CREATE TABLE IF NOT EXISTS Transactions(
            transactionID INTEGER PRIMARY KEY,
            referenceID TEXT NOT NULL,
            id INTEGER NOT NULL,
            transactionDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            returnDate TIMESTAMP DEFAULT 0,
            dueDate DATE,
            isReturned BOOLEAN DEFAULT 0,
            FOREIGN KEY (referenceID) REFERENCES Patron (referenceID),
            FOREIGN KEY (id) REFERENCES Book (id)

        ) 
        """,
        """
        CREATE TABLE IF NOT EXISTS Librarian(
            libID INTEGER PRIMARY KEY,
            libUsername TEXT NOT NULL,
            libPassword PASSWORD
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
#             id INTEGER

#         )
#         """,
#         """
#         CREATE TABLE IF NOT EXISTS Fine(
#             patronID
#             transactionID
#             fineID
#             fineAmount
#             fineDate
            
#         )
#         """,
#         """
#         CREATE TABLE IF NOT EXISTS Payment(
#             fineID
#             patronID
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