from django.urls import path
from site_app import views
app_name = 'site_app'
urlpatterns = [
    path('', views.index, name='index'),
    path('download_cv/', views.download_cv, name='downloadcv')

]