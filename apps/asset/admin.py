from django.contrib import admin

from models import *

for cls in [dataCenter, asset,network_segment]:
    admin.site.register(cls)