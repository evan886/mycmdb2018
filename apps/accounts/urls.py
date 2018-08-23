from django.conf.urls import include, url

urlpatterns = [
    url(r'^login/$', 'apps.accounts.views.user_login'),
    url(r'^loginout/$', 'apps.accounts.views.user_logout'),

    url(r'^userList/$', 'apps.accounts.views.userList'),
    url(r'^userAdd/$', 'apps.accounts.views.userAdd'),
    url(r'^userEdit/$', 'apps.accounts.views.userEdit'),
    url(r'^userStatus/$', 'apps.accounts.views.userStatus'),
    url(r'^userDel/$', 'apps.accounts.views.userDel'),

    url(r'^authMenu/$', 'apps.accounts.views.authMenu'),
    url(r'^auth/$', 'apps.accounts.views.Auth'),

    url(r'^newpasswd/$', 'apps.accounts.views.newPassword'),
    url(r'^resetpass/$', "apps.accounts.views.resetPassword"),
    url(r'^password/$', 'django.contrib.auth.views.password_change', {'template_name': 'accounts/editPassword.html', 'post_change_redirect': '/'}),
    
    url(r'^departmentList/$', 'apps.accounts.views.deptList'),
    url(r'^departmentAdd/$', 'apps.accounts.views.deptAdd'),
    url(r'^departmentEdit/$', 'apps.accounts.views.deptEdit'),
    url(r'^departmentDel/$', 'apps.accounts.views.deptDel'),

    url(r'^onDuty/$', 'apps.accounts.views.onDuty'),
    url(r'^onDutyAdd/$', 'apps.accounts.views.onDutyAdd'),
    url(r'^onDutyEdit/$', 'apps.accounts.views.onDutyEdit'),
]