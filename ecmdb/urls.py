#coding: utf-8
"""ecmdb URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/1.8/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  url(r'^$', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  url(r'^$', Home.as_view(), name='home')
Including another URLconf
    1. Add a URL to urlpatterns:  url(r'^blog/', include('blog.urls'))
"""
from django.conf.urls import include, url
from django.contrib import admin
from tastypie.api import Api
from apps.accounts.api import *
import settings

v1_api = Api(api_name='v1')
v1_api.register(onDutyApi())

urlpatterns = [
    url(r'^$', 'apps.asset.views.asset_list'),
    #url(r'^static/(?P<path>.*)$', 'django.views.static.serve', { 'document_root': settings.STATIC_ROOT}),  
    #API
    url(r'^api/', include(v1_api.urls)),

    #用户管理
    url(r'^accounts/', include('apps.accounts.urls')),
    #服务器
    url(r'^asset/', include('apps.asset.urls')),

    #应用管理
    url(r'^app/', include('apps.app.urls',namespace='app',app_name='app')),

    url(r'^auth/',include('apps.menuAuth.urls')),
    url(r'^ecmdb/', include(admin.site.urls)),
]
