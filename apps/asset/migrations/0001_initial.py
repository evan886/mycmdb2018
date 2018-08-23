# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models
import uuidfield.fields


class Migration(migrations.Migration):

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='asset',
            fields=[
                ('equipmentid', uuidfield.fields.UUIDField(primary_key=True, serialize=False, editable=False, max_length=32, blank=True, unique=True, verbose_name='\u8bbe\u5907id')),
                ('group_place', models.IntegerField(null=True, verbose_name='\u4f4d\u7f6e', blank=True)),
                ('relatedid', models.CharField(max_length=32, null=True, verbose_name='\u4e0a\u8054\u8bbe\u5907', blank=True)),
                ('relatedinfo', models.CharField(max_length=16, null=True, verbose_name='\u4e0a\u8054\u7aef\u53e3', blank=True)),
                ('sn', models.CharField(max_length=30, null=True, verbose_name='\u8bbe\u5907SN', blank=True)),
                ('name', models.CharField(max_length=30, verbose_name='\u4e3b\u673a\u540d')),
                ('server', models.CharField(max_length=20, verbose_name='\u64cd\u4f5c\u7cfb\u7edf')),
                ('server_type', models.CharField(max_length=30, verbose_name='\u8bbe\u5907\u7c7b\u578b', choices=[('ALONE', 'ALONE'), ('HOST', 'HOST'), ('VM', 'VM'), ('\u4ea4\u6362\u673a', '\u4ea4\u6362\u673a'), ('\u9632\u706b\u5899', '\u9632\u706b\u5899'), ('\u5b58\u50a8', '\u5b58\u50a8')])),
                ('status', models.IntegerField(default=1, help_text='1\u4f7f\u7528\u4e2d,2\u7a7a\u95f2', verbose_name='\u72b6\u6001', choices=[(0, '\u7a7a\u95f2'), (1, '\u4f7f\u7528\u4e2d'), (2, '\u4e0d\u53ef\u7528'), (3, '\u5831\u4fee\u4e2d'), (4, '\u5831\u5ee2')])),
                ('cpu', models.CharField(max_length=64, null=True, verbose_name='CPU', blank=True)),
                ('hard_disk', models.CharField(max_length=128, null=True, verbose_name='\u786c\u76d8', blank=True)),
                ('memory', models.CharField(max_length=128, null=True, verbose_name='\u5185\u5b58', blank=True)),
                ('create_time', models.DateTimeField(auto_now_add=True, verbose_name='\u521b\u5efa\u65f6\u95f4')),
                ('ip', models.CharField(max_length=32, null=True, verbose_name='IP', blank=True)),
                ('ip1', models.CharField(max_length=32, null=True, verbose_name='IP1', blank=True)),
                ('ip2', models.CharField(max_length=32, null=True, verbose_name='IP2', blank=True)),
                ('ip3', models.CharField(max_length=32, null=True, verbose_name='IP3', blank=True)),
                ('ip4', models.CharField(max_length=32, null=True, verbose_name='IP4', blank=True)),
                ('ip5', models.CharField(max_length=32, null=True, verbose_name='IP5', blank=True)),
                ('ip6', models.CharField(max_length=32, null=True, verbose_name='IP6', blank=True)),
                ('ip7', models.CharField(max_length=32, null=True, verbose_name='IP7', blank=True)),
                ('ip8', models.CharField(max_length=32, null=True, verbose_name='IP8', blank=True)),
                ('ip9', models.CharField(max_length=32, null=True, verbose_name='IP9', blank=True)),
                ('ilo', models.CharField(max_length=32, null=True, verbose_name='ILO\u5730\u5740', blank=True)),
                ('port', models.IntegerField(default=22, null=True, verbose_name='ssh\u7aef\u53e3\u53f7', blank=True)),
                ('use', models.CharField(max_length=32, null=True, verbose_name='\u7528\u9014', blank=True)),
                ('brand', models.CharField(max_length=32, null=True, verbose_name='\u578b\u53f7', blank=True)),
                ('buy', models.IntegerField(blank=True, null=True, verbose_name='\u8d2d\u4e70', choices=[(1, '\u6240\u6709\u6743\u9a6c\u4e0a\u8f6c\u79fb'), (2, '24\u500b\u6708\u6240\u6709\u6743\u8f6c\u79fb'), (3, '\u79df\u7528'), (4, '\u6211\u65b9\u8cfc\u8cb7')])),
                ('contract_start_time', models.CharField(help_text='\u4f8b:2018/01/01', max_length=18, null=True, verbose_name='\u5408\u540c\u5f00\u59cb\u65f6\u95f4', blank=True)),
                ('contract_end_time', models.CharField(help_text='\u4f8b:2018/01/01', max_length=18, null=True, verbose_name='\u5408\u540c\u7ed3\u675f\u65f6\u95f4', blank=True)),
                ('server_code', models.CharField(max_length=32, null=True, verbose_name='ServerCode', blank=True)),
                ('comment', models.TextField(null=True, verbose_name='\u5907\u6ce8', blank=True)),
                ('availabity', models.BigIntegerField(default=1, verbose_name='\u662f\u5426\u53ef\u7528')),
            ],
            options={
                'db_table': 'asset',
            },
        ),
        migrations.CreateModel(
            name='assetRecord',
            fields=[
                ('uuid', uuidfield.fields.UUIDField(primary_key=True, serialize=False, editable=False, max_length=32, blank=True, unique=True)),
                ('user', models.CharField(max_length=30, null=True)),
                ('time', models.DateTimeField(auto_now_add=True)),
                ('content', models.TextField(null=True, blank=True)),
                ('comment', models.TextField(null=True, blank=True)),
                ('asset', models.ForeignKey(to='asset.asset')),
            ],
            options={
                'db_table': 'assetRecord',
            },
        ),
        migrations.CreateModel(
            name='cabinet',
            fields=[
                ('uuid', uuidfield.fields.UUIDField(primary_key=True, serialize=False, editable=False, max_length=32, blank=True, unique=True, verbose_name='\u7f16\u53f7')),
                ('name', models.CharField(max_length=20, verbose_name='\u540d\u79f0')),
                ('comment', models.TextField(null=True, verbose_name='\u5907\u6ce8', blank=True)),
                ('availabity', models.BigIntegerField(default=1, verbose_name='\u662f\u5426\u53ef\u7528')),
            ],
            options={
                'db_table': 'cabinet',
            },
        ),
        migrations.CreateModel(
            name='dataCenter',
            fields=[
                ('uuid', uuidfield.fields.UUIDField(primary_key=True, serialize=False, editable=False, max_length=32, blank=True, unique=True, verbose_name='\u7f16\u53f7')),
                ('name', models.CharField(max_length=100, verbose_name='\u540d\u79f0')),
                ('area', models.CharField(max_length=100, verbose_name='\u533a\u57df')),
                ('bandwidth', models.CharField(max_length=64, null=True, verbose_name='\u673a\u623f\u5e26\u5bbd', blank=True)),
                ('phone', models.CharField(max_length=32, verbose_name='\u8054\u7cfb\u7535\u8bdd')),
                ('linkman', models.CharField(max_length=32, null=True, verbose_name='\u8054\u7cfb\u4eba')),
                ('address', models.CharField(max_length=128, null=True, verbose_name='\u673a\u623f\u5730\u5740', blank=True)),
                ('create_time', models.DateField(auto_now=True)),
                ('comment', models.TextField(null=True, verbose_name='\u5907\u6ce8', blank=True)),
                ('availabity', models.BigIntegerField(default=1, verbose_name='\u662f\u5426\u53ef\u7528')),
            ],
            options={
                'db_table': 'dataCenter',
            },
        ),
        migrations.CreateModel(
            name='ip_list',
            fields=[
                ('uuid', uuidfield.fields.UUIDField(primary_key=True, serialize=False, editable=False, max_length=32, blank=True, unique=True)),
                ('ip', models.GenericIPAddressField(verbose_name='IP')),
                ('netmask', models.GenericIPAddressField(verbose_name='\u5b50\u7f51\u63a9\u7801')),
                ('status', models.IntegerField(help_text='1\u5df2\u5206\u914d,2\u672a\u5206\u914d,3\u4fdd\u7559,4\u7981\u7528', verbose_name='\u4f7f\u7528\u72b6\u6001', choices=[(1, '\u5df2\u5206\u914d'), (2, '\u672a\u5206\u914d'), (3, '\u4fdd\u7559'), (4, '\u7981\u7528')])),
                ('type', models.IntegerField(help_text='1\u4e00\u822c\u5730\u5740,2\u7ba1\u7406\u5730\u5740,3VIP\u5730\u5740', verbose_name='\u4f7f\u7528\u7c7b\u578b', choices=[(1, '\u4e00\u822c\u5730\u5740'), (2, '\u7ba1\u7406\u5730\u5740'), (3, 'VIP\u5730\u5740')])),
                ('linkman', models.CharField(max_length=32, null=True, verbose_name='\u8054\u7cfb\u4eba', blank=True)),
                ('comment', models.TextField(null=True, verbose_name='\u5907\u6ce8', blank=True)),
                ('availabity', models.BigIntegerField(default=1, verbose_name='\u662f\u5426\u53ef\u7528')),
                ('group', models.ForeignKey(verbose_name='\u6240\u5c5e\u673a\u67dc', blank=True, to='asset.cabinet', null=True)),
                ('host', models.ForeignKey(verbose_name='\u5173\u8054\u8bbe\u5907', blank=True, to='asset.asset', null=True)),
                ('idc', models.ForeignKey(verbose_name='\u6240\u5c5e\u673a\u623f', blank=True, to='asset.dataCenter', null=True)),
            ],
            options={
                'db_table': 'ip_list',
            },
        ),
        migrations.CreateModel(
            name='network_segment',
            fields=[
                ('uuid', uuidfield.fields.UUIDField(primary_key=True, serialize=False, editable=False, max_length=32, blank=True, unique=True)),
                ('type', models.IntegerField(verbose_name='\u7c7b\u578b', choices=[(1, '\u516c\u7f51'), (2, '\u79c1\u7f51')])),
                ('segment', models.CharField(max_length=18, verbose_name='IP\u6bb5')),
                ('status', models.IntegerField(verbose_name='\u72b6\u6001', choices=[(1, '\u6b63\u5e38'), (2, '\u4fdd\u7559'), (3, '\u7981\u7528')])),
                ('auto', models.BooleanField(default=False, verbose_name='\u81ea\u52a8\u8865\u9f50IP', choices=[(True, b'\xe6\x98\xaf'), (False, b'\xe5\x90\xa6')])),
                ('comment', models.TextField(null=True, verbose_name='\u5907\u6ce8', blank=True)),
                ('availabity', models.BigIntegerField(default=1, verbose_name='\u662f\u5426\u53ef\u7528')),
                ('idc', models.ManyToManyField(to='asset.dataCenter', verbose_name='\u6240\u5c5e\u673a\u623f', blank=True)),
            ],
            options={
                'db_table': 'network_segment',
            },
        ),
        migrations.CreateModel(
            name='service',
            fields=[
                ('serviceid', uuidfield.fields.UUIDField(primary_key=True, serialize=False, editable=False, max_length=32, blank=True, unique=True, verbose_name='\u670d\u52a1ID')),
                ('name', models.CharField(max_length=100, verbose_name='\u670d\u52a1\u540d\u79f0')),
                ('install', models.CharField(max_length=100, null=True, verbose_name='\u5b89\u88c5\u8def\u5f84', blank=True)),
                ('config', models.CharField(max_length=200, null=True, verbose_name='\u914d\u7f6e\u6587\u4ef6', blank=True)),
                ('start', models.CharField(max_length=100, null=True, verbose_name='\u542f\u52a8\u6587\u4ef6', blank=True)),
                ('version', models.CharField(max_length=50, null=True, verbose_name='\u8f6f\u4ef6\u7248\u672c', blank=True)),
                ('port', models.IntegerField(null=True, verbose_name='\u670d\u52a1\u7aef\u53e3', blank=True)),
                ('protocol', models.CharField(blank=True, max_length=3, null=True, verbose_name='\u534f\u8bae\u7c7b\u578b', choices=[('tcp', 'TCP'), ('udp', 'UDP')])),
                ('user', models.CharField(max_length=20, null=True, verbose_name='\u7528\u6237\u540d', blank=True)),
                ('password', models.CharField(max_length=100, null=True, verbose_name='\u5bc6\u7801', blank=True)),
                ('comment', models.TextField(null=True, verbose_name='\u5907\u6ce8', blank=True)),
                ('availabity', models.BigIntegerField(default=1, verbose_name='\u662f\u5426\u53ef\u7528')),
                ('equipmentid', models.ForeignKey(verbose_name='\u5173\u8054\u8bbe\u5907', blank=True, to='asset.asset', null=True)),
            ],
            options={
                'db_table': 'service',
            },
        ),
        migrations.AddField(
            model_name='ip_list',
            name='segment',
            field=models.ForeignKey(verbose_name='\u7f51\u6bb5', to='asset.network_segment'),
        ),
        migrations.AlterUniqueTogether(
            name='datacenter',
            unique_together=set([('name', 'area', 'availabity')]),
        ),
        migrations.AddField(
            model_name='cabinet',
            name='dataCenter',
            field=models.ForeignKey(verbose_name='\u6240\u5c5e\u673a\u623f', to='asset.dataCenter'),
        ),
        migrations.AddField(
            model_name='asset',
            name='group',
            field=models.ForeignKey(verbose_name='\u6240\u5c5e\u673a\u67dc', to='asset.cabinet'),
        ),
        migrations.AddField(
            model_name='asset',
            name='hosted',
            field=models.ForeignKey(verbose_name='\u5bbf\u4e3b\u673a', blank=True, to='asset.asset', null=True),
        ),
        migrations.AlterUniqueTogether(
            name='service',
            unique_together=set([('equipmentid', 'name', 'port', 'availabity'), ('equipmentid', 'port', 'availabity')]),
        ),
        migrations.AlterUniqueTogether(
            name='network_segment',
            unique_together=set([('segment', 'availabity')]),
        ),
        migrations.AlterUniqueTogether(
            name='ip_list',
            unique_together=set([('ip', 'idc', 'availabity')]),
        ),
        migrations.AlterUniqueTogether(
            name='cabinet',
            unique_together=set([('name', 'dataCenter', 'availabity')]),
        ),
        migrations.AlterUniqueTogether(
            name='asset',
            unique_together=set([('group', 'group_place', 'sn', 'name', 'availabity')]),
        ),
    ]
