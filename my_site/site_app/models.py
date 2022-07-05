import datetime

from django.core import validators
from django.core.validators import RegexValidator
from django.db import models

YEAR_CHOICES = [(r, r) for r in range(1984, datetime.date.today().year + 1)]
# Create your models here.

class MainInfo(models.Model):
    fio = models.CharField(max_length=50, verbose_name='ПІБ',
                           validators=[validators.RegexValidator(regex="^[А-Яа-яёЁЇїІіЄєҐґ\s]+$",
                                                                 message='Використано недопустимі символи')])
    slug = models.SlugField(max_length=100, unique=True, verbose_name='URL', db_index=True)
    position = models.CharField(max_length=50, verbose_name='Вакансія')
    about = models.TextField(verbose_name='Про себе')
    work_hour = models.ManyToManyField('WorkHours', verbose_name='Ступінь зайнятості', related_query_name='info')
    age = models.IntegerField(verbose_name='Вік')
    birthday = models.DateField(verbose_name='Дата народження')
    phone = models.CharField(max_length=18, verbose_name='Телефон')
    location_sity = models.ManyToManyField('Locations_Sity', verbose_name='Місто', related_query_name='info')
    location_country = models.ManyToManyField('Locations_Country', verbose_name='Країна', related_query_name='info')
    email = models.EmailField(verbose_name='Пошта')
    languages = models.ManyToManyField('Languages', verbose_name='Мова', related_query_name='info')
    workplaces = models.ManyToManyField('WorkPlaces', verbose_name='Попередні місця роботи', related_query_name='info')
    interests = models.ManyToManyField('Interests', verbose_name='Захоплення', related_query_name='info')
    educations = models.ManyToManyField('Educations', verbose_name='Освіта', related_query_name='info')
    whyme= models.ManyToManyField('WhyMe', verbose_name='Чому я', related_query_name='info')
    skills = models.ManyToManyField('Skills', verbose_name='Вміння', related_query_name='info')
    photo = models.ImageField(upload_to="workers_foto/", verbose_name="Фото")
    published = models.DateTimeField(auto_now_add=True, verbose_name='Дата публікації')

    objects = models.Manager()

    class Meta:
        verbose_name = 'Резюме'
        verbose_name_plural = 'Резюме'
        ordering = ['-published']

    def __str__(self):
        return self.fio


class WorkHours(models.Model):
    KINDS = (
        ('f', 'Повна занятість'),
        ('h', 'Часткова занятість'),
        ('o', 'Віддалена праця'),
        (None, 'Оберіть ступінь')
    )

    hours = models.CharField(max_length=1, choices=KINDS, default='f')
    objects = models.Manager()

    class Meta:
        verbose_name = 'Ступінь зайнятості'
        verbose_name_plural = 'Ступені зайнятості'

    def __str__(self):
        return f'{self.hours}'


class Locations_Sity(models.Model):
    sity = models.CharField(max_length=25, verbose_name='Місто')
    objects = models.Manager()

    class Meta:
        verbose_name = 'Місто'
        verbose_name_plural = 'Міста'

    def __str__(self):
        return f'{self.sity}'


class Locations_Country(models.Model):
    country = models.CharField(max_length=25, verbose_name='Країна')
    objects = models.Manager()

    class Meta:
        verbose_name = 'Країна'
        verbose_name_plural = 'Країни'

    def __str__(self):
        return f'{self.country}'


class Languages(models.Model):
    KIND = (
        ('ua', 'Українська'),
        ('en', 'Англійська'),
        ('ru', 'Російська'),
        (None, 'Оберіть мову'),
    )

    KIND_L = (
        ('l', 'Низький'),
        ('m', 'Середній'),
        ('h', 'Високий'),
        ('n', 'Рідна мова'),
        (None, 'Оберіть рівень'),
    )

    language = models.CharField(max_length=2, verbose_name='Мова', choices=KIND)
    level = models.CharField(max_length=1, verbose_name='Рівень', choices=KIND_L)

    objects = models.Manager()

    class Meta:
        verbose_name = 'Мова'
        verbose_name_plural = 'Мови'

    def __str__(self):
        return f'{self.language} - {self.level}'


class Interests(models.Model):
    interest = models.CharField(max_length=25, verbose_name='Захоплення')

    objects = models.Manager()

    class Meta:
        verbose_name = 'Захоплення'
        verbose_name_plural = 'Захоплення'

    def __str__(self):
        return self.interest


class Educations(models.Model):
    KIND_L = (
        ('so', 'Середньо-освітний'),
        ('st', 'Середньо-технічний'),
        ('nhl', 'Неповна вища освіта'),
        ('hl', 'Вища освіта'),
        ('m', 'Магістр'),
        ('kds', 'Кандидат у доктора наук'),
        ('ds', 'Доктор наук'),
        (None, 'Оберіть ступінь'),
    )



    univer = models.CharField(max_length=100, verbose_name='Навчальний заклад')
    spec = models.CharField(max_length=50, verbose_name='Спеціальність')
    degree = models.CharField(max_length=3, verbose_name='Ступінь освіти', choices=KIND_L, default='st')
    about = models.TextField(verbose_name='Головне')
    date_start = models.IntegerField(verbose_name='З', choices=YEAR_CHOICES)
    date_over = models.IntegerField(verbose_name='По', choices=YEAR_CHOICES)

    objects = models.Manager()

    class Meta:
        verbose_name = 'Освіта'
        verbose_name_plural = 'Освіти'
        ordering = ['-date_over']

    def __str__(self):
        return self.univer


class WorkPlaces(models.Model):
    firma = models.CharField(max_length=50, verbose_name='Компанія')
    prof = models.CharField(max_length=50, verbose_name='Спеціальність')
    about = models.TextField(verbose_name='Головне')
    date_start = models.IntegerField(verbose_name='З', choices=YEAR_CHOICES)
    date_over = models.IntegerField(verbose_name='По', choices=YEAR_CHOICES)

    objects = models.Manager()

    class Meta:
        verbose_name = 'Місце роботи'
        verbose_name_plural = 'Місця роботи'
        ordering = ['-date_over']

    def __str__(self):
        return self.firma


class Skills(models.Model):
    skill = models.CharField(max_length=50, verbose_name='Вміння')
    shortly = models.TextField(verbose_name='Стисло')
    stages = models.ManyToManyField('SkillHistory', verbose_name='Етап розвитку', related_query_name='stages')
    logo = models.ImageField(upload_to="logo/", verbose_name="Значок", null=True)


    objects = models.Manager()

    class Meta:
        verbose_name = 'Вміння'
        verbose_name_plural = 'Вміння'
        ordering = ['skill']

    def __str__(self):
        return self.skill


class SkillHistory(models.Model):
    stage = models.CharField(max_length=50, verbose_name='Етап розвитку')
    about = models.TextField(verbose_name='Головне')
    date_start = models.IntegerField(verbose_name='З', choices=YEAR_CHOICES)
    date_over = models.IntegerField(verbose_name='По', choices=YEAR_CHOICES)

    objects = models.Manager()

    class Meta:
        verbose_name = 'Стадія розвитку вміння'
        verbose_name_plural = 'Стадії розвитку вмінь'
        ordering = ['-date_over', 'stage']

    def __str__(self):
        return self.stage


class WhyMe(models.Model):
    type = models.CharField(max_length=50, verbose_name='Персональна якість')
    about = models.TextField(verbose_name='Докладніше')

    objects = models.Manager()

    class Meta:
        verbose_name = 'Якості'
        verbose_name_plural = 'Якості'
        ordering = ['type']

    def __str__(self):
        return self.type
