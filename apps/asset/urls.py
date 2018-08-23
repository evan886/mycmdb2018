from django.conf.urls import include, url

urlpatterns = [
    url(r'^assetAdd/$', 'apps.asset.views.asset_add'),
    url(r'^getIP/$', 'apps.asset.views.get_ip'),
    url(r'^assetList/$', 'apps.asset.views.asset_list'),
    url(r'^getTree/$', 'apps.asset.views.get_tree'),
    url(r'^assetEdit/$', 'apps.asset.views.asset_edit'),
    url(r'^assetDetail/$', 'apps.asset.views.asset_detail'),
    url(r'^assetDel/$', 'apps.asset.views.asset_del'),
    url(r'^updateFromExcel/$', 'apps.asset.views.updateFromExcel'),
    
    url(r'^idcAdd/$', 'apps.asset.views.idc_add'),
    url(r'^idcList/$', 'apps.asset.views.idc_list'),
    url(r'^idcEdit/$', 'apps.asset.views.idc_edit'),
    url(r'^idcDel/$', 'apps.asset.views.idc_del'),

    url(r'^cabinetAdd/$', 'apps.asset.views.cabinet_add'),
    url(r'^cabinetEdit/$', 'apps.asset.views.cabinet_edit'),
    url(r'^cabinetDel/$', 'apps.asset.views.cabinet_del'),
    url(r'^getCabinet/$', 'apps.asset.views.get_cabinet'),
    url(r'^getRelated/$', 'apps.asset.views.get_related'),

    url(r'^serviceAdd/$', 'apps.asset.views.service_add'),
    url(r'^serviceEdit/$', 'apps.asset.views.service_edit'),
    url(r'^serviceDel/$', 'apps.asset.views.service_del'),


    url(r'^getIpTree/$', 'apps.asset.views.getIpTree'),
    url(r'^ipList/$', 'apps.asset.views.IP_list'),
    url(r'^ipAdd/$', 'apps.asset.views.ip_add'),
    url(r'^getNetmask/$', 'apps.asset.views.get_netmask'),
    url(r'^getIdcFromSegment/$', 'apps.asset.views.getIdcFromSegment'),
    url(r'^ipEdit/$', 'apps.asset.views.ip_edit'),
    url(r'^ipEditBatch/$', 'apps.asset.views.ipEditBatch'),
    url(r'^ipDel/$', 'apps.asset.views.ip_del'),
    url(r'^ipDelBatch/$', 'apps.asset.views.ipDelBatch'),

    url(r'^networkSegmentList/$', 'apps.asset.views.network_segment_list'),
    url(r'^networkSegmentAdd/$', 'apps.asset.views.network_segment_add'),
    url(r'^networkSegmentEdit/$', 'apps.asset.views.network_segment_edit'),
    url(r'^networkSegmentDel/$', 'apps.asset.views.network_segment_del'),
    
]