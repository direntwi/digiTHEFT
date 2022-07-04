##these are the instashop database tables. They helped me draft the tables for the library database. FOr reference use only 

import sqlite3
DATABASE_NAME = "database_for_instashop.db"


def get_db():
    conn = sqlite3.connect(DATABASE_NAME)
    return conn


def create_tables():
    tables = [
        """
        CREATE TABLE IF NOT EXISTS VendorInfo(
            VendorID INTEGER PRIMARY KEY AUTOINCREMENT,
            VendorFirstName TEXT NOT NULL,
            VendorLastName TEXT NOT NULL, 
            ShopName TEXT NOT NULL,
            ShopPicture TEXT NOT NULL,
            VendorEmail TEXT NOT NULL,
            VendorPhoneNo INT NOT NULL,
            VendorPassword TEXT NOT NULL,
            VendorAddress TEXT NOT NULL
        )
        """,
        """
        CREATE TABLE IF NOT EXISTS CustomerInfo(
           CustomerID INTEGER PRIMARY KEY AUTOINCREMENT,
           CustomerFirstName TEXT NOT NULL,
           CustomerLastName TEXT NOT NULL,
           CustomerEmail TEXT NOT NULL,
           CustomerPhoneNo INT NOT NULL,
           CustomerPassword TEXT NOT NULL,
           CustomerAddress TEXT NOT NULL
        )
        
        """,
        """
        CREATE TABLE IF NOT EXISTS ProductInfo(
           ProductID INTEGER PRIMARY KEY AUTOINCREMENT,
           VendorID INTEGER,
           Product TEXT,
           ProductCategory TEXT,
           ProductPicture TEXT,
           ProductPrice REAL,
           ProductDescription TEXT,
           FOREIGN KEY (VendorID) REFERENCES VendorInfo(VendorID)
        )
        
        """,
        """
        CREATE TABLE IF NOT EXISTS Wishlist(
           WishlistID INTEGER PRIMARY KEY AUTOINCREMENT,
           ProductID INTEGER,
           CustomerID INTEGER,
           FOREIGN KEY (ProductID) REFERENCES ProductInfo(ProductID),
           FOREIGN KEY (CustomerID) REFERENCES CustomerInfo(CustomerID)
        )        
        
        """, 
        """
        CREATE TABLE IF NOT EXISTS Cart(
           CartID INTEGER PRIMARY KEY AUTOINCREMENT,
           ProductID INTEGER,
           CustomerID INTEGER,
           FOREIGN KEY (ProductID) REFERENCES ProductInfo(ProductID),
           FOREIGN KEY (CustomerID) REFERENCES CustomerInfo(CustomerID)
        )
        
        """,
        """
        CREATE TABLE IF NOT EXISTS OrderHistory(
           OrderID INTEGER PRIMARY KEY AUTOINCREMENT,
           ProductID INTEGER,
           CustomerID INTEGER,
           OrderDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
           FOREIGN KEY (ProductID) REFERENCES ProductInfo(ProductID),
           FOREIGN KEY (CustomerID) REFERENCES CustomerInfo(CustomerID)
        )
        
        """
    ]

   


    db = get_db()
    cursor = db.cursor()
    for table in tables:
        cursor.execute(table)
    
