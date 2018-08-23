# coding:utf-8
from django import forms
from models import app, classify
from ..asset.models import service


class appForm(forms.ModelForm):
    class Meta:
        model = app
        fields = ['name','another_name','domain_name','online_time','yunwei','developer','comment']

class classifyForm(forms.ModelForm):
    #def __init__(self, *args, **kwargs):
       #super(classifyForm, self).__init__(*args, **kwargs)
       #self.fields['service'].queryset = service.objects.filter(availabity=1)
    class Meta:
        model = classify
        fields = ['name','monitoring','virtual_host','database_name','comment']

