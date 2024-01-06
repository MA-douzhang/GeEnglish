from future.backports.datetime import datetime
from sqlalchemy import text, func
from models.BaseModel import BaseModel
from db import db
from models.word import Word


class RemeberedWord(BaseModel):
    """
    记单词表
    """
    __tablename__ = "remebered_word"

    id = db.Column(db.Integer, primary_key=True, autoincrement=True, comment="ID")
    user_id = db.Column(db.Integer, comment="用户ID")
    word_id = db.Column(db.Integer, comment="单词id")
    times = db.Column(db.Integer, comment="记录次数")
    remeber_time = db.Column(db.TIMESTAMP(True), comment="记录时间", nullable=False, default=func.now())

    def listByName(self, userId, page, size):
        data = RemeberedWord().query.join(Word,
                                          Word.id == RemeberedWord.word_id).filter(
            RemeberedWord.user_id == userId).paginate(page=page,
                                                      per_page=size,
                                                      error_out=False)
        payload = []
        for result in data:
            content = {'word': result[0], 'translation': result[1], 'times': result[2]}
            payload.append(content)
        return payload

    #复习单词数据
    def getReview(self,username,limit):
        data = db.session.execute(text(
            "SELECT wd.id,wd.word,wd.translation,remeber_time FROM `remebered_word` rw LEFT JOIN account ac ON ac.id = rw.user_id LEFT JOIN word wd ON wd.id = rw.word_id WHERE times < 7 AND DAY ( remeber_time )!= DAY (NOW()) AND ac.`name` = '{}'".format(
                username))).fetchall()
        payload = []
        for result in data:
            content = {'id': result[0], 'word': result[1], 'translation': result[2], "remeber_time": result[3]}
            payload.append(content)

        def get_date_difference(item):
            remember_time = item['remeber_time']
            # 将日期字符串转换为日期对象
            # 获取当前日期
            current_date = datetime.now().date()    # 获取当前日期

            # 计算 'remeber_time' 与当前日期的间隔
            t = abs((remember_time.date() - current_date).days)
            # 算法积分 分越高说明记忆越清晰
            difference = 0.75/(1+0.42*t)+0.25/(1+0.003*t)
            print(difference)
            return difference  # 返回绝对值间隔天数
        # 根据日期间隔对 'payload' 进行排序
        payload = sorted(payload, key=get_date_difference)
        return payload[:limit]

