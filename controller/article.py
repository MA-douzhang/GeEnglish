from flask_jwt_extended import jwt_required
from controller import *
from models.article import Article
from models.word import Word
from utils.common import \
    construct_page_data
from utils.code_enum import Code

article = Blueprint('article', __name__)


@article.route('', methods=['GET'])
@jwt_required()
def getArticleData():
    page = int(request.args.get('page', 0))
    size = int(request.args.get('size', 0))
    if not all([page, size]):
        return jsonify(code=Code.NOT_NULL.value, msg="数量不能为空")
    articleList = Article().getArticleData(page, size)
    resData = {
        "resCode": 200,  # 非0即错误 1
        "data": articleList,  # 数据位置，一般为数组
        "message": 'success'
    }
    return jsonify(resData)


@article.route('/name', methods=['GET'])
@jwt_required()
def listByName():
    page = int(request.args.get('page', 0))
    size = int(request.args.get('size', 0))
    userName = request.args.get('userName', '')
    if not all([userName,page, size]):
        return jsonify(code=Code.NOT_NULL.value, msg="参数不能为空")
    articleList = Article().listByName(userName,page, size)
    resData = {
        "code": 200,  # 非0即错误 1
        "data": articleList,  # 数据位置，一般为数组
        "message": 'success'
    }
    return jsonify(resData)



@article.route('/name', methods=['POST'])
@jwt_required()
def addByName():
    title = request.json.get('title', 0)
    content = request.json.get('content', 0)
    userName = request.json.get('userName', '')
    if not all([userName,title, content]):
        return jsonify(code=Code.NOT_NULL.value, msg="参数不能为空")
    Article().addByName(userName,content, title)
    resData = {
        "code": 200,  # 非0即错误 1
        "data": 1,  # 数据位置，一般为数组
        "message": 'success'
    }
    return jsonify(resData)

