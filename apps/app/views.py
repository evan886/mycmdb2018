#coding: utf-8
from django.shortcuts import render, render_to_response, get_object_or_404
from django.http import HttpResponseRedirect, HttpResponse
from django.template import RequestContext
from django.contrib.auth.decorators import login_required
from django.db.models import Q
from django.core.urlresolvers import reverse

from ..asset.models import service
from models import app, classify, app_association_app
from forms import appForm,classifyForm

from ..lib.lib import pages

import time
import json
# Create your views here.

@login_required
def get_service(request):
    '''获取服务'''
    keyword = request.GET.get('keyword')
    serviceList = service.objects.filter(Q(equipmentid__ip__contains=keyword),availabity='1')
    data = {'value': []}
    for s in serviceList:
        serviceInfo ='%s->%s' % (s.equipmentid.ip.split('/')[0],s)
        data['value'].append({'keyword':serviceInfo,'id':str(s.serviceid)})
    return HttpResponse(json.dumps(data), content_type="application/json")


@login_required
def get_tree(request):
    zNodes = []
    if request.method == 'POST':
        appID = request.POST.get('id')
        if appID:
            childList = app.objects.filter(parentid=appID,availabity=1)
            if childList:
                for child in childList:
                    isParent = app.objects.filter(parentid=child.uuid)
                    if isParent:
                        zNodes.append({'name':child.name,'fid':appID,'id':str(child.uuid),'open':False,'isParent':True})
                    else:
                        zNodes.append({'name':child.name,'fid':appID,'id':str(child.uuid),'open':False})
        else:
            appList = app.objects.filter(availabity=1,parentid=0)
            for appInfo in appList:
                isParent = app.objects.filter(parentid=appInfo.uuid,availabity=1)
                if isParent:
                    zNodes.append({'name':appInfo.name,'id':str(appInfo.uuid),'open':False,'isParent':True})
                else:
                    zNodes.append({'name':appInfo.name,'id':str(appInfo.uuid),'open':False,'isParent':False})
            zNodes = [{'name':'全部应用','id':0,'open':True,'isParent':True,'children':zNodes}]
        zNodes = json.dumps(zNodes)
        return HttpResponse(zNodes, content_type="application/json")

"""app 操作"""
@login_required
def app_add(request):
    """ 添加app """
    listOrAddTag = ['app','app','appAdd']
    af = appForm()

    childAppList = app.objects.filter(availabity=1)
    if request.method == 'POST':
        af = appForm(request.POST)
        if af.is_valid():
            _app = af.save(commit=False)
            parentID = request.GET.get('fatherID')
            if parentID:
                _app.parentid = parentID
                parentTree = app.objects.get(uuid=parentID)
                if parentTree.tree:
                    _app.tree = '%s,%s' % (parentTree.tree,parentID)
                else:
                    _app.tree = '%s' % (parentID)
            else:
                _app.parentid = 0
            _app.save()
            return HttpResponse(200)
        else:
            return HttpResponse(json.dumps(af.errors).decode('unicode_escape'))

    return render_to_response('app/app_add.html', locals(), context_instance=RequestContext(request))

@login_required
def app_list(request):
    '''应用列表'''
    listOrAddTag = ['app','app','appAdd']
    appList = app.objects.filter(availabity=1)
    if request.is_ajax():
        Get = request.GET
        keyword = Get.get('keyword')
        if keyword == 'None':
            keyword = ''
        if keyword:
            appList = appList.filter(Q(name__contains=keyword)|
                                     Q(another_name__contains=keyword)|
                                     Q(domain_name__contains=keyword)|
                                     Q(online_time__contains=keyword)|
                                     Q(yunwei__contains=keyword)|
                                     Q(developer__contains=keyword)|
                                     Q(comment__contains=keyword)
                                    )

            classifyList = classify.objects.filter(availabity=1).filter(Q(service__equipmentid__ip__contains=keyword) | 
                                                                        Q(service__equipmentid__ip1__contains=keyword) |
                                                                        Q(service__equipmentid__ip2__contains=keyword) |
                                                                        Q(service__equipmentid__ip3__contains=keyword) |
                                                                        Q(service__equipmentid__ip4__contains=keyword) |
                                                                        Q(service__equipmentid__ip5__contains=keyword) |
                                                                        Q(service__equipmentid__ip6__contains=keyword) |
                                                                        Q(service__equipmentid__ip7__contains=keyword) |
                                                                        Q(service__equipmentid__ip8__contains=keyword) |
                                                                        Q(service__equipmentid__ip9__contains=keyword)
                                                                        )
            appList = [a for a in appList]
            classifyList = [c.app for c in classifyList]
            appList.extend(classifyList)
            appList = list(set(appList))
        #分页功能
        ontact_list, p, contacts, page_range, current_page, show_first, show_end = pages(appList, request)
        s_url = '%s' % (request.get_full_path())
        if request.GET.get('target') == 'table':
            return render_to_response('app/app_list_table.html', locals(), context_instance=RequestContext(request))
        return render_to_response('app/app_search.html', locals(), context_instance=RequestContext(request))
    #分页功能
    ontact_list, p, contacts, page_range, current_page, show_first, show_end = pages(appList, request)
    s_url = '%s%s' % (request.get_full_path(),'?')
    return render_to_response('app/app_list.html', locals(), context_instance=RequestContext(request))

@login_required
def app_detail(request):
    '''应用详细信息'''
    appID = request.GET.get('id')
    classifyList = classify.objects.filter(app__uuid=appID,availabity=1)
    appInfo = get_object_or_404(app, uuid=appID, availabity=1)
    #associationApp = app_association_app.objects.filter(association_id=appInfo)
    associationApp = appInfo.association.all()
    associationAppClassify = classify.objects.filter(availabity=1,app__in=associationApp.values('app_id'))
    if request.is_ajax():
        if request.GET.get('target') == 'detail':
            return render_to_response('app/app_detail_content_detail.html', locals(), context_instance=RequestContext(request))
        return render_to_response('app/app_detail_content.html', locals(), context_instance=RequestContext(request))
    return render_to_response('app/app_detail.html', locals(), context_instance=RequestContext(request))

@login_required
def app_edit(request):
    '''修改应用信息'''
    appID = request.GET.get('id')
    appInfo = get_object_or_404(app, uuid=appID)
    af = appForm(instance=appInfo)
    if request.method == 'POST':
        af = appForm(request.POST, instance=appInfo)
        if af.is_valid():
            af.save()
            return HttpResponse(200)
        else:
            return HttpResponse(json.dumps(af.errors).decode('unicode_escape'))
    return render_to_response('app/app_edit.html', locals(), context_instance=RequestContext(request))

@login_required
def app_association(request):
    '''关联应用'''
    if request.method == 'POST':
        appid = request.GET.get('appid')
        appInfo = get_object_or_404(app,uuid=appid)
        associationID = request.POST.getlist('dataList[]')
        associationAppInfo = app.objects.filter(uuid__in=associationID)
        add = []
        for a in associationAppInfo:
            add.append(app_association_app(app_id=a,association_id=appInfo))
        try:
            app_association_app.objects.bulk_create(add)
        except Exception as e:
            return HttpResponse(json.dumps(str(e)))
        return HttpResponse(200)
    return render_to_response('app/app_association.html', locals(), context_instance=RequestContext(request))

@login_required
def app_association_remove(request):
    '''取消关联应用'''
    if request.method == 'POST':
        fid = request.GET.get('fid')
        fappInfo = get_object_or_404(app,uuid=fid)
        appid = request.GET.get('id')
        appInfo = get_object_or_404(app,uuid=appid)
        app_association_app.objects.get(app_id=appInfo,association_id=fappInfo).delete()
        return HttpResponse(200)

@login_required
def app_del(request):
    '''删除应用'''
    _id = request.GET.get('id')
    if request.POST:
        appInfo = app.objects.get(uuid=_id)
        association = appInfo.association_app.all()
        if association:
            associationAppName = [a.name for a in association]
            msg = u'此应用处于被关联状态,关联它的应用:%s' % (",".join(associationAppName))
            return HttpResponse(json.dumps(msg), content_type="application/json")
        
        childrenApp = app.objects.filter(parentid=_id,availabity=1)
        if childrenApp:
            msg = u'此应用下还有子应用!'
            return HttpResponse(json.dumps(msg), content_type="application/json")
        
        classifyInfo = classify.objects.filter(app_id=appInfo,availabity=1)
        if classifyInfo:
            msg = u'此应用下还存在分类信息!'
            return HttpResponse(json.dumps(msg), content_type="application/json")
        appInfo.availabity =int(time.time())
        appInfo.save()
        return HttpResponse(200)
    return HttpResponse(444)

"""app 操作结束"""

'''分类操作'''
@login_required
def classify_add(request):
    '''添加分类'''
    appID = request.GET.get('appid')
    appInfo = get_object_or_404(app, uuid=appID)
    if request.method == 'POST':
        try:
            sf = classifyForm(request.POST)
            if sf.is_valid():
                serviceID = request.POST.get('serviceid')
                if serviceID:
                    serviceInfo = service.objects.get(serviceid=serviceID)
                    zw = sf.save(commit=False)
                    zw.app = appInfo
                    zw.service = serviceInfo
                    zw.save()
                    return HttpResponse(200)
                else:
                    return HttpResponse('关联服务为必填项.')
            else:
                return HttpResponse(json.dumps(sf.errors).decode('unicode_escape'))
        except:
            return False
    else:
        sf = classifyForm()
        return render_to_response('app/classify_add.html',locals(),context_instance=RequestContext(request))

@login_required
def classify_edit(request):
    '''修改分类信息'''
    classifyID = request.GET.get('id')
    classifyInfo = get_object_or_404(classify,uuid=classifyID)
    appInfo = classifyInfo.app
    serviceList = service.objects.filter(availabity=1).exclude(serviceid=classifyInfo.service.serviceid)
    if request.method == 'POST':
        try:
            sf = classifyForm(request.POST, instance=classifyInfo)
            if sf.is_valid():
                serviceID = request.POST.get('serviceid')
                if serviceID:
                    serviceInfo = service.objects.get(serviceid=serviceID)
                    zw = sf.save(commit=False)
                    zw.app = appInfo
                    zw.service = serviceInfo
                    zw.save()
                    return HttpResponse(200)
                else:
                    return HttpResponse('关联服务为必填项.')
            else:
                return HttpResponse(json.dumps(sf.errors).decode('unicode_escape'))
        except:
            return False
    sf = classifyForm(instance=classifyInfo)
    return render_to_response('app/classify_edit.html',locals(),context_instance=RequestContext(request))

@login_required
def classify_del(request):
    '''删除分类'''
    try:
        _id = request.GET.get('uuid')
        classifyInfo = classify.objects.get(uuid=_id)
        classifyInfo.availabity=int(time.time())
        classifyInfo.save()
        return HttpResponse(200)
    except:
        return HttpResponse(False)

'''分类操作结束'''