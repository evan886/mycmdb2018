# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models
import uuidfield.fields


class Migration(migrations.Migration):

    dependencies = [
        ('asset', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='app',
            fields=[
                ('uuid', uuidfield.fields.UUIDField(primary_key=True, serialize=False, editable=False, max_length=32, blank=True, unique=True)),
                ('name', models.CharField(max_length=30, verbose_name='\u5e94\u7528\u540d\u79f0')),
                ('another_name', models.CharField(max_length=30, null=True, verbose_name='\u522b\u540d', blank=True)),
                ('domain_name', models.CharField(max_length=128, null=True, verbose_name='\u57df\u540d', blank=True)),
                ('online_time', models.CharField(max_length=10, null=True, verbose_name='\u4e0a\u7ebf\u65f6\u95f4', blank=True)),
                ('yunwei', models.CharField(max_length=128, null=True, verbose_name='\u8fd0\u7ef4\u4eba\u5458', blank=True)),
                ('developer', models.CharField(max_length=128, null=True, verbose_name='\u5f00\u53d1\u8005', blank=True)),
                ('parentid', models.CharField(max_length=32, null=True, verbose_name='\u7236ID', blank=True)),
                ('tree', models.TextField(null=True, verbose_name='\u6811', blank=True)),
                ('comment', models.TextField(null=True, verbose_name='\u5907\u6ce8', blank=True)),
                ('availabity', models.BigIntegerField(default=1, verbose_name='\u662f\u5426\u53ef\u7528')),
            ],
            options={
                'db_table': 'app',
            },
        ),
        migrations.CreateModel(
            name='app_association_app',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('app_id', models.ForeignKey(to='app.app')),
                ('association_id', models.ForeignKey(related_name='association', to='app.app')),
            ],
            options={
                'db_table': 'app_association_app',
            },
        ),
        migrations.CreateModel(
            name='classify',
            fields=[
                ('uuid', uuidfield.fields.UUIDField(primary_key=True, serialize=False, editable=False, max_length=32, blank=True, unique=True)),
                ('name', models.CharField(max_length=30, verbose_name='\u540d\u79f0')),
                ('monitoring', models.BooleanField(default=False, verbose_name='\u662f\u5426\u76d1\u63a7', choices=[(True, b'\xe6\x98\xaf'), (False, b'\xe5\x90\xa6')])),
                ('virtual_host', models.CharField(max_length=128, null=True, verbose_name='\u865a\u62df\u4e3b\u673a', blank=True)),
                ('database_name', models.CharField(max_length=128, null=True, verbose_name='\u6570\u636e\u5e93\u540d', blank=True)),
                ('comment', models.TextField(null=True, verbose_name='\u5907\u6ce8', blank=True)),
                ('availabity', models.BigIntegerField(default=1, verbose_name='\u662f\u5426\u53ef\u7528')),
                ('app', models.ForeignKey(verbose_name='\u5173\u8054\u5e94\u7528', to='app.app')),
                ('service', models.ForeignKey(verbose_name='\u5173\u8054\u670d\u52a1', blank=True, to='asset.service', null=True)),
            ],
            options={
                'db_table': 'classify',
            },
        ),
        migrations.AddField(
            model_name='app',
            name='association_app',
            field=models.ManyToManyField(to='app.app', verbose_name='\u5173\u8054\u5e94\u7528', through='app.app_association_app', blank=True),
        ),
        migrations.AlterUniqueTogether(
            name='app_association_app',
            unique_together=set([('app_id', 'association_id')]),
        ),
    ]
