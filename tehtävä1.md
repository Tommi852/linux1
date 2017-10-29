###### Pohjautuu terokarvinen.com sivun tehtäviin ja ohjeisiin
# Linux tehtävä 1

## Käytettävä laitteisto:
- Käyttöjärjestelmä: Windows 10 Pro 64bit
- Prosessori: Intel Core i7-6700K
- Näytönohjain: Gigabyte GeForce GTX 980 Ti G1 GAMING 6 GB
- Emolevy: ASUS Z170 Pro Gaming
- Keskusmuisti: Kingston HyperX Fury Black 2 x 8 GB (DDR4, 2666 MHz, CL15)
- Muistitikku: Corsair 64GB Voyager Vega

## Aloitus

Aloitin tehtävän päivittämällä repositoryt ja asentamalla puppetin komennoilla:
```
sudo apt-get update
sudo apt-get install puppet
```
Tämän jälkeen lisäsin puppetin luomaan "/etc/puppet/" kansioon uuden moduulin komennoilla:
```
cd /etc/puppet
sudo mkdir -p modules/ssh/manifests/
sudo nano modules/ssh/manifests/init.pp
```

Otin mallia tunnilla tehdystä moduulista, jolla asennettiin apache2 ja muokkasin sitä SSH:n asennusta varten. (Apache2 moduuli löytyy osoitteesta: https://github.com/Tommi852/puppetman/blob/master/puppet/modules/apache2/manifests/init.pp)
Moduulin init.pp tiedostoon kirjoitin:
```
class ssh {
        package {'ssh':
        ensure => 'installed',
        allowcdrom => 'true',

        }
}

```
Kokeilin toimiiko ssh ennen kuin lähdin kokeilemaan moduulia komennolla:
```
ssh
```
Vastaukseksi sain:
```
bash: /usr/bin/ssh: No such file or directory
```
SSH ei siis ole asennettuna. Kokeillaan siis toimiiko moduuli nyt komennolla:
```
sudo puppet apply -e 'class {"ssh":}'
```
Jonka jälkeen puppet ilmoitti:
```
Notice: Compiled catalog for ubuntu in environment production in 0.17 seconds
Notice: /Stage[main]/Ssh/Package[ssh]/ensure: ensure changed 'purged' to 'present'
Notice: Finished catalog run in 2.94 seconds
```
Kokeilin SSH:n toimivuutta ottamalla yhteyden omaan palvelimeeni osoitteessa timonen.me.
Yhteyden otto onnistui ongelmitta ja SSH toimii normaalisti.
