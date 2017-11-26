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
Seurasin tässä CCM tuottamia ohjeita osoitteesta: https://github.com/joonaleppalahti/CCM/blob/master/salt/Salt%20raportti.md#esivalmistelut

Aloitin tehtävän asentamalla Salt-masterin omalle palvelimelleni ja Salt-minionin omalle koneelleni.

Lisäsin salt-masterille sen oman IP-osoitteen config tiedostoon /etc/salt/master:
```
interface: 165.227.183.78
```
Sekä minionille sen omaan /etc/salt/minion:
```
master: 165.227.183.78
```

Tämän jälkeen käynnistin salt-masterin komennolla "sudo salt-master".
Tein saman salt-minionille komennolla "sudo salt-minion"

salt-minion ei saanut yhteyttä masteriin, joten jouduin avaamaan tulimuurin komennoilla:
```
sudo ufw allow 4505/tcp
sudo ufw allow 4506/tcp
```
Nyt minion sai yhteyden masteriini ja näin masterilla sen pyytämän avain vahvistuksen komennolla:
```
sudo salt-key -F master
```
Tämän jälkeen sallin avaimen antamalla komennon, joka sallii kaikki avaimet:
```
sudo salt-key -A
```
Pingasin vielä masterilla minionia komennolla:
```
sudo salt '*' test.ping
```
ja sain vastaukseksi
```
mestari420:
    True
```
Joka indikoi, että pingaus minioniin onnistui.

Tämän jälkeen koitin asentaa tetriksen omalle koneelleni salt-masterilla. Tein sen komennolla:
```
sudo salt '*' pkg.install bastet
```
Master ilmoitti tämän jälkeen:
```
mestari420:
    ----------
    bastet:
        ----------
        new:
            0.43-4build1
        old:
    libboost-program-options1.58.0:
        ----------
        new:
            1.58.0+dfsg-5ubuntu3.1
        old:
```
Kokeilin omalla koneellani oliko bastet asentunut ja kyllähän se hurahti käyntiin, kun kirjoitin komentoriville "bastet".

Näin tuli salt-master testattua.


#### A) Ansible
Aloitin asentamalla palvelimelleni Ansiblen tällä scriptillä: https://github.com/joonaleppalahti/CCM/blob/master/ansible/ansible_install.sh
Tai käytin scriptistä vain ensimmäiset neljä riviä Ansiblen asentamiseen.
Asentelin masterin myös näiden ohjeiden mukaisesti: https://github.com/joonaleppalahti/CCM/blob/master/ansible/Ansible%20raportti.md

Lisäsin masterilla /etc/ansible/hosts tiedostoon rivin:

```
[test]
80.221.62.101
```

Tämän jälkeen asensin SSH:n orjakoneelle ja lisäsin masterin julkisen avaimen komennoilla:
```
ssh-keygen -t rsa
ssh-copy-id tommi@timonen.me
```
Yhteys ei aluksi meinannut toimia, joten jouduin käyttämään komentoa "ssh-add", jotta saisin yksityisen identiteetin käyttöön.
Tämän jälkeen jouduin tekemään masterin vahvistukseen uudestaan pakotettuna komennolla:
```
sudo ssh-copy-id -f tommi@timonen.me
```
Nyt palvelimeni ssh tiedot ainakin tallentuivat koneelleni, mutta pingaus yritys masterilta minionille epäonnistuu edelleen ja antaa virheen:
```
80.221.62.101 | UNREACHABLE! => {
    "changed": false, 
    "msg": "Failed to connect to the host via ssh: ssh: connect to host 80.221.62.101 port 22: Connection refused\r\n", 
    "unreachable": true
}
```
Asetin reitittimeni ohjaamaan sisään tulevat 22 porttia käyttävät liikenteet tietokoneeseeni, mutta se ei auttanut tähän ongelmaan.
Tässä vaiheessa päätin luovuttaa.
