# coding: utf-8
from django.db import models
from uuidfield import UUIDField
#from app.models import app

# Create your models here.
#ALONE  HOST VM  交换机  防火墙   存储
ASSET_TYPE = ((u'ALONE', u'ALONE'), (u'HOST', u'HOST'), (u'VM', u'VM'), (u'交换机', u'交换机'), (u'防火墙', u'防火墙'), (u'存储', u'存储'))
ASSET_STATUS_CHOICES = ((0, u'空闲'), (1, u'使用中'), (2, u'不可用'), (3, u'報修中'), (4, u'報廢'))
ASSET_BUY_CHOICES = ((1,u'所有权马上转移'),(2,u'24個月所有权转移'),(3,u'租用'),(4,u'我方購買'))
SERVICE_CHOICES = ((u'tcp',u'TCP'),(u'udp',u'UDP'))
network_segment_type_choices = ((1,u'公网'),(2,u'私网'))
network_segment_status_choices = ((1,u'正常'),(2,u'保留'),(3,u'禁用'))
network_segment_auto_choices = ((True, '是'), (False, '否'))
ip_list_status_choices = ((1,u'已分配'),(2,u'未分配'),(3,u'保留'),(4,u'禁用'))
ip_list_type_choices = ((1,u'一般地址'),(2,u'管理地址'),(3,u'VIP地址'))

class dataCenter(models.Model):
    uuid = UUIDField(auto=True, primary_key=True, verbose_name=u'编号')
    name = models.CharField(max_length=100, verbose_name=u'名称')
    area = models.CharField(max_length=100, verbose_name=u'区域')
    bandwidth = models.CharField(max_length=64, blank=True, null=True, verbose_name=u'机房带宽')
    phone = models.CharField(max_length=32, verbose_name=u'联系电话')
    linkman = models.CharField(max_length=32, null=True, verbose_name=u'联系人')
    address = models.CharField(max_length=128, blank=True, null=True, verbose_name=u"机房地址")
    create_time = models.DateField(auto_now=True)
    comment = models.TextField(blank=True, null=True, verbose_name=u"备注")
    availabity = models.BigIntegerField(default=1, verbose_name=u'是否可用')

    def __unicode__(self):
        return '%s -> %s' % (self.name, self.area)

    def natural_key(self):
        return '%s -> %s' % (self.name, self.area)

    class Meta:
        db_table = 'dataCenter'
        unique_together = (('name', 'area', 'availabity'),)

class cabinet(models.Model):
    uuid = UUIDField(auto=True, primary_key=True,verbose_name=u'编号')
    name = models.CharField(max_length=20,verbose_name=u'名称')
    dataCenter = models.ForeignKey(dataCenter,verbose_name=u'所属机房')
    comment = models.TextField(blank=True, null=True, verbose_name=u"备注")
    availabity = models.BigIntegerField(default=1,verbose_name=u'是否可用')
    def __unicode__(self):
        return '%s -> %s' % (self.dataCenter.name,self.name)
    def natural_key(self):
        return '%s -> %s' % (self.dataCenter.name,self.name)

    class Meta:
        db_table = 'cabinet'
        unique_together = (('name', 'dataCenter', 'availabity'),)


class asset(models.Model):
    equipmentid = UUIDField(auto=True, primary_key=True,verbose_name=u'设备id')
    group = models.ForeignKey(cabinet, verbose_name=u'所属机柜')
    group_place = models.IntegerField(blank=True,null=True,verbose_name=u'位置')
    relatedid = models.CharField(max_length=32,blank=True,null=True,verbose_name=u'上联设备')
    relatedinfo = models.CharField(max_length=16,blank=True,null=True,verbose_name=u'上联端口')
    sn = models.CharField(max_length=30,blank=True,null=True,verbose_name=u'设备SN')
    name = models.CharField(max_length=30,verbose_name=u'主机名')
    server = models.CharField(max_length=20,verbose_name=u'操作系统')
    server_type = models.CharField(max_length=30, choices=ASSET_TYPE, verbose_name=u'设备类型')
    hosted = models.ForeignKey("self", blank=True, null=True, verbose_name=u"宿主机")
    status = models.IntegerField(default=1, choices=ASSET_STATUS_CHOICES,verbose_name=u'状态',
        help_text=u'1使用中,2空闲')
    cpu = models.CharField(max_length=64, blank=True, null=True, verbose_name=u'CPU')
    hard_disk = models.CharField(max_length=128, blank=True, null=True, verbose_name=u'硬盘')
    memory = models.CharField(max_length=128, blank=True, null=True, verbose_name=u'内存')
    create_time = models.DateTimeField(auto_now_add=True,verbose_name=u'创建时间')
    ip = models.CharField(max_length=32, blank=True, null=True, verbose_name=u'IP')
    ip1 = models.CharField(max_length=32, blank=True, null=True, verbose_name=u'IP1')
    ip2 = models.CharField(max_length=32, blank=True, null=True, verbose_name=u'IP2')
    ip3 = models.CharField(max_length=32, blank=True, null=True, verbose_name=u'IP3')
    ip4 = models.CharField(max_length=32, blank=True, null=True, verbose_name=u'IP4')
    ip5 = models.CharField(max_length=32, blank=True, null=True, verbose_name=u'IP5')
    ip6 = models.CharField(max_length=32, blank=True, null=True, verbose_name=u'IP6')
    ip7 = models.CharField(max_length=32, blank=True, null=True, verbose_name=u'IP7')
    ip8 = models.CharField(max_length=32, blank=True, null=True, verbose_name=u'IP8')
    ip9 = models.CharField(max_length=32, blank=True, null=True, verbose_name=u'IP9')
    ilo = models.CharField(max_length=32, blank=True, null=True, verbose_name=u'ILO地址')
    port = models.IntegerField(default=22, blank=True, null=True, verbose_name=u'ssh端口号')
    use = models.CharField(max_length=32, blank=True, null=True, verbose_name=u'用途')
    brand = models.CharField(max_length=32, blank=True, null=True, verbose_name=u'型号')
    buy = models.IntegerField(blank=True, null=True, choices=ASSET_BUY_CHOICES, verbose_name=u'购买')
    contract_start_time = models.CharField(max_length=18, blank=True, null=True, verbose_name=u'合同开始时间',
                                        help_text=u'例:2018/01/01')
    contract_end_time = models.CharField(max_length=18, blank=True, null=True, verbose_name=u'合同结束时间',
                                        help_text=u'例:2018/01/01')
    server_code = models.CharField(max_length=32, blank=True, null=True, verbose_name=u'ServerCode')
    comment = models.TextField(blank=True, null=True, verbose_name=u"备注")
    availabity = models.BigIntegerField(default=1, verbose_name=u'是否可用')

    def __unicode__(self):
        return '%s(%s)' % (self.name,self.ip)

    class Meta:
        db_table = 'asset'
        unique_together = (('group', 'group_place', 'sn', 'name', 'availabity'),)

class service(models.Model):
    serviceid = UUIDField(auto=True, primary_key=True,verbose_name=u'服务ID')
    equipmentid = models.ForeignKey(asset,null=True,blank=True,verbose_name=u'关联设备')
    name = models.CharField(max_length=100,verbose_name=u'服务名称')
    install = models.CharField(max_length=100,null=True,blank=True,verbose_name=u'安装路径')
    config = models.CharField(max_length=200,null=True,blank=True,verbose_name=u'配置文件')
    start = models.CharField(max_length=100,null=True,blank=True,verbose_name=u'启动文件')
    version = models.CharField(max_length=50,null=True,blank=True,verbose_name=u'软件版本')
    port = models.IntegerField(null=True,blank=True,verbose_name=u'服务端口')
    protocol = models.CharField(max_length=3,null=True,blank=True,choices=SERVICE_CHOICES,verbose_name=u'协议类型')
    user = models.CharField(max_length=20,null=True,blank=True,verbose_name=u'用户名')
    password = models.CharField(max_length=100,null=True,blank=True,verbose_name=u'密码')
    comment = models.TextField(null=True,blank=True,verbose_name=u'备注')
    availabity = models.BigIntegerField(default=1,verbose_name=u'是否可用')

    def __unicode__(self):
        return "%s:%s" % (self.name,self.port)
    class Meta:
        db_table = 'service'
        unique_together = (('equipmentid','name','port','availabity'),('equipmentid','port','availabity'))

class assetRecord(models.Model):
    """ 主机修改记录model """
    uuid = UUIDField(auto=True, primary_key=True)
    asset = models.ForeignKey(asset)
    user = models.CharField(max_length=30, null=True)
    time = models.DateTimeField(auto_now_add=True)
    content = models.TextField(blank=True, null=True)
    comment = models.TextField(blank=True, null=True)

    class Meta:
        db_table = 'assetRecord'

class network_segment(models.Model):
    '''IP 网段'''
    uuid = UUIDField(auto=True,primary_key=True)
    type = models.IntegerField(choices=network_segment_type_choices, verbose_name=u'类型')
    segment = models.CharField(max_length=18, verbose_name=u'IP段')
    status = models.IntegerField(choices=network_segment_status_choices, verbose_name=u'状态')
    auto = models.BooleanField(default=False,choices=network_segment_auto_choices, verbose_name=u'自动补齐IP')
    idc = models.ManyToManyField(dataCenter, blank=True, verbose_name=u'所属机房')
    comment = models.TextField(blank=True, null=True, verbose_name=u"备注")
    availabity = models.BigIntegerField(default=1,verbose_name=u'是否可用')

    def __unicode__(self):
        return self.segment

    class Meta:
        db_table = 'network_segment'
        unique_together = (('segment','availabity'))

#class networksegment_idc(models.Model):
#    datacenter_id = models.ForeignKey(dataCenter)
#    network_segment_id = models.ForeignKey(network_segment)
#
#    def __unicode__(self):
#        return "%s -> %s" % (self.network_segment_id.segment,self.datacenter_id.name)
#
#    def natural_key(self):
#        return "%s -> %s" % (self.network_segment_id.segment,self.datacenter_id.name)
#
#    class Meta:
#        db_table = 'networksegment_idc'

class ip_list(models.Model):
    '''IP'''
    uuid = UUIDField(auto=True,primary_key=True)
    segment = models.ForeignKey(network_segment,verbose_name=u'网段')
    ip = models.GenericIPAddressField(max_length=16,verbose_name=u'IP')
    netmask = models.GenericIPAddressField(max_length=16,verbose_name=u'子网掩码')
    status = models.IntegerField(choices=ip_list_status_choices,verbose_name=u'使用状态',
                                help_text=u'1已分配,2未分配,3保留,4禁用')
    type = models.IntegerField(choices=ip_list_type_choices,verbose_name=u'使用类型',
                                help_text=u'1一般地址,2管理地址,3VIP地址')
    idc = models.ForeignKey(dataCenter, null=True, blank=True, verbose_name=u'所属机房')
    group = models.ForeignKey(cabinet, null=True, blank=True, verbose_name=u'所属机柜')
    host = models.ForeignKey(asset,null=True, blank=True, verbose_name=u'关联设备')
    linkman = models.CharField(max_length=32, blank=True, null=True, verbose_name=u'联系人')
    comment = models.TextField(blank=True, null=True, verbose_name=u"备注")
    availabity = models.BigIntegerField(default=1,verbose_name=u'是否可用')

    def __unicode__(self):
        return '%s -> %s' % (self.segment,self.ip)

    class Meta:
        db_table = 'ip_list'
        unique_together = (('ip', 'idc', 'availabity'))