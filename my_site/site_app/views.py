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
        return context

    def get_queryset(self):
        return Skills.objects.filter(info__fio='Савушкін Віталій')


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
        return MainInfo.objects.filter(fio='Савушкін Віталій')

    def post(self, request):
        if request.method == 'POST':
            form = ContactForm(request.POST)
            if form.is_valid():
                subject = "From Resume_Site"
                body = {

                    'name': f"Відправник: {form.cleaned_data['name']}",
                    'email': f"Скринька відправника: {form.cleaned_data['email']}",
                    'text': 'Текс повідомлення: ',
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





