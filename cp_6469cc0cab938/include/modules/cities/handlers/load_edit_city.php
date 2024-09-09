<?php
	
	define('cms', true);
	session_start();
	
	$config = require "../../../../../config.php";
	include_once( $config["basePath"] . "/systems/classes/Site.php");
	include_once( $config["basePath"] . "/" . $config["folder_admin"] . "/lang/" . $settings["lang_admin_default"].".php" );
	
	if( !(new Admin())->accessAdmin($_SESSION['cp_control_city']) ){
		$_SESSION["CheckMessage"]["warning"] = "Ограничение прав доступа!";
		exit;
	}
	
	$id = (int)$_POST["id"];
	$get = findOne("uni_city","city_id=?", array($id));
	
?>

<form id="form-data-city-edit" >
	
	<div class="form-group row d-flex align-items-center mb-5">
		<label class="col-lg-3 form-control-label">Название</label>
		<div class="col-lg-9">
			<input type="text" class="form-control setTranslate" value="<?php echo $get->city_name; ?>" name="name" >
		</div>
	</div>
	
	<!-- city_lng -->
	
	<?php
		$conn = new mysqli($config["db"]["host"], $config["db"]["user"], $config["db"]["pass"], $config["db"]["database"]);
		
		$sqlCount = "SELECT COUNT(*) AS count FROM uni_languages";
		$resultCount = $conn->query($sqlCount);
		$rowCount = $resultCount->fetch_assoc();
		$count = $rowCount['count'];
		
		
		$sqlIso = "SELECT name FROM uni_languages";
		$resultIso = $conn->query($sqlIso);
		$isoArray = array();
		
		if ($resultIso->num_rows > 0) {
			while ($rowIso = $resultIso->fetch_assoc()) {
				$isoArray[] = $rowIso['name'];
			}
		}
		
	?>
	
	
	<div class="form-group row d-flex align-items-center mb-5">
		<?php
			
			if ($count > 0) {
				for ($i = 0; $i < $count; $i++) {
					$fieldName = "name_" . ($i + 1);
					
					
					if ($i != 0) {
						echo '<label class="col-lg-3 form-control-label">' . $isoArray[$i] . '</label>';
						echo '<div class="col-lg-9"><div class="form-group d-flex align-items-center mb-5"><input type="text" class="form-control" value="'.$get->$fieldName.'" name="' . $fieldName . '"></div></div>';
					}
				}
				} else {
				
				echo '<label class="col-lg-3 form-control-label">Название</label>';
				echo '<div class="col-lg-9"><div><input type="text" class="form-control" value="" name="name_1"> iso</div></div>';
			}
		?>
	</div>
	
	<!--end_city_lng -->
	
	<div class="form-group row d-flex align-items-center mb-5">
		<label class="col-lg-3 form-control-label">Алиас</label>
		<div class="col-lg-9">
			<input type="text" class="form-control outTranslate" value="<?php echo $get->city_alias; ?>" name="alias" >
		</div>
	</div>
	
	<div class="form-group row d-flex align-items-center mb-5">
		<label class="col-lg-3 form-control-label">Склонение</label>
		<div class="col-lg-9">
			<input type="text" class="form-control" value="<?php echo $get->city_declination; ?>" name="declination" >
		</div>
	</div>
	
	<div class="form-group row d-flex align-items-center mb-5">
		<label class="col-lg-3 form-control-label">Описание</label>
		<div class="col-lg-9">
			<textarea name="desc" class="form-control" ><?php echo $get->city_desc; ?></textarea>
		</div>
	</div>
	
	<div class="form-group row d-flex align-items-center mb-5">
		<label class="col-lg-3 form-control-label">Широта (latitude)</label>
		<div class="col-lg-9">
			<input name="lat" class="form-control" value="<?php echo $get->city_lat; ?>">
		</div>
	</div>
	
	<div class="form-group row d-flex align-items-center mb-5">
		<label class="col-lg-3 form-control-label">Долгота (longitude)</label>
		<div class="col-lg-9">
			<input name="lng" class="form-control" value="<?php echo $get->city_lng; ?>">
		</div>
	</div>
	
	<input type="hidden" name="id" value="<?php echo $id; ?>" />                                                              
</form>