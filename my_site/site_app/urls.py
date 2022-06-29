from django.urls import path
from site_app import views

urlpatterns = [
    path('', views.index, name='index')
]