<?php


session_start();
define("cms", true);
$config = (require "config.php");
include_once "systems/classes/Site.php";
$Main = new Main();
$Profile = new Profile();
$Geo = new Geo();
$Banners = new Banners();
$Cart = new Cart();
$Main->accessSite();
$Profile->activation();
$Profile->checkAuth();
$Banners->click();
if (isset($_GET["logout"])) {
    update("update uni_clients set clients_cookie_token=? where clients_id=?", ["", intval($_SESSION["profile"]["id"])]);
    unset($_SESSION["profile"]);
    setcookie("tokenAuth", "", time() - 2592000);
}
if ($config["https"] && strpos($_SERVER["HTTP_CF_VISITOR"], "https") === false && (!isset($_SERVER["HTTPS"]) || $_SERVER["HTTPS"] == "off")) {
    $redirect_url = "https://" . $_SERVER["HTTP_HOST"] . $_SERVER["REQUEST_URI"];
    header("Location: " . $redirect_url);
    exit;
}
if (strpos($_SERVER["REQUEST_URI"], "//") !== false) {
    $redirect_url = "https://" . $_SERVER["HTTP_HOST"] . "/" . preg_replace("|([/]+)|s", "/", trim($_SERVER["REQUEST_URI"], "/"));
    header("Location: " . $redirect_url);
    exit;
}
if (strpos(getenv("HTTP_HOST"), "www.") !== false) {
    $redirect_url = $config["urlPath"] . "/" . trim($_SERVER["REQUEST_URI"], "/");
    header("Location: " . $redirect_url);
    exit;
}
if (strpos($_SERVER["REQUEST_URI"], $config["urlPrefix"]) !== false && $config["urlPrefix"] != "/") {
    $explode_uri = explode("/", trim($_SERVER["REQUEST_URI"], "/"));
    unset($explode_uri[0]);
    $_SERVER["REQUEST_URI"] = implode("/", $explode_uri);
}
if (file_exists($config["basePath"] . "/installment_access.php")) {
    include $config["basePath"] . "/installment_access.php";
}
define("LANG_URI", langUri());
define("REQUEST_URI", requestUri());
define("REAL_REQUEST_URI", trim($_SERVER["REQUEST_URI"], "/"));
$_SERVER["REQUEST_URI"] = REQUEST_URI;
if ($settings["visible_lang_site"]) {
    if (!LANG_URI) {
        if (!$_SESSION["langSite"]["iso"] && $settings["auto_lang_detection"]) {
            $SxGeo = new SxGeo($config["basePath"] . "/systems/libs/SxGeo/SxGeoCity.dat", SXGEO_BATCH | SXGEO_MEMORY);
            $getGeo = $SxGeo->getCityFull($_SERVER["REMOTE_ADDR"]);
            if ($getGeo["country"]["iso"]) {
                $findLang = findOne("uni_languages", "iso = ? and status = ?", [$getGeo["country"]["iso"], 1]);
                if ($findLang) {
                    $getIso = $findLang->iso;
                } else {
                    $getIso = getLang();
                }
            } else {
                $getIso = getLang();
            }
        } else {
            $getIso = getLang();
        }
        header("Location: " . $config["urlPath"] . "/" . $getIso);
        exit;
    }
    $findLang = findOne("uni_languages", "iso = ? and status = ?", [LANG_URI, 1]);
    if ($findLang) {
        $_SESSION["langSite"]["iso"] = $findLang->iso;
        $_SESSION["langSite"]["name"] = $findLang->name;
        $_SESSION["langSite"]["image"] = $findLang->image;
    } else {
        header("Location: " . $config["urlPath"] . "/" . getLang() . "/" . REAL_REQUEST_URI);
        exit;
    }
}

$Geo->metrics();
$Main->createDir();
$Main->createRobots();
$Profile->setMode();
$Profile->sessionsFavorites();
$Main->searchKeyword();
$Cart->refresh();
if (!is_dir($config["template_path"])) {
    if (REQUEST_URI) {
        header("Location: " . $config["urlPath"]);
        exit;
    }
    echo file_get_contents($config["basePath"] . "/install_ub4/get_templates.php");
    exit;
}
require "systems/routes.php";
Router::execute(trim(explode("?", $_SERVER["REQUEST_URI"])[0], "/"));
if ($_SESSION["user_step_route"][count($_SESSION["user_step_route"]) - 1] != full_path_url()) {
    $_SESSION["user_step_route"][] = full_path_url();
}
if (file_exists($config["basePath"] . "/test_drive_modal_info.php")) {
    include $config["basePath"] . "/test_drive_modal_info.php";
}
echo " ";
function parseMainDomain($domen)
{
    if (strpos($domen, "://") !== false) {
        $explode_protocol = explode("://", $domen);
        unset($explode_protocol[0]);
        $explode_point = explode(".", $explode_protocol[1]);
        if ($explode_point[0] == "www") {
            unset($explode_point[0]);
        }
    } else {
        $explode_point = explode(".", $domen);
        if ($explode_point[0] == "www") {
            unset($explode_point[0]);
        }
    }
    $domen = array_values($explode_point);
    if (count($domen) == 2) {
        return implode(".", $domen);
    }
    if (count($domen) == 3) {
        if ((mb_strlen($domen[1], "UTF-8") == 2 || mb_strlen($domen[1], "UTF-8") == 3) && (mb_strlen($domen[2], "UTF-8") == 2 || mb_strlen($domen[2], "UTF-8") == 3)) {
            return implode(".", $domen);
        }
        unset($domen[0]);
        return implode(".", $domen);
    }
    if (count($domen) == 4) {
        unset($domen[0]);
        return implode(".", $domen);
    }
}

?>