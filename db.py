from email.policy import default
from sqlalchemy import Column, String, Integer, Float, ForeignKey, Boolean
from sqlalchemy.types import DateTime
from enum import unique
from datetime import datetime
from flask import Flask
from flask_sqlalchemy import SQLAlchemy


app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///library_database.db'

db = SQLAlchemy(app)

class Author(db.Model):
    authorID = db.Column(db.Integer, primary_key = True)
    authorLastName = db.Column(db.String(120), unique = False, nullable = False)
    authorOtherNames = db.Column(db.String(120), unique = False, nullable = False)
    #author can have many books, hence the next line
    books = db.relationship('Book', backref='author', lazy='True' ) #This is how you represent the relationship between an author and his/her books
    
    def __repr__(self):
        return f"Author('{self.authorID}', '{self.authorLastName}', '{self.authorOtherNames}')"

class Category(db.Model):
    categoryID = db.Column(db.Integer, primary_key = True)
    category = db.Column(db.String(120), unique = False, nullable = False)
    #one category can be used to describe many books, hence the next line
    bookCategory = db.relationship('Book', backref='bookCategory')

    def __repr__(self):
        return f"Category('{self.categoryID}', '{self.category}')"

class Member(db.Model):
    memberID = db.Column(db.Integer, primary_key = True)
    memberLastName = db.Column(db.String(120), unique = False, nullable = False)
    memberOtherNames = db.Column(db.String(120), unique = False, nullable = False)
    memberStatus = db.Column(db.String(120), unique = False, nullable = False)

    def __repr__(self):
        return f"Member('{self.memberID}', '{self.memberLastName}', '{self.memberOtherNames}', '{self.memberStatus}')"
    
 ##contents in the following brackets are subject to change 
class Book(db.Model):
    barCodeID = db.Column(db.Integer, primary_key = True)
    bookTitle = db.Column(db.Text, unique = False, nullable = False)
    dateAdded = db.Column(db.DateTime, nullable = False, default=datetime.utcnow)
    rfID = db.Column(db.String(120), unique = True, nullable = False)
    borrowStatus = db.Column(db.String(20), unique = False, nullable = False)
    availability = db.Column(db.String(20), unique = False, nullable = False)
    publicationYear = db.Column(db.String(20), unique = False, nullable = False)
    location = db.Column(db.String(120), unique = False, nullable = False)
    callNumber = db.Column(db.String(120), unique = False, nullable = False)

    authorID = db.Column(db.Integer, db.ForeignKey('author.authorID'), nullable =False)##this is how a foreign key is represented
    categoryID = db.Column(db.String(120), db.ForeignKey('category.categoryID'))##also a foreign key

    def __repr__(self):
        return f"Book('{self.barCodeID}', '{self.bookTitle}', '{self.dateAdded}', '{self.rfID}', '{self.borrowStatus}', '{self.availability}', '{self.publicationYear}','{self.location}', '{self.callNumber}', '{self.authorID}', '{self.categoryID}' )"
        

# class BookAndAuthor(db.Model):
#     authorID = db.Colum.n()
#     barCodeID = db.Column()

#     def __repr__(self):
#         pass



# class Loan(db.Model):
#     memberID = db.Column()
#     loanID = db.Column()
#     barCodeID = db.Column()
#     loanDate = db.Column(db.DateTime, nullable = False, default=datetime.utcnow)##this is how the system would record a date by default if one isn't given
#     returnDate = db.Column(db.DateTime, nullable = False, default=datetime.utcnow)
#     dueDate = db.Column(db.DateTime, nullable = False)

#     def __repr__(self):
#         pass

# class Fine(db.Model):
#     memberID = db.Column()
#     loanID = db.Column()
#     fineID = db.Column()
#     fineAmount = db.Column()
#     fineDate = db.Column(db.DateTime, nullable = False, default=datetime.utcnow)

#     def __repr__(self):
#         pass

# class Payment(db.Model):
#     fineID = db.Column()
#     memberID = db.Column()
#     paymentDate = db.Column(db.DateTime, nullable = False, default=datetime.utcnow)
#     paymentID = db.Column()

#     def __repr__(self):
#         pass







    


# ##remember to ask what will be used as the primary key for the books and change it in the BookANdAuthor and loan tables