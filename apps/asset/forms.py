# coding:utf-8
from django import forms
from apps.asset.models import dataCenter, asset, cabinet, service, ip_list, network_segment
from ip_tool import check_network_segment

class assetForm(forms.ModelForm):
    #def __init__(self, *args, **kwargs):
    #   super(assetForm, self).__init__(*args, **kwargs)
    #   self.fields['group'].queryset = cabinet.objects.filter(availabity=1)
    class Meta:
        model = asset
        fields = ['group','group_place','relatedid','relatedinfo','sn','name','server',
        'server_type','hosted','status','cpu','hard_disk','memory','ip',
        'ip1','ip2','ip3','ip4','ip5','ip6','ip7','ip8','ip9','ilo','port','use','brand',
        'buy','contract_start_time','contract_end_time','server_code','comment']

class idcForm(forms.ModelForm):
    class Meta:
        model = dataCenter
        fields = ['name','area','bandwidth','phone','linkman','address','comment']

class cabinetForm(forms.ModelForm):
    class Meta:
        model = cabinet
        fields = ['name','comment']

class serviceForm(forms.ModelForm):
    port = forms.IntegerField()
    class Meta:
        model = service
        fields = ['name','install','config','start','version','port','protocol','user','password','comment']
    def clean(self):
        cleaned_data = super(serviceForm, self).clean()
        port = cleaned_data.get('port')
        if not isinstance(port, int):
            raise forms.ValidationError(u"Error:端口为数值.")

class ipForm(forms.ModelForm):
    def __init__(self, *args, **kwargs):
       super(ipForm, self).__init__(*args, **kwargs)
       self.fields['segment'].queryset = network_segment.objects.filter(availabity=1)
       self.fields['host'].queryset = asset.objects.filter(availabity=1)
    class Meta:
        model = ip_list
        fields = ['segment', 'ip','netmask','status','type','idc','group','host','linkman','comment']
    def clean(self):
        cleaned_data = super(ipForm, self).clean()
        status = cleaned_data.get('status')
        if status == 1:
            idc = cleaned_data.get('idc')
            cabinet = cleaned_data.get('group')
            if not idc:
                raise forms.ValidationError(u"Error:机房不能为空.")
            if not cabinet:
                raise forms.ValidationError(u"Error:机柜不能为空.")




class networkSegmentForm(forms.ModelForm):
    class Meta:
        model = network_segment
        fields = ['type','segment','status','auto','idc','comment']
    def clean(self):
        cleaned_data = super(networkSegmentForm, self).clean()
        segment = cleaned_data.get('segment')
        if not check_network_segment(segment):
            raise forms.ValidationError(u"Error:网段不合理.")