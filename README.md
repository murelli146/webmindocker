# webmindocker
Der webmindocker dient zum einfachen Backup von Docker-Volumes auf z.B. einem NAS mittels FTP
und bietet einen SSH Zugang für z.B. Filezilla zum einfachen bearbeiten verschiedenster Konfigurationsdateien der gemounteten Volumes. 

* Webminport 10000
* Benutzer: admin
* Passwort: admin
 
Einfach die Volumes im Container mounten und den ganzen /mnt regelmäßig auf ein NAS sichern lassen.
Webmin > System >Filesystem Backup (ip:10000/fsdump)

* SSH 22
* Benutzer: root
* Passwort: root
 
