from cgitb import handler

from flask import Flask, jsonify, request
import re

from flask_jwt_extended import JWTManager

from config import settings
from config.settings import SECRET_KEY
from controller.article import article
from controller.likeTable import likeTable
from controller.remeberedWord import remeberedWord
from controller.user import user
from controller.userLikes import userLikes
from controller.word import word
from db import db
from datetime import timedelta

from models.remeberedWord import RemeberedWord
app = Flask(__name__)


# # 检查是否含有特殊字符
# def is_string_validate(str):
#     sub_str = re.sub(u"([^\u4e00-\u9fa5\u0030-\u0039\u0041-\u005a\u0061-\u007a])", "", str)
#     if len(str) == len(sub_str):
#         # 说明合法
#         return False
#     else:
#         # 不合法
#         return True


@app.route('/')
def hello_world():  # put application's code here
    return 'Hello World!'


def register_blueprints(app):
    '''
    创建蓝图
    :param app:
    :return:
    '''
    app.register_blueprint(user, url_prefix='/account')
    app.register_blueprint(word, url_prefix='/word')
    app.register_blueprint(remeberedWord, url_prefix='/remebered/word')
    app.register_blueprint(userLikes, url_prefix='/user/likes')
    app.register_blueprint(article, url_prefix='/article')
    app.register_blueprint(likeTable, url_prefix='/like/table')
def create_app():
    app = Flask(__name__)

    # 设置返回jsonify方法返回dict不排序
    app.config['JSON_SORT_KEYS'] = False
    # 设置返回jsonify方法返回中文不转为Unicode格式
    app.config['JSON_AS_ASCII'] = False

    # 配置跨域
    # CORS(app, resources={r"/api/*": {"origins": "*"}})

    # 注册蓝图
    register_blueprints(app)

    #加载jwt配置token
    init_jwt(app)

    # 加载数据库
    init_db(app)
    #
    # # 加载redis配置
    # init_redis(app)

    # 加载日志
    app.logger.addHandler(handler)
    return app
def init_db(app):
    '''
    加载数据库
    :param app:
    :return:
    '''
    app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://{}:{}@{}:{}/{}'.format(settings.MYSQL['USER'],
                                                                            settings.MYSQL['PASSWD'],
                                                                            settings.MYSQL['HOST'],
                                                                            settings.MYSQL['PORT'], settings.MYSQL['DB'])
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False  # 跟踪对象的修改，在本例中用不到调高运行效率，所以设置为False
    app.config['SQLALCHEMY_ECHO'] = True
    db.init_app(app)

def init_jwt(app):
    app.config["JWT_SECRET_KEY"] = SECRET_KEY  # 设置 jwt 的秘钥
    app.config["JWT_ACCESS_TOKEN_EXPIRES"] = timedelta(days=15)
    # 设置刷新JWT过期时间
    app.config["JWT_REFRESH_TOKEN_EXPIRES"] = timedelta(days=30)
    jwt = JWTManager(app)

app = create_app()

if __name__ == '__main__':
    app.run(host='192.168.1.134', port=9090)
