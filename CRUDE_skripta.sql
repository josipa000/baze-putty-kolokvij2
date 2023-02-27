
--konfiguracija--
$student='jgalic_21';
$baza='jgalic_21_20';
$imeTablice='kuhar';
$direktorij='VK2_kuhar';

--create--
 <label for="ime">Ime</label>
            <input type="text" id="ime" name="ime">
            
            <label for="prezime">Prezime</label>
            <input type="text" id="prezime" name="prezime">

            <label for="razina">Razina</label>
            <input type="text" id="razina" name="razina">

--read--

 <!-- Student mijenja OD ove linije -->
              <th>Ime</th>
              <th>Prezime</th>
              <th>Razina</th>
<!-- Student mijenja DO ove linije -->

<!-- Student mijenja OD ove linije -->
         <td> <?=$red->ime?> </td>
         <td> <?=$red->prezime?> </td>
         <td> <?=$red->razina?> </td>
<!-- Student mijenja DO ove linije -->

--update--

<label for ="ime">Ime</label>
<input type ="text" id="ime" name="ime" value="ime">

<label for ="prezime">Prezime</label>
<input type ="text" id="prezime" name="prezime" value="prezime">

<label for ="razina">Razinae</label>
<input type ="text" id="razina" name="razina" value="razina">

--delete--

Želite li sigurno obrisati <?=$red->ime?> <?=$red->prezime?> <?=$red->razina?>?

--filezilla--
