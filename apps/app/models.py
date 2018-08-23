#coding: utf-8
from django.db import models
from uuidfield import UUIDField

from ..asset.models import service

# Create your models here.

classify_monitoring_choices = ((True, '是'), (False, '否'))

class app(models.Model):
    uuid = UUIDField(auto=True,primary_key=True)
    name = models.CharField(max_length=30, verbose_name=u'应用名称')
    another_name = models.CharField(max_length=30, blank=True, null=True, verbose_name=u'别名')
    domain_name = models.CharField(max_length=128,blank=True,null=True,verbose_name=u'域名')
    online_time = models.CharField(max_length=10,blank=True,null=True,verbose_name=u'上线时间')
    yunwei = models.CharField(max_length=128,blank=True,null=True,verbose_name=u'运维人员')
    developer = models.CharField(max_length=128,blank=True,null=True,verbose_name=u'开发者')
    parentid = models.CharField(max_length=32,blank=True,null=True,verbose_name=u'父ID')
    tree = models.TextField(blank=True,null=True,verbose_name=u'树')
    association_app = models.ManyToManyField("self", blank=True, verbose_name=u'关联应用',through='app_association_app',symmetrical=False)
    comment = models.TextField(blank=True, null=True, verbose_name=u"备注")
    availabity = models.BigIntegerField(default=1, verbose_name=u'是否可用')
    
    def __unicode__(self):
        if self.tree:
            tree = self.tree.split(",")
            path = []
            for t in tree:
                name = app.objects.get(uuid=t).name
                path.append(name)
            path.append(self.name)
            path = ("-->".join(path))
        else:
            path = self.name
        return path

    def natural_key(self):
        return '%s' % (self.name)

    class Meta:
        db_table = 'app'

class app_association_app(models.Model):
    app_id = models.ForeignKey(app)
    association_id = models.ForeignKey(app,related_name='association')

    class Meta:
        db_table = 'app_association_app'
        unique_together = (('app_id', 'association_id'),)



class classify(models.Model):
    uuid = UUIDField(auto=True,primary_key=True)
    name = models.CharField(max_length=30, verbose_name=u'名称')
    app = models.ForeignKey(app,verbose_name=u'关联应用')
    service = models.ForeignKey(service,null=True,blank=True,verbose_name=u'关联服务')
    monitoring = models.BooleanField(default=False,choices=classify_monitoring_choices,verbose_name=u'是否监控')
    virtual_host = models.CharField(max_length=128,null=True,blank=True,verbose_name=u'虚拟主机')
    database_name = models.CharField(max_length=128,null=True,blank=True,verbose_name=u'数据库名')
    comment = models.TextField(blank=True,null=True,verbose_name=u'备注')
    availabity = models.BigIntegerField(default=1, verbose_name=u'是否可用')

    def __unicode__(self):
        return '%s:%s(%s)' % (self.name,self.service.equipmentid.ip.split('/')[0],self.service)

    class Meta:
        db_table = 'classify'