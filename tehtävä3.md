###### Pohjautuu terokarvinen.com sivun tehtäviin ja ohjeisiin
# Linux tehtävä 1

### Käytettävä laitteisto:
- Käyttöjärjestelmä: Ubuntu 16.04.3 LTS
- Prosessori: Intel Core i7-6700K
- Näytönohjain: Gigabyte GeForce GTX 980 Ti G1 GAMING 6 GB
- Emolevy: ASUS Z170 Pro Gaming
- Keskusmuisti: Kingston HyperX Fury Black 2 x 8 GB (DDR4, 2666 MHz, CL15)

## Aloitus

###A), C) ja D)
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
Tein Vagrantfile nimisen tiedoston ja rakensin ohjeet vagrantille, kuinka koneet tulisi asentaa. Käytin loop rakennetta, jotta voin helposti määrätä montako konetta asennetaan.
Koodiin on lisätty scripti nimeltä "slaver", joka määritetään puppetin asennuksen ja masterin tietojen asettamisen.
Vagrantfilen työstäminen haluamanilaiseksi vei melko paljon aikaa sillä en ollut yhtään perillä sen syvemmästä toiminnasta. Hetken  tutkittuani sain kuitenkin puoli toimivan version ja jouduin kysymään stackoverflowsta apua. Stack overflowssa ystävällisesti neuvottiinkin miten koodi tulee korjata.

Vagrantfile näyttää tältä:
```
Vagrant.configure(2) do |config|

        config.vm.box = "minimal/xenial64"
        config.vm.provision "shell", path: "slaver"
(1..100).each do |i|
        config.vm.define "slave#{i}" do |slave|
                slave.vm.hostname = "slave#{i}"

        slave.vm.provider "virtualbox" do |vb|
                vb.memory = 150
                vb.linked_clone = true
        end

 end
end
end
```
Ja slaver taas tältä:
```
# Modification of code found at http://TeroKarvinen.com/
apt update
apt install -y puppet
echo "192.168.100.12 mestari420" |sudo tee --append /etc/hosts
echo "[agent]"|sudo tee --append /etc/puppet/puppet.conf
echo "server = mestari420"|sudo tee --append /etc/puppet/puppet.conf
puppet agent --enable
service puppet restart
```
Pistin Vagrantin asentelemaan koneita komennolla:
```
vagrant up
```
Tämän jälkeen asensin gnome-system-monitor ohjelman seuratakseni, ettei virtuaalikoneet tuki koko RAM muistia.

Loppujen lopuksi sain asennettua 51 konetta, kunnes vagrant ilmoitti, että virtuaalikoneella on tapahtunut portti yhteentörmäys, jota se on koittanut korjata automaattisesti, mutta kaikki automaattisen korjauksen käyttämät portit ovat jo käytössä.
Tyydyin nyt toistaiseksi tähän  määrään.

### B)

Lista koneista:
```

```
