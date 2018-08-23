#!/usr/bin/env python2.7
#coding: utf-8
from ..menuAuth.models import menu
from django.shortcuts import render_to_response

def userMenuAuth(func):
    def wrapper(request,*args,**kwargs):
        menuInfo = menu.objects.get(url=request.path)
        userMenu = request.user.menu_auth.all()
        departmentMenu = request.user.department.menu_auth.all()
        if menuInfo in userMenu:
            return func(request,*args,**kwargs)
        elif menuInfo in departmentMenu:
            return func(request,*args,**kwargs)
        else:
            return render_to_response('authError.html')
    return wrapper
