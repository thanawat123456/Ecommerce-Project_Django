# Generated by Django 3.0 on 2022-01-20 23:26

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('company', '0013_orderpending_trackingnumber'),
    ]

    operations = [
        migrations.AddField(
            model_name='orderpending',
            name='confirmed',
            field=models.BooleanField(default=False),
        ),
    ]