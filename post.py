#coding: utf-8
#api示例
import json
import urllib2
import re

def onDutyApi():
    user = 'onDutyApi'
    key = '6fc12fa544739f7931df11f4e3010b21c8115c84'
    post_url = 'http://127.0.0.1:8111/api/v1/onDuty/?username=%s&api_key=%s' % (user,key)
    headers = {'content-type': 'application/json'}

    post_data = {'level':1, 'group':'0001', 'message':'爆炸啦！！！！'}
    r = urllib2.Request(post_url, headers=headers, data=json.dumps(post_data))
    a = urllib2.urlopen(r).read()
    a = re.sub('"','',a)
    print a


if __name__ == '__main__':
    onDutyApi()