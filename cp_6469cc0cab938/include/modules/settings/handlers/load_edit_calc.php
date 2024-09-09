<?php

define('cms', true);
session_start();

$config = require "../../../../../config.php";
include_once($config["basePath"] . "/systems/classes/Site.php");
include_once($config["basePath"] . "/" . $config["folder_admin"] . "/lang/" . $settings["lang_admin_default"] . ".php");

if (!(new Admin())->accessAdmin($_SESSION['cp_control_settings'])) {
    $_SESSION["CheckMessage"]["warning"] = "Ограничение прав доступа!";
    exit;
}

$id = intval($_POST["id"]);
$get = findOne("uni_calc", "id=?", array($id));

?>

<div class="form-group row d-flex align-items-center mb-5">
    <label class="col-lg-4 form-control-label">Название</label>
    <div class="col-lg-8">
        <input type="text" class="form-control setTranslate" value="<?php echo $get->name; ?>" name="name">
    </div>
</div>

<div class="form-group row d-flex align-items-center mb-5">
    <label class="col-lg-4 form-control-label">Акциз(Ставка)</label>
    <div class="col-lg-8">
        <input type="number" placeholder="Грузия Азербайджан" class="form-control" value="<?php echo $get->actiz; ?>" name="actiz">
    </div>
</div>

<div class="form-group row d-flex align-items-center mb-5">
    <label class="col-lg-4 form-control-label">Налог(тамож.)</label>
    <div class="col-lg-8">
        <input type="number" placeholder="Грузия Азербайджан" class="form-control" value="<?php echo $get->nal_customs; ?>" name="nal_customs">
    </div>
</div>

<div class="form-group row d-flex align-items-center mb-5">
    <label class="col-lg-4 form-control-label">Оформление</label>
    <div class="col-lg-8">
        <input type="number" placeholder="Грузия" class="form-control" value="<?php echo $get->apply; ?>" name="apply">
    </div>
</div>

<div class="form-group row d-flex align-items-center mb-5">
    <label class="col-lg-4 form-control-label">Налог(импорт)</label>
    <div class="col-lg-8">
        <input type="text" class="form-control" value="<?php echo $get->nal_import; ?>" name="nal_impt"
        placeholder="1_number;2_number Грузия">
    </div>
</div>

<div class="form-group row d-flex align-items-center mb-5">
    <label class="col-lg-4 form-control-label">Оценка эксперта</label>
    <div class="col-lg-8">
        <input type="number" placeholder="Грузия" class="form-control" value="<?php echo $get->reating_ex; ?>" name="rating_exp">
    </div>
</div>

<div class="form-group row d-flex align-items-center mb-5">
    <label class="col-lg-4 form-control-label">Тамож. декларация</label>
    <div class="col-lg-8">
        <input type="number" placeholder="Грузия Казахстан" class="form-control" value="<?php echo $get->customs_dec; ?>" name="Customs_declar">
    </div>
</div>

<div class="form-group row d-flex align-items-center mb-5">
    <label class="col-lg-4 form-control-label">Транзит. номер (60 дней)</label>
    <div class="col-lg-8">
        <input type="number" placeholder="Грузия" class="form-control" value="<?php echo $get->number_transitions; ?>"
            name="transition_number">
    </div>
</div>

<div class="form-group row d-flex align-items-center mb-5">
    <label class="col-lg-4 form-control-label">Таможенная пошлина</label>
    <div class="col-lg-8">
        <input type="number" placeholder="Казахстан Азербайджан" placeholder="Казахстан Азербайджан" class="form-control" name="customs_posh" value="<?php echo $get->customs_posh; ?>">
    </div>
</div>

<div class="form-group row d-flex align-items-center mb-5">
    <label class="col-lg-4 form-control-label">НДC</label>
    <div class="col-lg-8">
        <input type="number" placeholder="Казахстан" class="form-control" name="nds" value="<?php echo $get->nds; ?>">
    </div>
</div>

<div class="form-group row d-flex align-items-center mb-5">
    <label class="col-lg-4 form-control-label">Сертификат безопастности</label>
    <div class="col-lg-8">
        <input type="number" placeholder="Казахстан" class="form-control" name="certif_secur" value="<?php echo $get->certif_secur; ?>">
    </div>
</div>

<div class="form-group row d-flex align-items-center mb-5">
    <label class="col-lg-4 form-control-label">Утильсбор</label>
    <div class="col-lg-8">
        <input type="text" placeholder="(1_number;2_number) Казахстан" class="form-control" name="recycling" value="<?php echo $get->recycling; ?>">
    </div>
</div>

<div class="form-group row d-flex align-items-center mb-5">
    <label class="col-lg-4 form-control-label">Первичная регистрация</label>
    <div class="col-lg-8">
        <input type="text" placeholder="(ставка;до 2х лет; от 2х до 3х; более 3х лет) Казахстан" class="form-control" name="reg" value="<?php echo $get->reg; ?>">
    </div>
</div>

<div class="form-group row d-flex align-items-center mb-5">
    <label class="col-lg-4 form-control-label">Услуга “Сопровождение клиента”</label>
    <div class="col-lg-8">
        <input type="number" placeholder="Казахстан Азербайджан Армения Кыргызстан" class="form-control" name="service_escort" value="<?php echo $get->service_escort; ?>">
    </div>
</div>

<div class="form-group row d-flex align-items-center mb-5">
    <label class="col-lg-4 form-control-label">Оформление экспортных документов</label>
    <div class="col-lg-8">
        <input type="number" placeholder="Казахстан Азербайджан Армения Кыргызстан" class="form-control" name="apply_escort" value="<?php echo $get->apply_escort; ?>">
    </div>
</div>

<div class="form-group row d-flex align-items-center mb-5">
    <label class="col-lg-4 form-control-label">Доставка до Алматы (ориентир.)</label>
    <div class="col-lg-8">
        <input type="number" placeholder="Казахстан" class="form-control" name="delivery_almat" value="<?php echo $get->delivery_almat; ?>">
    </div>
</div>

<div class="form-group row d-flex align-items-center mb-5">
    <label class="col-lg-4 form-control-label">Операционный сбор</label>
    <div class="col-lg-8">
        <input type="number" placeholder="Азербайджан" class="form-control" name="operac_collecting" value="<?php echo $get->operac_collecting; ?>">
    </div>
</div>

<div class="form-group row d-flex align-items-center mb-5">
    <label class="col-lg-4 form-control-label">Сертификат</label>
    <div class="col-lg-8">
        <input type="number" placeholder="Азербайджан" class="form-control" name="certif" value="<?php echo $get->certif; ?>">
    </div>
</div>

<div class="form-group row d-flex align-items-center mb-5">
    <label class="col-lg-4 form-control-label">Доставка до Баку (ориентир.)</label>
    <div class="col-lg-8">
        <input type="number" placeholder="Азербайджан" class="form-control" name="delivery_baku" value="<?php echo $get->delivery_baku; ?>">
    </div>
</div>

<div class="form-group row d-flex align-items-center mb-5">
    <label class="col-lg-4 form-control-label">Доставка до Еревана (ориентир.)</label>
    <div class="col-lg-8">
        <input type="number" placeholder="Армения" class="form-control" name="delivery_erevan" value="<?php echo $get->delivery_erevan; ?>">
    </div>
</div>

<div class="form-group row d-flex align-items-center mb-5">
    <label class="col-lg-4 form-control-label">Доп. расходы</label>
    <div class="col-lg-8">
        <input type="number" placeholder="Кыргызстан Армения" class="form-control" name="additional_expenses" value="<?php echo $get->additional_expenses; ?>">
    </div>
</div>

<div class="form-group row d-flex align-items-center mb-5">
    <label class="col-lg-4 form-control-label">Доставка до Бишкека (ориентир.)</label>
    <div class="col-lg-8">
        <input type="number" placeholder="Кыргызстан" class="form-control" name="delivery_bishkent" value="<?php echo $get->delivery_bishkent; ?>">
    </div>
</div>

<input type="hidden" name="id" value="<?php echo $id; ?>" />