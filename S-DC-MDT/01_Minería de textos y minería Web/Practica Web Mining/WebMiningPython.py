import re
from dateutil.parser import parse
from bs4 import BeautifulSoup
from urllib import request
import time



##currentdate=time.strftime('%Y-%m-%d')
currentdate='2018-01-01'

############# To be modified #############
TOPIC = "[Cc]onference"
pagename="Givaudan"
ID="1471"
address="https://www.givaudan.com/investors/shareholder-information/investor-calendar"
##########################################

def altnames(mydict):
    aux_mydict = mydict.copy()
    for elem in mydict.keys():
        if "/" in elem:
            for alt in elem.split("/"):
                aux_mydict[alt] = mydict[elem]
            del aux_mydict[elem]
    return aux_mydict   

def findrows(soup_browser):
    """This method receives as parameter a BeautifulSoup object and
    returns a list of strings, one for each event to be processed"""
    rows=[]
    try:
    ############# To be modified #############
        rows=["13/14 November 2018$UBS Conference - London$UBS"]
    ##########################################
    except:
        print("Could not process webpage")
    return rows


def output(m,spondict,citydict):
    ############# To be modified #############
    ti,d,c,s="UBS Conference","2018-11-13/14","London","UBS"
    ###########################################
    return ti.strip(),d,c.strip(),s.strip()    


def processhtml(pageID,pageAddress,pcities,psponsors):
    """This method reads in the webpage with id pageID and url pageAddress
    and prints out the requested information for each of the relevant events found"""
    ############# To be modified #############
    url=request.urlopen(pageAddress,timeout=None).read()
    soup = BeautifulSoup(url,"lxml")
    r="(.*)\$(.*)\$(.*)"   
    for line in findrows(soup):
        m1=re.search(TOPIC,line)
        if m1:
            t=2 # this must be changed accordingly
            m2=re.search(r,line)
            if m2:
                ti,d,c,s=output(m2,psponsors,pcities)
                if d[:10]>currentdate:
                    c=pcities.get(c,c)
                    s=psponsors.get(s,s)
                    newrecord="Company: %s\nType: %s\nDate: %s\nTitle: %s\nCity: %s\nSponsor: %s\n"%(pageID,t,d,ti,c,s)
                    print(newrecord)
    ##########################################                    
    
                            

if __name__ == "__main__":
    ## Read cities list from file    
    cities=dict([line.strip().split(";") for line in open("city.csv", encoding='ISO-8859-1').readlines()[1:]])
    pcities = dict(zip([x for x in cities.values()],cities.keys()))
    pcities=altnames(pcities)
    ## Read sponsors list from file     
    sponsors=dict([line.strip().split(";") for line in open("sponsor.csv").readlines()[1:]])
    psponsors = dict(zip(sponsors.values(),sponsors.keys()))
    psponsors = altnames(psponsors)  

    print("Extract information from %s webpage"%pagename)
    processhtml(ID,address,pcities,psponsors)

                






