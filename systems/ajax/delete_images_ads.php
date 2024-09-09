<?php
defined('unisitecms') or exit();
//Подключение к базе данных
$servername = "localhost";
$username = "u162091693_autospotgeo";
$password = "Auto2023Spot";
$dbname = "u162091693_autospotge";

$conn = new mysqli($servername, $username, $password, $dbname);

	// Показать столбцы таблицы
	$sqlShowColumns = "SHOW COLUMNS FROM uni_ads";
	$resultColumns = $conn->query($sqlShowColumns);
	
	if (!$resultColumns) {
		die("Query to show columns failed: " . $conn->error);
	}
	
	// Вывести имена столбцов
	while ($column = $resultColumns->fetch_assoc()) {
		echo "";
	}
	
	// Получение имен файлов из базы данных
	$sql = "SELECT ads_id, ads_images FROM uni_ads";
	$result = $conn->query($sql);
	
	if (!$result) {
		die("Query failed: " . $conn->error);
	}
	
	// Создаем массив для хранения всех файлов из базы данных
	$dbFileNames = array();
	
	while ($row = $result->fetch_assoc()) {
		// Декодируем данные JSON и проверяем, является ли это массивом
		$decodedImages = json_decode($row['ads_images'], true);
		
		if (is_array($decodedImages)) {
			// Добавляем декодированные изображения к массиву
			$dbFileNames = array_merge($dbFileNames, $decodedImages);
			} else {
			// Обрабатываем случай, когда данные JSON не являются массивом (например, это null или недопустимый JSON)
			echo "";
		}
	}
	
	// Путь к папке с изображениями "big"
	$imageFolderPathBig = '../../media/images_boards/bigs/';
	
	// Получение имен файлов из папки "big"
	$folderFileNamesBig = array_diff(scandir($imageFolderPathBig), array('..', '.'));
	
	// Удаление файлов формата webp и jpg, которых нет в базе
	$filesToDeleteBig = array_diff($folderFileNamesBig, $dbFileNames);
	$deletedCountBig = 0; // Инициализация счетчика удаленных файлов "big"
	
	foreach ($filesToDeleteBig as $file) {
		$filePathBig = $imageFolderPathBig . '/' . $file;
		
		// Получаем расширение файла
		$fileExtensionBig = pathinfo($filePathBig, PATHINFO_EXTENSION);
		
		// Проверяем, что файл имеет расширение webp или jpg
		if (strtolower($fileExtensionBig) === 'webp' || strtolower($fileExtensionBig) === 'jpg') {
			if (unlink($filePathBig)) {
				echo "";
				$deletedCountBig++;
				} else {
				echo "Не удалось удалить файл $filePathBig.\n<br>";
			}
		}
	}
	
	echo "Общее количество удаленных фото (big): $deletedCountBig\n"; // Вывод общего количества удаленных фото "big"
	
	// Путь к папке с изображениями "small"
	$imageFolderPathSmall = '../../media/images_boards/smalls/';
	
	// Получение имен файлов из папки "small"
	$folderFileNamesSmall = array_diff(scandir($imageFolderPathSmall), array('..', '.'));
	
	// Удаление файлов формата webp и jpg, которых нет в базе
	$filesToDeleteSmall = array_diff($folderFileNamesSmall, $dbFileNames);
	$deletedCountSmall = 0; // Инициализация счетчика удаленных файлов "small"
	
	foreach ($filesToDeleteSmall as $file) {
		$filePathSmall = $imageFolderPathSmall . '/' . $file;
		
		// Получаем расширение файла
		$fileExtensionSmall = pathinfo($filePathSmall, PATHINFO_EXTENSION);
		
		// Проверяем, что файл имеет расширение webp или jpg
		if (strtolower($fileExtensionSmall) === 'webp' || strtolower($fileExtensionSmall) === 'jpg') {
			if (unlink($filePathSmall)) {
				echo "";
				$deletedCountSmall++;
				} else {
				echo "Не удалось удалить файл $filePathSmall.\n<br>";
			}
		}
	}
	
	echo "Общее количество удаленных фото (small): $deletedCountSmall\n"; // Вывод общего количества удаленных фото "small"

?>
