# Generated by Django 4.1.5 on 2024-01-21 21:27

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('company', '0029_orderlist_purchase_date'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='orderlist',
            name='purchase_date',
        ),
    ]
