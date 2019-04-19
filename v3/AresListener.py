import requests 
import datetime
import platform
from robot.libraries.BuiltIn import BuiltIn

class AresListener:

    ROBOT_LISTENER_API_VERSION = 3
    ROBOT_LIBRARY_SCOPE = "GLOBAL"

    def __init__(self):
        self.ROBOT_LIBRARY_LISTENER = self
        self.PRE_RUNNER = 0

    def start_suite(self, data, result):

        # set-up ARES session only once
        if self.PRE_RUNNER == 0:

            self.ARES_API_BASE_URI = BuiltIn().get_variable_value("${ARES_API_BASE_URI}")
            self.USER_TOKEN = BuiltIn().get_variable_value("${USER_TOKEN}")
            self.WORK_SPACE_NAME = BuiltIn().get_variable_value("${WORK_SPACE_NAME}")
            self.PROJECT_NAME = BuiltIn().get_variable_value("${PROJECT_NAME}")
            self.PROJECT_KEY = BuiltIn().get_variable_value("${PROJECT_KEY}")
            self.PRODUCT_NAME = BuiltIn().get_variable_value("${PRODUCT_NAME}")
            self.TEST_BROWSER = BuiltIn().get_variable_value("${TEST_BROWSER}")
            self.TEST_DEVICE = BuiltIn().get_variable_value("${TEST_DEVICE}")
            self.RUN_BY_USER = BuiltIn().get_variable_value("${RUN_BY_USER}")
            self.EXECUTION_MODE = BuiltIn().get_variable_value("${EXECUTION_MODE}")

            self.request_id = setup_ares_session(self.ARES_API_BASE_URI, self.USER_TOKEN, self.WORK_SPACE_NAME, self.PROJECT_NAME, "started")
            self.PRE_RUNNER = 1

        self.suite_name =  data.name
        self.test_count = len(data.tests)

        if self.test_count != 0:
            setup_suite_session(self.ARES_API_BASE_URI, self.USER_TOKEN, self.WORK_SPACE_NAME, self.PROJECT_NAME,
             self.request_id, self.suite_name, self.test_count, "started")

    def start_test(self, data, test):
        if self.test_count != 0:
            self.test_start_time = get_current_date_time('%Y-%m-%d %H:%M:%S.%f',True)

    def end_test(self, data, test):
        if self.test_count != 0:
            push_test_details(self.ARES_API_BASE_URI, self.USER_TOKEN, self.PROJECT_KEY, self.request_id, self.PROJECT_NAME,
             self.suite_name, test, test_status_helper(test.status), test.message, self.TEST_BROWSER, self.test_start_time,
             self.RUN_BY_USER, self.EXECUTION_MODE, self.TEST_DEVICE )

    def end_suite(self, data, suite):
        if self.test_count != 0:
            setup_suite_session(self.ARES_API_BASE_URI, self.USER_TOKEN, self.WORK_SPACE_NAME, self.PROJECT_NAME,
             self.request_id, self.suite_name, self.test_count, "started")

    def close(self):
        setup_ares_session(self.ARES_API_BASE_URI, self.USER_TOKEN, self.WORK_SPACE_NAME, self.PROJECT_NAME, "ended")


'''

# * # * # * # * Re-usable methods out of class * # * # * # * #

''' 

def setup_ares_session(uri, token, work_space, project, action):

    # setup payload
    raw_data = {
        "token":str(token),
        "ws_name":str(work_space),
        "project_name":str(project),
        "status":str(action)
    }

    # perform post
    session_request = requests.post(url = uri + "/createrunid" , data = raw_data)

    # convert post response to JSON
    request_response = session_request.json()

    # return newly request_id
    return  request_response['data'][0]['runId']

def setup_suite_session(uri, token, work_space, project, run_id, module_name, total_tests, action):
    # setup payload
    raw_data = {
        "token":str(token),
        "runId":str(run_id),
        "ws_name":str(work_space),
        "project_name":str(project),
        "module_name":str(module_name),
        "starttime":str(get_current_date_time('%Y-%m-%d %H:%M:%S.%f',True)),
        "totaltests":str(total_tests),
        "status":str(action)
    }

    # perform post
    session_request = requests.post(url = uri + "/addmoduledata" , data = raw_data)


def push_test_details(uri, token, project_key, run_id, project_name, module_name, test_case_title,
 test_status, fail_message, test_browser, start_time, run_user, execution_mode, device):
    # setup payload
    raw_data = {
        'graphData':{
            "runId":str(run_id),
            "productName":str(project_name),
            "moduleName":str(module_name),
            "testcaseTitle":str(test_case_title),
            "testStatus":str(test_status),
            "testData":"",
            "failStacktrace":str(fail_message),
            "testBrowser":str(test_browser),
            "testMachine":str(platform.uname()[1]),
            "imageLink":"",
            "videoLink":"",
            "testDevice":str(device),
            "testOs":str(platform.uname()[0]),
            "testDate":str(get_current_date_time('%Y-%m-%d',False)),
            "testStartTime":str(start_time),
            "testEndTime":str(get_current_date_time('%Y-%m-%d %H:%M:%S.%f',True)),
            "testSuite":str(module_name),
            "runBy":str(run_user),
            "errorMessage":str(fail_message),
            "executionMode":str(execution_mode),
            "failType":""
        }
    }

    headers = {
        "content-type": "application/json",
        "usertoken": str(token),
        "ProjectId": str(project_key)
    }

    # perform post
    session_request = requests.post(url = uri + "/addgraphdata" , json=raw_data, headers=headers)

def get_current_date_time(format,trim):
    t = datetime.datetime.now()
    if t.microsecond % 1000 >= 500:  # check if there will be rounding up
        t = t + datetime.timedelta(milliseconds=1)  # manually round up
    if trim:
        return t.strftime(format)[:-3]
    else:
        return t.strftime(format)

def test_status_helper(status):
    if status == 'PASS':
        return 'PASSED'
    else:
        return 'FAILED'