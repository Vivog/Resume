from django.http import FileResponse
from django.shortcuts import render, redirect
from django.core.mail import BadHeaderError, send_mail
from django.http import HttpResponse
from django.contrib.messages.views import SuccessMessageMixin
from django.contrib import messages

# Create your views here.
from django.views.generic import ListView

from .forms import ContactForm
from .models import *
FIO = 'Савушкін Віталій'
CONTEXT = {}
CONTEXT['information'] = MainInfo.objects.filter(fio=FIO)
CONTEXT['location_sity'] = Locations_Sity.objects.filter(info__fio=FIO)
CONTEXT['location_country'] = Locations_Country.objects.filter(info__fio=FIO)
CONTEXT['langs'] = Languages.objects.filter(info__fio=FIO)
CONTEXT['interests'] = Interests.objects.filter(info__fio=FIO)
CONTEXT['workhour'] = WorkHours.objects.filter(info__fio=FIO)
CONTEXT['whyme'] = WhyMe.objects.filter(info__fio=FIO)
CONTEXT['educations'] = Educations.objects.filter(info__fio=FIO)
CONTEXT['workplaces'] = WorkPlaces.objects.filter(info__fio=FIO)
CONTEXT['skills'] = Skills.objects.filter(info__fio=FIO)


def index(request):

    context = {}
    context.update(CONTEXT)

    return render(request, 'site_app/index.html', context=context)


def download_cv(request):
    from pathlib import Path
    # Build paths inside the project like this: BASE_DIR / 'subdir'.
    BASE_DIR = Path(__file__).resolve().parent.parent
    filename = Path(BASE_DIR, 'site_app/static/site_app/cv', 'Savushkin_CV.pdf')
    if not filename.exists():
        filename = Path(BASE_DIR, 'static/site_app/cv', 'Savushkin_CV.pdf')

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


class ContactsView(ListView, SuccessMessageMixin):
    model = MainInfo
    template_name = 'site_app/contacts.html'
    context_object_name = 'contacts'
    success_message = 'Ваш лист успішно відправлено'

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
                messages.success(request, 'Ваш лист успішно відправлено')
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