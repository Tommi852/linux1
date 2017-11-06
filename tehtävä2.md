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
### A)
Aloitin tehtävän tekemällä bash scriptin nimeltä "fastsetup" githubin, puppetin ja asetusten asennusta varten. Scriptiin kirjoitin:
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
cp -r linux1/puppet /etc/
```
Kokeilin scriptin toimintaa komennolla "bash fastsetup" ja kaikki ohjelmat ohjelmat sekä asetukset tulivat voimaan ongelmitta.
Scripti ei kuitenkaan onnistunut kopioimaan puppet kansiota /etc/ kansioon, koska käyttöoikeudet eivät riittäneet.
Tämä ongelma oli helppo korjata suorittamalla scripti sudo oikeuksilla "sudo bash fastsetup".

Sitten rupesin lisäämään puppetin moduulin asennusta scriptiin.
Lisäsin vain SSH moduulin, sillä en välttämättä tarvitse apachea tai mysql:ää aina.
Lisäsin moduulin asennuksen lisäämällä scriptin perään yhden rivin:
```
puppet apply --modulepath modules/ -e 'class {"ssh":}'
```
Kokeilin vielä SSH yhteyden toimivuuden ja se toimi juuri niinkuin pitää.

### B)

Aloitin tehtävän asentamalla Oracle VM VirtualBox manageriin kaksi puhdasta Xubuntu 16.04.3 LTS distroa. Toisen nimeksi määritin asennuksessa master ja toisen slave.
Asennusten valmistuttua asensin slave:lle puppetin ja masterille puppetmasterin.
Tämän jälkeen muutin virtual boxien verkko asetuksia siten, että kummatkin ovat samassa lähiverkossa. Tämä onnistui kummankin koneen settingseissä olevien network asetusten muuttamisella Host-only adaptereiksi. Näin asetettuina koneet eivät saa yhteyttä ulkoiseen verkkoon, mutta saavat yhteyden toisiinsa.

Tarkistin yhteyden toimivuuden katsomalla kummankin koneen osoitteet komennolla "hostname -I". Tämän jälkeen kokeilin pingata kummallakin koneella toisiaan. Kummankin koneen paketit menivät perille toisilleen.

Tämän jälkeen pysäytin puppetmasterin ja poistin puppetin ssl kansion komennoilla:
```
sudo service puppetmaster stop
sudo rm -r /var/lib/puppet/ssl
```
Tämän jälkeen lisäsin puppetmasterin /etc/puppet/puppet.conf tiedostoon master asetuksiin dns alternatiivi nimet:
```
dns_alt_names = puppet, master.local, puppet.timonen.me
```
ja käynnistin puppetmasterin uudestaan.
```
sudo service puppetmaster start
```
Sitten olikin aika siirtyä slave koneen pariin.
Slave koneella muokkasin /etc/puppet/puppet.conf asetustiedostoa siten, että lisäsin loppuun kohdan:
```
[agent]
server = master.local
```
Tämän jälkeen sallin puppet slaven lisäämällä /etc/default/puppet tiedostoon rivin:
```
START=yes
```
Nyt oli aika käynnistää slaven puppet uusiksi komennolla:
```
sudo service puppet restart
```
Tämän jälkeen tarkistin slaven sertifikaatin komennolla:
```
sudo puppet cert --list
```
Komento antoi yhden sertifikaatin:
```
  "slave" (SHA256) 46:CA:78:AB:B3:75:42:69:2E:F2:CE:BD:10:CE:39:A5:A3:F5:3C:F9:21:00:63:4B:F2:A9:DF:43:0A:F9:31:94
```
Tämän jälkeen hyväksyin sertifikaatin komennolla:
```
sudo puppet cert --sign slave
```
