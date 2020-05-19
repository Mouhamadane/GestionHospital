-- 1) Donnez le numéro, le nom de tous les médecins ayant la spécialité S1
SELECT medecinID,medecinName,specialityName
FROM medecin,speciality
WHERE medecin.specialityID=speciality.specialityID AND speciality.specialityName='S1'
-- 2.	Donnez les différentes spécialités.
SELECT DISTINCT specialityName
FROM speciality
-- 3.	Donnez le numéro, le nom et la date de naissance de tous les malades de sexe masculin par ordre croissant de l’âge.
SELECT patientID,patientName,dateNaissance
FROM patient
WHERE sexe='masculin'
ORDER By dateNaissance
-- 4.	Donnez le numéro, le nom et la date de naissance de tous les malades de sexe féminin dont l’adresse contient « p » par ordre croissant du nom.
 SELECT patientID,patientName,dateNaissance
 FROM patient
 WHERE sexe='feminin' AND adressePatient LIKE '%p%'
 ORDER By patientName
--  5.	Donnez le numéro, le nom et la date de naissance du malade ainsi que le numéro, la catégorie et le type de la chambre occupé par chaque malade.
SELECT patientID,patientName,dateNaissance, room.roomID, categorie,roomType
FROM patient,room,bed
WHERE patient.bedNum=bed.bedNum AND bed.roomID= room.roomID
ORDER By patientName
-- 6.	Donnez le numéro, le nom et la date de naissance du malade ainsi que le numéro et le des départements où le malade né le 22-4-2012 ont été internés. 
SELECT patientID,patientName,dateNaissance,departementmedical.departmentID,departName
FROM patient,departementmedical
WHERE patient.departmentID=departementmedical.departmentID AND dateNaissance='2012-04-22'
-- 7.	Donnez le numéro, le nom et la date de naissance de tous les malades suivis par le médecin M3
SELECT patient.patientID,patientName,dateNaissance,medecinName
FROM patient,medecin,suivre
WHERE patient.patientID=suivre.patientID AND medecin.medecinID= suivre.medecinID AND medecin.medecinName= 'M3'
-- 8.	Donnez le numéro, le nom et la date de naissance de tous les malades suivis par le médecin M3 et qui ont occupé le lit numéro 21.
SELECT patient.patientID,patientName,dateNaissance
FROM patient,occupedbed,medecin
WHERE patient.patientID=occupedbed.patientID AND medecin.medecinName='M3' AND occupedbed.bedNum=1
-- 9.	Donnez le numéro, le nom et la date de naissance de tous les malades qui ont occupé le lit numéro 21.
SELECT patient.patientID,patientName,dateNaissance
FROM patient,occupedbed
WHERE patient.patientID=occupedbed.patientID AND occupedbed.bedNum=1
-- 10.	Donnez le numéro, le nom et la date de naissance du malade ainsi que le numéro et la date pour le suivit de l’évolution du malade numéro 11.
SELECT patient.patientID,patientName,feuille.numFeuille,feuille.dateFeuille
FROM patient,feuille
WHERE patient.patientID=feuille.patientID AND feuille.numFeuille=11
-- 11.	Donnez le nombre de malades internés dans chaque département.
SELECT departementmedical.departName, COUNT(patient.departmentID) as Total_Patient
FROM patient,departementmedical
WHERE patient.departmentID=departementmedical.departmentID
GROUP BY departName
-- 12.	Donnez le numéro, le nom, l’adresse du malade ainsi que le nom du médecin de tous les malades suivis par un médecin du département D2.
SELECT patient.patientID,patientName,adressePatient,medecin.medecinName
FROM patient,medecin,intervenir,suivre
WHERE intervenir.departmentID=patient.departmentID AND medecin.medecinID=intervenir.medecinID AND suivre.patientID=patient.patientID AND suivre.medecinID=medecin.medecinID
-- 13.	Donnez le numéro, le nom, l’adresse de tous les malades qui ont été internés au mois de février ou au mois de décembre.
SELECT patient.patientID,patientName,adressePatient
FROM patient,feuille
WHERE patient.patientID=feuille.patientID AND MONTH(dateFeuille)=5;
-- 14.	Donnez toutes les informations de la chambre ayant accueilli le plus de malade.
SELECT room.roomID,room.categorie,room.roomType,room.departmentID, COUNT(bed.roomID) AS NbreTotal
FROM bed,patient,room
WHERE patient.bedNum=bed.bedNum AND bed.roomID=room.roomID
GROUP BY room.roomID
LIMIT 1
-- 15.	Donnez toutes les informations du département ayant accueilli le plus de malade.
SELECT departementmedical.departmentID,departementmedical.departName, COUNT(patient.departmentID) AS NbreTotal
FROM patient,departementmedical
WHERE patient.departmentID=departementmedical.departmentID
GROUP BY patient.departmentID
ORDER BY nbreTotal DESC
LIMIT 1
-- 16.	Donnez toutes les informations de la chambre ayant accueilli le plus de malade.
SELECT room.roomID,room.categorie,room.roomType,room.departmentID, COUNT(bed.roomID) AS NbreTotal
FROM patient,bed,room
WHERE patient.bedNum=bed.bedNum AND room.roomID=bed.roomID
GROUP BY room.roomID
ORDER BY nbreTotal asc
LIMIT 1
-- 17.	Donnez toutes les informations du médecin ayant suivi le plus de malade.
SELECT medecin.medecinID,medecin.medecinName, medecin.specialityID, COUNT(suivre.medecinID) As NbrePatient
FROM medecin,suivre
WHERE medecin.medecinID=suivre.medecinID
GROUP BY suivre.medecinID
ORDER BY NbrePatient DESC
LIMIT 1
-- 18.	Donnez le numéro, le nom et la date de naissance du malade, le numéro de la chambre et le numéro du lit des patients qui son suivi par un médecin avec la spécialité S2
SELECT patient.patientID, patientName, dateNaissance, room.roomID,bed.bedNum,medecinName
FROM patient,room,bed,medecin,suivre,speciality
WHERE patient.patientID=suivre.patientID AND suivre.medecinID=medecin.medecinID AND medecin.specialityID=speciality.specialityID AND speciality.specialityName='Dermatologue'
GROUP BY patient.patientID
-- 19.	Donnez l’évolution du premier malade qui à été interné au département D2 en juin 2020
SELECT patient.patientID,patientName,feuille.dateFeuille
FROM patient,feuille,departementmedical
WHERE patient.patientID=feuille.patientID AND patient.departmentID=departementmedical.departmentID AND departementmedical.departName='AMICAR'
ORDER BY feuille.dateFeuille ASC
LIMIT 1
-- 20.	Donnez le numéro des lits qui n’ont pas été occupés au mois de mars.
SELECT bed.bedNum
FROM patient,bed,feuille
WHERE patient.bedNum = bed.bedNum AND feuille.patientID=patient.patientID AND Month (feuille.dateFeuille) != 5
















