FROM python:3.10

RUN apt update
RUN apt-get update

WORKDIR /waza

#Add folder containing both google-chrome and chromedriver (Compatible Versions)
COPY browser/ .

# Install Google Chrome and delete the instalation package
RUN apt install ./google-chrome-stable_current_amd64.deb -y
RUN rm -f google-chrome-stable_current_amd64.deb

# Install Google ChromeDriver and delete the instalation resources
COPY browser/chromedriver-linux64.zip .
RUN unzip chromedriver-linux64.zip
RUN rm -f chromedriver-linux64.zip
RUN mv chromedriver-linux64/chromedriver /usr/bin
RUN rm -fr chromedriver-linux64

# Install Node.js
RUN apt install nodejs npm -y

#Add Scrapping Utilities
COPY google-maps-scraper google_maps_scraper

#Add chromedriver to a specific path otherwise botasaurus does not like it
RUN mkdir google_maps_scraper/build
RUN cp /usr/bin/chromedriver google_maps_scraper/build/chromedriver-122

#Install Scraping Script Requirements
RUN pip install -r google_maps_scraper/requirements.txt

#Run Library once so it downloads the required node.js packages
WORKDIR /waza/google_maps_scraper
COPY setup_query.py .
RUN python setup_query.py

#Personal web scraping scripts
COPY main.py .

ENTRYPOINT ["bash"]