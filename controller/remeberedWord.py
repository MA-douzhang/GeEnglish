from flask_jwt_extended import jwt_required
from sqlalchemy import and_, func

from controller import *
from models.remeberedWord import RemeberedWord
from models.word import Word
from utils.code_enum import Code
from utils.common import FIND_FAILED, UPDATE_FAILED, construct_page_data, construct_page_data_sql

remeberedWord = Blueprint('remeberedWord', __name__)


@remeberedWord.route('', methods=['POST'])
@jwt_required()
def add():
    userName = request.json.get('userName', None)
    wordId = int(request.json.get('wordId', None))
    if not all([userName, wordId]):
        return jsonify(code=Code.NOT_NULL.value, msg="参数不能为空")
    user = User.query.filter_by(name=userName).first()
    if not user:
        return FIND_FAILED

    remeberedWord = RemeberedWord()
    remeberedWord.user_id = user.id
    remeberedWord.word_id = wordId
    tmp = RemeberedWord.query.filter_by(user_id=int(user.id), word_id=wordId).first()
    if not tmp:
        remeberedWord.times = 1
        remeberedWord.remeber_time = func.now()
        remeberedWord.save()
    else:
        try:
            tmp.times += 1
            tmp.remeber_time = func.now()
            tmp.update()
        except Exception as e:
            return UPDATE_FAILED()
    resData = {
        "resCode": 200,  # 非0即错误 1
        "data": 1,  # 数据位置，一般为数组
        "message": 'success'
    }
    return jsonify(resData)


@remeberedWord.route('/user', methods=['GET'])
@jwt_required()
def getSelfData():
    page = int(request.args.get('page', 0))
    size = int(request.args.get('size', 0))
    userName = request.args.get('userName', '')
    if not all([userName, size, page]):
        return jsonify(code=Code.NOT_NULL.value, msg="参数不能为空")
    user = User.query.filter_by(name=userName).first()
    if not user:
        return FIND_FAILED

    wordList = RemeberedWord().query.join(Word, Word.id == RemeberedWord.word_id).filter(
        RemeberedWord.user_id == user.id).with_entities(Word.word,Word.translation,RemeberedWord.times).paginate(page=page,
                                                   per_page=size,
                                                   error_out=False)
    payload = []
    for result in wordList.items:
        content = {'word': result[0], 'translation': result[1], 'times': result[2]}
        payload.append(content)
    wordList.items=payload
    wordList = construct_page_data_sql(wordList)
    resData = {
        "resCode": 200,  # 非0即错误 1
        "data": wordList,  # 数据位置，一般为数组
        "message": 'success'
    }
    return jsonify(resData)


@remeberedWord.route('/review', methods=['GET'])
@jwt_required()
def getReview():
    limit = int(request.args.get('limit', 20))
    userName = request.args.get('userName', '')
    if not all([limit,userName]):
        return jsonify(code=Code.NOT_NULL.value, msg="参数不能为空")
    wordList = RemeberedWord().getReview(userName,limit)
    resData = {
        "resCode": 200,  # 非0即错误 1
        "data": wordList,  # 数据位置，一般为数组
        "message": 'success'
    }
    return jsonify(resData)

