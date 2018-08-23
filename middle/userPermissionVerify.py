try:
    from django.utils.deprecation import MiddlewareMixin  # Django 1.10.x
except ImportError:
    MiddlewareMixin = object

from apps.menuAuth.models import menu
from django.shortcuts import render_to_response
from django.http import HttpResponseRedirect

class userMenuAuth(MiddlewareMixin):
    def process_request(self,request):
        try:
            menuInfo = menu.objects.get(url=request.path)
        except:
            menuInfo = ''
        if menuInfo:
            try:
                userMenu = request.user.menu_auth.all()
                departmentMenu = request.user.department.menu_auth.all()
                if menuInfo in userMenu:
                    pass
                elif menuInfo in departmentMenu:
                    pass
                else:
                    pass 
                    #return render_to_response('authError.html')
            except:
                return HttpResponseRedirect('/accounts/login')
