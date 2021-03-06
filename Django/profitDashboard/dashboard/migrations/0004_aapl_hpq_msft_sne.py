# Generated by Django 2.2.6 on 2019-10-25 18:53

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('dashboard', '0003_auto_20191025_1230'),
    ]

    operations = [
        migrations.CreateModel(
            name='AAPL',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('symbol', models.CharField(max_length=20)),
                ('date', models.DateField(max_length=20)),
                ('revenue', models.IntegerField()),
            ],
        ),
        migrations.CreateModel(
            name='HPQ',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('symbol', models.CharField(max_length=20)),
                ('date', models.DateField(max_length=20)),
                ('revenue', models.IntegerField()),
            ],
        ),
        migrations.CreateModel(
            name='MSFT',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('symbol', models.CharField(max_length=20)),
                ('date', models.DateField(max_length=20)),
                ('revenue', models.IntegerField()),
            ],
        ),
        migrations.CreateModel(
            name='SNE',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('symbol', models.CharField(max_length=20)),
                ('date', models.DateField(max_length=20)),
                ('revenue', models.IntegerField()),
            ],
        ),
    ]
