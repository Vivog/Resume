from django.db.models.functions import ExtractYear
from django.http import HttpResponse, FileResponse
from django.shortcuts import render, redirect
from django.db.models import F, Q
from django.core.mail import BadHeaderError, send_mail
from django.http import HttpResponse, HttpResponseRedirect

# Create your views here.
from django.views.generic import DetailView, ListView

from .forms import ContactForm
from .models import *
FIO = 'Савушкін Віталій'
# FIO = 'Savushkin Vitalii'
CONTEXT = {}
# Base.html
# CONTEXT['hello'] = 'Hello, I am '

# UKR
CONTEXT['main'] = 'ГОЛОВНА'
CONTEXT['portfol'] = 'ПОРТФОЛІО'
CONTEXT['contact'] = 'ЗВ\'ЯЗОК'
CONTEXT['privasy'] = 'ОСОБИСТА ІНФОРМАЦІЯ:'
CONTEXT['birth'] = 'ДАТА НАРОДЖЕННЯ: '
CONTEXT['phone'] = 'ТЕЛЕФОН: '
CONTEXT['em'] = 'ПОШТА: '
CONTEXT['pos'] = 'РОЗТАШУВАННЯ:  '
CONTEXT['load_cv'] = 'ЗАВАНТАЖИТИ CV'
CONTEXT['lang'] = 'МОВИ:'
CONTEXT['inter'] = 'ЗАХОПЛЕННЯ:'
CONTEXT['foot'] = 'Власне резюме. Усі права захищено 2022'
CONTEXT['hello'] = 'Привіт, я '
CONTEXT['propose'] = 'Запропонуй мені роботу'
CONTEXT['resume'] = 'РЕЗЮМЕ'
CONTEXT['education'] = 'ОСВІТА'
CONTEXT['workplace'] = 'ПОПЕРЕДНІ МІСЦЯ РОБОТИ'
CONTEXT['i_can'] = 'ЩО Я ВЖЕ МОЖУ'
CONTEXT['skill'] = 'ВМІННЯ'
CONTEXT['contact_me'] = 'Зв\'яжись зі мною'
CONTEXT['request'] = 'Якщо ви бажаете запропонувати мені роботу, або переговорити з будь-яких питань, то зв\'яжиться зі мною'
CONTEXT['call_me'] = 'Зателефонуйте мені'
CONTEXT['mail_me'] = 'Надсилайте мені email'
CONTEXT['name'] = 'ІМ\'Я'
CONTEXT['mail'] = 'ПОШТОВА СКРИНЬКА'
CONTEXT['mess'] = 'ПОВІДОМЛЕННЯ'
CONTEXT['send'] = 'НАДІСЛАТИ'
CONTEXT['me'] = 'Я ось тут'







CONTEXT['information'] = MainInfo.objects.filter(fio=FIO)
CONTEXT['location_sity'] = Locations_Sity.objects.filter(info__fio=FIO)
CONTEXT['location_country'] = Locations_Country.objects.filter(info__fio=FIO)
CONTEXT['languages'] = Languages.objects.filter(info__fio=FIO)
CONTEXT['interests'] = Interests.objects.filter(info__fio=FIO)
CONTEXT['workhour'] = WorkHours.objects.filter(info__fio=FIO)
CONTEXT['whyme'] = WhyMe.objects.filter(info__fio=FIO)

def index(request):
    # index attr
    educations = Educations.objects.filter(info__fio=FIO)
    workplaces = WorkPlaces.objects.filter(info__fio=FIO)
        # .annotate(ex_year_start=ExtractYear('date_start'), ex_year_over=ExtractYear('date_over'))
    skills = Skills.objects.filter(info__fio=FIO)

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
        return context

    def get_queryset(self):
        return Skills.objects.filter(info__fio=FIO)


class ContactsView(ListView):
    model = MainInfo
    template_name = 'site_app/contacts.html'
    context_object_name = 'contacts'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context.update(CONTEXT)
        context['form'] = ContactForm()

        return context

    def get_queryset(self):
        return MainInfo.objects.filter(fio=FIO)

    def post(self, request):
        if request.method == 'POST':
            form = ContactForm(request.POST)
            if form.is_valid():
                subject = "From Resume_Site"
                body = {

                    'name': f"Відправник: {form.cleaned_data['name']}",
                    'email': f"Скринька відправника: {form.cleaned_data['email']}",
                    'text': 'Текст повідомлення: ',
                    'message': form.cleaned_data['message'],
                }
                message = "\n".join(body.values())
                try:
                    send_mail(subject, message,
                               'vivog2022@ukr.net',
                              ['vivog2022@ukr.net'], fail_silently=False)
                except BadHeaderError:
                    return HttpResponse('Знайдено невірний заголовок')
                return redirect("site_app:contacts")

        form = ContactForm()
        return render(request, "site_app/contacts.html", {'form': form})


def portfolio(request):

    portfolio = Portfolio.objects.all()
    context = {
        'portfolio': portfolio,
    }
    context.update(CONTEXT)

    return render(request, 'site_app/portfolio.html', context=context)





