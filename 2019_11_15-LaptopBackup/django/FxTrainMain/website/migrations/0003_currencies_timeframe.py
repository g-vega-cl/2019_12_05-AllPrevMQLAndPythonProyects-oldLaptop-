# Generated by Django 2.2.6 on 2019-11-06 17:29

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('website', '0002_currencies_name'),
    ]

    operations = [
        migrations.AddField(
            model_name='currencies',
            name='TimeFrame',
            field=models.CharField(default='', max_length=30),
        ),
    ]