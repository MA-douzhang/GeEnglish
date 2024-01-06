from sqlalchemy import text, func
from models.BaseModel import BaseModel
from db import db
from models.user import User
from models.word import Word
from utils.common import construct_page_data_sql, FIND_FAILED, SAVE_FAILED


class Article(BaseModel):
    """
    动态表
    """
    __tablename__ = "article"

    id = db.Column(db.Integer, primary_key=True, autoincrement=True, comment="ID")
    title = db.Column(db.String(30), comment="标题")
    content = db.Column(db.String(100), comment="动态内容")
    author = db.Column(db.Integer, comment="作者id")
    like_count = db.Column(db.Integer, comment="点赞数")

    def getArticleData(self, page, size):
        data = Article().query.join(User,
                                    User.id == Article.author).with_entities(Article.id, Article.title, Article.content,
                                                                             User.avatar, User.name,
                                                                             Article.like_count).paginate(page=page,
                                                                                                          per_page=size,
                                                                                                          error_out=False)
        payload = []
        for result in data.items:
            content = {'id': result[0], 'title': result[1], 'content': result[2], 'avatar': result[3],
                       'name': result[4], 'like_count': result[5]}
            payload.append(content)
        data.items = payload
        data = construct_page_data_sql(data)
        return data

    def listByName(self, userName, page, size):
        data = Article().query.join(User,
                                    User.id == Article.author).filter(User.name == userName).with_entities(Article.id,
                                                                                                           Article.title,
                                                                                                           Article.content,
                                                                                                           User.avatar,
                                                                                                           User.name,
                                                                                                           Article.like_count).paginate(
            page=page,
            per_page=size,
            error_out=False)
        payload = []
        for result in data.items:
            content = {'id': result[0], 'title': result[1], 'content': result[2], 'avatar': result[3],
                       'name': result[4], 'like_count': result[5]}
            payload.append(content)
        data.items = payload
        data = construct_page_data_sql(data)
        return data


    def addByName(self, userName, content, title):
        try:
            user = User().query.filter_by(name=userName).first()
        except Exception as e:
            return FIND_FAILED()
        try:
            article = Article()
            article.title = title
            article.content= content
            article.author=user.id
            article.like_count=0
            article.save()
        except Exception as e:
             return SAVE_FAILED()
