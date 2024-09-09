<?php

define('cms', true);
session_start();

$config = require "../../../../../config.php";
include_once( $config["basePath"] . "/systems/classes/Site.php");
include_once( $config["basePath"] . "/" . $config["folder_admin"] . "/lang/" . $settings["lang_admin_default"].".php" );

if( !(new Admin())->accessAdmin($_SESSION['cp_control_board']) ){
   $_SESSION["CheckMessage"]["warning"] = "Ограничение прав доступа!";
   exit;
}

$id = intval($_POST["id"]);
$get = findOne("uni_services_ads_category","id=?", array($id));
  
?>


    <div class="form-group row d-flex align-items-center mb-5">
      <label class="col-lg-4 form-control-label">Статус</label>
      <div class="col-lg-6">
          <label>
            <input class="toggle-checkbox-sm toolbat-toggle" type="checkbox" name="visible" <?php if(!empty($get->visible)) echo 'checked=""'; ?> value="1" >
            <span><span></span></span>
          </label>
      </div>
    </div>

    <div class="form-group row d-flex align-items-center mb-5">
      <label class="col-lg-4 form-control-label">Изображение</label>
      <div class="col-lg-8">
          <?php echo img( array( "img1" => array( "class" => "change-img change-image", "path" => $config["media"]["other"] . "/" . $get->image, "width" => "60px" ), "img2" => array( "class" => "change-img change-image", "path" => $config["media"]["other"] . "/icon_photo_add.png", "width" => "60px" ) ) ); ?>
          <input type="file" name="image" class="input-img" >
      </div>
    </div>

    <div class="form-group row d-flex align-items-center mb-5">
      <label class="col-lg-4 form-control-label">Название</label>
      <div class="col-lg-8">
           <input type="text" class="form-control" value="<?php echo $get->name; ?>" name="title" >
      </div>
    </div>

    <div class="form-group row d-flex align-items-center mb-5">
      <label class="col-lg-4 form-control-label">Стоимость услуги за день</label>
      <div class="col-lg-3">
           <input type="text" class="form-control" value="<?php echo $get->price; ?>" name="price" >
      </div>
    </div>

    <div class="form-group row d-flex align-items-center mb-5">
      <label class="col-lg-4 form-control-label">Описание</label>
      <div class="col-lg-3">
           <textarea type="text" class="form-control" value="<?php echo $get->text; ?>" name="text" ><?php echo $get->text; ?></textarea>
      </div>
    </div>
  
  <input type="hidden" name="id" value="<?php echo $id; ?>" />

 