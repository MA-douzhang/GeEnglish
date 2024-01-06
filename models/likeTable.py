from sqlalchemy import text, func
from models.BaseModel import BaseModel
from db import db
from models.user import User
from models.word import Word
from utils.common import construct_page_data_sql, FIND_FAILED, SAVE_FAILED


class LikeTable(BaseModel):
    """
    动态喜欢表
    """
    __tablename__ = "like_table"

    id = db.Column(db.Integer, primary_key=True, autoincrement=True, comment="ID")
    user_id = db.Column(db.Integer, comment="用户id")
    article_id = db.Column(db.Integer, comment="动态id")

    # 查看当前用户动态喜欢状态
    def fetchLikeStatus(self,articleId,userName):
        try:
            user = User().query.filter_by(name=userName).first()
        except Exception as e:
            return FIND_FAILED()
        try:
            likeTable = LikeTable().query.filter_by(user_id=user.id,article_id=articleId).first()
        except Exception as e:
             return FIND_FAILED()
        if not likeTable:
            return 0
        else:
            return likeTable.id

    def addByName(self, userName,id):
        try:
            user = User().query.filter_by(name=userName).first()
        except Exception as e:
            return FIND_FAILED()
        try:
            likeTable = LikeTable()
            likeTable.article_id = id
            likeTable.user_id= user.id
            likeTable.save()
        except Exception as e:
            return SAVE_FAILED()
