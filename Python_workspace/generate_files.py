import requests
from bs4 import BeautifulSoup
import random

usa_states = ['New York', 'California', 'Washington','New Jersey', 'Illinois', 'Texas', 'Florida', 'Massachusetts', 'Pennsylvania', 'Georgia', 'Michigan', 'Arizona', 'Maryland', 'Virginia', 'North Carolina', 'Louisiana', 'Ohio', 'Connecticut', 'Indiana', 'Tennessee', 'Alabama', 'Minnesota', 'Colorado', 'South Carolina', 'Iowa', 'Wisconsin', 'Mississippi', 'Utah', 'Nebraska', 'Arkansas', 'Rhode Island', 'Nevada', 'Kentucky', 'Kansas', 'Oklahoma', 'New Mexico', 'Delaware', 'Oregon', 'South Dakota', 'New Hampshire', 'Idaho', 'North Dakota', 'Maine', 'West Virginia', 'Wyoming', 'Vermont', 'Montana', 'Missouri']
print(len(usa_states))


def find_country(country):
    finding = []
    website = requests.get("https://www.worldometers.info/coronavirus/country/us/")
    soup = BeautifulSoup(website.text, 'html.parser')
    table = soup.find("table", attrs={"id": "usa_table_countries_today"})
    find_verses = table.find_all("tr")
    lista = []
    for x in find_verses:
        lista.append(str(x))

    elements = ['State:', 'Ill:', 'Death:', 'Actual cases:', 'Tests:', 'Recovered: ', 'Population: ']
    matching = [s for s in lista if country in s] #szukanie odpowiedniego kraju
    matching = str(matching[0])
    finding.append(matching)
    if len(finding) != 0:
        f = finding[0]
        soup2 = BeautifulSoup(f, 'html.parser')
        proba2 = soup2.find_all("td")
        country = proba2[0].next_element.next_element.next_element
        total_cases = proba2[1].next_element.replace(" ", "")
        total_deaths = proba2[3].next_element.replace(" ", "")
        total_deaths = total_deaths.replace("\n", "")
        active_cases = proba2[5].next_element.replace(" ", "")
        active_cases = active_cases.replace("\n", "")
        total_tests = proba2[8].next_element.replace(" ", "")
        total_tests = total_tests.replace("\n", "")
        tests_per_million = proba2[9].next_element.replace(" ", "")
        tests_per_million = tests_per_million.replace("\n", "")
        if proba2[0].next_element == " ":
            country = proba2[0].next_element.next_element.next_element
        final = [country, total_cases, total_deaths, active_cases, total_tests, tests_per_million]
        print(final)

        for checking_empty in range(len(final)):
            if final[checking_empty] == "":
                final[checking_empty] = '0' #zerowanie pustych elementów dla danego kraju (np. gdy nie ma żadnych wyzdrowiałych)

        total_cases = int(final[1].replace(",", ""))
        total_deaths = int(final[2].replace(",", ""))
        active_cases = int(final[3].replace(",", ""))
        total_tests = int(final[4].replace(",", ""))
        tests_per_million = int(final[5].replace(",", ""))

        final = [country, total_cases, total_deaths, active_cases, total_tests]
        total_recovered = float(total_cases) - float(total_deaths) - float(active_cases)
        population = (float(total_tests)/float(tests_per_million)) * 1000000
        final.append(int(total_recovered))
        final.append(int(population))

        for element in range(len(elements)):
            print('{} {}'.format(elements[element], final[element]))

        return final


def create_file(stan):
    kraj = find_country(stan)
    file = "C:/Users/Kamil0232/Desktop/COVID19 Symulacja/Stany_USA/{}.txt".format(stan)
    f = open(file, 'w')
    foo = []
    foo_ill = [1,2,3,4,8,11,14,16]
    foo_health = [6,7,10,12,13,17]
    foo_recovered = [5,9,15,19]
    listx = []

    probability_ill = (kraj[3]/kraj[6])
    print('Ill probability:')
    print(probability_ill)
    probability_recovered = (kraj[5]/kraj[6])

    for b in range(1000):
        if b < (probability_ill*1000):
            listx.append(random.choice(foo_ill))
        if b > (probability_ill*1000) and b < (probability_ill*1000)+(probability_recovered*1000):
            listx.append(random.choice(foo_recovered))
        if b > (probability_ill*1000)+(probability_recovered*1000):
            listx.append(random.choice(foo_health))
    print(len(listx))

    lista_ratunkowa = []
    for fi in range(0,21):
        lista_ratunkowa.append(0)

    for k in range(1, 100001):
        list = []
        a = random.choice(listx)
        lista_ratunkowa[a] = lista_ratunkowa[a] + 1
        foo.append(a)
        if k < 100000:
            list.append(a)

            f.write(str(list[-1]))
            f.write(',')
        if k == 100000:
            list.append(a)
            f.write(str(list[-1]))
    f.close()

    print(len(foo))
    print(lista_ratunkowa)


for state in range(len(usa_states)):
    create_file(usa_states[state])


