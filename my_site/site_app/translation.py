from modeltranslation.translator import register, TranslationOptions

from .models import *


@register(MainInfo)
class MainInfoTranslationOptions(TranslationOptions):
    fields = (
        'fio', 'position', 'about', 'birthday',)


@register(WorkHours)
class WorkHoursTranslationOptions(TranslationOptions):
    fields = ('hours',)


@register(Locations_Sity)
class Locations_SityTranslationOptions(TranslationOptions):
    fields = ('sity',)


@register(Locations_Country)
class Locations_CountryTranslationOptions(TranslationOptions):
    fields = ('country',)


@register(Languages)
class LanguagesTranslationOptions(TranslationOptions):
    fields = ('language', 'level',)


@register(Interests)
class InterestsTranslationOptions(TranslationOptions):
    fields = ('interest',)


@register(Educations)
class EducationsTranslationOptions(TranslationOptions):
    fields = ('univer', 'spec', 'degree', 'about', 'date_start', 'date_over')


@register(WorkPlaces)
class WorkPlacesTranslationOptions(TranslationOptions):
    fields = ('firma', 'prof', 'about',  'date_start', 'date_over')


@register(Skills)
class SkillsTranslationOptions(TranslationOptions):
    fields = ('skill', 'shortly',)


@register(SkillHistory)
class SkillHistoryTranslationOptions(TranslationOptions):
    fields = ('stage', 'about',)


@register(Portfolio)
class PortfolioTranslationOptions(TranslationOptions):
    fields = ('name', 'teh',)


@register(WhyMe)
class WhyMeTranslationOptions(TranslationOptions):
    fields = ('type', 'about',)
