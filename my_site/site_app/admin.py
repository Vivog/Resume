from django.contrib import admin
from django.utils.safestring import mark_safe
from django.db.models import Q

from .models import *


# Register your models here.

@admin.register(MainInfo)
class MainInfoAdmin(admin.ModelAdmin):
    list_display = ('published', 'position', 'fio', 'get_html_photo')
    list_display_links = ('position', 'fio')
    list_filter = ('position',)
    prepopulated_fields = {'slug': ('fio',)}
    fieldsets = (
        (
            "Загальні відомості", {'fields': ('fio', 'slug', 'position', 'work_hour', 'about','birthday', 'age', 'phone', 'email', 'skills',)}
        ),
        (
            "Додатково", {'fields': (('location_sity', 'location_country'), 'languages', 'interests', 'educations', 'workplaces', 'whyme', 'photo')}
        )
    )
    search_fields = ('published', 'fio')

    def get_html_photo(self, object):
        if object.photo:
            return mark_safe(f"<img src='{object.photo.url}' width=50")

    get_html_photo.short_description = 'Мініатюра'




@admin.register(Locations_Sity)
class Locations_SityAdmin(admin.ModelAdmin):
    list_display = ('sity',)
    list_filter = ('sity',)
    search_fields = ('sity',)


@admin.register(Locations_Country)
class Locations_CountryAdmin(admin.ModelAdmin):
    list_display = ('country',)
    list_filter = ('country',)
    search_fields = ('country',)


@admin.register(WorkHours)
class WorkHoursAdmin(admin.ModelAdmin):
    list_display = ('hours',)
    list_filter = ('hours',)
    search_fields = ('hours',)


@admin.register(Languages)
class LanguagesAdmin(admin.ModelAdmin):
    list_display = ('language', 'level')
    list_filter = ('language', 'level')
    search_fields = ('language',)


@admin.register(Interests)
class InterestsAdmin(admin.ModelAdmin):
    list_display = ('interest',)
    list_filter = ('interest',)
    search_fields = ('interest',)


@admin.register(Educations)
class EducationsAdmin(admin.ModelAdmin):
    list_display = ('univer', 'spec', 'degree')
    list_filter = ('univer', 'spec', 'degree')
    search_fields = ('univer', 'date_start', 'date_over')
    fieldsets = (
        (
            "Загальні відомості", {'fields': ('univer', 'spec', 'degree',)}
        ),
        (
            "Додатково", {'fields': (
            ('date_start', 'date_over'), 'about',)}
        )
    )


@admin.register(WorkPlaces)
class WorkPlacesAdmin(admin.ModelAdmin):
    list_display = ('firma', 'prof', 'date_start', 'date_over')
    list_filter = ('firma', 'prof', 'date_start', 'date_over')
    search_fields = ('firma', 'date_start', 'date_over')
    fieldsets = (
        (
            "Загальні відомості", {'fields': ('firma', 'prof',)}
        ),
        (
            "Додатково", {'fields': (
            ('date_start', 'date_over'), 'about',)}
        )
    )

@admin.register(Skills)
class SkillsAdmin(admin.ModelAdmin):
    list_display = ('skill',)
    list_filter = ('skill',)
    search_fields = ('skill',)

@admin.register(SkillHistory)
class SkillHistoryAdmin(admin.ModelAdmin):
    list_display = ('stage', 'date_start', 'date_over')
    list_filter = ('stage',)
    search_fields = ('stage',)

@admin.register(WhyMe)
class WhyMeAdmin(admin.ModelAdmin):
    list_display = ('type',)
    list_filter = ('type',)
    search_fields = ('type',)


admin.site.site_title = "Портал НДВ"
admin.site.site_header = "Портал НДВ"
