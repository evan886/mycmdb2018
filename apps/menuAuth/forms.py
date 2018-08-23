from django import forms
from models import menu

class menuForm(forms.ModelForm):
    class Meta:
        model = menu
        fields = ('mid', 'name', 'htmlID', 'fatherID', 'icon', 'htmlClass', 'url')