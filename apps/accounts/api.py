#coding: utf-8

"""
============================================================================
Author: Matt Hsu
LastChange: 2018-06-07
History:
        2018-06-07: add on duty api.
============================================================================
"""

from django.contrib.auth import authenticate

from tastypie.resources import ModelResource
from tastypie.authentication import ApiKeyAuthentication

from django.db.models import Q
from models import myUser,on_duty
import time
import json

def getOnDuty():
    bundles = []
    try:
        nowTime = time.strftime('%Y-%m',time.localtime(time.time()))
        onDutyList = on_duty.objects.filter((Q(start__contains=nowTime)|Q(end__contains=nowTime)))
        nowTime = int(time.strftime('%Y-%m-%d',time.localtime(time.time())).replace('-',''))
        for onDuty in onDutyList:
            startTime = int(onDuty.start.replace('-',''))
            endTime = int(onDuty.end.replace('-',''))
            if nowTime in range(startTime, endTime):
                bundles.append(onDuty.title)
            elif nowTime == startTime and nowTime == endTime:
                bundles.append(onDuty.title)
        if bundles:
            return {'code':1, 'message':bundles}
        else:
            return {'code':0, 'message':'Nobody on duty.'}
    except Exception as e:
        return {'code':0,'message':'API error.'}


class onDutyApi(ModelResource):
    class Meta:
        resource_name = 'onDuty'
        authentication = ApiKeyAuthentication()
        list_allowed_methods = ['get']
        detail_allowed_methods = ['get']

    def get_list(self,request,**kwargs):
        content = getOnDuty()
        return self.create_response(request, content)

    #def post_list(self, request,**kwargs):
    #    deserialized = self.deserialize(request, request.body, format=request.META.get('CONTENT_TYPE', 'application/json'))
    #    bundles = []
    #    try:
    #        nowTime = time.strftime('%Y-%m',time.localtime(time.time()))
    #        onDutyList = on_duty.objects.filter((Q(start__contains=nowTime)|Q(end__contains=nowTime)))
    #        nowTime = int(nowTime.replace('-',''))
    #        for onDuty in onDutyList:
    #            startTime = int(onDuty.start)
    #            endTime = int(onDuty.end)
    #            if nowTime in range(startTime, endTime):
    #                bundles.append(onDuty.title)
    #        content = {'code':1, 'message':bundles}
    #    except:
    #        content = {'code':0, 'message':startTime}
    #    return self.create_response(request, content)