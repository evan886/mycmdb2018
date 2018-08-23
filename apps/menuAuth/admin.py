from django.contrib import admin

# Register your models here.
from django.contrib import admin

from models import *

for cls in [menu]:
    admin.site.register(cls)