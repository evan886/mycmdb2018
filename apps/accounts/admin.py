from django.contrib import admin

# Register your models here.
from django.contrib import admin

from models import *

for cls in [myUser,department]:
    admin.site.register(cls)