#!/usr/bin/env python
# -*- coding: utf-8 -*-
# =============================================================================
#     FileName: business_tag2.py
#         Desc: 2018/05/21 10:30
#       Author: Matt Hsu
#        Email: matthsu6@gmail.com
#      History: 
# =============================================================================

import ast

from django import template
from ..models import asset

register = template.Library()

@register.filter(name='get_hosted_info')
def get_hosted_info(host_id):
    vm = asset.objects.filter(hosted__equipmentid=host_id,availabity=1)
    if vm:
        return vm
    else:
        return False

@register.filter(name='get_BottomAllied_Info')
def get_BottomAllied_Info(related_id):
    bottomAlliedEquipment = asset.objects.filter(relatedid=related_id,availabity=1)
    if bottomAlliedEquipment:
        return bottomAlliedEquipment
    else:
        return False

@register.filter(name='str_to_list')
def str_to_list(info):
    return ast.literal_eval(info)

@register.filter(name='ip_info')
def ip_info(host,ipNumber):
    ipnb = 'ip%s' % ipNumber
    ipInfo = host.__dict__[ipnb]
    return ipInfo