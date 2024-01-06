
import enum


class Code(enum.Enum):
    # 成功
    SUCCESS = 0
    # 获取信息失败
    SUCCEED_REQUEST_FAILED_RESULT = 1000
    #查询失败
    FIND_FAILED=2000
    #保存失败
    SAVE_FAILED=2001
    #删除失败
    DELETE_FAILED=2003
    #账户名重复
    DUPLICATE_NAME=2004
    #数据库异常
    DATABASE_EXCEPTION=4001
    #认证异常
    UNAUTHORIZED_EXCEPTION=4002
    #验证异常
    VIOLATION_EXCEPTION=4003
    # 504错误
    NOT_FOUND = 404
    # 500错误
    INTERNAL_ERROR = 500
    # 登录超时
    LOGIN_TIMEOUT = 50014
    # 无效token
    ERROR_TOKEN = 50008
    # 别的客户端登录
    OTHER_LOGIN = 50012
    # 权限不够
    ERR_PERMISSOM = 50013
    # 更新数据库失败
    UPDATE_DB_ERROR = 2002
    # 更新数据库失败
    CREATE_DB_ERROR = 1001
    # 更新数据库失败
    DELETE_DB_ERROR = 1002
    # 不能为空
    NOT_NULL = 1003
    # 缺少参数
    NO_PARAMETER = 1004
    # 用户密码错误
    ERR_PWD = 1005

    # 数据不存在
    ID_NOT_FOUND = 1006
    # 参数错误
    PARAMETER_ERROR = 1007
    # 文件不存在
    FILE_NO_FOUND = 1008
    # 无效的格式
    ERROR_FILE_TYPE = 1009
    # 超出文件限制
    OVER_SIZE = 1010
    # 上传失败
    UPLOAD_FAILD = 1011
