from django.urls import path
from site_app.views import *

app_name = 'site_app'
urlpatterns = [
    path('', index, name='index'),
    path('download_cv/', download_cv, name='downloadcv'),
    path('skills/', SkillsView.as_view(), name='skills'),
    path('contacts/', ContactsView.as_view(), name='contacts'),
    path('portfolio/', portfolio, name='portfolio'),


]