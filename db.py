from email.policy import default
from enum import unique
from datetime import datetime
from flask import Flask
from flask_sqlalchemy import SQLAlchemy


app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///library_database.db'

db = SQLAlchemy(app)

class Author():
    authorID = db.Column(db.Integer, primary_key = True)
    authorLastName = db.Column(db.String(120), unique = False, nullable = False)
    authorOtherNames = db.Column(db.String(120), unique = False, nullable = False)
    # books = db.relationship('Books', backref='author', lazy='True' ) #This is how you represent the relationship between an author and his/her books
    
    def __repr__(self):
        return f"Author('{self.authorID}', '{self.authorLastName}', '{self.authorOtherNames}')"

# class CategoryTable():
#     categoryID = db.Column(db.Integer, primary_key = True)
#     category = db.Column(db.String(120), unique = False, nullable = False)

#     def __repr__(self):
#         pass
    
# ##contents in the following brackets are subject to change 
# class Books(db.Model):
#     bookTitle = db.Column(db.Text, unique = False, nullable = False )
#     authorID = db.Column(db.Integer, db.ForeignKey('author.authorID'), nullable =False)##this is how a foreign key is represented
#     dateAdded = db.Column(db.DateTime, nullable = False, default=datetime.utcnow)
#     barCodeID = db.Column(db.Integer, primary_key = True)
#     rfID = db.Column()
#     borrowStatus = db.Column()
#     availability = db.Column()
#     publicationYear = db.Column()
#     categoryID = db.Column()
#     location = db.Column(db.String(120), unique = False, nullable = False)
#     callNumber = db.Column()

#     def __repr__(self):
#         return f"User('{self.bookTitle}','{self.authorID}', '{self.dateAdded}', '{self.barCodeID}', '{self.rfid}', '{self.borrowStatus}', '{self.availability}', '{self.publicationYear}', '{self.categoryID}','{self.location}', '{self.callNumber}' )"


# class BookAndAuthor():
#     authorID = db.Column()
#     bookID = db.Column()

#     def __repr__(self):
#         pass

# class MemberTable():
#     memberID = db.Column()
#     lastName = db.Column()
#     otherNames = db.Column()
#     memberStatus = db.Column()

#     def __repr__(self):
#         pass

# class LoanTable():
#     memberID = db.Column()
#     loanID = db.Column()
#     bookID = db.Column()
#     loanDate = db.Column(db.DateTime, nullable = False, default=datetime.utcnow)##this is how the system would record a date by default if one isn't given
#     returnDate = db.Column(db.DateTime, nullable = False, default=datetime.utcnow)
#     dueDate = db.Column(db.DateTime, nullable = False)

#     def __repr__(self):
#         pass

# class FineTable():
#     memberID = db.Column()
#     loanID = db.Column()
#     fineID = db.Column()
#     fineAmount = db.Column()
#     fineDate = db.Column(db.DateTime, nullable = False, default=datetime.utcnow)

#     def __repr__(self):
#         pass

# class FinePaymentTable():
#     fineID = db.Column()
#     memberID = db.Column()
#     paymentDate = db.Column(db.DateTime, nullable = False, default=datetime.utcnow)
#     paymentID = db.Column()

#     def __repr__(self):
#         pass







    


# ##remember to ask what will be used as the primary key for the books and change it in the BookANdAuthor and loan tables