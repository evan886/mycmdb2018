#coding: utf-8
import sys

reload(sys)

sys.setdefaultencoding('utf8')
from django.shortcuts import render, render_to_response, get_object_or_404
from django.http import HttpResponseRedirect, HttpResponse
from django.template import RequestContext
from django.contrib.auth.decorators import login_required
from django.core import serializers
from django.views.decorators.csrf import csrf_exempt

from django.db.models import Q

from models import dataCenter, asset ,ASSET_TYPE, cabinet, service, assetRecord, ip_list, network_segment,network_segment_type_choices
#from project.models import app, appRole,app_roles,service,app_service

from forms import assetForm, idcForm, cabinetForm, serviceForm, ipForm, networkSegmentForm
from django.forms import modelformset_factory

from apps.lib.export_excel import ExcelResponse
from apps.lib.lib import pages,handle_uploaded_file

from ip_tool import exchange_maskint, network_segment_ip,get_network_segment

import time
import json
# Create your views here.

@login_required
def get_cabinet(request):
    '''获取机柜信息'''
    type = request.GET.get('type')
    if type:
        idcIdList = request.GET.getlist('idcIdList[]')
        cabinetList = []
        for idcId in idcIdList:
            cabinets = cabinet.objects.filter(dataCenter__uuid=idcId,availabity=1)
            cabinetList.extend(cabinets)
        if type == 'edit':
            return render_to_response('asset/ip_edit_cabinet.html', locals(), context_instance=RequestContext(request))
        else:
            return render_to_response('asset/ip_add_cabinet.html', locals(), context_instance=RequestContext(request))

    id = request.GET.get('idcid')
    data = serializers.serialize('json', cabinet.objects.filter(dataCenter__uuid=id, availabity='1'))
    return HttpResponse(data)

@login_required
def get_related(request):
    '''获取上联设备'''
    idcID = request.GET.get('idcid')
    data = serializers.serialize('json',asset.objects.filter(group__dataCenter__uuid=idcID,server_type=u'交换机',availabity='1'))
    return HttpResponse(data)

@login_required
def get_ip(request):
    '''获取IP'''
    idcID = request.GET.get('idcid')
    keyword = request.GET.get('keyword')
    if idcID:
        #data = ip_list.objects.filter(Q(ip__contains=keyword),idc__uuid=idcID,availabity='1').values('ip')
        #data = serializers.serialize('json',ip_list.objects.filter(Q(ip__contains=keyword),status=2,idc__uuid=idcID,availabity='1'))
        ipList = ip_list.objects.filter(Q(ip__contains=keyword),status=2,idc__uuid=idcID,availabity='1')
        data = []
        for i in ipList:
            ip ='%s/%s' % (i.ip,i.segment.segment.split('/')[1])
            data.append({'ip':ip})

    else:
        data=''
    return HttpResponse(json.dumps(data), content_type="application/json")

@login_required
def get_tree(request):
    zNodes = []
    idcList = dataCenter.objects.filter(availabity=1)
    for idc in idcList:
        cabinetList = cabinet.objects.filter(dataCenter=idc,availabity=1)
        idcChildren = []
        for c in cabinetList:
            assetList = asset.objects.filter(group=c,availabity=1)
            cabinetChildren = []
            for a in assetList:
                if a.ip:
                    ip = a.ip.split('/')[0]
                elif a.ip1:
                    ip = a.ip1.split('/')[0]
                else:
                    ip = a.name
                cabinetChildren.append({'name':ip,'id':str(a.equipmentid)})
            idcChildren.append({'name':c.name,'parentID':str(idc.uuid),'open':False,'id':str(c.uuid),'children':cabinetChildren})
        zNodes.append({'name':idc.name,'id':str(idc.uuid),'open':False,'children':idcChildren})
    zNodes = json.dumps(zNodes)
    return HttpResponse(zNodes, content_type="application/json")

def get_diff(obj1, obj2):
    fields = ['group', 'hosted']
    #no_check_fields = ['cpu', 'core_num', 'hard_disk', 'memory']
    old, now = obj1, dict(obj2.iterlists())
    info = {}
    for oldKey, oldValue in old.items():
        if oldKey in fields:
            if oldValue:
                oldValue = str(oldValue).replace('-','')
            else:
                oldValue = u''
        #elif k in no_check_fields:
        #    continue
        now_value = now[oldKey][0]
        if not oldValue:
            if oldValue==False:
                pass
            else:
                oldValue = u''
        if isinstance(oldValue,list):
            oldValue.sort()
            if not now_value:
                now_value = []
            now_value.sort()
            if oldValue != now_value:
                info.update({oldKey: [oldValue, now_value]})
        else:
            if str(oldValue) != str(now_value):
                info.update({oldKey: [oldValue, now_value]})

    for oldKey, oldValue in info.items():
        if oldValue == [None, u'']:
            info.pop(oldKey)
    return info

def db_to_record(username, host,group,info,serviceRecord=False, serviceInfo=None):
    text_list = []
    if serviceRecord:
        if serviceRecord == 'add':
            text = u'新增服务: %s' % serviceInfo
            text_list.append(text)
        if serviceRecord == 'edit':
            for k, v in info.items():
                field = service._meta.get_field_by_name(k)[0].verbose_name
                oldInfo = str(v[0])
                nowInfo = str(v[1])
                text = u'服务:%s %s 由 %s 更改为 %s' % (serviceInfo,field,oldInfo,nowInfo)
                text_list.append(text)
        if serviceRecord == 'del':
            text = u'删除服务: %s' % serviceInfo
            text_list.append(text)
    else:
        for k, v in info.items():
            field = asset._meta.get_field_by_name(k)[0].verbose_name
            oldInfo = str(v[0])
            nowInfo = str(v[1])
            if k == 'group':
                if oldInfo:
                    oldInfo = str(cabinet.objects.get(uuid=oldInfo))
                if nowInfo:
                    nowInfo = str(cabinet.objects.get(uuid=nowInfo))
            if k == 'hosted':
                if oldInfo:
                    oldInfo = str(asset.objects.get(equipmentid=oldInfo))
                if nowInfo:
                    nowInfo = str(asset.objects.get(equipmentid=nowInfo))
            if k == 'relatedid':
                if oldInfo:
                    oldInfo = str(asset.objects.get(equipmentid=oldInfo))
                if nowInfo:
                    nowInfo = str(asset.objects.get(equipmentid=nowInfo))
            #text = field + u'由 ' + oldInfo + u' 更改为 ' + str(v[1])
            text = u'%s由 %s 更改为 %s' % (field,oldInfo,nowInfo)

            '''修改IP状态'''
            ipNumber = ['IP','IP1','IP2','IP3','IP4','IP5','IP6','IP7','IP8','IP9','ILO地址']
            if field in ipNumber:
                if nowInfo:
                    ip = nowInfo
                    idc = group.dataCenter
                    networkSegment = get_network_segment(ip)
                    segmentInfo = network_segment.objects.filter(segment=networkSegment,idc=idc,availabity=1)
                    if segmentInfo:
                        ipInfo = ip_list.objects.filter(ip=ip.split('/')[0],segment__segment=networkSegment ,availabity=1)
                        if ipInfo:
                            if ipInfo[0].status != 2:
                                emg = u'%s, 该IP已被使用.' % ipInfo[0].ip
                                return emg
                            ipInfo.update(status=1,idc=idc,group=group,host=host)
                        else:
                            netmask = exchange_maskint(int(ip.split('/')[1]))
                            ip_list(segment=segmentInfo[0],ip=ip.split('/')[0],netmask=netmask,status=1,type=1,idc=idc,group=group,host=host).save()
                    else:
                        emg = u'所选机房没有%s 该网段信息,请先添加网段.' % networkSegment
                        return emg
                if oldInfo:
                    ip = oldInfo.split('/')[0]
                    ipInfo = ip_list.objects.get(ip=ip,availabity=1)
                    ipInfo.host = None
                    ipInfo.status = 2
                    ipInfo.save()

            ''''''
            
            text_list.append(text)
    if len(text_list) != 0:
        assetRecord.objects.create(asset=host, user=username, content=text_list)
    return 0

"""asset 操作"""
@login_required
def asset_add(request):
    """ 添加主机 """
    listOrAddTag = ['asset','asset', 'assetAdd']
    if request.GET.get('idcid'):
        idcID = request.GET.get('idcid')
        electIDC = dataCenter.objects.get(uuid=idcID)
        idcList = dataCenter.objects.filter(availabity=1).exclude(uuid=idcID)
        cabinetInfo = cabinet.objects.filter(dataCenter__uuid=idcID)
        related = asset.objects.filter(group__dataCenter__uuid=idcID,server_type=u'交换机',availabity='1')
    else:
        idcList = dataCenter.objects.filter(availabity=1)
    if request.GET.get('cabinetid') and request.GET.get('cabinetid') != 'None':
        cabinetID = request.GET.get('cabinetid')
        electCabinet = cabinet.objects.get(uuid=cabinetID)
        cabinetInfo = cabinet.objects.filter(dataCenter__uuid=idcID,availabity=1).exclude(uuid=cabinetID)
    af = assetForm()

    hostedList = asset.objects.filter(server_type='HOST',availabity=1)

    if request.method == 'POST':
        af = assetForm(request.POST)
        ip = request.POST.get('ip')
        if asset.objects.filter(ip=ip, availabity=1):
            emg = u'添加失败, 该IP %s 已存在!' % ip
        #af.is_valid()
        #zw = af.save(commit=False)
        elif af.is_valid():
            '''IP地址操作'''
            groupID = request.POST.get('group')
            group = cabinet.objects.get(uuid=groupID)
            idc = group.dataCenter
            for i in range(11):
                if i != 0:
                    ip = request.POST.get('ip%s' % i)
                if i == 10:
                    ip = request.POST.get('ilo')
                if ip:
                    networkSegment = get_network_segment(ip)
                    segmentInfo = network_segment.objects.filter(segment=networkSegment,idc=idc,availabity=1)
                    if segmentInfo:
                        ipInfo = ip_list.objects.filter(ip=ip.split('/')[0],segment__segment=networkSegment ,availabity=1)
                        if ipInfo:
                            if ipInfo[0].status != 2:
                                emg = u'%s, 该IP已被使用.' % ipInfo[0].ip
                                return HttpResponse(emg)
                            ipInfo.update(status=1,idc=idc,group=group,host=af.save())
                        else:
                            netmask = exchange_maskint(int(ip.split('/')[1]))
                            ip_list(segment=segmentInfo[0],ip=ip.split('/')[0],netmask=netmask,status=1,type=1,idc=idc,group=group,host=af.save()).save()
                    else:
                        emg = u'所选机房没有%s 该网段信息,请先添加网段.' % networkSegment
                        return HttpResponse(emg)
            ''''''

            af.save()
            emg = 200
        #zw = af.save(commit=False)
        return HttpResponse(emg)
    return render_to_response('asset/host_add.html', locals(), context_instance=RequestContext(request))

def updateFromExcel(request):
    #'''从Excel批量导入'''
    if request.method == "POST":


        _results = []
        file = request.FILES.get("file")
        _r = handle_uploaded_file(f=file)
        if not _r:
            return HttpResponse(404)

        file = _r

        import xlrd
        import sys
        
        from datetime import date,datetime
        
        #from xlrd import xldate_as_tuple
        
        #def read_excel():
        
        #文件位置
        
        ExcelFile=xlrd.open_workbook(file)
        
        #获取目标EXCEL文件sheet名
        
        #print ExcelFile.sheet_names()
        sheet2_name=ExcelFile.sheet_names()[0]
        #print sheet2_name
        sheet=ExcelFile.sheet_by_name(sheet2_name)
        #print sheet.name,sheet.nrows,sheet.ncols
        rows=sheet.row_values(0)#第三行内容
        cols=sheet.col_values(1)#第二列内容
        
        for i in range(2,sheet.nrows):
            data = sheet.row_values(i)
            server_type = data[5]
            #if server_type == 'VM':
            if True:
                idcName = data[0]
                groupName = data[1].split('/')[0]
                group_place = data[1].split('/')[1]

                sn = data[2]
                #print sn
                name = data[3]
                server = data[4]
                server_type = data[5]

                hosted = data[6]
                if hosted:

                    hosted = asset.objects.get(sn=hosted,availabity=1)

                else:
                    hosted = None
                status = int(data[7])
                cpu = data[8]
                if isinstance(cpu, float):
                    cpu = int(cpu)
                hard_disk = data[9]
                memory = int(data[10])
                ip = data[11]
                ip1 = data[12]
                ip2 = data[13]
                ip3 = data[14]
                ilo = data[15]
                port = int(data[16])
                use = data[17]
                brand = data[18]
                buy = data[19]
                if not buy:
                    buy = None
                else:
                    buy= int(buy)
            
                contract_start_time = data[20]
                if contract_start_time:
                    date = datetime(*xlrd.xldate_as_tuple(contract_start_time, 0))
                    contract_start_time = date.strftime('%Y/%m/%d')
            
                contract_end_time = data[21]
                if contract_end_time:
                    date = datetime(*xlrd.xldate_as_tuple(contract_end_time, 0))
                    contract_end_time = date.strftime('%Y/%m/%d')
            
                server_code = data[22]
                if isinstance(server_code, float):
                    server_code = int(server_code)
                comment = data[23]
                
                idc = dataCenter.objects.filter(name=idcName,availabity=1)
                if not idc:
                    dataCenter(name=idcName).save()
                    idc = dataCenter.objects.get(name=idcName,availabity=1)
                else:
                    idc = idc[0]
                group = cabinet.objects.filter(dataCenter=idc,name=groupName,availabity=1)
                if not group:
                    cabinet(dataCenter=idc,name=groupName).save()
                    group = cabinet.objects.get(dataCenter=idc,name=groupName,availabity=1)
                else:
                    group = group[0]
        
                #print 'group=%s' % group
                #print 'group_place=%s' % group_place
                #print 'sn=%s' % sn
                #print 'name=%s' % name
                #print 'server=%s' % server
                #print 'server_type=%s' % server_type
                #print 'hosted=%s' % hosted
                #print 'status=%s' % status
                #print 'cpu=%s' % cpu
                #print 'hard_disk=%s' % hard_disk
                #print 'memory=%s' % memory
                #print 'ip=%s' % ip
                #print 'ip1=%s' % ip1
                #print 'ip2=%s' % ip2
                #print 'ip3=%s' % ip3
                #print 'ilo=%s' % ilo
                #print 'port=%s' % port
                #print 'use=%s' % use
                #print 'brand=%s' % brand
                #print 'buy=%s' % buy
                #print 'contract_start_time=%s' % contract_start_time
                #print 'contract_end_time=%s' % contract_end_time
                #print 'server_code=%s' % server_code
                #print 'comment=%s' % comment
                host = asset.objects.filter(group=group,group_place=group_place,sn=sn,name=name,availabity=1)
                if not host:
                    asset(group=group,group_place=group_place,sn=sn,name=name,
                        server=server,server_type=server_type,hosted=hosted,
                        status=status,cpu=cpu,hard_disk=hard_disk,memory=memory,
                        ip=ip,ip1=ip1,ip2=ip2,ip3=ip3,ilo=ilo,port=port,use=use,
                        brand=brand,buy=buy,contract_start_time=contract_start_time,
                        contract_end_time=contract_end_time,server_code=server_code,comment=comment).save()
        
                    host = asset.objects.filter(group=group,group_place=group_place,sn=sn,name=name,
                        server=server,server_type=server_type,hosted=hosted,
                        status=status,cpu=cpu,hard_disk=hard_disk,memory=memory,
                        ip=ip,ip1=ip1,ip2=ip2,ip3=ip3,ilo=ilo,port=port,use=use,
                        brand=brand,buy=buy,contract_start_time=contract_start_time,
                        contract_end_time=contract_end_time,server_code=server_code,comment=comment,availabity=1)[0]
                    def updateIP(ip,nstype,iptype):
                        if ip:
                            networkSegment = get_network_segment(ip)
                            segmentInfo = network_segment.objects.filter(segment=networkSegment,availabity=1)
                            if segmentInfo:
                                segmentInfo = segmentInfo[0]
                                segmentInfo.idc.add(idc)
                                segmentInfo.save()
                                segmentInfo = network_segment.objects.get(segment=networkSegment,idc=idc,availabity=1)
                            else:
                                ns = network_segment(segment=networkSegment,type=nstype,status=1,auto=False).save()
                                ns = network_segment.objects.get(segment=networkSegment,availabity=1)
                                ns.idc.add(idc)
                                ns.save()
                                segmentInfo = network_segment.objects.get(segment=networkSegment,idc=idc,availabity=1)

                            ipInfo = ip_list.objects.filter(ip=ip.split('/')[0],segment__segment=networkSegment ,availabity=1)
                            if ipInfo:
                                ipInfo.update(status=1,idc=idc,group=group,host=host)
                            else:
                                netmask = exchange_maskint(int(ip.split('/')[1]))
                                ip_list(segment=segmentInfo,ip=ip.split('/')[0],netmask=netmask,status=1,type=iptype,idc=idc,group=group,host=host).save()
                    updateIP(ip,1,1)
                    updateIP(ip1,2,1)
                    updateIP(ip2,2,3)
                    updateIP(ip3,2,1)
                    updateIP(ilo,2,1)
                response = {"code": 0,"msg": "上传成功."} 
        return HttpResponse(json.dumps(response), content_type="application/json")
                    #''''''
    return render_to_response('asset/update_from_excel.html', locals(), context_instance=RequestContext(request))

@login_required
def asset_list(request):
    listOrAddTag = ['asset','asset', 'assetAdd']
    assets = asset.objects.filter(availabity=1)
    idcs = dataCenter.objects.filter(availabity=1)
    serverList = assets.all().values('server')
    servers = []
    for server in serverList:
        if server['server'] not in servers:
            servers.append(server['server'])
    serverCount = len(assets)



    if request.GET.get('download'):
        data = serializers.serialize('json',assets,use_natural_foreign_keys=True, use_natural_primary_keys=True)
        data = json.loads(data)

        data = [[d['fields'] for d in data]]
        #print data
        headers = [[h for h in data[0][0]]]
        #print headers
        sheet_name=[u'asset']
        return ExcelResponse(data, output_name=u'data', headers=headers, is_template=False, sheet_name=sheet_name)

    if request.is_ajax():
        changeIdc = request.GET.get('change_idc')
        changeCabinet = request.GET.get('change_cabinet')
        listOrAddTag.append('?idcid=%s&cabinetid=%s' % (changeIdc,changeCabinet))
        keyword = request.GET.get('keyword')
        if changeIdc and changeIdc != 'None':
            if changeCabinet and changeCabinet != 'None':
                assets = assets.filter(group__dataCenter__uuid=changeIdc,group__uuid=changeCabinet)
            else:
                assets = assets.filter(group__dataCenter__uuid=changeIdc)

        select = request.GET.get('select')
        if select and select != 'None':
            selectList = select.split(',')
            selectDict = {}
            for s in selectList:
                s = s.split(':')
                if selectDict.has_key(s[0]):
                    selectDict[s[0]].append(s[1])
                else:
                    selectDict[s[0]] = [s[1]]
            for k,v in selectDict.items():
                if k == 'status':
                    assets = assets.filter(status__in=v)
                if k == 'type':
                    assets = assets.filter(server_type__in=v)
                if k == 'buy':
                    assets = assets.filter(buy__in=v)
                if k == 'server':
                    assets = assets.filter(server__in=v)

        if keyword:
            try:
                assets = assets.filter(Q(equipmentid__contains=keyword) |
                                       Q(group__dataCenter__name__contains=keyword) |
                                       Q(group__name__contains=keyword) |
                                       Q(sn__contains=keyword) |
                                       Q(name__contains=keyword) |
                                       Q(cpu__contains=keyword) |
                                       Q(hard_disk__contains=keyword) |
                                       Q(memory__contains=keyword) |
                                       Q(ip__contains=keyword) |
                                       Q(ip1__contains=keyword) |
                                       Q(ip2__contains=keyword) |
                                       Q(ip3__contains=keyword) |
                                       Q(ip4__contains=keyword) |
                                       Q(ip5__contains=keyword) |
                                       Q(ip6__contains=keyword) |
                                       Q(ip7__contains=keyword) |
                                       Q(ip8__contains=keyword) |
                                       Q(ip9__contains=keyword) |
                                       Q(ilo__contains=keyword) |
                                       Q(port__contains=keyword)|
                                       Q(comment__contains=keyword))
            except:
                assets = ''
        serverCount = len(assets)
        assets = list(set(assets))
        s_url = request.get_full_path()
        #分页功能
        ontact_list, p, contacts, page_range, current_page, show_first, show_end = pages(assets, request)
        #if request.is_ajax():
        if request.GET.get('target') == 'table':
            s_url = '%s' % (request.get_full_path())
            return render_to_response('asset/host_list_table.html', locals(), context_instance=RequestContext(request))
        return render_to_response('asset/host_search.html', locals(), context_instance=RequestContext(request))

    else:
        s_url = '%s%s' % (request.get_full_path(),'?')
        #分页功能
        ontact_list, p, contacts, page_range, current_page, show_first, show_end = pages(assets, request)
    return render_to_response('asset/host_list.html', locals(), context_instance=RequestContext(request))

@login_required
def asset_edit(request):
    '''修改主机信息'''
    hostID = request.GET.get('id')
    host = get_object_or_404(asset, equipmentid=hostID, availabity=1)
    serviceList = service.objects.filter(equipmentid=host,availabity=1)
    hostedList = asset.objects.filter(server_type='ALONE',availabity=1)
    af = assetForm(instance=host)

    '''idc列表'''
    idc = dataCenter.objects.filter(availabity=1).exclude(uuid=host.group.dataCenter.uuid)

    '''机柜列表'''
    cabinetList = cabinet.objects.filter(dataCenter=host.group.dataCenter,availabity=1).exclude(uuid=host.group.uuid)

    '''上联设备'''
    if host.relatedid:
        hostRelated = asset.objects.get(equipmentid=host.relatedid)
        relatedList = asset.objects.filter(group__dataCenter=host.group.dataCenter, server_type=u'交换机',availabity=1).exclude(equipmentid=host.relatedid)
    else:
        relatedList = asset.objects.filter(group__dataCenter=host.group.dataCenter, server_type=u'交换机',availabity=1)

    if request.method == 'POST':
        af = assetForm(request.POST, instance=host)
        if af.is_valid():
            info = get_diff(af.__dict__.get('initial'), request.POST)
            if info:
                username = request.user.username
                group = cabinet.objects.get(uuid=request.POST.get('group'))
                emg = db_to_record(username,host,group,info)
                if emg:
                    return HttpResponse(emg)
            zw = af.save()
            return HttpResponse(200)
        else:
            emg = json.dumps(af.errors).decode('unicode_escape')
            
    return render_to_response('asset/host_edit.html', locals(), context_instance=RequestContext(request))

@login_required
def asset_detail(request):
    '''主机详细信息'''
    _id = request.GET.get('id')
    serviceList = service.objects.filter(equipmentid__equipmentid=_id,availabity=1)
    host = get_object_or_404(asset, equipmentid=_id, availabity=1)
    if host.relatedid:
        hostRelated = asset.objects.get(equipmentid=host.relatedid)
    asset_record = assetRecord.objects.filter(asset=host).order_by('-time')

    if request.is_ajax():
        return render_to_response('asset/host_detail_content.html', locals(), context_instance=RequestContext(request))
    return render_to_response('asset/host_detail.html', locals(), context_instance=RequestContext(request))

@login_required
def asset_del(request):
    '''删除主机'''
    _id = request.GET.get('id')
    #host = asset.objects.filter(equipmentid=_id)
    #host.update(availabity=int(time.time()))
    host = asset.objects.get(equipmentid=_id)
    if host.server_type == u'交换机':
        if asset.objects.filter(relatedid=host.equipmentid,availabity=1):
            msg = u'该设备为交换机,且还存在下联设备.'
            return HttpResponse(json.dumps(msg))
    elif host.server_type == u'HOST':
        if asset.objects.filter(hosted=host,availabity=1):
            msg = u'该设备为还存在子设备.'
            return HttpResponse(json.dumps(msg))
    hostService = service.objects.filter(equipmentid=host,availabity=1)
    if hostService:
        #msg = u'该设备下还存在服务.'
        #return HttpResponse(json.dumps(msg))
        if request.POST.get('delete_service'):
            hostService.update(availabity = int(time.time()))
        else:
            return HttpResponse(300)
    ip_list.objects.filter(host=host,availabity=1).update(status=2)
    host.availabity = int(time.time())
    host.save()
    return HttpResponse(200)
    
@login_required
def service_add(request):
    '''添加服务'''
    assetID = request.GET.get('assetid')
    assetInfo = get_object_or_404(asset, equipmentid=assetID)
    if request.method == 'POST':
        try:
            sf = serviceForm(request.POST)
            if sf.is_valid():
                zw = sf.save(commit=False)
                zw.equipmentid = assetInfo
                zw.save()
                #serviceID = sf.cleaned_data['serviceid']
                #serviceInfo = service.objects.get(serviceid=serviceID)
                #m2 = service_relevance(equipmentid=assetInfo,serviceid=serviceInfo)
                #m2.save()
                username = request.user.username
                db_to_record(username,assetInfo,'','','add',str(zw))
                return HttpResponse(200)
            else:
                return HttpResponse(json.dumps(sf.errors).decode('unicode_escape'))
        except:
            return False
    else:
        sf = serviceForm()
        return render_to_response('asset/service_add.html',locals(),context_instance=RequestContext(request))

@login_required
def service_edit(request):
    '''修改服务信息'''
    assetID = request.GET.get('assetid')
    serviceID = request.GET.get('id')
    assetInfo = get_object_or_404(asset, equipmentid=assetID)
    serviceInfo = get_object_or_404(service,serviceid=serviceID)
    if request.method == 'POST':
        try:
            sf = serviceForm(request.POST,instance=serviceInfo)
            if sf.is_valid():
                zw = sf.save(commit=False)
                zw.save()
                info = get_diff(sf.__dict__.get('initial'), request.POST)
                if info:
                    username = request.user.username
                    db_to_record(username,assetInfo,'',info,'edit',str(zw))
                return HttpResponse(200)
            else:
                return HttpResponse(json.dumps(sf.errors).decode('unicode_escape'))
        except:
            return False
    sf = serviceForm(instance=serviceInfo)
    return render_to_response('asset/service_edit.html',locals(),context_instance=RequestContext(request))

@login_required
def service_del(request):
    '''删除服务'''
    try:
        _id = request.GET.get('uuid')
        serviceInfo = service.objects.filter(serviceid=_id)
        serviceInfo.update(availabity=int(time.time()))
        username = request.user.username
        assetInfo = serviceInfo[0].equipmentid
        db_to_record(username,assetInfo,'','','del',str(serviceInfo[0]))
        return HttpResponse(200)
    except:
        return HttpResponse(False)


"""asset 操作结束"""


"""dataCenter 操作"""
@login_required
def idc_add(request):
    """ 添加IDC """
    listOrAddTag = ['idc','asset','idcAdd']
    if request.method == 'POST':
        uf = idcForm(request.POST)
        if uf.is_valid():
            uf.save()
            return HttpResponseRedirect('/asset/idcList/')
        else:
            emg = json.dumps(uf.errors).decode('unicode_escape')
            return render_to_response('asset/idc_add.html', locals(), context_instance=RequestContext(request))

    else:
        uf = idcForm()
    return render_to_response('asset/idc_add.html', locals(), context_instance=RequestContext(request))

@login_required
def cabinet_add(request):
    '''添加机柜'''
    idcID = request.GET.get('id')
    idc = get_object_or_404(dataCenter, uuid=idcID)
    if request.method == 'POST':
        try:
            cf = cabinetForm(request.POST)
            if cf.is_valid():
                zw = cf.save(commit=False)
                zw.dataCenter = idc
                zw.save()
                return HttpResponse(200)
        except:
            return False
    else:
        cf = cabinetForm()
        return render_to_response('asset/cabinet_add.html',locals(),context_instance=RequestContext(request))

@login_required
def cabinet_edit(request):
    '''修改机柜信息'''
    idcID = request.GET.get('idcid')
    cabinetID = request.GET.get('id')
    idc = get_object_or_404(dataCenter, uuid=idcID)
    cabinetInfo = get_object_or_404(cabinet,uuid=cabinetID)
    if request.method == 'POST':
        try:
            cf = cabinetForm(request.POST,instance=cabinetInfo)
            if cf.is_valid():
                zw = cf.save(commit=False)
                zw.dataCenter = idc
                zw.save()
                return HttpResponse(200)
            else:
                return HttpResponse(json.dumps(cf.errors).decode('unicode_escape'))
        except Exception as e:
            return False
    cf = cabinetForm(instance=cabinetInfo)
    return render_to_response('asset/cabinet_edit.html',locals(),context_instance=RequestContext(request))

@login_required
def cabinet_del(request):
    '''删除机柜'''
    _id = request.GET.get('uuid')
    #host = asset.objects.filter(equipmentid=_id)
    #host.update(availabity=int(time.time()))
    cabinetInfo = cabinet.objects.get(uuid=_id)
    if asset.objects.filter(group=cabinetInfo,availabity=1):
        msg = u'该机柜下还存在服务器.'
        return HttpResponse(json.dumps(msg))
    cabinetInfo.availabity = int(time.time())
    cabinetInfo.save()
    return HttpResponse(200)

@login_required
def idc_list(request):
    '''数据中心列表'''
    listOrAddTag = ['idc','asset','idcAdd']
    idcs = dataCenter.objects.filter(availabity=1)
    #server_type = Project.objects.all()
    return render_to_response('asset/idc_list.html', locals(), context_instance=RequestContext(request))

@login_required
def idc_edit(request):
    '''修改数据中心信息'''
    idcID = request.GET.get('id')
    idc = get_object_or_404(dataCenter, uuid=idcID)
    idcCabinet = cabinet.objects.filter(dataCenter=idcID,availabity=1)
    uf = idcForm(instance=idc)
    if request.method == 'POST':
        uf = idcForm(request.POST, instance=idc)
        if uf.is_valid():
            uf.save()
            return HttpResponseRedirect('/asset/idcList/')
        else:
            emg = json.dumps(uf.errors).decode('unicode_escape')
    return render_to_response('asset/idc_edit.html', locals(), context_instance=RequestContext(request))

@login_required
def idc_del(request):
    '''删除数据中心'''
    _id = request.GET.get('id')
    if request.POST:
        idc = dataCenter.objects.filter(uuid=_id)
        if cabinet.objects.filter(dataCenter=idc,availabity=1):
            msg = u'该机房下还存在机柜.'
            return HttpResponse(json.dumps(msg))
        idc.update(availabity=int(time.time()))
        return HttpResponse(200)
"""dataCenter 操作结束"""

@login_required
def get_netmask(request):
    '''获取子网掩码'''
    if request.method == 'POST':
        segment = request.POST.get('segment')
        segmentNumber = int(segment.split('/')[1])
        return HttpResponse(json.dumps(exchange_maskint(segmentNumber)))


@login_required
def getIdcFromSegment(request):
    '''通过网段获取IDC'''
    segmentID = request.GET.get('segmentid')
    segmentInfo = get_object_or_404(network_segment,uuid=segmentID)
    data = serializers.serialize('json',segmentInfo.idc.all())
    return HttpResponse(data)


'''IP管理'''

@login_required
def getIpTree(request):
    if request.method == 'POST':
        zNodes = []
        segmentID = request.POST.get('id')
        if segmentID:
            ipList = ip_list.objects.filter(segment=segmentID,availabity=1) #第三层IP
            three = []
            for a in ipList:
                zNodes.append({'name':'%s   %s' % (a.ip,a.group),'id':str(a.uuid)})
        else:
            for nsType in network_segment_type_choices:
                one = nsType[1]   #第一层
                two = []
                nsList = network_segment.objects.filter(type=nsType[0],availabity=1) #第二层网段
                for c in nsList:
                    two.append({'name':'%s' % (c.segment),'parentID':nsType[0],'open':False,'id':str(c.uuid),'isParent':True})
                zNodes.append({'name':one,'id':0,'open':False,'children':two})
    zNodes = json.dumps(zNodes)
    return HttpResponse(zNodes, content_type="application/json")

@login_required
def IP_list(request):
    '''IP列表'''
    listOrAddTag = ['ip','asset','networkSegment']

    ipList = ip_list.objects.filter(availabity=1)
    if request.is_ajax():
        #changetype = request.GET.get('change_type')
        change_ns = request.GET.get('change_ns')
        listOrAddTag.append('?nsid=%s' % change_ns)
        keyword = request.GET.get('keyword')
        if change_ns and change_ns != 'None':
            change_idc = request.GET.get('change_idc')
            if change_idc and change_idc != 'null':
                ipList = ipList.filter(segment__uuid=change_ns,idc__uuid=change_idc)
            else:
                ipList = ipList.filter(segment__uuid=change_ns)
        status = request.GET.get('status')
        if status:
            ipList = ipList.filter(status=int(status))

        iptype = request.GET.get('type')
        if iptype:
            ipList = ipList.filter(type=int(iptype))
        if keyword:
            try:
                ipList = ipList.filter(Q(segment__segment__contains=keyword)|
                                       Q(ip__contains=keyword)|
                                       Q(netmask__contains=keyword)|
                                       Q(status__contains=keyword)|
                                       Q(type__contains=keyword)|
                                       Q(idc__name__contains=keyword)|
                                       Q(group__name__contains=keyword)|
                                       Q(linkman__contains=keyword)|
                                       Q(comment__contains=keyword))
            except:
                ipList = ''

        s_url = request.get_full_path()
        #分页功能
        ontact_list, p, contacts, page_range, current_page, show_first, show_end = pages(ipList, request)
        if request.GET.get('target') == 'table':
            return render_to_response('asset/ip_list_table.html', locals(), context_instance=RequestContext(request))
        return render_to_response('asset/ip_search.html', locals(), context_instance=RequestContext(request))
    else:
    #分页功能
        s_url = '%s%s' % (request.get_full_path(),'?')
        ontact_list, p, contacts, page_range, current_page, show_first, show_end = pages(ipList, request)

        return render_to_response('asset/ip_list.html', locals(), context_instance=RequestContext(request))

@login_required
def ip_add(request):
    '''IP添加'''
    listOrAddTag = ['ip','asset','ipAdd']
    af = ipForm()
    idcList = dataCenter.objects.filter(availabity=1)
    networkSegmentList = network_segment.objects.filter(availabity=1)
    if request.GET.get('nsid'):
        nsInfo = network_segment.objects.get(uuid=request.GET.get('nsid'))
        networkSegmentList = networkSegmentList.exclude(uuid=request.GET.get('nsid'))
        idcList = nsInfo.idc.all()
    if request.method == 'POST':
        cf = ipForm(request.POST)
        if cf.is_valid():
            ip = cf.cleaned_data['ip']
            if ip_list.objects.filter(ip=ip,availabity=1):
                emg = u'添加失败,已经存在%s.' % (ip)
                return render_to_response('asset/ip_add.html', locals(), context_instance=RequestContext(request))
            cf.save()
            return HttpResponseRedirect("/asset/ipList/")
        else:
            emg = json.dumps(cf.errors).decode('unicode_escape')

    return render_to_response('asset/ip_add.html', locals(), context_instance=RequestContext(request))

@login_required
def ip_edit(request):
    '''IP修改'''
    listOrAddTag = ['ip','asset','ipAdd']
    ipID = request.GET.get('id')
    ipInfo = get_object_or_404(ip_list, uuid=ipID)
    segmentList = network_segment.objects.filter(availabity=1)

    '''idc列表'''
    if ipInfo.idc:
        idcList = dataCenter.objects.filter(availabity=1).exclude(uuid=ipInfo.idc.uuid)

    '''机柜列表'''
    if ipInfo.group:
        cabinetList = cabinet.objects.filter(dataCenter=ipInfo.group.dataCenter,availabity=1).exclude(uuid=ipInfo.group.uuid)

    if ipInfo.host:
        hostList = asset.objects.filter(availabity=1).exclude(equipmentid=ipInfo.host.equipmentid)

    af = ipForm(instance=ipInfo)
    if request.method == 'POST':
        af = ipForm(request.POST,instance=ipInfo)
        if af.is_valid():
            af.save()
            return HttpResponseRedirect("/asset/ipList/")
        else:
            emg = json.dumps(af.errors).decode('unicode_escape')
    if request.is_ajax():
        return render_to_response('asset/ip_edit_content.html', locals(), context_instance=RequestContext(request))
    return render_to_response('asset/ip_edit.html', locals(), context_instance=RequestContext(request))

@login_required
def ipEditBatch(request):
    '''IP批量修改'''
    segmentList = network_segment.objects.filter(availabity=1)
    idcList = dataCenter.objects.filter(availabity=1)
    af = ipForm()
    if request.method == 'POST':
        ids = str(request.POST.get('uuid', ''))
        status = int(request.POST.get('status', ''))
        type = int(request.POST.get('type', ''))
        idc = request.POST.get('idc', None)
        group = request.POST.get('group', None)
        linkman = request.POST.get('linkman','')
        comment = request.POST.get('comment','')
        if status == 1:
            if not idc:
                msg = u"Error:机房不能为空."
                return HttpResponse(json.dumps(msg))
            if not group:
                msg = u"Error:机柜不能为空."
                return HttpResponse(json.dumps(msg))
        uuid_list = ids.split(",")
        ipList = ip_list.objects.filter(uuid__in=uuid_list)
        if not idc:
            idc = None
        if not group:
            group = None
        ipList.update(status=status,type=type,idc=idc,group=group,linkman=linkman,comment=comment)
        return HttpResponse(200)
    return render_to_response('asset/ip_edit_batch.html', locals(), context_instance=RequestContext(request))

@login_required
def ip_del(request):
    '''删除IP'''
    _id = request.GET.get('id')
    if request.POST:
        ipInfo = ip_list.objects.get(uuid=_id)
        if ipInfo.status != 2:
            msg = u'该IP不处于未分配状态.'
            return HttpResponse(json.dumps(msg))
        else:
            ipInfo.availabity = int(time.time())
            ipInfo.save()
        return HttpResponse(200)

@login_required
def ipDelBatch(request):
    """ 批量删除IP """
    ids = str(request.POST.get('ids'))
    notDelete = []
    for uuid in ids.split(','):
        ipInfo = get_object_or_404(ip_list, uuid=uuid)
        if ipInfo.status != 2:
            notDelete.append(ipInfo.ip)
        else:
            ipInfo.availabity = int(time.time())
            ipInfo.save()
    if notDelete:
        msg = u'使用状态不处于未分配状态,未进行删除:%s' % str(notDelete)
        return HttpResponse(msg)
    return HttpResponse(200)



@login_required
def network_segment_list(request):
    '''网段列表'''
    listOrAddTag = ['ip','asset','networkSegment']
    networkSegmentList = network_segment.objects.filter(availabity=1)
    if request.is_ajax():
        changetype = request.GET.get('change_type')
        listOrAddTag.append('?typeid=%s' % changetype)
        #listOrAddTag.append('?idcid=%s&cabinetid=%s' % (changeIdc,changeCabinet))
        keyword = request.GET.get('keyword')
        if changetype and changetype != 'None':
            networkSegmentList = networkSegmentList.filter(type=changetype)
        status = request.GET.get('status')
        if status:
            networkSegmentList = networkSegmentList.filter(status=int(status))
        if keyword:
            try:
                networkSegmentList = networkSegmentList.filter(Q(idc__name__contains=keyword)|
                                       Q(type__contains=keyword)|
                                       Q(segment__contains=keyword)|
                                       Q(comment__contains=keyword))
#
            except:
                networkSegmentList = ''



        s_url = request.get_full_path()
        #分页功能
        ontact_list, p, contacts, page_range, current_page, show_first, show_end = pages(networkSegmentList, request)
        #if request.is_ajax():
        if request.GET.get('target') == 'table':
            return render_to_response('asset/network_segment_list_table.html', locals(), context_instance=RequestContext(request))

        return render_to_response('asset/network_segment_search.html', locals(), context_instance=RequestContext(request))
    else:
        #分页功能
        s_url = '%s%s' % (request.get_full_path(),'?')
        ontact_list, p, contacts, page_range, current_page, show_first, show_end = pages(networkSegmentList, request)
        return render_to_response('asset/network_segment_list.html', locals(), context_instance=RequestContext(request))


def addIP(segment,ipList):
    segmentNumber = int(segment.segment.split('/')[1])
    netmask = exchange_maskint(segmentNumber)
    for ip in ipList:

        info = {'segment':segment.uuid,
                'ip':ip,
                'netmask':netmask,
                'status':2,
                'type':1
                }
        insertIp = ipForm(info)
        if insertIp.is_valid():
            insertIp.save()


@login_required
def network_segment_add(request):
    '''网段添加'''
    listOrAddTag = ['networkSegment','asset','networkSegment']
    af = networkSegmentForm()
    idcList = dataCenter.objects.filter(availabity=1)
    if request.method == 'POST':
        nf = networkSegmentForm(request.POST)
        if nf.is_valid():
            segment = nf.cleaned_data['segment']
            if network_segment.objects.filter(segment=segment,availabity=1):
                emg = u'添加失败, 已存在 %s !' % (segment)
                return HttpResponse(json.dumps(emg))

            else:
                if nf.cleaned_data['auto']:
                    nsIP = network_segment_ip(segment)
                    if nsIP:
                        addIP(segment,nsIP)
                    else:
                        emg = u'自动补齐IP错误：网段是否填写错误.'
                        return HttpResponse(json.dumps(emg))
                nf.save()
                return HttpResponse(200)
        else:
            emg = json.dumps(nf.errors).decode('unicode_escape')
            return HttpResponse(json.dumps(emg), content_type="application/json")
                #return HttpResponseRedirect("/asset/networkSegmentList/")
                #type = nf.cleaned_data['type']
                #segment = nf.cleaned_data['segment']
                #status = nf.cleaned_data['status']
                #auto = nf.cleaned_data['auto']
                #comment = nf.cleaned_data['comment']
                #netsegment = network_segment.objects.create(type=type,segment=segment,status=status,auto=auto,comment=comment)
                #for idc in nf.cleaned_data['idc']:
                #    m2 = networksegment_idc(datacenter_id=idc,network_segment_id=netsegment)
                #    m2.save()
            #return HttpResponseRedirect("/asset/networkSegmentList/")

    return render_to_response('asset/network_segment_add.html', locals(), context_instance=RequestContext(request))

@login_required
def network_segment_edit(request):
    '''网段修改'''
    listOrAddTag = ['networkSegment','asset','networkSegment']
    nsID = request.GET.get('id')
    nsInfo = get_object_or_404(network_segment,uuid=nsID,availabity=1)
    nf = networkSegmentForm(instance=nsInfo)
    idcList = dataCenter.objects.filter(availabity=1)
    nsIdc =nsInfo.idc.all() #该网段所属IDC
    idcList = [i for i in idcList if i not in nsIdc]
    if request.method == 'POST':
        nf = networkSegmentForm(request.POST,instance=nsInfo)
        if nf.is_valid():
            nf.save()
            return HttpResponseRedirect("/asset/networkSegmentList/")
        else:
            emg = json.dumps(nf.errors).decode('unicode_escape')

    return render_to_response('asset/network_segment_edit.html', locals(), context_instance=RequestContext(request))

@login_required
def network_segment_del(request):
    '''删除网段'''
    _id = request.GET.get('id')
    if request.POST:
        nsInfo = network_segment.objects.get(uuid=_id)
        nsIpInfo = ip_list.objects.filter(segment=nsInfo,availabity=1)
        if nsIpInfo:
            usedIpInfo = nsIpInfo.exclude(status=2) #非未分配IP
            if usedIpInfo:
                msg = u'该网段下有IP不是非未分配状态: %s' % usedIpInfo
                return HttpResponse(json.dumps(msg))
            else:
                nsIpInfo.update(availabity=int(time.time()))
                nsInfo.availabity = int(time.time())
                nsInfo.save()
        else:
            nsInfo.availabity = int(time.time())
            nsInfo.save()
        return HttpResponse(200)