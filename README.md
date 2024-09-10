## Procedimiento para convertir imágenes de DICOM a NIFTI

El script `runProcessing.sh` centraliza toda la conversión y llama a otros para realizar todas las tareas. El pipeline de procesamiento es el siguiente:

1. Las imágenes se copian en la carpeta `pending`
2. Se ejecuta `runProcessing.sh`
	1. Crea una carpeta para el sujeto en `tmp`
	2. Crea una carpeta para el sujeto en `store/image/ANALYZE`
	3. Crea una copia comprimida de la carpeta en DICOM y la copia en `store/image/DICOM`
	4. Ejecuta la conversión con el comando `mcverter -o <output> -f nifti -v -x -d -n -F PR <input>`
	5. Ejecuta el script `test_rename.sh`
		1. Ejecuta el script `test_compress.sh`
			1. Encuentra todos los ficheros `.nii`
			2. Los comprime para convertirlos en `.nii.gz`
			3. Reorienta las imágenes ya convertidas (`mcverter` las orienta de forma diferente al MNI, aunque en FSLView las etiquetas de posición son correctas). Usa el comando `fslreorient2std` (que reorienta la imagen como la MNI sin modificarla) 
		2. Renombra las imágenes con los nombres convencionales que usamos para las secuencias
	6. Crea los subdirectorios para cada secuencia en `ANALYZE` y copia las imágenes en sus directorios correspondientes
	7. Hace la conversión de las imágenes de DTI usando `dcm2niix` 
	8. Renombra las secuencias de DTI y las mueve a sus directorios correspondientes
	9. Se ejecuta `report.sh` que añade una línea a `report.csv` con la información del sujeto que se acaba de procesar (se indica qué secuencias tiene y si alguna está incompleta, y hace una detección automatizada del protocolo aplicado)



El usuario solo tiene que realizar los pasos 1 y 2. Los pasos internos de cada script se realizan automáticamente.

Actualmente el script está preparado para hacer la conversión de las imágenes de los siguientes protocolos:
- CANNABIS
- FEPs
- MANIA
- AVH
- LESEX

>### Error con imágenes DTI en processing1 y processing2
>
>Actualmente las imágenes de DTI no se convierten correctamente con el script de `runProcessing.sh` si se ejecuta en processing1 o processing2. Esto ocurre porque la versión de `dcm2niix` que hay en los processing 1 y 2 es antigua y tiene un error a la hora de identificar las imágenes. Esto no pasaba antes, parece deberse al cambio de software que han hecho en SJD en julio de 2024.
>
>La conversión funciona correctamente con versiones más nuevas de `dcm2niix` como la que hay en processing4 o la que viene con el MRIcroGL (con interfaz gráfica para poder usarla en Windows).
>
>Por ahora conviene ejecutar el `runProcessing.sh` en processing4 para que la conversión del DTI funcione
>

