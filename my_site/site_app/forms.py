from django import forms
from django.forms import ModelForm, TextInput, EmailInput

from .models import MainInfo


class ContactForm(forms.Form):
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
