# Docker Build Google Maps Scraper

This repository contains instructions on how to make a docker container that can run [omkarcloud](https://github.com/omkarcloud)'s [google-maps-scraper](https://github.com/omkarcloud/google-maps-scraper). I created this because I wasn't able to build  the original Docker image to run.



## Installation and Usage

To build the image you will first need to download into the browser file both **Google Chrome** and **Chromedriver** for **linux64**. 

Pay attention to which version of Google Chrome you download, because you will have to download the **same version** of chromedriver.

- Google Chrome for linux can be downloaded from [google's website](https://www.google.com/chrome/?platform=linux).
- The Chromedriver can be found [here](https://googlechromelabs.github.io/chrome-for-testing/).

After you will need to clone the [google-maps-scraper](https://github.com/omkarcloud/google-maps-scraper) repository into its own folder.

```bash
git clone https://github.com/omkarcloud/google-maps-scraper.git
```

And thats all you need to download.

You can now build the container image.

```bash
docker build --platform linux/amd64 -t IMAGE_NAME .
```

To run the container there are somethings you should pay attention to:
 - Make sure you use the ```-v /dev/shm/:/dev/shm/``` option, this will allow the container to use your machines shared memory, without this option I could not run it on my computer.
 - Mount the output of google-maps-scraper to your prefered destination folder, otherwise it might be hard to retrieve the files after each query. To do so you can add this option to the run command ```-v DESIRED_OUTPUT_DIR:/waza/google_maps_scraper/output```.
 - If you want to use the container multiple times you can run it detached with ```-it -d``` option.

This is the run command I have used:
```bash
docker run --name YOUR_CONTAINER_NAME --rm -v ./output:/waza/google_maps_scraper/output -it -d -v /dev/shm:/dev/shm waza/test4
```
Now that the Container is running you can query it by running the main.py script to make sure it works:
```bash
docker exec -it YOUR_CONTAINER_NAME python main.py max_nr_of_businesses max_nr_of_reviews query...
```
On success it will show where the files where stored inside the container, if you mounted the output folder to your machine you will probably find them there.

## Demo
[![IMAGE ALT TEXT HERE](https://img.youtube.com/vi/fmUhoHXErhY/0.jpg)](https://www.youtube.com/watch?v=fmUhoHXErhY)

## Authors

- [@waz4](https://www.github.com/waz4)

