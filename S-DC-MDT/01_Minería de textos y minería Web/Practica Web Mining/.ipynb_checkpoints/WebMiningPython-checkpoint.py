import re
from dateutil.parser import parse
from bs4 import BeautifulSoup
from urllib import request
import time



##currentdate=time.strftime('%Y-%m-%d')
currentdate='2018-01-01'

############# To be modified #############
currentdate = '2019-01-01'
TOPIC = "[Cc]onference|[Rr]oadshow|[Ii]nvestor days?"
pagename = "Rational"
ID = "2414"
address = "https://www.rational-online.com/en_in/Company/Investor_Relations/Financial_and_roadshow_calendar_"
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
        rows = soup_browser.find_all("table")[2].find_all("tr")
    ##########################################
    except:
        print("Could not process webpage")
    return rows

def processhtml(pageID,pageAddress,pcities,psponsors):
    """This method reads in the webpage with id pageID and url pageAddress
    and prints out the requested information for each of the relevant events found"""
    ############# To be modified #############
    url = request.urlopen(pageAddress,timeout=None).read()
    soup = BeautifulSoup(url,"lxml")
    r="(.*)\$(.*)\$(.*)\$(.*)"
    
    for row in findrows(soup):
        
        line = [elem.text.strip() for elem in row.find_all("td")]
        line = "$".join(line)

        m = re.search(TOPIC,line)

        if m != None:
            
            n = re.search(r,line)

            if n.group(1).lower() == "conference":
                t = 1
            elif n.group(1).lower() == "roadshow":
                t = 2
            else:
                t = 3

            date = n.group(4)
            date = parse(date,dayfirst = True).strftime('%Y-%m-%d')
            
            if date > currentdate:
            
                if n.group(2) in pcities.keys():
                    c = pcities[n.group(2)]
                else:
                    c = "Not Available"

                if n.group(3) in psponsors.keys():
                    s = psponsors[n.group(3)]
                else:
                    s = "Not Available"

                print("")
                print("Company:",ID)
                print("Type:",t)
                print("Date:",date)
                print("Title:",n.group(1))
                print("City:",c)
                print("Institute:",s)

                print("")
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

                






