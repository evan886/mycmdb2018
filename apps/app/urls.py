from django.conf.urls import include, url

urlpatterns = [
    url(r'^getTree/$', 'apps.app.views.get_tree',name='getTree'),
    url(r'^getService/$', 'apps.app.views.get_service',name='getService'),    

    url(r'^appAdd/$', 'apps.app.views.app_add',name='appAdd'),
    url(r'^appList/$', 'apps.app.views.app_list',name='appList'),
    url(r'^appDetail/$', 'apps.app.views.app_detail',name='appDetail'),
    url(r'^appEdit/$', 'apps.app.views.app_edit',name='appEdit'),
    url(r'^appDel/$', 'apps.app.views.app_del',name='appDel'),
    url(r'^appAssociation/$', 'apps.app.views.app_association',name='appAssociation'),
    url(r'^appAssociationRemove/$', 'apps.app.views.app_association_remove',name='appAssociationRemove'),

    url(r'^classifyAdd/$', 'apps.app.views.classify_add',name='classifyAdd'),
    url(r'^classifyEdit/$', 'apps.app.views.classify_edit',name='classifyEdit'),
    url(r'^classifyDel/$', 'apps.app.views.classify_del',name='classifyDel'),
]