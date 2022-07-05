from django import forms
from django.forms import ModelForm, TextInput, EmailInput

from .models import MainInfo


class ContactForm(forms.Form):
    name = forms.CharField(max_length=50)
    email = forms.EmailField(max_length=150)
    message = forms.CharField(widget=forms.Textarea,
                              max_length=2000)
    # class Meta:
    #     # model = MainInfo
    #     fields = ['name', 'email', 'message']
    #     widgets={
    #         'name': TextInput(attrs={
    #             'class': 'form-control',
    #             'placeholder': "name"
    #
    #         }),
    #         'email': EmailInput(attrs={
    #             'class': 'form-control',
    #             'placeholder': "email"
    #
    #         }),
    #         'message': EmailInput(attrs={
    #             'class': 'form-control',
    #             'placeholder': "email"
    #
    #         }),
    #     }


