from django.db.models.functions import ExtractYear
from django.http import HttpResponse, FileResponse
from django.shortcuts import render
from django.db.models import F, Q

# Create your views here.
from django.views.generic import DetailView, ListView

from .models import *


def index(request):
    # base attr
    information = MainInfo.objects.all()
    location_sity = Locations_Sity.objects.filter(info__fio='Савушкін Віталій')
    location_country = Locations_Country.objects.filter(info__fio='Савушкін Віталій')
    languages = Languages.objects.filter(info__fio='Савушкін Віталій')
    interests = Interests.objects.filter(info__fio='Савушкін Віталій')
    workhour = WorkHours.objects.filter(info__fio='Савушкін Віталій')
    whyme = WhyMe.objects.filter(info__fio='Савушкін Віталій')

    # index attr
    educations = Educations.objects.filter(info__fio='Савушкін Віталій').annotate(
        ex_year_start=ExtractYear('date_start'), ex_year_over=ExtractYear('date_over'))
    workplaces = WorkPlaces.objects.filter(info__fio='Савушкін Віталій').annotate(
        ex_year_start=ExtractYear('date_start'), ex_year_over=ExtractYear('date_over'))
    skills = Skills.objects.filter(info__fio='Савушкін Віталій')

    context = {
        'information': information,
        'languages': languages,
        'location_sity': location_sity,
        'location_country': location_country,
        'interests': interests,
        'workhour': workhour,
        'educations': educations,
        'workplaces': workplaces,
        'whyme': whyme,
        'skills': skills,
    }

    return render(request, 'site_app/index.html', context=context)


def download_cv(request):
    from pathlib import Path
    # Build paths inside the project like this: BASE_DIR / 'subdir'.
    BASE_DIR = Path(__file__).resolve().parent.parent
    filename = Path(BASE_DIR, 'site_app/static/site_app/cv', 'CV_Savushkin_Vitalii.pdf')
    if not filename.exists():
        filename = Path(BASE_DIR, 'static/site_app/cv', 'CV_Savushkin_Vitalii.pdf')

    return FileResponse(open(filename, 'rb'), as_attachment=True)


class SkillsView(ListView):
    model = Skills
    template_name = 'site_app/skills.html'
    context_object_name = 'skills'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        print(context)
        context['information'] = MainInfo.objects.all()
        context['location_sity'] = Locations_Sity.objects.filter(info__fio='Савушкін Віталій')
        context['location_country'] = Locations_Country.objects.filter(info__fio='Савушкін Віталій')
        context['languages'] = Languages.objects.filter(info__fio='Савушкін Віталій')
        context['interests'] = Interests.objects.filter(info__fio='Савушкін Віталій')
        context['workhour'] = WorkHours.objects.filter(info__fio='Савушкін Віталій')
        context['whyme'] = WhyMe.objects.filter(info__fio='Савушкін Віталій')

        context['skills_stages'] = SkillHistory.objects.filter(stages__skill=f"{context['skills'].first()}")

        return context

    def get_queryset(self):
        return Skills.objects.filter(info__fio='Савушкін Віталій')

    # skills = Skills.objects.filter(info__fio='Савушкін Віталій')
    # skills_stages = SkillHistory.objects.all().annotate(
    #     ex_year_start=ExtractYear('date_start'), ex_year_over=ExtractYear('date_over'))


