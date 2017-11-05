###### Pohjautuu terokarvinen.com sivun tehtäviin ja ohjeisiin
# Linux tehtävä 1

## Käytettävä laitteisto:
- Käyttöjärjestelmä: Ubuntu 16.04.3 LTS
- Prosessori: Intel Core i7-6700K
- Näytönohjain: Gigabyte GeForce GTX 980 Ti G1 GAMING 6 GB
- Emolevy: ASUS Z170 Pro Gaming
- Keskusmuisti: Kingston HyperX Fury Black 2 x 8 GB (DDR4, 2666 MHz, CL15)
- Muistitikku: Corsair 64GB Voyager Vega

## Aloitus
Aloitin tehtävän tekemällä bash scriptin nimeltä "fastsetup" puppetin asennusta varten. Scriptiin kirjoitin:
```
#!/bin/bash
setxkbmap fi
sudo apt-get update
sudo apt-get install -y git
sudo apt-get install -y puppet
git clone https://github.com/Tommi852/linux1.git
git config --global user.email "timonen@outlook.com"
git config --global user.name "Tommi Timonen"
git config --global credential.helper "cache --timeout=36000"

```
Kokeilin scriptin toimintaa komennolla "bash fastsetup" ja kaikki ohjelmat sekä asetukset tulivat voimaan ongelmitta.

Tämän jälkeen latasin githubista tunnilla tehdyt puppet moduulit.

