from django.db.models.functions import ExtractYear
from django.http import HttpResponse, FileResponse
from django.shortcuts import render
from django.db.models import F, Q

# Create your views here.
from django.views.generic import DetailView, ListView

from .models import *

CONTEXT = {}
CONTEXT['information'] = MainInfo.objects.all()
CONTEXT['location_sity'] = Locations_Sity.objects.filter(info__fio='Савушкін Віталій')
CONTEXT['location_country'] = Locations_Country.objects.filter(info__fio='Савушкін Віталій')
CONTEXT['languages'] = Languages.objects.filter(info__fio='Савушкін Віталій')
CONTEXT['interests'] = Interests.objects.filter(info__fio='Савушкін Віталій')
CONTEXT['workhour'] = WorkHours.objects.filter(info__fio='Савушкін Віталій')
CONTEXT['whyme'] = WhyMe.objects.filter(info__fio='Савушкін Віталій')

def index(request):
    # index attr
    educations = Educations.objects.filter(info__fio='Савушкін Віталій')
    workplaces = WorkPlaces.objects.filter(info__fio='Савушкін Віталій')
        # .annotate(ex_year_start=ExtractYear('date_start'), ex_year_over=ExtractYear('date_over'))
    skills = Skills.objects.filter(info__fio='Савушкін Віталій')

    context = {
        'educations': educations,
        'workplaces': workplaces,
        'skills': skills,
    }
    context.update(CONTEXT)

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
        context.update(CONTEXT)
        skills = Skills.objects.filter(info__fio='Савушкін Віталій')
        skills_stages = []
        for skill in skills:
            stg = SkillHistory.objects.filter(stages__skill=skill)
            for s in stg:
                skills_stages.append(s)
        # context['skills_stages'] = skills_stages
        context['skills_stages'] = SkillHistory.objects.get(stages__skill=context['skills'])
        return context

    def get_queryset(self):
        skills = Skills.objects.filter(info__fio='Савушкін Віталій')
        for skill in skills:
            stg = SkillHistory.objects.filter(stages__skill=skill)
            print(skill)
            for s in stg:
                print(s.stage)
                print(s.about)
                print(s.date_start, ' - ', s.date_over)
                print()
        return Skills.objects.filter(info__fio='Савушкін Віталій')

    # skills = Skills.objects.filter(info__fio='Савушкін Віталій')
    # skills_stages = SkillHistory.objects.all().annotate(
    #     ex_year_start=ExtractYear('date_start'), ex_year_over=ExtractYear('date_over'))


