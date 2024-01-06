import hashlib

from flask import jsonify

from utils.code_enum import Code


def model_to_dict(result):
    '''
    查询结果转换为字典
    :param result:
    :return:
    '''
    from collections import Iterable
    # 转换完成后，删除  '_sa_instance_state' 特殊属性
    try:
        if isinstance(result, Iterable):
            tmp = [dict(zip(res.__dict__.keys(), res.__dict__.values())) for res in result]
            for t in tmp:
                t.pop('_sa_instance_state')
        else:
            tmp = dict(zip(result.__dict__.keys(), result.__dict__.values()))
            tmp.pop('_sa_instance_state')
        return tmp
    except BaseException as e:
        print(e.args)
        raise TypeError('Type error of parameter')


def construct_page_data(data):
    '''
    分页需要返回的数据
    :param data:
    :return:
    '''
    result = model_to_dict(data.items)
    data = {"hasNextPage": data.has_next,
            "hasPreviousPage": data.has_prev,
            "nextPage": data.next_num,
            "prePage": data.prev_num,
            "pageNum": data.page,  # 当前页数
            "pageSize": data.per_page,  # 每页显示的属性
            "pages": data.pages,  # 总共的页数
            "total": data.total,  # 查询返回的记录总数
            "isFirstPage": True if data.page == 1 else False,  # 是否第一页
            "isLastPage": False if data.has_next else True,  # 是否最后一页
            "list": result}
    return data

def construct_page_data_sql(data):
    '''
    分页需要返回的数据
    :param data:
    :return:
    '''
    data = {"hasNextPage": data.has_next,
            "hasPreviousPage": data.has_prev,
            "nextPage": data.next_num,
            "prePage": data.prev_num,
            "pageNum": data.page,  # 当前页数
            "pageSize": data.per_page,  # 每页显示的属性
            "pages": data.pages,  # 总共的页数
            "total": data.total,  # 查询返回的记录总数
            "isFirstPage": True if data.page == 1 else False,  # 是否第一页
            "isLastPage": False if data.has_next else True,  # 是否最后一页
            "list": data.items}
    return data


def SUCCESS(data=None):
    return jsonify(code=Code.SUCCESS.value, msg="ok", data=data)


def NO_PARAMETER(msg="未接收到参数!"):
    return jsonify(code=Code.NO_PARAMETER.value, msg=msg)


def PARAMETER_ERR(msg="参数错误!"):
    return jsonify(code=Code.NO_PARAMETER.value, msg=msg)


def OTHER_LOGIN(msg="其他客户端登录!"):
    return jsonify(code=Code.OTHER_LOGIN.value, msg=msg)


def AUTH_ERR(msg="身份验证失败!"):
    return jsonify(code=Code.ERROR_TOKEN.value, msg=msg)


def TOKEN_ERROR(msg="Token校验失败!"):
    return jsonify(code=Code.ERROR_TOKEN.value, msg=msg)


def REQUEST_ERROR(msg="请求失败!"):
    return jsonify(code=Code.SUCCEED_REQUEST_FAILED_RESULT.value, msg=msg)


def ID_NOT_FOUND(msg="数据不存在!"):
    return jsonify(code=Code.ID_NOT_FOUND.value, msg=msg)


def CREATE_ERROR(msg="创建失败!"):
    return jsonify(code=Code.CREATE_DB_ERROR.value, msg=msg)


def UPDATE_ERROR(msg="更新失败!"):
    return jsonify(code=Code.UPDATE_DB_ERROR.value, msg=msg)


def DELETE_ERROR(msg="删除失败"):
    return jsonify(code=Code.DELETE_DB_ERROR.value, msg=msg)


def FILE_NO_FOUND(msg="请选择文件!"):
    return jsonify(code=Code.FILE_NO_FOUND.value, msg=msg)


def ERROR_FILE_TYPE(msg="无效的格式!"):
    return jsonify(code=Code.ERROR_FILE_TYPE.value, msg=msg)


def UPLOAD_FAILD(msg="上传失败!"):
    return jsonify(code=Code.UPLOAD_FAILD.value, msg=msg)


def OVER_SIZE(msg="文件大小超出限制!"):
    return jsonify(code=Code.OVER_SIZE.value, msg=msg)


def SUCCEED_REQUEST_FAILED_RESULT(msg="成功请求，但结果不是期望的成功结果"):
    return jsonify(code=Code.SUCCEED_REQUEST_FAILED_RESULT.value, msg=msg)


def FIND_FAILED(msg="查询失败"):
    return jsonify(code=Code.FIND_FAILED.value, msg=msg)


def SAVE_FAILED(msg="保存失败"):
    return jsonify(code=Code.SAVE_FAILED.value, msg=msg)


def UPDATE_FAILED(msg="更新失败"):
    return jsonify(code=Code.UPDATE_FAILED.value, msg=msg)


def DELETE_FAILED(msg="删除失败"):
    return jsonify(code=Code.DELETE_FAILED.value, msg=msg)


def DUPLICATE_NAME(msg="账户名重复"):
    return jsonify(code=Code.DUPLICATE_NAME.value, msg=msg)


def DATABASE_EXCEPTION(msg="数据库异常"):
    return jsonify(code=Code.DATABASE_EXCEPTION.value, msg=msg)


def UNAUTHORIZED_EXCEPTION(msg="认证异常"):
    return jsonify(code=Code.UNAUTHORIZED_EXCEPTION.value, msg=msg)


def VIOLATION_EXCEPTION(msg="验证异常"):
    return jsonify(code=Code.VIOLATION_EXCEPTION.value, msg=msg)


def create_passwd(passwd):
    # 创建md5对象
    m = hashlib.md5()
    b = passwd.encode(encoding='utf-8')
    m.update(b)
    str_md5 = m.hexdigest()
    return str_md5
