Pterodactyl Docker-Server auf unserem NAS als Backup zu speichern. Pterodactyl verfügt über eine großartige Funktion, mit der Crontabs Backups der einzelnen Server erstellt werden können. Wir nutzen diese Funktion, um die Backups regelmäßig automatisch auf unser NAS zu Hause zu speichern, falls unser "Pterodactyl Server" ausfällt oder beschädigt wird.
Der gesamte Vorgang wird mit zwei Skripten durchgeführt.

Zuallererst wird um 0 Uhr über Pterodactyl für jeden Server ein automatisches Backup erstellt.
Etwa 5-10 Minuten später verbindet sich unsere Synology NAS über SSH-Key mit unserem Server und startet dort ein Skript.
Dieses Skript fasst die erstellten Backups zu einer einzigen ZIP-Datei zusammen, legt sie in unser Verzeichnis und gewährt uns entsprechende Rechte.
Anschließend lädt unser NAS diese ZIP-Datei über SCP (SFTP) herunter.
Lokal wird ein neuer Ordner mit dem aktuellen Datum erstellt, in dem diese ZIP-Datei gespeichert wird.
Sobald der Download abgeschlossen ist, wird die temporäre ZIP-Datei auf dem Server gelöscht.
Anschließend sucht das Skript lokal nach Backups, die älter als 30 Tage sind, und löscht sie.
