
from sqlalchemy import text
from models.BaseModel import BaseModel
from db import db

class UserLikes(BaseModel):
    """
    用户喜欢单词表
    """
    __tablename__ = "user_likes"

    id = db.Column(db.Integer, primary_key=True, autoincrement=True, comment="喜欢单词ID")
    user_id = db.Column(db.Integer, comment="用户id")
    from_sentence = db.Column(db.String(30), comment="目标单词")
    to_sentence = db.Column(db.String(30), comment="翻译单词")

