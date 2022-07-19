from django import forms
from django.forms import ModelForm, TextInput, EmailInput

from .models import MainInfo
# FIO = 'Савушкін Віталій'
FIO = 'Savushkin Vitalii'


class ContactForm(forms.Form):
    if FIO == 'Савушкін Віталій':
        name = forms.CharField(label='Ім\'я', max_length=50,
                           widget=TextInput(
                               attrs={'class': 'form-control', 'placeholder': "ІМ\'Я", 'style': 'font-size: 14px'}))
        email = forms.EmailField(label='Email', max_length=150,
                             widget=EmailInput(attrs={'class': 'form-control', 'placeholder': "ВАША ПОШТОВА СКРИНЬКА",
                                                      'style': 'font-size: 14px'}))
        message = forms.CharField(label='Повідомлення', max_length=5000,
                              widget=forms.Textarea(
                                  attrs={'size': 100, 'class': 'form-control', 'placeholder': "ПОВІДОМЛЕННЯ",
                                         'style': 'font-size: 14px'}))
    else:
        name = forms.CharField(label='Ім\'я', max_length=50,
                               widget=TextInput(
                                   attrs={'class': 'form-control', 'placeholder': "NAME", 'style': 'font-size: 14px'}))
        email = forms.EmailField(label='Email', max_length=150,
                                 widget=EmailInput(
                                     attrs={'class': 'form-control', 'placeholder': "EMAIL",
                                            'style': 'font-size: 14px'}))
        message = forms.CharField(label='Повідомлення', max_length=5000,
                                  widget=forms.Textarea(
                                      attrs={'size': 100, 'class': 'form-control', 'placeholder': "MESSAGE",
                                             'style': 'font-size: 14px'}))
