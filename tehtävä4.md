###### Pohjautuu terokarvinen.com sivun tehtäviin ja ohjeisiin
# Linux tehtävä 4

### Käytettävä laitteisto:
- Käyttöjärjestelmä: Xubuntu 16.04.3 LTS
- Prosessori: Intel Core i7-6700K
- Näytönohjain: Gigabyte GeForce GTX 980 Ti G1 GAMING 6 GB
- Emolevy: ASUS Z170 Pro Gaming
- Keskusmuisti: Kingston HyperX Fury Black 2 x 8 GB (DDR4, 2666 MHz, CL15)

## Aloitus

#### B)
Aloitin luomalla Vagrantilla kaksi virtualbox konetta, joista toiselle asensin salt-masterin ja toiselle salt-minionin.
Salt-masterilla lisäsin /etc/salt/master tiedostoon kohdan: "interface: 80.221.62.101", joka indikoi masterin IP-osoitetta.
Lisäsin salt-minionille myös masterin tiedot lisäämällä tiedostoon /etc/salt/minion rivin: "master: 80.221.62.101".
Koska kohtasin myöhemmin virheitä testasin asetusten tekemistä "hostname -I" komennolla saadulla IP-osoitteella, sekä julkisella IP-osoitteella.

Tämän jälkeen käynnistin salt-masterin komennolla "sudo salt-master".
Tein saman salt-minionille komennolla "sudo salt-minion"

Salt-master ei halunnut toimia, vaan antoi koko ajan ilmoitusta "Unable to bind socket, error: [Errno 99] Cannot assign requested address".

Käynnistelin salt-masteria uudestaan, mutta se ei vaan suostunut toimimaan ja edes salt-masterin resetointi ei enään onnistunut, vaan antoi virhettä.
![Virhe](https://github.com/Tommi852/linux1/raw/master/kuvat/restart.png)
Parin tunnin testailun jälkeen luovtin.


#### A) Ansible
Aloitin tekemällä kaksi virtuaalista konetta vagrantilla ja asentamalla toiselle niistä Ansiblen tällä scriptillä: https://github.com/joonaleppalahti/CCM/blob/master/ansible/ansible_install.sh
Tai käytin scriptistä vain ensimmäiset neljä riviä master koneella Ansiblen asentamiseen.
Tein koneet myös näiden ohjeiden mukaisesti: https://github.com/joonaleppalahti/CCM/blob/master/ansible/Ansible%20raportti.md

Lisäsin masterilla /etc/ansible/hosts tiedostoon rivin:

```
[test]
10.0.2.15
```
Tämän jälkeen asensin SSH:n orjakoneelle ja lisäsin masterin julkisen avaimen komennoilla:
```
ssh-keygen -t rsa
ssh-copy-id vagrant@10.0.2.15
```
Vagrant loi avaimen, mutta epäilen, että se on sama kuin orjakoneen oma avain sillä orja ja masterkone ovat samalla IP-osoitteella "hostname -I":n mukaan ja niillä on sama nimi.

Kokeilin testata masterilla pingausta komennolla "ansible test -m ping", jolloin master antoi virheen:
```
10.0.2.15 | UNREACHABLE! => {
    "changed": false, 
    "msg": "Failed to connect to the host via ssh: Permission denied (publickey,password).\r\n", 
    "unreachable": true
}
```
En siis saa yhteyttä tässäkään toimimaan. Kokeilin tässäkin käyttää masterin julkista IP-osoitetta, mutta sekään ei tuottanut tulosta.

Kokeilin vielä tehdä tästä rautakoneesta joka pyörittää virtuaalikoneita ansible masterin, ja sain sen ssh yhteyden asetettua, mutta master ei vieläkään saanut pingattua virtuaalista orjaa sen host IP-osoitteella eikä julkisella IP-osoitteella.
