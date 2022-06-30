from django.db.models.functions import ExtractYear
from django.http import HttpResponse
from django.shortcuts import render
from django.db.models import F, Q

# Create your views here.
from django.views.generic import DetailView

from .models import *


def index(request):
    # base attr
    information = MainInfo.objects.all()
    location_sity = Locations_Sity.objects.filter(info__fio='Савушкін Віталій')
    location_country = Locations_Country.objects.filter(info__fio='Савушкін Віталій')
    languages = Languages.objects.filter(info__fio='Савушкін Віталій')
    interests = Interests.objects.filter(info__fio='Савушкін Віталій')
    workhour = WorkHours.objects.filter(info__fio='Савушкін Віталій')

    # index attr
    educations = Educations.objects.filter(info__fio='Савушкін Віталій').annotate(
        ex_year_start=ExtractYear('date_start'), ex_year_over=ExtractYear('date_over'))
    workplaces = WorkPlaces.objects.filter(info__fio='Савушкін Віталій').annotate(
        ex_year_start=ExtractYear('date_start'), ex_year_over=ExtractYear('date_over'))

    context = {
        'information': information,
        'languages': languages,
        'location_sity': location_sity,
        'location_country': location_country,
        'interests': interests,
        'workhour': workhour,
        'educations': educations,
        'workplaces': workplaces,
    }

    return render(request, 'site_app/index.html', context=context)
