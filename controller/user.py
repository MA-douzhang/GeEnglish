from flask_jwt_extended import create_access_token, jwt_required
from controller import *
from utils.common import DUPLICATE_NAME, create_passwd, SAVE_FAILED, UPDATE_FAILED
from utils.code_enum import Code

user = Blueprint('user', __name__)

@user.route('/<int:id>', methods=['get'])
def getUserById(id):  # put application's code here
    if request.method == 'GET':
        user = User.query.filter_by(id=id).first()
        sql_data = {'id': user.id, 'name': user.name, 'email': user.email, 'avatar': user.avatar,
                    'password': user.password, 'todayWords': user.today_words, 'loginTime': user.login_time,
                    'registerTime': user.register_time}
        resData = {
            "resCode": 0,  # 非0即错误 1
            "data": sql_data,  # 数据位置，一般为数组
            "message": 'success'
        }
    return jsonify(resData)


@user.route('/token', methods=['POST'])
def login():
    name = request.json.get('name', None)
    password = request.json.get('password', None)
    if not all([name, password]):
        return jsonify(code=Code.NOT_NULL.value, msg="用户名和密码不能为空")
    try:
        user = User.query.filter_by(name=name).first()
    except Exception as e:
        app.logger.error("login error：{}".format(e))
        return jsonify(code=Code.SUCCEED_REQUEST_FAILED_RESULT.value, msg="获取信息失败")
    if user is None or not user.check_password(password):
        return jsonify(code=Code.ERR_PWD.value, msg="用户名或密码错误")
    access_token = create_access_token(identity=name)

    resData = {
        "resCode": 0,  # 非0即错误 1
        "data": {'name': name, 'token': access_token, 'email': user.email, 'avatar': user.avatar,
                 'todayWords': user.today_words,"todayReviewWords":user.today_review_words},  # 数据位置，一般为数组
        "message": 'success'
    }
    return jsonify(resData)


@user.route('', methods=['POST'])
def register():
    name = request.json.get('name', None)
    password = request.json.get('password', None)
    email = request.json.get('email', None)
    if not all([name, password]):
        return jsonify(code=Code.NOT_NULL.value, msg="用户名和密码不能为空")
    try:
        user = User.query.filter_by(name=name).first()
        if user:
            return DUPLICATE_NAME()
    except Exception as e:
        app.logger.error("login error：{}".format(e))
        return jsonify(code=Code.SUCCEED_REQUEST_FAILED_RESULT.value, msg="获取信息失败")
    try:
        model = User()
        model.name = name
        model.email = email
        model.password = create_passwd(password)
        model.save()
    except Exception as e:
        return SAVE_FAILED()

    access_token = create_access_token(identity=name)
    print("==> Create Account<{}> Id<{}>".format(model.name, model.id))
    resData = {
        "resCode": 0,  # 非0即错误 1
        "data": {'name': name, 'token': access_token, 'email': model.email},  # 数据位置，一般为数组
        "message": 'success'
    }
    return jsonify(resData)


@user.route('', methods=['Patch'])
@jwt_required()
def update():
    name = request.json.get('name', None)
    todayWords = request.json.get('todayWords', None)
    todayReviewWords = request.json.get('todayReviewWords', None)
    if not all([name, todayWords,todayReviewWords]):
        return jsonify(code=Code.NOT_NULL.value, msg="用户名和单词数量不能为空")
    try:
        user = User.query.filter_by(name=name).first()
        if not user:
            return DUPLICATE_NAME()
    except Exception as e:
        app.logger.error("login error：{}".format(e))
        return jsonify(code=Code.SUCCEED_REQUEST_FAILED_RESULT.value, msg="获取信息失败")
    try:
        model = User()
        model.id = user.id
        model.today_words = todayWords
        model.today_review_words= todayReviewWords
        model.update()
    except Exception as e:
        return UPDATE_FAILED()
    print("==> Create Account<{}> Id<{}>".format(model.name, model.id))
    resData = {
        "code": 200,  # 非0即错误 1
        "data": {},  # 数据位置，一般为数组
        "message": 'success'
    }
    return jsonify(resData)
