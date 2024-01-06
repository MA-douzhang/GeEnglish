import hashlib

from pymysql import connect
from pymysql.cursors import DictCursor  # 为了返回字典形式

from sqlalchemy import func
from models.BaseModel import BaseModel
from db import db


class User(BaseModel):
    """
    用户表
    """
    __tablename__ = "account"
    id = db.Column(db.Integer, primary_key=True, autoincrement=True, comment="用户ID")
    name = db.Column(db.String(30), comment="登录账号")
    email = db.Column(db.String(50), comment="用户邮箱")
    avatar = db.Column(db.String(100), comment="头像路径",default="https://c-ssl.duitang.com/uploads/blog/202206/12/20220612164733_72d8b.jpg")
    password = db.Column(db.String(50), comment="密码")
    today_words= db.Column(db.Integer,comment='每日单词数量',default=20)
    today_review_words= db.Column(db.Integer,comment='每日复习单词数量',default=20)
    login_time = db.Column(db.TIMESTAMP, comment="最后登陆时间", nullable=False,
                           onupdate=func.now(),default=func.now())
    register_time = db.Column(db.TIMESTAMP(True), comment="注册时间", nullable=False,default=func.now())


    def check_password(self, passwd):
        '''
        检查密码
        :param passwd:
        :return: 0/1
        '''
        # 创建md5对象
        m = hashlib.md5()
        b = passwd.encode(encoding='utf-8')
        m.update(b)
        str_md5 = m.hexdigest()
        if self.password == str_md5:
            return 1
        else:
            return 0
