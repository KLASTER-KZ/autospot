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

if (isAjax() == true) {

    $error = array();

    $Main = new Main();

    $id = (int) $_POST["id"];

    $find = findOne("uni_calc", "id=?", array($id));

    $name = clear($_POST["name"]);
    $actiz = clear($_POST["actiz"]);
    $nal_customs = clear($_POST["nal_customs"]);
    $apply = clear($_POST["apply"]);
    $nal_impt = clear($_POST["nal_impt"]);
    $rating_exp = clear($_POST["rating_exp"]);
    $Customs_declar = clear($_POST["Customs_declar"]);
    $transition_number = clear($_POST["transition_number"]);
    $customs_posh = clear($_POST["customs_posh"]);
    $nds = clear($_POST["nds"]);
    $certif_secur = clear($_POST["certif_secur"]);
    $recycling = clear($_POST["recycling"]);
    $reg = clear($_POST["reg"]);
    $service_escort = clear($_POST["service_escort"]);
    $apply_escort = clear($_POST["apply_escort"]);
    $delivery_almat = clear($_POST["delivery_almat"]);
    $operac_collecting = clear($_POST["operac_collecting"]);
    $certif = clear($_POST["certif"]);
    $delivery_baku = clear($_POST["delivery_baku"]);
    $delivery_erevan = clear($_POST["delivery_erevan"]);
    $additional_expenses = clear($_POST["additional_expenses"]);
    $delivery_bishkent = clear($_POST["delivery_bishkent"]);

    if (empty($name)) {
        $error[] = "Пожалуйста, укажите название страны";
    }    

    if (count($error) == 0) {

        update("UPDATE uni_calc SET name=?, actiz=?, nal_customs=?, apply=?, nal_import=?, reating_ex=?, customs_dec=?, number_transitions=?, customs_posh=?, nds=?, certif_secur=?, recycling=?, reg=?, service_escort=?, apply_escort=?, delivery_almat=?, operac_collecting=?, certif=?, delivery_baku=?, delivery_erevan=?, additional_expenses=?, delivery_bishkent=? WHERE id=?", [$name, $actiz, $nal_customs, $apply, $nal_impt, $rating_exp, $Customs_declar, $transition_number, $customs_posh, $nds, $certif_secur, $recycling, $reg, $service_escort, $apply_escort, $delivery_almat, $operac_collecting, $certif, $delivery_baku, $delivery_erevan, $additional_expenses, $delivery_bishkent, $id]);

        $_SESSION["CheckMessage"]["success"] = "Действие успешно выполнено!";
        echo true;

    } else {
        $_SESSION["CheckMessage"]["warning"] = implode("<br/>", $error);
    }

}
?>