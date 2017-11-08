###### Pohjautuu terokarvinen.com sivun tehtäviin ja ohjeisiin
# Linux tehtävä 1

## Käytettävä laitteisto:
- Käyttöjärjestelmä: Ubuntu 16.04.3 LTS
- Prosessori: Intel Core i7-6700K
- Näytönohjain: Gigabyte GeForce GTX 980 Ti G1 GAMING 6 GB
- Emolevy: ASUS Z170 Pro Gaming
- Keskusmuisti: Kingston HyperX Fury Black 2 x 8 GB (DDR4, 2666 MHz, CL15)

## Aloitus

Aloitin tehtävän suorittamalla fastsetup scriptini, joka asettaa muutaman aliaksen, päivittää repositoryt, sekä asentaa gitin ja puppetin.
Scripti löytyy täältä: https://github.com/Tommi852/linux1/blob/master/fastsetup
Tämän jälkeen asensin puppet masterin komennolla:
```
gimme puppetmaster
```
*"gimme" on fastsetupissa asetettu alias komennolle "sudo apt-get -y install"*

Asennuksen jälkeen jälkeen pysäytin puppetmasterin ja poistin sen sertifikaatit komennoilla:
```
sudo service puppetmaster stop
sudo rm -r /var/lib/puppet/ssl
```
Tämän jälkeen muokkasin puppetin konfiguraatio tiedostoa komennolla:
```
sudoedit /etc/puppet/puppet.conf
```
Konfiguraatioon lisäsin [master] otsikon alle:
```
dns_alt_names = master, mestari, mestari420, master420
autosign = true
```
Autosignin laitoin päälle, sillä aion asentaa monta konetta samanaikaisesti ja yksittäinen koneiden hyväksyminen olisi turhauttavaa.

Laitoin puppetmasterin takaisin päälle komennolla:
```
sudo service puppetmaster start
```
Tein Vagrantfile nimisen tiedoston 



