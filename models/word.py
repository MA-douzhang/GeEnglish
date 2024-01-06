
from sqlalchemy import text
from models.BaseModel import BaseModel
from db import db

class Word(BaseModel):
    """
    单词表
    """
    __tablename__ = "word"

    id = db.Column(db.Integer, primary_key=True, autoincrement=True, comment="单词ID")
    word = db.Column(db.String(30), comment="单词")
    sw = db.Column(db.String(30), comment="单词缩写")
    phonetic = db.Column(db.String(30), comment="音标")
    definition = db.Column(db.String(30), comment="词性")
    translation = db.Column(db.String(100), comment="翻译")
    pos = db.Column(db.String(30), comment="")
    collins = db.Column(db.Integer, comment='', )
    frq = db.Column(db.Integer, comment='', )
    oxford = db.Column(db.Integer, comment='', )
    bnc = db.Column(db.Integer, comment='', )
    tag = db.Column(db.String(30), comment="")
    audio = db.Column(db.String(30), comment="")
    exchange = db.Column(db.String(30), comment="")
    detail = db.Column(db.String(30), comment="")

    def randomSelect(self, limit):
        data = db.session.execute(text("select * from word where id >= (select floor(rand() * (select MAX(id) from word)))order by id limit {}".format(limit))).fetchall()
        payload = []
        for result in data:
            content = {'id': result[0], 'word': result[1], 'translation': result[5]}
            payload.append(content)
        return payload
