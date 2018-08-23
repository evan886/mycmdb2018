from django.conf.urls import include, url

urlpatterns = [
    url(r'^menuAdminAdd/$', 'apps.menuAuth.views.menuAdminAdd'),
    url(r'^menuAdminList/$', 'apps.menuAuth.views.menuAdminList'),
    url(r'^menuAdminEdit/$', 'apps.menuAuth.views.menuAdminEdit'),
    url(r'^menuAdminDel/$', 'apps.menuAuth.views.menuAdminDel'),
]