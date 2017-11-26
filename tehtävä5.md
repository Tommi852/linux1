###### Pohjautuu terokarvinen.com sivun tehtäviin ja ohjeisiin
# Linux tehtävä 5

### Käytettävä laitteisto:
- Käyttöjärjestelmä: Xubuntu 16.04.3 LTS sekä Windows 10 64bit Pro
- Prosessori: Intel Core i7-6700K
- Näytönohjain: Gigabyte GeForce GTX 980 Ti G1 GAMING 6 GB
- Emolevy: ASUS Z170 Pro Gaming
- Keskusmuisti: Kingston HyperX Fury Black 2 x 8 GB (DDR4, 2666 MHz, CL15)

## Aloitus

#### A)

Käytän masterina jälleen kerran omaa palvelintani.

Aloitin tehtävän tekemällä windows koneestani orjan asentamalla puppetin osoitteesta: https://downloads.puppetlabs.com/windows/
Asensin sieltä version 3.8.5-x64.

Tämän jälkeen vaihdoin puppetin konffi tiedostoon polussa "C:\ProgramData\PuppetLabs\puppet\etc\puppet.conf" serverin omaani muokkaamalla server kohtaa:
```
[main]
server=165.227.183.78
```

Tämän jälkeen tein palvelimelleni moduulin hellowindows
```
class hellowindows {
 file {"C:/windowsorja.txt":
   content => "Tervehdys windows roska väki!\n",
 }
}
```
Jonka lisäsin site.pp tiedostoon komennolla "class {hellowindows:}"

Hain kyseisen testi moduulin palvelimeltani komennolla "puppet agent -tdv"

Windows ei heti saanut asetuksia sillä en ollut vielä sallinut windowsin sertifikaattia palvelimellani, jonka kävin sitten hyväksymässä.

Pyöräytin haku komennon uudestaan ja puppet agent alkoi hakemaan tiedostoja palvelimeltani sillä olin asentanut chocolateyn palvelimelleni jo tunnilla. Hakeminen kesti melko kauan.

Loppujen lopuksi tekstitiedosto ilmestyi C: aseman juureen, joten yhteystoimii.

Seuraavaksi asettelin linuxin orjaksi vanhalle tietokoneelleni ja pyöräytin siinä skriptin joka orjuutti sen nopeasti.
```
#!/bin/bash
sudo apt-get update
sudo apt-get install -y puppet
sudo echo "165.227.183.78 mestari420" |sudo tee --append /etc/hosts
sudo echo "[agent]"|sudo tee --append /etc/puppet/puppet.conf
sudo echo "server = mestari420"|sudo tee --append /etc/puppet/puppet.conf
sudo puppet agent --enable
sudo service puppet restart
```
Sallin taas tämänkin koneen palvelimellani.
Käytin aikaisemmissa tehtävissä tekemääni helloworld moduulia joka luo helloworld tiedoston /tmp kansioon ja se toimii.

Nyt minulla on siis windows ja linux orja samanaikaisesti.

#### B)

Tein moduulin, joka asentaa windowsille VLC soittimen. 

```
class hellowindows {
   include chocolatey

   Package {
       ensure => "installed",
       provider => "chocolatey",
   }

 file {"C:/windowsorja.txt":
   content => "Tervehdys windows roska väki!\n",
 }


   package {["vlc"]:}

}
```

Koska minulla oli jo VLC asennettuna, niin päätin poistaa sen nähdäkseni asentuuko se.

Koska A kohdassa otimme jo hellowindowsin käyttöön ei sitä tarvitse tässä enään erikseen lisätä site.pp tiedostoon.

Ajan taas windowsilla puppetin päivityksen, jotta näemme toimiiko moduuli.

Ajettuani komennon "puppet agent -tdv" VLC asentui nätisti ja ilmaantui työpöydälle. Moduuli siis toimii.
