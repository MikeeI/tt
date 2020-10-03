from selenium import webdriver
from time import sleep
import os
from sys import argv

options = webdriver.ChromeOptions()

options.add_argument("--no-sandbox")
options.add_argument("--disable-dev-shm-usage")
options.headless = True

driver = webdriver.Chrome(options=options)
driver.set_window_size(2000, 2000)
driver.implicitly_wait(10)

driver.get("https://anonfiles.com/LfUap8X4o0/WinPE10_8_Sergei_Strelec_x86_x64_2020.09.21_English_rar/")

download = driver.find_element_by_id("download-url")
download_link = download.get_attribute("href")

print("Download Link: ", download_link)

os.system("axel -n 16 " + "\'" + download_link + "\'" )

driver.quit()
