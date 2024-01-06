from flask_jwt_extended import jwt_required
from controller import *
from models.word import Word
from utils.common import \
    construct_page_data
from utils.code_enum import Code

word = Blueprint('word', __name__)


@word.route('/random', methods=['GET'])
@jwt_required()
def random():
    limit = request.args.get('limit', 20)
    if not all([limit]):
        return jsonify(code=Code.NOT_NULL.value, msg="数量不能为空")
    wordList = Word().randomSelect(limit)
    resData = {
        "resCode": 200,  # 非0即错误 1
        "data": wordList,  # 数据位置，一般为数组
        "message": 'success'
    }
    return jsonify(resData)


@word.route('/word', methods=['GET'])
@jwt_required()
def listByWord():
    page = int(request.args.get('page', 0))
    size = int(request.args.get('size', 0))
    word = request.args.get('word', '')
    if not all([page, size]):
        return jsonify(code=Code.NOT_NULL.value, msg="数量不能为空")

    wordList = Word().query.filter(Word.word.like("%" + word + "%") if word is not None else "").paginate(page=page,
                                                                                                          per_page=size,
                                                                                                          error_out=False)
    wordList = construct_page_data(wordList)
    resData = {
        "code": 200,  # 非0即错误 1
        "data": wordList,  # 数据位置，一般为数组
        "message": 'success'
    }
    return jsonify(resData)
