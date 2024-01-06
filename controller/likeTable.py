from flask_jwt_extended import jwt_required
from controller import *
from models.article import Article
from models.likeTable import LikeTable
from models.word import Word
from utils.common import \
    construct_page_data, DELETE_FAILED
from utils.code_enum import Code

likeTable = Blueprint('likeTable', __name__)


@likeTable.route('/status', methods=['GET'])
@jwt_required()
def statusUserLike():
    userName = request.args.get('userName', "")
    id = int(request.args.get('id', 0))
    if not all([userName, id]):
        return jsonify(code=Code.NOT_NULL.value, msg="数量不能为空")
    likeTableId = LikeTable().fetchLikeStatus(id, userName)
    resData = {
        "resCode": 200,  # 非0即错误 1
        "data": likeTableId,  # 数据位置，一般为数组
        "message": 'success'
    }
    return jsonify(resData)


@likeTable.route('', methods=['POST'])
@jwt_required()
def add():
    userName = request.json.get('userName', '')
    id = int(request.json.get('id', 0))
    if not all([userName, id]):
        return jsonify(code=Code.NOT_NULL.value, msg="参数不能为空")
    LikeTable().addByName(userName, id)
    resData = {
        "code": 200,  # 非0即错误 1
        "data": 1,  # 数据位置，一般为数组
        "message": 'success'
    }
    return jsonify(resData)


@likeTable.route('<int:id>', methods=["DELETE"])
@jwt_required()
def delete(id):
    if not all([id]):
        return jsonify(code=Code.NOT_NULL.value, msg="参数不能为空")
    try:
        userLikes = LikeTable().query.filter_by(id=id).first()
        userLikes.delete()
    except Exception as e:
        return DELETE_FAILED()
    resData = {
        "code": 200,  # 非0即错误 1
        "data": 1,  # 数据位置，一般为数组
        "message": 'success'
    }
    return jsonify(resData)
