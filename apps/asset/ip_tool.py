#-*- coding: utf-8 -*-
from IPy import IP
def exchange_maskint(mask_int):
    '''子网掩码位数转换子网掩码'''
    bin_arr = ['0' for i in range(32)]
    for i in range(int(mask_int)):
        bin_arr[i] = '1'
    tmpmask = [''.join(bin_arr[i * 8:i * 8 + 8]) for i in range(4)]
    tmpmask = [str(int(tmpstr, 2)) for tmpstr in tmpmask]
    return '.'.join(tmpmask)

def check_network_segment(segment):
    try:
        ips = IP(segment)
        return ips
    except:
        return False

def network_segment_ip(segment):
    '''获取网段全部IP'''
    ipList = []
    try:
        ips = check_network_segment(segment)
        if ips:
            for ip in ips:
                lastNb = int(str(ip).split('.')[-1])
                if lastNb != 0:
                    if lastNb != 255:
                        ipList.append(str(ip))
            return ipList
        else:
            return ''
    except:
        return ''

def get_network_segment(ip):
    '''获取网段'''
    netmask = exchange_maskint(int(ip.split('/')[1]))
    return (IP(ip.split('/')[0]).make_net(netmask))