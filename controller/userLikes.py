from flask_jwt_extended import jwt_required
from controller import *
from models.userLikes import UserLikes
from utils.common import \
     FIND_FAILED, SAVE_FAILED, DELETE_FAILED
from utils.code_enum import Code

userLikes = Blueprint('userLikes', __name__)


@userLikes.route('', methods=['POST'])
@jwt_required()
def add():
    userName = request.json.get('username', None)
    fromSentence = request.json.get('from', None)
    toSentence = request.json.get('to', None)
    if not all([userName, fromSentence, toSentence]):
        return jsonify(code=Code.NOT_NULL.value, msg="参数不能为空")
    user = User.query.filter_by(name=userName).first()
    if not user:
        return FIND_FAILED
    try:
        userLikes = UserLikes()
        userLikes.user_id = user.id
        userLikes.from_sentence = fromSentence
        userLikes.to_sentence = toSentence
        userLikes.save()
    except Exception as e:
        return SAVE_FAILED()
    resData = {
        "resCode": 200,  # 非0即错误 1
        "data": 1,  # 数据位置，一般为数组
        "message": 'success'
    }
    return jsonify(resData)


@userLikes.route('<int:id>', methods=["DELETE"])
@jwt_required()
def delete(id):
    # id = request.args.get('id')
    if not all([id]):
        return jsonify(code=Code.NOT_NULL.value, msg="参数不能为空")
    try:
        userLikes = UserLikes().query.filter_by(id=id).first()
        userLikes.delete()
    except Exception as e:
        return DELETE_FAILED()
    resData = {
        "code": 200,  # 非0即错误 1
        "data": 1,  # 数据位置，一般为数组
        "message": 'success'
    }
    return jsonify(resData)


@userLikes.route('/detail/<string:name>', methods=["GET"])
@jwt_required()
def starDetail(name):
    # name = request.args.get('name')
    if not all([name]):
        return jsonify(code=Code.NOT_NULL.value, msg="参数不能为空")
    try:
        user = User().query.filter_by(name=name).first()
    except Exception as e:
        return FIND_FAILED()
    userLikes = UserLikes().query.filter_by(user_id=user.id).all()
    payload = []
    for result in userLikes:
        content = {'id': result.id, 'fromSentence': result.from_sentence, 'toSentence': result.to_sentence,
                   "userId": result.user_id}
        payload.append(content)
    userLikes = payload
    resData = {
        "code": 200,  # 非0即错误 1
        "data": userLikes,  # 数据位置，一般为数组
        "message": 'success'
    }
    return jsonify(resData)
