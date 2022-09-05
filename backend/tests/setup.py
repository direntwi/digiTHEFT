import os
import queries
from backend.tests.data import (
    new_author_data,
    new_book_data,
    new_category_data,
    new_member_data)

def create_author(author):
    response = author.post("/new-author", json = new_author_data)
    return response.json


def update_author(author):
    response = author.put("/update-author", json = [])
    return response.json

def delete_author(author):
    pass



