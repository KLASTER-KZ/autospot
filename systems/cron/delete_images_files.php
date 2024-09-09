<?php

	$conn = new mysqli($config['db']['host'], $config['db']['user'], $config['db']['pass'], $config['db']['database']);
	
	$sqlShowColumns = "SHOW COLUMNS FROM uni_ads";
	$resultColumns = $conn->query($sqlShowColumns);
	
	if (!$resultColumns) {
		die("Query to show columns failed: " . $conn->error);
	}
	
	while ($column = $resultColumns->fetch_assoc()) {
		echo "";
	}
	
	$sql = "SELECT ads_id, ads_images FROM uni_ads";
	$result = $conn->query($sql);
	
	if (!$result) {
		die("Query failed: " . $conn->error);
	}
	
	$dbFileNames = array();
	
	while ($row = $result->fetch_assoc()) {
		
		$decodedImages = json_decode($row['ads_images'], true);
		
		if (is_array($decodedImages)) {
			
			$dbFileNames = array_merge($dbFileNames, $decodedImages);
			} else {
			
			echo "";
		}
	}

	$imageFolderPathBig = '../../media/images_boards/big/';

	$folderFileNamesBig = array_diff(scandir($imageFolderPathBig), array('..', '.'));

	$filesToDeleteBig = array_diff($folderFileNamesBig, $dbFileNames);
	$deletedCountBig = 0; 
	
	foreach ($filesToDeleteBig as $file) {
		$filePathBig = $imageFolderPathBig . '/' . $file;
		
		
		$fileExtensionBig = pathinfo($filePathBig, PATHINFO_EXTENSION);
		
		
		if (strtolower($fileExtensionBig) === 'webp' || strtolower($fileExtensionBig) === 'jpg') {
			if (unlink($filePathBig)) {
				echo "";
				$deletedCountBig++;
				} else {
				echo "Не удалось удалить файл $filePathBig.\n<br>";
			}
		}
	}
	
	echo "Общее количество удаленных фото (big): $deletedCountBig\n"; 
	
	$imageFolderPathSmall = '../../media/images_boards/small/';
	
	
	$folderFileNamesSmall = array_diff(scandir($imageFolderPathSmall), array('..', '.'));
	
	
	$filesToDeleteSmall = array_diff($folderFileNamesSmall, $dbFileNames);
	$deletedCountSmall = 0; 
	
	foreach ($filesToDeleteSmall as $file) {
		$filePathSmall = $imageFolderPathSmall . '/' . $file;
		
		
		$fileExtensionSmall = pathinfo($filePathSmall, PATHINFO_EXTENSION);
		
		
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

