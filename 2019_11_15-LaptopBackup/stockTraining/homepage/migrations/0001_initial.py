# Generated by Django 2.2.6 on 2019-10-23 13:55

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Currencies',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('Symbol', models.CharField(max_length=20)),
                ('Open', models.DecimalField(decimal_places=6, max_digits=6)),
                ('High', models.DecimalField(decimal_places=6, max_digits=6)),
                ('Low', models.DecimalField(decimal_places=6, max_digits=6)),
                ('Close', models.DecimalField(decimal_places=6, max_digits=6)),
                ('Volume', models.DecimalField(decimal_places=1, max_digits=18)),
            ],
        ),
    ]
